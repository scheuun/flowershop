package kwaktaemoon.flower.service;

import java.util.List;

import kwaktaemoon.flower.domain.Notice;

public interface NoticeService {
	List<Notice> getNotices();
	List<Notice> getDetailNotices(int noticeNum);
	List<Notice> getAdminNotices();
	List<Notice> getAdminDetailNotices(int noticeNum);
	void addAdminNotice(Notice notice);
	void fixAdminNotice(Notice notice);
	void delAdminNotice(int noticeNum);
}
