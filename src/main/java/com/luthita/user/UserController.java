package com.luthita.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/user")
@Controller
public class UserController {
	
	@RequestMapping("/sign_in_view")
	public String signInView() {
		return "user/sign_in";
	}
	
	@RequestMapping("sign_up_view")
	public String signUpView(Model model) {
		model.addAttribute("viewName","user/sign_up");
		
		return "template/layout";
	}
	
	@RequestMapping("/sign_out")
	public String signOut(HttpServletRequest request){
		// 로그아웃
		HttpSession session = request.getSession();
		session.removeAttribute("userLoginId");
		session.removeAttribute("userId");
		session.removeAttribute("userName");
		session.removeAttribute("userAddress");

		return "redirect:/user/sign_in_view";
	}
}
