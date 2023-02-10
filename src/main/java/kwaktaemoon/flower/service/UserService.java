package kwaktaemoon.flower.service;

import java.util.List;

import kwaktaemoon.flower.domain.User;

public interface UserService {
	User chkUser(String userId, String userPw);
	String chkId(String userId);
	String findId(String userName, String contactNum);
	String findPw(String userName, String userId, String email);
	User getMyPage(String userId);
	int addUser(User user);
	int fixPw(String userId, String userPw);
	int fixEmail(String userId, String email);
	int fixContactNum(String userId, String contactNum);
	int fixAddr(String userId, String postcode, String addr, String detailAddr);
	void delUser(String userId);
	List<User> getUsersAdmin();
	void fixUserAdmin(User user);
	void delUserAdmin(String userId);
}
