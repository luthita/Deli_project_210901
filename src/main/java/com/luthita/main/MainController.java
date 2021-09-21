package com.luthita.main;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.luthita.menu.bo.MenuBO;
import com.luthita.menu.model.Menu;
import com.luthita.store.bo.StoreBO;
import com.luthita.store.model.Store;

@RequestMapping("/main")
@Controller
public class MainController {
	
	@Autowired
	private MenuBO menuBO;
	
	@Autowired
	private StoreBO storeBO;
	
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
			Model model) {
		
		List<Menu> menuList = menuBO.getMenuList(storeId);
		Store store = storeBO.getStore(storeId);
		
		model.addAttribute("store",store);
		model.addAttribute("menuList", menuList);
		model.addAttribute("viewName","main/store");
		return "template/layout";
	}
}
