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
	
	public void addUser(String loginId, String password, String userName, String email, String address) {
		userDAO.insertUser(loginId, password, userName, email, address);
	}
	
	public User getUserByloginIdAndPassword(String loginId, String password) {
		return userDAO.selectUserByLoginIdAndPassword(loginId, password);
	}
	
}
