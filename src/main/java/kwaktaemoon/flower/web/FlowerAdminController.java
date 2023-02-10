package kwaktaemoon.flower.web;

import java.io.File;
import java.io.IOException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kwaktaemoon.flower.domain.Flower;
import kwaktaemoon.flower.service.FlowerService;

@Controller
@RequestMapping("/admin/flower")
public class FlowerAdminController {
	@Autowired private FlowerService flowerService;
	
	@Value("${attachPath}") private String attachPath;
	
	@GetMapping("/listFlower")
	public String listFlower() {
		return "admin/flower/listFlower";
	}
	
	@GetMapping("/detailFlower")
	public String detailFlower(Model model, @RequestParam("flowerNum") int flowerNum) {
	    List<Flower> flowerList = flowerService.getDetailFlowers(flowerNum);
	    model.addAttribute("flowerList", flowerList);
		return "admin/flower/detailFlower";
	}
	
	@GetMapping("/addFlower")
	public String addFlower() {
		return "admin/flower/addFlower";
	}
	
	@GetMapping("/fixFlower")
	public String fixFlower() {
		return "admin/flower/fixFlower";
	}
	
	@ResponseBody
	@PostMapping("/listFlower")
	public List<Flower> getAdminFlowers() {
		return flowerService.getAdminFlowers();
	}
	
	@ResponseBody	
	@DeleteMapping("del/{flowerNum}")
	public void delFlower(@PathVariable int flowerNum, Model model) {
		int result = flowerService.delFlower(flowerNum);
		model.addAttribute("result", result);
		System.out.println(result);
	}
	
	@ResponseBody
	@PostMapping("/addFlower")
	public ModelAndView addFlower(Flower flower, ModelAndView mv) throws IOException {
		try {
		String flowerFileName = flower.getFlowerImgfile().getOriginalFilename();
		String detailFileName = flower.getDetailImgfile().getOriginalFilename();
		
		saveFlowerFile(attachPath + "/" + flowerFileName, flower.getFlowerImgfile());
		flower.setFlowerImgfileName(flowerFileName);
		
		saveDetailFile(attachPath + "/" + detailFileName, flower.getDetailImgfile());
		flower.setDetailImgfileName(detailFileName);
		flowerService.addFlower(flower);
		} catch(NullPointerException e) {}
		
		mv.setViewName("admin/flower/listFlower");
		return mv;
	}
	
	@ResponseBody
	@PostMapping("/fix")
	public void fixFlower(@RequestBody Flower flower, Model model) {
		int result = flowerService.fixFlower(flower);
		model.addAttribute("result", result);
		System.out.println(result);
	}

	private void saveFlowerFile(String flowerFileName, MultipartFile flowerFile) {
		try {
			flowerFile.transferTo(new File(flowerFileName));
		} catch(IOException e) {}
	}
	
	private void saveDetailFile(String flowerFileName, MultipartFile detailFile) { 
		try {
			detailFile.transferTo(new File(flowerFileName));
		} catch(IOException e) {}
	}
}
