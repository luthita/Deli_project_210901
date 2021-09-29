package com.luthita.main;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.luthita.basket.bo.BasketBO;
import com.luthita.basket.model.Basket;
import com.luthita.menu.bo.MenuBO;
import com.luthita.orderedMenu.bo.OrderedMenuViewBO;
import com.luthita.orderedMenu.model.OrderedMenuView;
import com.luthita.review.bo.ReviewBO;
import com.luthita.review.model.Review;
import com.luthita.store.bo.LikeBO;
import com.luthita.store.bo.StoreBO;
import com.luthita.store.bo.StoreContentBO;
import com.luthita.store.model.Store;
import com.luthita.store.model.StoreContent;
import com.luthita.user.bo.UserBO;
import com.luthita.user.model.User;

@RequestMapping("/main")
@Controller
public class MainController {
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private MenuBO menuBO;
	
	@Autowired
	private StoreBO storeBO;
	
	@Autowired
	private BasketBO basketBO;
	
	@Autowired
	private LikeBO likeBO;
	
	@Autowired
	private OrderedMenuViewBO orderedMenuViewBO;
	
	@Autowired
	private StoreContentBO storeContentBO;
	
	@Autowired
	private ReviewBO reviewBO;
	
	@RequestMapping("/main_view")
	public String signInView(Model model) {
		model.addAttribute("viewName","main/main");
		return "template/layout";
	}
	
	@RequestMapping("/kinds_view")
	public String kindsView(
			@RequestParam("kinds") String kinds,
			Model model) {
		
		List<Store> storeList = storeBO.getStoreListByKinds(kinds);
		
		model.addAttribute("kinds", kinds);
		model.addAttribute("storeList", storeList);
		model.addAttribute("viewName","main/kinds_store");
		return "template/layout";
		
	}
	@RequestMapping("/store_view")
	public String storeView(
			@RequestParam("storeId") int storeId,
			Model model,
			HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		session.removeAttribute("sessionStoreId");
		
		StoreContent storeContent = storeContentBO.getStoreContent(storeId, userId);
		
		session.setAttribute("sessionStoreId", storeId);
		model.addAttribute("userId",userId);
		model.addAttribute("storeContent",storeContent);
		model.addAttribute("viewName","main/store");
		return "template/layout";
	}
	
	@RequestMapping("/basket_view")
	public String basketView(
			Model model,
			HttpServletRequest request) {
		
		model.addAttribute("viewName","main/basket");
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		
		List<Basket> basketList = basketBO.getBasketListByUserId(userId);
		model.addAttribute("basketList", basketList);
		
		return "template/layout";
	}
	
	@RequestMapping("/order_view")
	public String orderView(
			Model model,
			HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		User user = userBO.getUserById(userId);
		List<Basket> basketList = basketBO.getBasketListByUserId(userId);
		
		// 어차피 장바구니의 메뉴들은 모두 같은 가게의 메뉴이다.
		int menuId = basketList.get(0).getMenuId();
		int storeId = menuBO.getStoreIdById(menuId);
		
		// 장바구니의 가게 객체 생성
		Store store = storeBO.getStore(storeId);
		
		model.addAttribute("viewName","main/order");
		model.addAttribute("user",user);
		model.addAttribute("store",store);
		model.addAttribute("basketList",basketList);
		
		return "template/layout";
	}
	
	@RequestMapping("/orderedList_view")
	public String orderedListView(
			Model model,
			HttpServletRequest request) {
	
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		List<OrderedMenuView> orderedMenuViewList= orderedMenuViewBO.generateOrderedMenuList(userId);
		
		model.addAttribute("viewName","main/orderedList");
		model.addAttribute("orderedMenuViewList", orderedMenuViewList);
		return "template/layout";
	}
	
	@RequestMapping("/like_list_view")
	public String likeListView(
			Model model,
			HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		
		List<Integer> storeIdList = likeBO.getStoreIdList(userId);
		List<Store> storeList = new ArrayList<>();
		for(int storeId : storeIdList) {
			Store store = storeBO.getStore(storeId);
			storeList.add(store);
		}
		
		model.addAttribute("storeList", storeList);
		model.addAttribute("viewName","main/like_list");
		return "template/layout";
		
	}
	
	@RequestMapping("/review_view")
	public String reviewListView(
			Model model,
			HttpServletRequest request,
			@RequestParam("storeId") int storeId,
			@RequestParam(required=false, value="orderId") Integer orderId) {
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		List<Review> reviewList = reviewBO.getReviewListByStoreId(storeId);
		
		Boolean isExistReview = null;
		// 만약 orderId가 존재한다면 이미 리뷰를 쓴 주문은 아닐까?(한번 주문하고 여러번 리뷰를 쓰는 것을 방지)
		if(orderId != null) {
			isExistReview = reviewBO.isExistReview(orderId, userId);
		} else {
			isExistReview = false;
		}

		Store store = storeBO.getStore(storeId);
		model.addAttribute("isExistReview", isExistReview);
		model.addAttribute("orderId",orderId);
		model.addAttribute("userId",userId);
		model.addAttribute("store",store);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("viewName","main/review");
		return "template/layout";
	}
	
}
