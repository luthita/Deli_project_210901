package com.luthita.orderedMenu.bo;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.luthita.orderedMenu.dao.OrderedMenuDAO;

@Service
public class OrderedMenuBO {

	@Autowired
	private OrderedMenuDAO orderedMenuDAO;
	
	public int addOrderedMenu(int orderId, int menuId, int count) {
		return orderedMenuDAO.insertOrderedMenu(orderId, menuId, count);
	}
	
	public Map<String, Integer> getMenuIdAndCountByOrderId(int orderId){
		return orderedMenuDAO.selectMenuIdAndCountByOrderId(orderId);
	}
}
