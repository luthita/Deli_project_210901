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
}
