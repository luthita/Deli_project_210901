package com.luthita.store.model;

import java.util.List;

import com.luthita.menu.model.Menu;

public class StoreContent {

	private Store store;
	private List<Menu> menuList;
	private boolean filledLike;
	private int likeCount;
	private int reviewCount;
	
	public int getReviewCount() {
		return reviewCount;
	}
	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}
	public Store getStore() {
		return store;
	}
	public void setStore(Store store) {
		this.store = store;
	}

	public List<Menu> getMenuList() {
		return menuList;
	}
	public void setMenuList(List<Menu> menuList) {
		this.menuList = menuList;
	}
	public boolean isFilledLike() {
		return filledLike;
	}
	public void setFilledLike(boolean filledLike) {
		this.filledLike = filledLike;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	
}
