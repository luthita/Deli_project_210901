package com.luthita.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin")
@Controller
public class AdminController {

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
}
