package com.luthita.orderedMenu.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.luthita.menu.bo.MenuBO;
import com.luthita.order.bo.OrderBO;
import com.luthita.order.model.Order;
import com.luthita.orderedMenu.model.OrderedMenuView;
import com.luthita.store.bo.StoreBO;
import com.luthita.store.model.Store;
import com.luthita.user.bo.UserBO;

@Service
public class OrderedMenuViewBO {

	@Autowired
	private OrderBO orderBO;
	
	@Autowired
	private StoreBO storeBO;
	
	@Autowired
	private OrderedMenuBO orderedMenuBO;
	
	@Autowired
	private MenuBO menuBO;
	
	@Autowired
	private UserBO userBO;
	
	public List<OrderedMenuView> generateOrderedMenuList(int userId){
		List<OrderedMenuView> orderedMenuViewList = new ArrayList<>();
		
		List<Order> orderList = orderBO.getOrderListByUserId(userId);
		for(Order order : orderList) {
			OrderedMenuView orderedMenuView = new OrderedMenuView();
			
			// 해당 주문의 주문 가져오기
			orderedMenuView.setOrder(order);
			
			// 해당 주문의 가게 가져오기
			int storeId = order.getStoreId();
			Store store = storeBO.getStore(storeId);
			orderedMenuView.setStore(store);
			
			// 해당 주문의 메뉴들 가져오기
			List<Integer> orderedMenuId = orderedMenuBO.getMenuIdByOrderId(order.getId());
			List<String> orderedMenuName = new ArrayList<>();
			for(int menuId : orderedMenuId) {
				String menuName = menuBO.getMenuNameById(menuId);
				orderedMenuName.add(menuName);
			}
			orderedMenuView.setMenuName(orderedMenuName);
			
			// 해당 주문의 총 주문금액 가져오기
			orderedMenuView.setPayment(order.getPayment());
			
			// 해당 주문 회원의 주소 가져오기
			orderedMenuView.setAddress(userBO.getAddressById(userId));
			
			orderedMenuViewList.add(orderedMenuView);
		}
		return orderedMenuViewList;
	}
}
