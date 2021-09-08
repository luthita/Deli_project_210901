package com.luthita.admin;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.luthita.admin.bo.AdminBO;
import com.luthita.admin.model.Admin;
import com.luthita.common.EncryptUtils;

@RequestMapping("/admin")
@RestController
public class AdminRestController {

	@Autowired
	private AdminBO adminBO;
	
	@RequestMapping("/is_duplicated_id")
	public Map<String,Boolean> isDuplicated(
			@RequestParam("loginId") String loginId){
		
		Map<String, Boolean> result = new HashMap<>();
		Admin admin = adminBO.getAdminByloginId(loginId);
		
		if(admin == null) {
			result.put("result", false);
		}else {
			result.put("result", true);
		}
		return result;
	}
	
	@PostMapping("/sign_up")
	public Map<String, String> signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("email") String email){
		
		// 암호화
		String encryptPassword = EncryptUtils.md5(password);
		
		adminBO.addAdmin(loginId, encryptPassword, email);
		
		Map<String, String> result = new HashMap<>();
		result.put("result", "success");
		
		return result;
	}
	
	@PostMapping("/sign_in")
	public Map<String, String> signIn(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			HttpServletRequest request){
		
		String encryptPassword = EncryptUtils.md5(password);
		
		Admin admin = adminBO.getAdminByloginIdAndPassword(loginId, encryptPassword);
		
		Map<String, String> result = new HashMap<>();
		if(admin != null) {
			HttpSession session = request.getSession();
			session.setAttribute("userLoginId", admin.getLoginId());
			session.setAttribute("userId", admin.getId());
			
			result.put("result", "success");
		} else {
			result.put("result", "fail");
			result.put("message", "존재하지 않는 ID 입니다.");
		}
		return result;
		
	}
}
