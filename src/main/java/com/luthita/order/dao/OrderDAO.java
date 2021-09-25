package com.luthita.order.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderDAO {

	public int insertOrder(
			@Param("storeId") int storeId,
			@Param("userId") int userId,
			@Param("payMethod") String payMethod,
			@Param("payment") int payment);
	
	public int selectLastOrderId(int userId);
}
