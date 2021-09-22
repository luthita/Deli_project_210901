package com.luthita.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.luthita.common.EncryptUtils;
import com.luthita.user.bo.UserBO;
import com.luthita.user.model.User;

 
@RestController
@RequestMapping("/user")
public class UserRestController {

	@Autowired
	private UserBO userBO;
	
	@RequestMapping("/is_duplicated_id")
	public Map<String,Boolean> isDuplicated(
			@RequestParam("loginId") String loginId){
		
		Map<String, Boolean> result = new HashMap<>();
		User user = userBO.getUserByloginId(loginId);
		
		if(user == null) {
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
			@RequestParam("userName") String userName,
			@RequestParam("email") String email,
			@RequestParam("address") String address){
		
		// 암호화
		String encryptPassword = EncryptUtils.md5(password);
		
		userBO.addUser(loginId, encryptPassword, userName, email, address);
		
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
		
		User user = userBO.getUserByloginIdAndPassword(loginId, encryptPassword);
		
		Map<String, String> result = new HashMap<>();
		if(user != null) {
			HttpSession session = request.getSession();
			session.setAttribute("userLoginId", user.getLoginId());
			session.setAttribute("userName", user.getUserName());
			session.setAttribute("userId", user.getId());
			session.setAttribute("userAddress", user.getAddress());
			
			result.put("result", "success");
		} else {
			result.put("result", "fail");
			result.put("message", "존재하지 않는 ID 입니다.");
		}
		return result;
		
	}
}
