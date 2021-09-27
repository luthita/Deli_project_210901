package com.luthita.orderedMenu.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderedMenuDAO {

	public int insertOrderedMenu(
			@Param("orderId") int orderId,
			@Param("menuId") int menuId,
			@Param("count") int count);
	
	public Map<String, Integer> selectMenuIdAndCountByOrderId(int orderId);
	
	public List<Integer> selectMenuIdByOrderId(int orderId);
}
