package com.luthita.review.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.luthita.review.model.Review;

@Repository
public interface ReviewDAO {

	public List<Review> selectReviewListByStoreId(int storeId);
	
	public int insertReview(
			@Param("storeId") int storeId,
			@Param("userId") int userId,
			@Param("orderId") int orderId,
			@Param("userName") String userName,
			@Param("point") int point,
			@Param("reviewText") String reviewText);
	
	public List<Integer> selectOrderIdList(int userId);
	
	public int selectReviewCountByStoreId(int storeId);
	
	public void deleteReview(int id);
	
	public List<Integer> getPointListById(int storeId);
}
