package com.luthita.store.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.luthita.store.dao.LikeDAO;

@Service
public class LikeBO {

	@Autowired
	private LikeDAO likeDAO;
	
	public void like(int storeId, int userId) {
		boolean existLike = existLike(storeId,userId);
		if(existLike) {
			likeDAO.deleteLike(storeId, userId);
		} else {
			likeDAO.insertLike(storeId, userId);
		}
	}
	
	
	public boolean existLike(int storeId, Integer userId) {
		// 로그인 안했을때는 좋아요 X
		if(userId == null) {
			return false;
		}
		int count = likeDAO.selectLikeCountByStoreIdOrUserId(storeId,userId);
		return count > 0 ? true : false;
	}
	
	public int getLikeCountByStoreId(int storeId) {
		return likeDAO.selectLikeCountByStoreIdOrUserId(storeId, null);
	}
	
	public List<Integer> getStoreIdList(int userId){
		return likeDAO.selectStoreIdList(userId);
	}
	
}