package kwaktaemoon.flower.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kwaktaemoon.flower.dao.map.CartMap;
import kwaktaemoon.flower.domain.Cart;

@Service
public class CartServiceImpl implements CartService {
	@Autowired private CartMap cartMap;
	
	@Override
	public List<Cart> getCarts(String userId) {
		return cartMap.selectCarts(userId);
	}

	@Override
	public List<Cart> getCart(int flowerNum, String userId) {
		return cartMap.selectCart(flowerNum, userId);
	}
	
	@Override
	public int addCart(Cart cart) {
		return cartMap.insertCart(cart);
	}

	@Override
	public int delCart(int cartNum) {
		int result = cartMap.deleteCart(cartNum);

		if(result == 1) return 1;
		else return 0;
	}
	
	@Override
	public int emptyCart(String userId) {
		int result =  cartMap.emptyCart(userId);

		if(result == 1) return 1;
		else return 0;
	}
}
