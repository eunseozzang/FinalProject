package kr.or.ddit.vacation.contorller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.emp.vo.EmpVO;
import kr.or.ddit.vacation.service.VacationService;
import kr.or.ddit.vacation.vo.VacatTypeVO;
import kr.or.ddit.vacation.vo.VacationVO;

@Controller
public class VacationController {
	
	@Resource(name = "vacationService")
	private VacationService vacationService;
	
	
	
	
	
	@RequestMapping("/vacate/empVacateinfo")
	public String empVacateInfo(HttpSession session, Model model) {
		
		EmpVO empVO = (EmpVO) session.getAttribute("EMP");
		
		VacationVO vacateVO = new VacationVO();
		vacateVO.setEmpId(empVO.getEmpId());
		
		List<VacationVO> empVacateList = vacationService.selectEmpVacateInfo(vacateVO);
		// 사원의 직급에 해당되는 연차일수
		int empVacateDayCnt = vacationService.selectEmpJobTitleVacateDayCnt(empVO);
		float myUseVacateCnt = 0;
		
		if(empVacateList != null && empVacateList.size() > 0) {
			for(VacationVO myVacateInfo : empVacateList) {
				myUseVacateCnt += Float.parseFloat(myVacateInfo.getVacateDayCnt()); 
			}
		}
		model.addAttribute("myVacateDayCnt", empVacateDayCnt);
		model.addAttribute("myUseVacateCnt", myUseVacateCnt);
		model.addAttribute("empVacateList", empVacateList);
		return "jsonView";
	}
	
	
	
	
	
	
	@RequestMapping("/vacate/isInsertVacateInfo")
	public String isInsertVacateInfo(VacationVO vacateVO, HttpSession session, Model model) {
		
		EmpVO empVO = (EmpVO) session.getAttribute("EMP");
		
		vacateVO.setEmpId(empVO.getEmpId());
		List<VacationVO> empVacateInfo = vacationService.selectIsInsertVacateInfo(vacateVO);
		model.addAttribute("empVacateInfo", empVacateInfo);
		return "jsonView";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping("/vacate/myVacatePage")
	public String myVacatePage(HttpSession session, Model model) {
		
		EmpVO empVO = (EmpVO) session.getAttribute("EMP");
		
		VacationVO vacateVO = new VacationVO();
		vacateVO.setEmpId(empVO.getEmpId());
		
		// 1970년 부터 올해까지의 날짜 데이터
		List<String> yearStrList = vacationService.selectYearStrList();
		
		
		// 휴가 종류
		List<VacatTypeVO> vacatTypeList = vacationService.selectVacatTypeList();
		
		
		// 사원의 직급에 해당되는 연차일수
		int empVacateDayCnt = vacationService.selectEmpJobTitleVacateDayCnt(empVO);
		
		
		// 사원이 사용한 연차 일수
		float myUseVacateCnt = 0;
		List<VacationVO> empVacateList = vacationService.selectEmpVacateInfo(vacateVO);
		if(empVacateList != null && empVacateList.size() > 0) {
			for(VacationVO myVacateInfo : empVacateList) {
				myUseVacateCnt += Float.parseFloat(myVacateInfo.getVacateDayCnt()); 
			}
		}
		model.addAttribute("myVacateDayCnt", empVacateDayCnt);
		model.addAttribute("myVacateUseCnt", myUseVacateCnt);
		
		model.addAttribute("vacatTypeList", vacatTypeList);
		model.addAttribute("empVacateList", empVacateList);
		model.addAttribute("yearStrList", yearStrList);
		return "tiles/vacate/myVacatePageView";
	}
	
	
	
	
	@RequestMapping("/vacate/selectMyVacateInfoCal")
	public String selectMyVacateInfoCal(VacationVO vacateVO, Model model, HttpSession session) {
		
		EmpVO empVO = (EmpVO) session.getAttribute("EMP");
		
		vacateVO.setEmpId(empVO.getEmpId());
		List<VacationVO> empVacateList = vacationService.selectEmpVacateInfo(vacateVO);
		model.addAttribute("empVacateList", empVacateList);
		
		return "jsonView";
	}
	
	
	
	
}
