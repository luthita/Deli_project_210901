package com.luthita.review.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.luthita.review.model.Review;

@Repository
public interface ReviewDAO {

	public List<Review> selectReviewListByStoreId(int storeId);
}
