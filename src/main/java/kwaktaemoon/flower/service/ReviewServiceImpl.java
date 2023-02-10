package kwaktaemoon.flower.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kwaktaemoon.flower.dao.map.ReviewMap;
import kwaktaemoon.flower.domain.Review;

@Service 
public class ReviewServiceImpl implements ReviewService {
	@Autowired private ReviewMap reviewMap;
	
	@Override
	public List<Review> getReviews() {
		return reviewMap.selectReviews();
	}
	
	@Override
	public List<Review> getDetailReviews(int reviewNum) {
		return reviewMap.detailReviews(reviewNum);
	}
	
	@Override
	public List<Review> getAdminReviews() {
		return reviewMap.selectAdminReviews();
	}
	
	@Override
	public List<Review> getDetailAdminReviews(int reviewNum) {
		return reviewMap.detailAdminReviews(reviewNum);
	}
	
	@Override
	public void addReview(Review review) {
		reviewMap.insertReview(review);
	}
	
	@Override
	public void fixReview(Review review) {
		reviewMap.updateReview(review);
	}
	
	@Override
	public void delReview(int reviewNum) {
		reviewMap.deleteReview(reviewNum);
	}
	
	@Override
	public void delAdminReview(int reviewNum) {
		reviewMap.deleteAdminReview(reviewNum);
	}
}
 