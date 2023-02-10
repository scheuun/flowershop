package kwaktaemoon.flower.web;

import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import kwaktaemoon.flower.domain.Cart;
import kwaktaemoon.flower.service.CartService;

@Controller("kwaktaemoon.flower.cart")
@RequestMapping("/cart")
public class CartController {
	@Autowired private CartService cartService;
	
	@GetMapping("/listCart")
	public String listCart(Model model, @RequestParam("userId") String userId) {
	    List<Cart> cartList = cartService.getCarts(userId);
	    model.addAttribute("cartList", cartList);
		return "cart/listCart";
	}
	

	@ResponseBody
	@GetMapping("/del/{cartNum}")
	public String delCart(Model model, @PathVariable int cartNum) {
		int result = cartService.delCart(cartNum);
		
		if(result == 1) {
			model.addAttribute("result", result);
			System.out.println(result);
			return "cart/listCart";
			
		} else {
			model.addAttribute("result", result);
			System.out.println(result);
			return "cart/listCart";
		}
		
	}
	
	@ResponseBody
	@DeleteMapping("/empty")
	public String emptyCart(HttpSession session, Model model) {
		String userId = (String) session.getAttribute("userId");
		int result = cartService.emptyCart(userId);
		System.out.println(result);
		if(result == 1) {
			model.addAttribute("result", result);
			return "cart/listCart";
		} else {
			model.addAttribute("result", result);
			return "cart/listCart";
		}
	}
}
