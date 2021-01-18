package kr.or.ddit.chat.service;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import kr.or.ddit.alarm.vo.AlarmVO;
import kr.or.ddit.chat.dao.ChatMapperDao;
import kr.or.ddit.chat.vo.ChatInfoVO;
import kr.or.ddit.chat.vo.ChatRoomVO;
import kr.or.ddit.emp.vo.EmpVO;

@Service("chatService")
public class ChatService {
	
	
	private static final Logger logger = LoggerFactory.getLogger(ChatService.class);
	
	@Resource(name = "chatMapperDao")
	private ChatMapperDao chatMapperDao;
	
	
	
	public List<ChatRoomVO> selectChatRoomList(ChatRoomVO chatRoomVO) throws Exception{
		return chatMapperDao.selectChatRoomList(chatRoomVO);
	}
	
	
	
	public List<ChatInfoVO> selectChatInfoList(ChatInfoVO chatInfoVO, HttpSession session) {
		// 이미 읽은것이므로 읽음 체크로 수정
		List<ChatInfoVO> chatInfoList = null;
		int updateChatAlarmInfo = 0;
		try {
			EmpVO loginEmpInfo = (EmpVO) session.getAttribute("EMP");
			
			AlarmVO tempAlarm = new AlarmVO();
			tempAlarm.setEmpId(loginEmpInfo.getEmpId());
			tempAlarm.setAlarmCont("chat");
			tempAlarm.setAlarmLinkCont(chatInfoVO.getChatrmId());
			tempAlarm.setAlarmSt("C");
			
			updateChatAlarmInfo = chatMapperDao.updateChatAlarmInfo(tempAlarm);
			// update 된 후의 채팅정보 가져오기
			chatInfoList = chatMapperDao.selectChatInfoList(chatInfoVO);
		} catch (Exception e) { e.printStackTrace(); }
		return chatInfoList;
	}
	
	
	
	public int insertChatInfo(ChatInfoVO chatInfoVO) throws Exception {
		return chatMapperDao.insertChatInfo(chatInfoVO);
	}
	
	
	public List<EmpVO> selectEmpList() throws Exception{
		return chatMapperDao.selectEmpList();
	}



