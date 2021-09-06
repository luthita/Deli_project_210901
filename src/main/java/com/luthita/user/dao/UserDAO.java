package com.luthita.user.dao;

import org.springframework.stereotype.Repository;

import com.luthita.user.model.User;

@Repository
public interface UserDAO {

	public User selectUserByLoginId(String loginId);
}
