package com.luthita.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/admin")
@Controller
public class AdminController {

	@RequestMapping("/sign_in_view")
	public String signInView(Model model) {
		model.addAttribute("viewName","admin/sign_in");
		
		return "template/layout";
	}
}
