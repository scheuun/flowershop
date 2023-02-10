package kwaktaemoon.flower.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kwaktaemoon.flower.dao.map.NoticeMap;
import kwaktaemoon.flower.domain.Notice;

@Service
public class NoticeServiceImpl implements NoticeService{
	@Autowired private NoticeMap noticeMap;
	
	@Override
	public List<Notice> getNotices(){
		return noticeMap.selectNotices();
	}
	
	@Override
	public List<Notice> getDetailNotices(int noticeNum){
		return noticeMap.selectDetailNotices(noticeNum);
	}
	
	@Override
	public List<Notice> getAdminNotices(){
		return noticeMap.selectAdminNotices();
	}
	
	@Override
	public List<Notice> getAdminDetailNotices(int noticeNum){
		return noticeMap.selectAdminDetailNotices(noticeNum);
	}
	
	@Override
	public void addAdminNotice(Notice notice) {
		noticeMap.insertAdminNotice(notice);
	}
	@Override
	public void fixAdminNotice(Notice notice) {
		noticeMap.updateAdminNotice(notice);
	}
	@Override
	public void delAdminNotice(int noticeNum) {
	}
}

