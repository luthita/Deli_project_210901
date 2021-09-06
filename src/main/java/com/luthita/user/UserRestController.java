package com.luthita.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.luthita.user.bo.UserBO;
import com.luthita.user.model.User;

@RequestMapping("/user")
@RestController
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
}
