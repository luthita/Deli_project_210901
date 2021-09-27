package com.luthita.order.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.luthita.order.model.Order;

@Repository
public interface OrderDAO {

	public int insertOrder(
			@Param("storeId") int storeId,
			@Param("userId") int userId,
			@Param("payMethod") String payMethod,
			@Param("payment") int payment);
	
	public int selectLastOrderId(int userId);
	
	public List<Order> selectOrderListByUserId(int userId);
	
	public Order selectOrderById(int id);
}
