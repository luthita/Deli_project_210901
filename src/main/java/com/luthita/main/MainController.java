package com.luthita.main;

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
import com.luthita.menu.model.Menu;
import com.luthita.store.bo.StoreBO;
import com.luthita.store.model.Store;
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
		session.removeAttribute("sessionStoreId");
		
		List<Menu> menuList = menuBO.getMenuList(storeId);
		Store store = storeBO.getStore(storeId);
		
		session.setAttribute("sessionStoreId", store.getId());
		
		model.addAttribute("store",store);
		model.addAttribute("menuList", menuList);
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
		Integer storeId = (Integer) session.getAttribute("sessionStoreId");
		User user = userBO.getUserById(userId);
		Store store = storeBO.getStore(storeId);
		List<Basket> basketList = basketBO.getBasketListByUserId(userId);
		model.addAttribute("viewName","main/order");
		model.addAttribute("user",user);
		model.addAttribute("store",store);
		model.addAttribute("basketList",basketList);
		
		return "template/layout";
	}
}
