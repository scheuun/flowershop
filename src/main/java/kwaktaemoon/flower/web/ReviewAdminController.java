package kwaktaemoon.flower.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kwaktaemoon.flower.domain.Review;
import kwaktaemoon.flower.service.ReviewService;

@Controller
@RequestMapping("/admin/review")
public class ReviewAdminController {
	@Autowired private ReviewService reviewService;
	
	@RequestMapping("/listReview")
	public String listReview() {
		return "admin/review/listReview";
	}
	
	@GetMapping("/listReview")
	public List<Review> getReviews() {
		return reviewService.getAdminReviews();
	}
	
	@RequestMapping(value="/detailReview", method=RequestMethod.GET)
	public String detailReview(Model model, @RequestParam("reviewNum") int reviewNum) {
		List<Review> reviewList = reviewService.getDetailAdminReviews(reviewNum);
		model.addAttribute("reviewList", reviewList);
		return "admin/review/detailReview";
	}
	
	@ResponseBody
	@DeleteMapping("admin/del/{reviewNum}")
	public void delReview(@PathVariable int reviewNum) {
		reviewService.delAdminReview(reviewNum);
	}
}
