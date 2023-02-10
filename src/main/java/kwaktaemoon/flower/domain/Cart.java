package kwaktaemoon.flower.domain;

import lombok.Data;

@Data
public class Cart {
	private int cartNum;
	private String userId;
	private int flowerNum;
	private String flowerName;
	private String flowerImgfileName;
	private int price;
	private int amount;
}
