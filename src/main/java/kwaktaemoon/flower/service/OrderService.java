package kwaktaemoon.flower.service;

import java.util.List;

import kwaktaemoon.flower.domain.Order;

public interface OrderService {
	List<Order> getOrders(String userId);
	List<Order> getdetailOrders(int orderNum);
	List<Order> getAdminOrders();
	void addOrder(Order order);
	int fixDeliState(int orderNum);
	int fixAdmDeliState(int orderNum);
	int delOrder(int orderNum);
}
