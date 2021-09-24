package com.luthita.basket.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.luthita.basket.model.Basket;

@Repository
public interface BasketDAO {

	public int insertBasket(
			@Param("userId") int userId,
			@Param("menuId") int menuId,
			@Param("name") String name,
			@Param("price") int price,
			@Param("count") int count);
	
	public List<Basket> selectBasketListByUserId(int userId);
	
	public void deleteBasket(int id);
	
	public Integer selectLastMenuId(int userId);
}
