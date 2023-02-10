package kwaktaemoon.flower.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kwaktaemoon.flower.domain.Notice;
import kwaktaemoon.flower.service.NoticeService;

@Controller
@RequestMapping("/admin/notice")
public class NoticeAdminController {
	@Autowired private NoticeService noticeService;
	
	@RequestMapping("/listNotice")
	public String listNotice() {
		return "admin/notice/listNotice";
	}
	
	@GetMapping("/listNotice")
	public List<Notice> getNotices() {
		return noticeService.getAdminNotices();
	}
	
	@RequestMapping(value="/detailNotice", method=RequestMethod.GET)
	public String detailNotice(Model model, @RequestParam("noticeNum") int noticeNum) {
		List<Notice> noticeList = noticeService.getAdminDetailNotices(noticeNum);
		model.addAttribute("noticeList", noticeList);
		return "admin/notice/detailNotice";
	}
	
	@RequestMapping("/addNotice")
	public String addNotice() {
		return "admin/notice/addNotice";
	}
	
	@ResponseBody
	@PostMapping("/addNotice")
	public void addNotice(Notice notice) {
		noticeService.addAdminNotice(notice);
	}
	
	@ResponseBody
	@PutMapping("/fixNotice")
	public void fixNotice(@RequestBody Notice notice) {
		noticeService.fixAdminNotice(notice);
	}
	
	@ResponseBody
	@DeleteMapping("del/{noticeNum}")
	public void delNotice(@PathVariable int noticeNum) {
		noticeService.delAdminNotice(noticeNum);
	}
}

