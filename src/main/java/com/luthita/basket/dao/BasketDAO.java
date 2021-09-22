package com.luthita.basket.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface BasketDAO {

	public int insertBasket(
			@Param("userId") int userId,
			@Param("menuId") int menuId,
			@Param("count") int count);
}
