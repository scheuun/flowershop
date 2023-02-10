package kwaktaemoon.flower.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kwaktaemoon.flower.dao.map.FlowerMap;
import kwaktaemoon.flower.domain.Flower;



@Service
public class FlowerServiceImpl implements FlowerService{
	@Autowired private FlowerMap flowerMap;
	
	@Override
	public List<Flower> getFlowers() {
		return flowerMap.selectFlowers();
	}
	
	@Override
	public List<Flower> getDetailFlowers(int flowerNum) {
		return flowerMap.detailFlowers(flowerNum);
	}
	
	@Override
	public List<Flower> searchFlowerWithKeyword(String keyword) {
		return flowerMap.searchFlowerWithKeyword(keyword);
	}
	
	@Override
	public Flower findFlower(String flowerName) {
		return flowerMap.searchFlower(flowerName);
	}
	
	@Override
	public List<Flower> getAdminFlowers() {
		return flowerMap.selectAdminFlowers();
	}
	
	@Override
	public void addFlower(Flower flower) {
		flowerMap.insertFlower(flower);
	}
	
	@Override
	public int fixFlower(Flower flower) {
		int result = flowerMap.updateFlower(flower);
		
		if(result == 1) return 1;
		else return 0;
	}
	
	@Override
	public int fixAmount(Flower flower) {
		int result = flowerMap.updateAmount(flower);
		
		if(result == 1) return 1;
		else return 0;
	}
	
	@Override
	public int delFlower(int flowerNum) {
		int result = flowerMap.deleteFlower(flowerNum);
		
		if(result == 1) return 1;
		else return 0;
	}
}