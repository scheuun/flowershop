package kwaktaemoon.flower.dao.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kwaktaemoon.flower.domain.Review;

public interface ReviewMap {
	List<Review> selectReviews();
	List<Review> detailReviews(@Param("reviewNum") int reviewNum);
	List<Review> selectAdminReviews();
	List<Review> detailAdminReviews(@Param("reviewNum") int reviewNum);
	void insertReview(Review review);
	void updateReview(Review review);
	void deleteReview(int reviewNum);
	void deleteAdminReview(int reviewNum);
}
 