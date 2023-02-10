package kwaktaemoon.flower.web;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import kwaktaemoon.flower.domain.Cart;
import kwaktaemoon.flower.domain.Flower;
import kwaktaemoon.flower.domain.Order;
import kwaktaemoon.flower.service.CartService;
import kwaktaemoon.flower.service.FlowerService;
import kwaktaemoon.flower.service.OrderService;

@Controller
@RequestMapping("/order")
public class OrderController{
	@Autowired private OrderService orderService;
	@Autowired private FlowerService flowerService;
	@Autowired private CartService cartService;
	
	@GetMapping("/listOrder")
	public String listOrder() {
		return "order/listOrder";
	}
	
	@GetMapping("/detailOrder")
	public String detailOrder(Model model, @RequestParam("flowerNum") int flowerNum, @RequestParam("orderNum") int orderNum) {
	    List<Order> orderList = orderService.getdetailOrders(orderNum);
	    model.addAttribute("orderList", orderList);
	    
	    List<Flower> flowerList = flowerService.getDetailFlowers(flowerNum);
	    model.addAttribute("flowerList", flowerList);
		return "order/detailOrder";
	}
	
	@GetMapping("/addOrder")
	public String addOrder(Model model, @RequestParam("flowerNum") int flowerNum, HttpSession session) {
		String userId = (String) session.getAttribute("userId");
		
		List<Flower> flowerList = flowerService.getDetailFlowers(flowerNum);
	    model.addAttribute("flowerList", flowerList);
	    
	    List<Cart> cartList = cartService.getCart(flowerNum, userId);
	    model.addAttribute("cartList", cartList);
		return "order/addOrder";
	}
	
	@GetMapping("/successOrder")
	public String successOrder() {
		return "order/successOrder";
	}
	
	@ResponseBody
	@PostMapping("/listOrder")
	public List<Order> getOrders(HttpSession session) {
		String userId = (String) session.getAttribute("userId");
		return orderService.getOrders(userId);
	}
	
	@ResponseBody
	@PutMapping("fix/{orderNum}")
	public String fixDeliState(Model model, @PathVariable int orderNum) {
		int result = orderService.fixDeliState(orderNum);
		model.addAttribute("result", result);
		System.out.println(result);
		return "order/listOrder";
	}
	
	@ResponseBody
	@PostMapping("/addOrder")
	public void addOrder(Order order, HttpSession session) {
		String userId = (String) session.getAttribute("userId");
		order.setUserId(userId);
		orderService.addOrder(order);
	}
}
