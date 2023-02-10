package kwaktaemoon.flower.dao.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kwaktaemoon.flower.domain.User;

public interface UserMap {
	User login(@Param("userId") String userId, @Param("userPw") String userPw);
	String selectId(@Param("userId") String userId);
	String selectId2(@Param("userName") String userName,@Param("contactNum") String contactNum);
	String selectPw(@Param("userName") String userName,
									@Param("userId") String userId, @Param("email") String email);
	User selectUser(@Param("userId") String userId);
	int insertUser(User user);
	int updatePw(@Param("userId") String userId, @Param("userPw") String userPw);
	int updateEmail(@Param("userId") String userId, @Param("email") String email);
	int updateContactNum(@Param("userId") String userId, @Param("contactNum") String contactNum);
	int updateAddr(@Param("userId") String userId, @Param("postcode") String postcode,
							@Param("addr") String addr,@Param("detailAddr") String detailAddr);
	void deleteUser(@Param("userId")String userId);
	List<User> selectUsersAdmin();
	void updateUserAdmin(User user);
	void deleteUserAdmin(@Param("userId") String userId);
}
