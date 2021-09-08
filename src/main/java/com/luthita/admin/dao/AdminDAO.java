package com.luthita.admin.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.luthita.admin.model.Admin;

@Repository
public interface AdminDAO {

	public Admin selectAdminByLoginId(String loginId);
	
	public void insertAdmin(
			@Param("loginId") String loginId, 
			@Param("password") String password, 
			@Param("email") String email);
	
	public Admin selectAdminByLoginIdAndPassword(
			@Param("loginId") String loginId,
			@Param("password") String password);
}
