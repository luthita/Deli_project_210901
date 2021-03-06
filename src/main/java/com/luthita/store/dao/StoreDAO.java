package com.luthita.store.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.luthita.store.model.Store;


@Repository
public interface StoreDAO {

	public Store selectStoreByAdminId(int adminId);
	
	public Store selectStoreById(int id);
	
	public int insertStore(
			@Param("adminId") int adminId,
			@Param("storeName") String storeName, 
			@Param("address") String address, 
			@Param("introduce") String introduce, 
			@Param("phoneNumber")String phoneNumber, 
			@Param("kinds") String kinds, 
			@Param("logoImagePath") String logoImagePath);
	
	public List<Store> selectStoreListByKinds(String kinds);
	
	public String selectStoreNameById(int id);
	
	public int updateStore(
			@Param("adminId") int adminId,
			@Param("introduce") String introduce, 
			@Param("kinds") String kinds, 
			@Param("deliveryfee") int deliveryFee,
			@Param("minimumPrice") int minimumPrice,
			@Param("logoImagePath") String logoImagePath);
	
	public void updatePoint(
			@Param("avgPoint")double avgPoint,
			@Param("storeId") int storeId);
}
