package com.luthita.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.luthita.basket.bo.BasketBO;
import com.luthita.menu.bo.MenuBO;

@RestController
@RequestMapping("/main")
public class MainRestController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private BasketBO basketBO;
	
	@Autowired
	private MenuBO menuBO;
	
	// Insert Basket(장바구니에 담기)
	@RequestMapping("/add_basket")
	public Map<String, String> addBasket(
			@RequestParam("menuId") int menuId,
			@RequestParam("name") String name,
			@RequestParam("price") int price,
			@RequestParam("count") int count,
			HttpServletRequest request){
		
		Map<String,String> result = new HashMap<>();
		HttpSession session = request.getSession();
		
		Integer userId = (Integer) session.getAttribute("userId");
		if(userId == null) {
			result.put("result", "error");
			logger.error("[장바구니담기] 로그인 세션이 없습니다.");
			return result;
		}
		
		// 현재 장바구니가 비어있으면 추가 가능
		Integer lastMenuId = basketBO.getLastMenuId(userId);
		if(lastMenuId == null) {
			int row = basketBO.addBasket(userId, menuId, name, price, count);
			if(row > 0 ){
				result.put("result", "success");
			} else {
				result.put("result", "error");
				logger.error("[메뉴등록] 메뉴 등록을 완료하지 못했습니다.");
			}
			return result;
		}
		
		// 현재 사용자가 장바구니에 가장 마지막에 넣은 메뉴의 가게와 지금 넣는 메뉴의 가게가 같은가?
		boolean isSameStore = menuBO.isSameStore(menuId, lastMenuId);
		if(isSameStore == true) {
			int row = basketBO.addBasket(userId, menuId, name, price, count);
			if(row > 0 ){
				result.put("result", "success");
			} else {
				result.put("result", "error");
				logger.error("[메뉴등록] 메뉴 등록을 완료하지 못했습니다.");
			}
			return result;
		} else {
			result.put("result", "incorrect");
			return result;
		}
		
	}
	@RequestMapping("/delete_basket")
	public Map<String, String> deleteBasket(
			@RequestParam("id") int id,
			HttpServletRequest request){
		
		Map<String, String> result = new HashMap<>();
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		if( userId == null) {
			result.put("result", "error");
			logger.error("[장바구니 삭제] 로그인 세션이 없습니다.");
			return result;
		}
		
		basketBO.deleteBasket(id);
		result.put("result", "success");
		return result;
	}
	
	@RequestMapping("/order")
	public Map<String, String> order(
			@RequestParam("storeId") int storeId,
			@RequestParam("payMethod") String payMethod,
			@RequestParam("payment") int payment,
			@RequestParam(value="arrMenu") Map<String, Integer> arrMenu){
		
		Map<String,String> result = new HashMap<>();
		result.put("result", "success");
		return result;
		
	}
}
