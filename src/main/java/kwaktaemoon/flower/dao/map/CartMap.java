package kwaktaemoon.flower.dao.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kwaktaemoon.flower.domain.Cart;

public interface CartMap {
	List<Cart> selectCarts(@Param("userId") String userId);
	List<Cart> selectCart(@Param("flowerNum") int flowerNum, @Param("userId") String userId);
	int insertCart(Cart cart);
	int deleteCart(int cartNum);
	int emptyCart(@Param("userId") String userId);
}
