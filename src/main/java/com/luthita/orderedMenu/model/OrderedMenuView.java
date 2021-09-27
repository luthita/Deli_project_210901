package com.luthita.orderedMenu.model;

import java.util.List;

import com.luthita.order.model.Order;
import com.luthita.store.model.Store;

public class OrderedMenuView {

	private Order order;
	private Store store;
	private List<String> menuName;
	private int payment;
	private String address;
	

	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Store getStore() {
		return store;
	}
	public void setStore(Store store) {
		this.store = store;
	}
	public List<String> getMenuName() {
		return menuName;
	}
	public void setMenuName(List<String> menuName) {
		this.menuName = menuName;
	}
	public Order getOrder() {
		return order;
	}
	public void setOrder(Order order) {
		this.order = order;
	}
	public int getPayment() {
		return payment;
	}
	public void setPayment(int payment) {
		this.payment = payment;
	}

	
}
