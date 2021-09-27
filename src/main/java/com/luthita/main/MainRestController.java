package com.luthita.main;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.luthita.basket.bo.BasketBO;
import com.luthita.menu.bo.MenuBO;
import com.luthita.order.bo.OrderBO;
import com.luthita.orderedMenu.bo.OrderedMenuBO;
import com.luthita.store.bo.LikeBO;

@RestController
@RequestMapping("/main")
public class MainRestController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private BasketBO basketBO;
	
	@Autowired
	private MenuBO menuBO;
	
	@Autowired
	private OrderBO orderBO;
	
	@Autowired
	private OrderedMenuBO orderedMenuBO;
	
	@Autowired
	private LikeBO likeBO;
	
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
	
	@ResponseBody
	@RequestMapping("/order")
	public Map<String, String> order(
			@RequestBody List<Map<String, Object>> param,
			HttpServletRequest request,
			Model model){
		
		Map<String,String> result = new HashMap<>();
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		if( userId == null) {
			result.put("result", "error");
			logger.error("[주문하기] 로그인 세션이 없습니다.");
			return result;
		}
		
		// TODO : order 테이블에 주문정보 삽입
		
		Integer storeId = (Integer)param.get(0).get("storeId");
		String payMethod = (String) param.get(0).get("payMethod");
		Integer payment = (Integer) param.get(0).get("payment");
		
		int row_order = orderBO.addOrder(storeId, userId, payMethod, payment);
		if(row_order == 0) {
			result.put("result","error");
			logger.error("[주문하기] 주문 테이블에 데이터가 들어가지 않았습니다.");
			return result;
		}
		// 방금 주문한 회원의 주문번호 가져오기
		int orderId = orderBO.getLastOrderId(userId);
		// TODO : orderedMenu 테이블에 주문 메뉴 삽입
		
		int row_orderedMenu = 0;
		for(int i = 1; i < param.size(); i++) {
			String strMenuId = (String) param.get(i).get("menuId");
			String strCount = (String) param.get(i).get("count");
			Integer menuId = Integer.valueOf(strMenuId);
			Integer count = Integer.valueOf(strCount);
			
			int row = orderedMenuBO.addOrderedMenu(orderId, menuId, count);
			row_orderedMenu = row_orderedMenu + row;
		}

		// order 테이블 insert 횟수 + orderedMenu 테이블 insert 횟수
		int total_row = row_order + row_orderedMenu;
		
		// 총 insert 횟수가 일치할 경우 success
		if(total_row == param.size()) {
			result.put("result", "success");
			String strOrderId = Integer.toString(orderId);
			result.put("orderId", strOrderId);
		} else {
			result.put("result", "error");
			logger.error("[주문하기] 주문을 완료하지 못했습니다.");
			return result;
		}
		
		// TODO : 주문 완료 시, 장바구니 목록 모두 삭제
		basketBO.deleteAllBasketByUserId(userId);
		
		return result;
		
	}
	
	@RequestMapping("/like")
	public Map<String, Object> like(
			@RequestParam("storeId") int storeId,
			HttpServletRequest request){
		
		Map<String, Object> result = new HashMap<>();
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		if(userId == null) {
			result.put("result", "error");
			logger.error("[좋아요] 로그인 세션이 없습니다.");
			return result;
		}
		
		likeBO.like(storeId, userId);
		result.put("result", "success");
		return result;
	}
}
