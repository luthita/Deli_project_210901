package com.luthita.order.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.luthita.order.dao.OrderDAO;

@Service
public class OrderBO {

	@Autowired
	private OrderDAO orderDAO;
	
	public int addOrder(int storeId, int userId, String payMethod, int payment) {
		return orderDAO.insertOrder(storeId, userId, payMethod, payment);
	}
	
	public int getLastOrderId(int userId) {
		return orderDAO.selectLastOrderId(userId);
	}
}
