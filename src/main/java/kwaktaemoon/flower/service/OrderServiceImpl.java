package kwaktaemoon.flower.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kwaktaemoon.flower.dao.map.OrderMap;
import kwaktaemoon.flower.domain.Order;

@Service
public class OrderServiceImpl implements OrderService {
	@Autowired private OrderMap orderMap;
	
	@Override
	public List<Order> getOrders(String userId) {
		return orderMap.selectOrders(userId);
	}
	
	@Override
	public List<Order> getdetailOrders(int orderNum) {
		return orderMap.detailOrders(orderNum);
	}
	
	@Override
	public List<Order> getAdminOrders() {
		return orderMap.selectAdminOrders();
	}
	
	@Override
	public void addOrder(Order order) {
		orderMap.insertOrder(order);
	}
	
	@Override
	public int fixDeliState(int orderNum) {
		int result = orderMap.updateDeliState(orderNum);
		
		if(result == 1) return 1;
		else return 0;
	}
	
	@Override
	public int fixAdmDeliState(int orderNum) {
		int result = orderMap.updateAdmDeliState(orderNum);
		
		if(result == 1) return 1;
		else return 0;
	}
	
	@Override
	public int delOrder(int orderNum) {
		int result = orderMap.deleteOrder(orderNum);
		
		if(result == 1) return 1;
		else return 0;
	}
}
