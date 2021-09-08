package com.luthita.admin.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.luthita.admin.dao.AdminDAO;
import com.luthita.admin.model.Admin;

@Service
public class AdminBO {
	@Autowired
	private AdminDAO adminDAO;
	
	public Admin getAdminByloginId(String loginId) {
		return adminDAO.selectAdminByLoginId(loginId);
	}
	
	public void addAdmin(String loginId, String password, String email) {
		adminDAO.insertAdmin(loginId, password, email);
	}
	
	public Admin getAdminByloginIdAndPassword(String loginId, String password) {
		return adminDAO.selectAdminByLoginIdAndPassword(loginId, password);
	}

}
