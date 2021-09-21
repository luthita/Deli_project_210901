package com.luthita.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.luthita.menu.bo.MenuBO;
import com.luthita.menu.model.Menu;

@RequestMapping("/admin")
@Controller
public class AdminController {

	@Autowired
	private MenuBO menuBO;
	
	@RequestMapping("/sign_in_view")
	public String signInView() {
		
		return "admin/sign_in";
	}
	
	@RequestMapping("sign_up_view")
	public String signUpView() {
		
		return "admin/sign_up";
	}
	
	@RequestMapping("main_view")
	public String mainView(Model model) {
		model.addAttribute("viewName","admin/main");
		
		return "template/layout";
	}
	
	@RequestMapping("store_sign_up_view")
	public String storeSignUpView() {
		return "admin/store_sign_up";
	}
	
	@RequestMapping("menu_view")
	public String menuView(Model model,
			HttpServletRequest request) {
		model.addAttribute("viewName","admin/menu");
		
		HttpSession session = request.getSession();
		Integer storeId = (Integer) session.getAttribute("storeId");
		List<Menu> menuList = menuBO.getMenuList(storeId);
		model.addAttribute("menuList", menuList);
				
		return "template/layout";
	}
	
	@RequestMapping("/sign_out")
	public String signOut(HttpServletRequest request){
		// 로그아웃
		HttpSession session = request.getSession();
		session.removeAttribute("adminLoginId");
		session.removeAttribute("adminId");
		
		return "redirect:/admin/sign_in_view";
	}
}
