package com.luthita.user.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.luthita.user.model.User;

@Repository
public interface UserDAO {

	public User selectUserByLoginId(String loginId);
	
	public void insertUser(
			@Param("loginId") String loginId, 
			@Param("password") String password, 
			@Param("userName") String userName, 
			@Param("email") String email, 
			@Param("address") String address);
	
	public User selectUserByLoginIdAndPassword(
			@Param("loginId") String loginId,
			@Param("password") String password);
	
	public User selectUserById(int id);
}
