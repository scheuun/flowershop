package kwaktaemoon.flower.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kwaktaemoon.flower.domain.Cart;
import kwaktaemoon.flower.domain.Flower;
import kwaktaemoon.flower.service.CartService;
import kwaktaemoon.flower.service.FlowerService;

@Controller
@RequestMapping("/flower")
public class FlowerController {
	@Autowired private FlowerService flowerService;
	@Autowired private CartService cartService;
	
	@Value("${attachPath}") private String attachPath;
	
	@GetMapping("/listFlower")
	public List<Flower> listFlower() {
		return flowerService.getFlowers();
	}
	
	@GetMapping("/detailFlower")
	public String detailFlower(Model model, @RequestParam("flowerNum") int flowerNum) {
	    List<Flower> flowerList = flowerService.getDetailFlowers(flowerNum);
	    model.addAttribute("flowerList", flowerList);
		return "flower/detailFlower";
	}
	
	@GetMapping("searchFlower")
	public String searchFlowerAddr() {
		return "/flower/searchFlower";
	}
	
	@ResponseBody
	@PostMapping("/saveKeyword")
	public void saveKeyword(@RequestParam("keyword") String keyword, HttpSession session) {
		session.setAttribute("keyword", keyword);
	}
	
	@ResponseBody
	@PostMapping("/searchFlower")
	public List<Flower> showSearchResult(HttpSession session) {
		String keyword = (String) session.getAttribute("keyword");
		return flowerService.searchFlowerWithKeyword(keyword);
	}
	
	@ResponseBody
	@RequestMapping("/fix")
	public void fixAmount(@RequestBody Flower flower, Model model) {
		int result = flowerService.fixAmount(flower);
		model.addAttribute("result", result);
		System.out.println(result);
	}
	
	@ResponseBody
	@RequestMapping("addCart")
	public void addCart(@RequestBody Cart cart, HttpSession session) {
		String userId = (String) session.getAttribute("userId");
		cart.setUserId(userId);
		cartService.addCart(cart);
	}
}
