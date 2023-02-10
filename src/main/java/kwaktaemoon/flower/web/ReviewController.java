package kwaktaemoon.flower.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kwaktaemoon.flower.domain.Review;
import kwaktaemoon.flower.service.ReviewService;

@Controller 
@RequestMapping("/review")
public class ReviewController{
	@Autowired private ReviewService reviewService;	
	
	@RequestMapping("/listReview")
	public String listReview() {
		return "review/listReview";
	}
	
	@RequestMapping(value = "/detailReview", method=RequestMethod.GET)
	public String detailReview(Model model, @RequestParam("reviewNum") int reviewNum) {
	    List<Review> reviewList = reviewService.getDetailReviews(reviewNum);
	    model.addAttribute("reviewList", reviewList);
		return "review/detailReview";
	}
	
	@RequestMapping(value = "/modReview", method=RequestMethod.GET)
	public String modReview(Model model, @RequestParam("reviewNum") int reviewNum) {
	    List<Review> reviewList = reviewService.getDetailReviews(reviewNum);
	    model.addAttribute("reviewList", reviewList);
		return "review/modReview";
	}
	
	@RequestMapping("/addReview")
	public String addReview() {
		return "review/addReview";
	}
	
	@ResponseBody
	@PostMapping("/listReview")
	public List<Review> getReviews() {
		return reviewService.getReviews();
	}
	
	@ResponseBody
	@PutMapping("/fixReview")
	public void fixReview(@RequestBody Review review) {
		reviewService.fixReview(review);
	}
	
	@ResponseBody
	@PostMapping("/addReview")
	public void addReview(Review review, HttpServletRequest httpRequest) {
		HttpSession session = httpRequest.getSession();
		String userId = (String) session.getAttribute("userId");
		review.setUserId(userId);
		reviewService.addReview(review);
	}
	
	@ResponseBody	
	@DeleteMapping("del/{reviewNum}")
	public void delReview(@PathVariable int reviewNum) {
		reviewService.delReview(reviewNum);
	}
}
 