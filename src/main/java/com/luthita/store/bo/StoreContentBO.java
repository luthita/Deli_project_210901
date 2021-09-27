package com.luthita.store.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.luthita.menu.bo.MenuBO;
import com.luthita.store.model.StoreContent;

@Service
public class StoreContentBO {
	
	@Autowired
	private StoreBO storeBO;
	
	@Autowired
	private LikeBO likeBO;
	
	@Autowired
	private MenuBO menuBO;
	
	public StoreContent getStoreContent(Integer storeId, Integer userId) {
		StoreContent storeContent = new StoreContent();
		
		// store 가져오기
		storeContent.setStore(storeBO.getStore(storeId));
		
		// store의 좋아요
		storeContent.setFilledLike(likeBO.existLike(storeId, userId));
		
		// store의 좋아요 수
		storeContent.setLikeCount(likeBO.getLikeCountByStoreId(storeId));
		
		// store 메뉴 가져오기
		storeContent.setMenuList(menuBO.getMenuList(storeId));
		return storeContent;
	}
}
