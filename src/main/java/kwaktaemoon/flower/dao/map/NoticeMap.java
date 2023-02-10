package kwaktaemoon.flower.dao.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kwaktaemoon.flower.domain.Notice;

public interface NoticeMap {
	List<Notice> selectNotices();
	List<Notice> selectDetailNotices(@Param("noticeNum") int noticeNum);
	List<Notice> selectAdminNotices();
	List<Notice> selectAdminDetailNotices(@Param("noticeNum") int noticeNum);
	void insertAdminNotice(Notice notice);
	void updateAdminNotice(Notice notice);
	void deleteAdminNotice(@Param("noticeNum")int noticeNum);
	
}
