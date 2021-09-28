package com.luthita.review.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.luthita.review.dao.ReviewDAO;
import com.luthita.review.model.Review;

@Service
public class ReviewBO {

	@Autowired
	private ReviewDAO reviewDAO;
	
	public List<Review> getReviewListByStoreId(int storeId){
		return reviewDAO.selectReviewListByStoreId(storeId);
	}
	
	public int addReview(int storeId, int userId, int orderId, String userName, int point, String reviewText) {
		return reviewDAO.insertReview(storeId, userId, orderId, userName, point, reviewText);
	}
	
	public boolean isExistReview(int orderId, int userId) {
		List<Integer> orderIdList = reviewDAO.selectOrderIdList(userId);
		for(int reviewOrderId : orderIdList) {
			if(reviewOrderId == orderId) {
				return true;
			}
		}
		return false;
		
	}
	
	public int getReviewCountByStoreId(int storeId) {
		return reviewDAO.selectReviewCountByStoreId(storeId);
	}
	
	public void deleteReview(int id) {
		reviewDAO.deleteReview(id);
	}
}
