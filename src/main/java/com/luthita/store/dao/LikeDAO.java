package com.luthita.store.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface LikeDAO {

	public void insertLike(
			@Param("storeId") int storeId,
			@Param("userId") Integer userId);
	
	public void deleteLike(
			@Param("storeId")int storeId,
			@Param("userId")int userId);
	
	public int selectLikeCountByStoreIdOrUserId(
			@Param("storeId") int storeId,
			@Param("userId") Integer userId);
	
	public List<Integer> selectStoreIdList(int userId);
}
