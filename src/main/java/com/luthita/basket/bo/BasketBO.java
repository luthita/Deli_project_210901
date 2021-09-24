package com.luthita.basket.bo;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.luthita.basket.dao.BasketDAO;
import com.luthita.basket.model.Basket;

@Service
public class BasketBO {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private BasketDAO basketDAO;
	
	public int addBasket(int userId, int menuId, String name, int price,int count) {
		return basketDAO.insertBasket(userId, menuId, name, price, count);
	}
	
	public List<Basket> getBasketListByUserId(int userId) {
		return basketDAO.selectBasketListByUserId(userId);
	}
	
	public void deleteBasket(int id) {
		basketDAO.deleteBasket(id);
	}
	
	public Integer getLastMenuId(int userId) {
		return basketDAO.selectLastMenuId(userId);
	}
}
