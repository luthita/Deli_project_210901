package com.luthita.order.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.luthita.order.dao.OrderDAO;
import com.luthita.order.model.Order;

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
	
	public List<Order> getOrderListByUserId(int userId){
		return orderDAO.selectOrderListByUserId(userId);
	}
	
	public Order getOrder(int id) {
		return orderDAO.selectOrderById(id);
	}
}
