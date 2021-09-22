package com.luthita.basket.bo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.luthita.basket.dao.BasketDAO;

@Service
public class BasketBO {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private BasketDAO basketDAO;
	
	public int addBasket(int userId, int menuId, int count) {
		return basketDAO.insertBasket(userId, menuId, count);
	}
}
