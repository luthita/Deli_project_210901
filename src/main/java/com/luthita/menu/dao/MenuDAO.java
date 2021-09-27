package com.luthita.menu.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.luthita.menu.model.Menu;

@Repository
public interface MenuDAO {

	public List<Menu> selectMenuListByStoreId(int storeId);
	
	public int deleteMenu(int id);
	
	public int insertMenu(
			@Param("storeId") int storeId,
			@Param("name") String name,
			@Param("price") int price,
			@Param("imagePath") String imagePath);
	
	
	public Menu selectMenu(int id);
	
	public int selectStoreIdByMenuId(int id);
	
	public String selectMenuNameById(int id);
}
