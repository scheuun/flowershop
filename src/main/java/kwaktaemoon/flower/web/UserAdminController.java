package kwaktaemoon.flower.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import kwaktaemoon.flower.domain.User;
import kwaktaemoon.flower.service.UserService;

@RestController("kwaktaemoon.flower.admin.user")
@RequestMapping("/admin/user")
public class UserAdminController {
	@Autowired private UserService userService;
	
	@GetMapping("/listUser")
	public ModelAndView listUser(ModelAndView mv) {
		mv.setViewName("/admin/user/listUser");
		return mv;
	}
	
	@GetMapping("list")
	public List<User> getUsers() {
		return userService.getUsersAdmin();
	}
	
	@PutMapping("fix")
	public void fixUser(@RequestBody User user) {
		userService.fixUserAdmin(user);
	}
	
	@DeleteMapping("del/{userId}")
	public void delUser(@PathVariable String userId) {
		userService.delUserAdmin(userId);
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}
