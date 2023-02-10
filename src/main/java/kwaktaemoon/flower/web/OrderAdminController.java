package kwaktaemoon.flower.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kwaktaemoon.flower.domain.Flower;
import kwaktaemoon.flower.domain.Order;
import kwaktaemoon.flower.service.FlowerService;
import kwaktaemoon.flower.service.OrderService;

@Controller
@RequestMapping("/admin/order")
public class OrderAdminController{
	@Autowired private OrderService orderService;
	@Autowired private FlowerService flowerService;	

	@GetMapping("/listOrder")
	public String adminListOrder() {
		return "admin/order/listOrder";
	}
	
	@GetMapping("/detailOrder")
	public String detailOrder(Model model, @RequestParam("flowerNum") int flowerNum, @RequestParam("orderNum") int orderNum) {
	    List<Order> orderList = orderService.getdetailOrders(orderNum);
	    model.addAttribute("orderList", orderList);
	    
	    List<Flower> flowerList = flowerService.getDetailFlowers(flowerNum);
	    model.addAttribute("flowerList", flowerList);
		return "admin/order/detailOrder";
	}
	
	@ResponseBody
	@PostMapping("/listOrder")
	public List<Order> getAdminOrders() {
		return orderService.getAdminOrders();
	}
	
	@ResponseBody
	@PutMapping("fix/{orderNum}")
	public void fixAdmDeliState(@PathVariable int orderNum, Model model) {
		int result = orderService.fixAdmDeliState(orderNum);
		model.addAttribute("result", result);
		System.out.println(result);
	}
	
	@ResponseBody	
	@DeleteMapping("del/{orderNum}")
	public void delOrder(@PathVariable int orderNum, Model model) {
		int result = orderService.delOrder(orderNum);
		model.addAttribute("result", result);
		System.out.println(result);
	}
}
