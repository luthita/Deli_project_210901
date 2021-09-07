package com.luthita.main;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/main")
@Controller
public class MainController {
	@RequestMapping("/main_view")
	public String signInView(Model model) {
		model.addAttribute("viewName","main/main");
		return "template/layout";
	}
}
