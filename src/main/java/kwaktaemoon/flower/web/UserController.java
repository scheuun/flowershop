package kwaktaemoon.flower.web;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kwaktaemoon.flower.domain.User;
import kwaktaemoon.flower.domain.UserDto;
import kwaktaemoon.flower.service.UserService;

@Controller("kwaktaemoon.flower.user")
@RequestMapping("/user")
public class UserController {
	@Autowired private UserService userService;
	
	@GetMapping("/login")
	public String login(UserDto userDto, @CookieValue(required=false) Cookie loginCookie) throws Exception {
		if(loginCookie != null) userDto.setUserId(loginCookie.getValue());
		return "user/login";
	}
   
	@PostMapping("/login")
	public void loginchk(@RequestParam("userId") String userId, @RequestParam("userPw") String userPw,
			 Model model, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		User user = userService.chkUser(userId, userPw);
		session.setAttribute("userId", user.getUserId());
		if(user.getUserId().equals("admin")) {
			model.addAttribute("admin",user);
		}else {
			model.addAttribute("user",user);
		}
	}
	
	@GetMapping("/findId")
	public void findId() throws Exception {
		
	}
	
	@RequestMapping("/findId-send")
	public String findId(RedirectAttributes redirectAttrs, @RequestParam String userName, @RequestParam String contactNum) {
		String userId = userService.findId(userName, contactNum);
		redirectAttrs.addFlashAttribute("userId", userId);
		return "redirect:../user/findIdResult";
	}
	
	@GetMapping("findIdResult")
	public void findIdResult(String userId) throws Exception {
		
	}
	
	@GetMapping("/findPw")
	public void findPw() throws Exception {
		
	}
	
	@PostMapping("/findPw-send")
	public String findPw(RedirectAttributes redirectAttrs, @RequestParam String userName,
									@RequestParam String userId, @RequestParam String email) {
		String userPw = userService.findPw(userName, userId, email);
		redirectAttrs.addFlashAttribute("userPw", userPw);
		return "redirect:../user/findPwResult";
	}
	
	@GetMapping("findPwResult")
	public void findPwResult() throws Exception {
		
	}
   
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("/myPage")
	public String myPage(HttpSession session, Model model) throws Exception {
	model.addAttribute("user", userService.getMyPage((String)session.getAttribute("userId")));
		
		return "user/myPage";
	}
	
	@RequestMapping("/join")
	public String join(User user) {
		return "user/join";
	}
	
	@PostMapping("/join")
	public void joinUser(@RequestBody User user) {
		userService.addUser(user);
	}

	@ResponseBody
	@RequestMapping("/idChk")
	public String idChk(@RequestParam("userId") String userId, HttpServletRequest request, HttpServletResponse response) {
		String result = userService.chkId(userId);
		if(result == null) result = "";
		
		return result;
	}
	
	@RequestMapping("/terms")
	public String terms() {
		return "user/terms";
	}
	
	@RequestMapping("/successJoin")
	public String successJoin() {
		return "user/successJoin";
	}
	
	
	
	@RequestMapping("/fixPw")
	public String fixPwAddr() {
		return "user/fixPw";
	}
	
	@PostMapping("/fixPw")
	public void saveId(@RequestBody User user, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.getAttribute("userId");
		
		if(user.getUserId() != null) {
			session.setAttribute("userId", user.getUserId());
		}
	}
	
	@PostMapping("/fixPw2")
	public void fixPw(@RequestParam("userPw") String userPw, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		
		if(userId != null) {
			userService.fixPw(userId, userPw);
		}
	}
	
	@ResponseBody
	@PostMapping("/fixEmail")
	public void fixEmail(@RequestBody User user, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		String email = user.getEmail();
		
		userService.fixEmail(userId, email);
		
	}
	
	@ResponseBody
	@PostMapping("/fixContactNum")
	public void fixContactNum(@RequestBody User user, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		String contactNum = user.getContactNum();
		
		userService.fixContactNum(userId, contactNum);
	}
	
	@ResponseBody
	@PostMapping("/fixAddr")
	public void fixAddr(@RequestBody User user, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		String postcode = user.getPostcode();
		String addr = user.getAddr();
		String detailAddr = user.getDetailAddr();
		
		userService.fixAddr(userId, postcode, addr, detailAddr);
	}
	
	@ResponseBody
	@DeleteMapping("/delUser/{userId}")
	public void delUser(@PathVariable String userId, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String userId1 = (String) session.getAttribute("userId");
		userService.delUser(userId1);
		session.invalidate();
	}
	
	@RequestMapping("/successWithdraw")
	public String successWithdraw() {
		return "user/successWithdraw";
	}
}
