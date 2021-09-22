package com.luthita.main;

import java.util.HashMap;
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
	private MenuBO menuBO;
	
	@Autowired
	private BasketBO basketBO;
	
	// Insert Basket(장바구니에 담기)
	@RequestMapping("/add_basket")
	public Map<String, String> addBasket(
			@RequestParam("menuId") int menuId,
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
		int row = basketBO.addBasket(userId, menuId, count);
		if(row > 0 ){
			result.put("result", "success");
		} else {
			result.put("result", "error");
			logger.error("[메뉴등록] 메뉴 등록을 완료하지 못했습니다.");
		}
		
		return result;
	}
}
