package kwaktaemoon.flower.dao.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kwaktaemoon.flower.domain.Order;


public interface OrderMap {
	List<Order> selectOrders(@Param("userId") String userId);
	List<Order> detailOrders(@Param("orderNum") int orderNum);
	List<Order> selectAdminOrders();
	void insertOrder(Order order);
	int updateDeliState(int orderNum);
	int updateAdmDeliState(int orderNum);
	int deleteOrder(int orderNum);
}
