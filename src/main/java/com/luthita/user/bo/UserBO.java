package com.luthita.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.luthita.user.dao.UserDAO;
import com.luthita.user.model.User;

@Service
public class UserBO {
	
	@Autowired
	private UserDAO userDAO;
	
	public User getUserByloginId(String loginId) {
		return userDAO.selectUserByLoginId(loginId);
	}
	
}
