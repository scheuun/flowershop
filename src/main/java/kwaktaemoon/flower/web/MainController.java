package kwaktaemoon.flower.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kwaktaemoon.flower.service.FlowerService;
import kwaktaemoon.flower.service.NoticeService;
import kwaktaemoon.flower.service.OrderService;
import kwaktaemoon.flower.service.ReviewService;
import kwaktaemoon.flower.service.UserService;

@Controller
public class MainController {
	@Autowired private UserService userService;
	@Autowired private FlowerService flowerService;
	@Autowired private OrderService orderService;
	@Autowired private ReviewService reviewService;
	@Autowired private NoticeService noticeService;
	
	
	@Value("${attachPath}") private String attachPath;
	
	@RequestMapping("/")
	public String listFlower(Model model) {
		model.addAttribute("flowerList", flowerService.getFlowers());
		return "main";
	}
	
	@RequestMapping("/admin")
	public String adminMain(Model model) {
		model.addAttribute("userList", userService.getUsersAdmin());
		model.addAttribute("flowerList", flowerService.getFlowers());
		model.addAttribute("orderList", orderService.getAdminOrders());
		model.addAttribute("reviewList", reviewService.getAdminReviews());
		model.addAttribute("noticeList", noticeService.getAdminNotices());
		return "admin/main";
	}
}
