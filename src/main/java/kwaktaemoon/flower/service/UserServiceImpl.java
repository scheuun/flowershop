package kwaktaemoon.flower.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kwaktaemoon.flower.dao.map.UserMap;
import kwaktaemoon.flower.domain.User;

@Service
public class UserServiceImpl implements UserService {
	@Autowired private UserMap userMap;
	
	@Override
	public User chkUser(String userId, String userPw) {
		return userMap.login(userId, userPw);
	}
	
	@Override
	public String findId(String userName, String contactNum) {
		return userMap.selectId2(userName, contactNum);
	}
	
	@Override
	public String findPw(String userName, String userId, String email) {
		return userMap.selectPw(userName, userId, email);
	}
	
	@Override
	public User getMyPage(String userId) {
		return userMap.selectUser(userId);
	}
	
	@Override
	public int addUser(User user) {
		return userMap.insertUser(user);
	}
	
	@Override
	public String chkId(String userId) {
		return userMap.selectId(userId);
	}
	
	@Override
	public int fixPw(String userId, String userPw) {
		return userMap.updatePw(userId, userPw);
	}
	
	@Override
	public int fixEmail(String userId, String email) {
		return userMap.updateEmail(userId, email);
	}
	
	@Override
	public int fixContactNum(String userId, String contactNum) {
		return userMap.updateContactNum(userId, contactNum);
	}
	@Override
	public int fixAddr(String userId, String postcode, String addr, String detailAddr) {
		return userMap.updateAddr(userId, postcode, addr, detailAddr);
	}
	
	@Override
	public void delUser(String userId) {
		userMap.deleteUser(userId);
	}
	
	@Override
	public List<User> getUsersAdmin() {
		return userMap.selectUsersAdmin();
	}
	
	@Override
	public void fixUserAdmin(User user) {
		userMap.updateUserAdmin(user);
	}
	
	@Override
	public void delUserAdmin(String userId) {
		userMap.deleteUserAdmin(userId);
	}
}