	public int createChatRoom(EmpVO empVO, List<String> empIdArr, List<String> empNmArr, ChatRoomVO chatRoomVO) {
		
		
		logger.debug("===================================================================================");
		logger.debug("");
		logger.debug("");
		logger.debug("");
		logger.debug("");
		logger.debug("");
		
		
		logger.debug("empVO : {}", empVO);
		logger.debug("empIdArr : {}", empIdArr);
		logger.debug("empNmArr : {}", empNmArr);
		logger.debug("chatRoomVO : {}", chatRoomVO);
		
		
		logger.debug("");
		logger.debug("");
		logger.debug("");
		logger.debug("");
		logger.debug("");
		logger.debug("===================================================================================");
		
		int allEmpCnt = 0;			// 총 인원
		int insertEmpCnt = 0;		// 등록 성공 인원
		
		int createCharRoomRes = 0;	// 채팅방 생성 결과
		
		try {
			
			String chatRoomId = "chatRM" + chatMapperDao.selectChatRoomId();
			
			chatRoomVO.setChatrmId(chatRoomId);
			chatRoomVO.setEmpId(empVO.getEmpId());
			chatRoomVO.setHeadcount(empIdArr.size()+1);
			
			createCharRoomRes = chatMapperDao.insertChatRoom(chatRoomVO);
			
			// 방 생성 성공시
			if(createCharRoomRes == 1) {
				
				ChatInfoVO createrChatInfo = new ChatInfoVO();
				createrChatInfo.setChatrmId(chatRoomId);
				createrChatInfo.setEmpId(empVO.getEmpId());
				createrChatInfo.setEmpNm(empVO.getEmpNm());
				createrChatInfo.setChatCont(empVO.getEmpNm() + "님이 입장하셨습니다.");
				
				
				// 방 생성자
				int createrChatInfoRes = chatMapperDao.insertChatInfo(createrChatInfo);
				
				
				// 방 초대사원들
				if(createrChatInfoRes == 1) {
					for(int i=0; i<empIdArr.size(); i++) {
						
						allEmpCnt++;
						
						ChatInfoVO chatInfoVO = new ChatInfoVO();
						chatInfoVO.setChatrmId(chatRoomId);
						chatInfoVO.setEmpId(empIdArr.get(i));
						chatInfoVO.setEmpNm(empNmArr.get(i));
						chatInfoVO.setChatCont(empNmArr.get(i) + "님이 입장하셨습니다.");
						
						int insertChatInfo = chatMapperDao.insertChatInfo(chatInfoVO);
						if(insertChatInfo == 1) {
							insertEmpCnt++;
						}
					}
				}
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(allEmpCnt == insertEmpCnt && createCharRoomRes == 1) {
			return createCharRoomRes;
		}else {
			return createCharRoomRes;
		}
	}
	
	
	
	
	



	public List<EmpVO> selectAddChatRoomEmpList(String chatRoomId) throws Exception {
		return chatMapperDao.selectAddChatRoomEmpList(chatRoomId);
	}



	
	
	
	
	
	
	
	public int insertInviteChatEmp(List<String> empIdArr, List<String> empNmArr, String chatRoomId) {
		
		int allEmpCnt = 0;			// 총 인원
		int insertEmpCnt = 0;		// 등록 성공 인원
		
		for(int i=0; i<empIdArr.size(); i++) {
			allEmpCnt++;
			
			ChatInfoVO chatInfoVO = new ChatInfoVO();
			chatInfoVO.setChatrmId(chatRoomId);
			chatInfoVO.setEmpId(empIdArr.get(i));
			chatInfoVO.setEmpNm(empNmArr.get(i));
			chatInfoVO.setChatCont(empNmArr.get(i) + "님이 입장하셨습니다.");
			
			int insertChatInfo = 0;
			try {
				insertChatInfo = chatMapperDao.insertChatInfo(chatInfoVO);
				if(insertChatInfo == 1) {
					insertEmpCnt++;
					// 방 인원수 재설정
					ChatRoomVO tempChatRoomVO = new ChatRoomVO();
					tempChatRoomVO.setChatrmId(chatInfoVO.getChatrmId());
					
					ChatRoomVO dbChatRM = chatMapperDao.selectChatRMInfo(tempChatRoomVO);
					dbChatRM.setHeadcount(dbChatRM.getHeadcount()+1);
					
					int updatechatRM = chatMapperDao.updateChatRMInfo(dbChatRM);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		if(allEmpCnt == insertEmpCnt) {
			return 1;
		}else {
			return 0;			
		}
	}



	public int updateChatInfoEmp(ChatInfoVO chatInfo) throws Exception {
		
		int delChatInfoRes = 0;
		int res = 0;
		
		chatInfo.setChatCont(chatInfo.getEmpNm() + " 님이 방을 나가셨습니다.");
		
		int insertChatInfo = 0;
		try {
			insertChatInfo = chatMapperDao.insertChatInfo(chatInfo);
			if(insertChatInfo == 1) {
				delChatInfoRes = chatMapperDao.updateChatInfoEmp(chatInfo);
				if(delChatInfoRes == 1) {
					
					ChatRoomVO tempChatRoomVO = new ChatRoomVO();
					tempChatRoomVO.setChatrmId(chatInfo.getChatrmId());
					
					ChatRoomVO dbChatRM = chatMapperDao.selectChatRMInfo(tempChatRoomVO);
					if(dbChatRM.getHeadcount()-1 > 0) {
						dbChatRM.setHeadcount(dbChatRM.getHeadcount()-1);
					}else {
						dbChatRM.setHeadcount(0);
					}
					int updatechatRM = chatMapperDao.updateChatRMInfo(dbChatRM);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(delChatInfoRes == 1) {
			return 1;
		}else {
			return 0;			
		}
	}



	public ChatRoomVO selectChatRMInfo(ChatRoomVO chatRoomVO) {
		ChatRoomVO dbChatRoom = null;
		try {
			dbChatRoom = chatMapperDao.selectChatRMInfo(chatRoomVO);
		} catch (Exception e) { e.printStackTrace(); }
		return dbChatRoom;
	}



	public int updateChatRMInfo(ChatRoomVO chatRoomVO) {
		try {
			int updatechatRM = chatMapperDao.updateChatRMInfo(chatRoomVO);
		} catch (Exception e) { e.printStackTrace(); }
		return 0;
	}


	

}
