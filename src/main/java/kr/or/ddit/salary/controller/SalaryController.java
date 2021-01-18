package kr.or.ddit.salary.controller;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.comm.vo.PaginationVO;
import kr.or.ddit.emp.vo.EmpVO;
import kr.or.ddit.salary.service.SalaryService;
import kr.or.ddit.salary.view.SalaryExcelView;
import kr.or.ddit.salary.vo.SalaryReVO;
import kr.or.ddit.salary.vo.SalaryVO;
import kr.or.ddit.salary.vo.TaxVO;

@Controller
public class SalaryController {
	
	@Resource
	SalaryService salaryService;
	
	private static final Logger logger = LoggerFactory.getLogger(SalaryController.class);
	
	@RequestMapping("/salary/manage")
	public String salaryManage(Model model, String year, String month, SalaryVO inputVO) {
		
		logger.debug("월급 볼 년/달 : {},{}",year,month);
		Date nowDate = new Date();
		SimpleDateFormat yy = new SimpleDateFormat("yyyy");
		SimpleDateFormat mm = new SimpleDateFormat("MM");
		
		if(year == null || year.equals("")) {
			year = yy.format(nowDate);
		}
		
		if(month == null || month.equals("")) {
			month = mm.format(nowDate);
		}
		
		logger.debug("월급 볼 년/달 2222222222222 : {},{}",year,month);
		
		model.addAttribute("yy",yy.format(nowDate));
		model.addAttribute("mm",mm.format(nowDate));
		
		inputVO.setSalaryDt(year + "-" + month);
		
		inputVO.setRecordCountPerPage(10);
		int cnt = 1;
		
		List<SalaryReVO> salaryList = null;
		
		try {
			salaryList = salaryService.selectMonList(inputVO);
			cnt = salaryService.selectCnt(inputVO);
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		PaginationVO pagination = new PaginationVO(inputVO.getPageIndex(), inputVO.getRecordCountPerPage(), inputVO.getPageSize(), cnt);
		model.addAttribute("year",year);
		model.addAttribute("month",month);
		model.addAttribute("salaryList",salaryList);
		model.addAttribute("pagination", pagination);
		
		return "tiles/salary/salaryManage";
	}
	
	@RequestMapping("/salary/calculation")
	public String caculation(String year, String month) {
		logger.debug("월급 산정할 년/달  : {},{}",year,month);
		
		String year2 = year;
		String month2 = month;
		
		List<String> empList = new ArrayList<String>();
		
		int yearInt = Integer.parseInt(year);
		int monthInt = Integer.parseInt(month);
//		2 3 4 5 6 7 8 9 10
		if(monthInt == 1) {
			yearInt = yearInt - 1;
			monthInt = 12;
			
			year2 = yearInt + "";
			month2 = monthInt + "";
			
		} else if(monthInt < 11 && monthInt > 1) {
			monthInt = monthInt - 1;
			month2 = "0" + monthInt;
		} else if(monthInt == 11 || monthInt == 12) {
			monthInt = monthInt - 1;
			month2 = monthInt + "";
		}
		
		String calMon2 = year + "-" + month;
		String calMon = year2 + "-" + month2;
		logger.debug("계산할 달 ??????????? calMon ? {}",calMon);
		
		try {
			empList = salaryService.selectAllId();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		for(int i=0;i<empList.size();i++) {
			
			Map<String, String> map = new HashMap<String, String>();

			// i번째 사원의 정보 map에 넣어서 월급 가져오기
			map.put("empId", empList.get(i));
			map.put("month", calMon);
			String salary = "";
			try {
				salary = salaryService.getMonthSalary(map);
			} catch (Exception e) {
				e.printStackTrace();
			}
			SalaryVO salVO = new SalaryVO();
			salVO.setEmpId(empList.get(i));
			salVO.setSalaryAmt(salary);
			salVO.setSalaryDt(calMon2);
			logger.debug("salaryVO ???? {}",salVO);
			try {
				salaryService.salaryCal(salVO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "redirect:/salary/manage?year=" + year + "&month=" + month;
	}
	
	
	@RequestMapping("/salary/test")
	public String salaryTest(Model model) {
		
		Date nowDate = new Date();
		SimpleDateFormat yy = new SimpleDateFormat("yyyy");
		SimpleDateFormat mm = new SimpleDateFormat("MM");
		model.addAttribute("yy",yy.format(nowDate));
		model.addAttribute("mm",mm.format(nowDate));
		
		return "salary/test";
	}
	
	@RequestMapping("/salary/excel")
	public void salaryExcel(HttpServletRequest request, HttpServletResponse response, String year, String month) throws Exception {
		SalaryVO inputVO = new SalaryVO();
		String calMon = year + "-" + month;
		inputVO.setSalaryDt(calMon);
		
		List<SalaryReVO> monthList = null;
		
		try {
			monthList = salaryService.selectMonExcel(inputVO);
			salaryService.salaryStUpdate(inputVO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		logger.debug("개수 잘 가져왔나 {}", monthList.size());
		
		SalaryExcelView sev = new SalaryExcelView();
		
		Map<String, Object> beans = new HashMap<String, Object>();
		
		beans.put("monthList", monthList);
		beans.put("year", year);
		beans.put("month", month);
		
		sev.download(request, response, beans, year + "/" + month + "salary", "salary.xlsx", "salary");
		
	}
	
	@RequestMapping("/salary/specification")
	public String salarySpecification(String year, String month, HttpSession session, Model model) {
		
		SalaryReVO resultVO = null;
		
		DecimalFormat formatter = new DecimalFormat("###,###");
		
		Date nowDate = new Date();
		SimpleDateFormat yy = new SimpleDateFormat("yyyy");
		SimpleDateFormat mm = new SimpleDateFormat("MM");
		
		EmpVO sessionVO = (EmpVO) session.getAttribute("EMP");
		
		if(year == null || year.equals("")) {
			year = yy.format(nowDate);
		}
		
		if(month == null || month.equals("")) {
			month = mm.format(nowDate);
		}
		
		Map<String, String> maps = new HashMap<>();
		
		
		maps.put("empId", sessionVO.getEmpId());
		maps.put("month", year+"-"+month);
		
		
		String basicMoney = "";
		
		
		try {
			basicMoney = salaryService.selectBasicSal(sessionVO.getEmpId());
			resultVO = salaryService.selectEmpMonthSalary(maps);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		if(resultVO != null) {
			resultVO.setBasicAmt(formatter.format(Integer.parseInt(basicMoney)));
			resultVO.setPlusAmt(formatter.format(Integer.parseInt(resultVO.getSalaryAmt()) - Integer.parseInt(basicMoney)));
			resultVO.setSalaryAmt(formatter.format(Integer.parseInt(resultVO.getSalaryAmt())));
			model.addAttribute("salaryVO",resultVO);
			logger.debug("resultVO ????????????????????????? {}",resultVO);
			if(resultVO.getSalarySt().equals("Y")) {
				model.addAttribute("check","O");
			} else {
				model.addAttribute("check","X");
			}
		}  else {
			model.addAttribute("check","X");
		}
		
		model.addAttribute("yy",yy.format(nowDate));
		model.addAttribute("mm",mm.format(nowDate));
		model.addAttribute("year",year);
		model.addAttribute("month",month);
		
		return "tiles/salary/specification";
	}
	
	@RequestMapping("/salary/excel2")
	public void excel2(HttpServletRequest request, HttpServletResponse response, HttpSession session, String year, String month) throws Exception {
		
		SalaryReVO resultVO = null;
		DecimalFormat formatter = new DecimalFormat("###,###");
		
		EmpVO sessionVO = (EmpVO) session.getAttribute("EMP");
		
		Map<String, String> maps = new HashMap<>();
		
		
		maps.put("empId", sessionVO.getEmpId());
		maps.put("month", year+"-"+month);
		
		
		String basicMoney = "";
		String salaryAmt = "";
		
		try {
			basicMoney = salaryService.selectBasicSal(sessionVO.getEmpId());
			resultVO = salaryService.selectEmpMonthSalary(maps);
			if(resultVO.getDeptName().equals("사장")) {
				resultVO.setDeptName("SENDBOX");
			}
			salaryAmt = resultVO.getSalaryAmt();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		resultVO.setBasicAmt(formatter.format(Integer.parseInt(basicMoney)));
		resultVO.setPlusAmt(formatter.format(Integer.parseInt(resultVO.getSalaryAmt()) - Integer.parseInt(basicMoney)));
		resultVO.setSalaryAmt(formatter.format(Integer.parseInt(resultVO.getSalaryAmt())));
		
		TaxVO taxVO = new TaxVO();
		
		taxVO.setIncomeTax(formatter.format(Integer.parseInt(basicMoney)*0.03));
		taxVO.setResidentTax(formatter.format(Integer.parseInt(basicMoney)*0.003));
		taxVO.setNationalPension(formatter.format(Integer.parseInt(basicMoney)*0.045));
		taxVO.setHealthInsurance(formatter.format(Integer.parseInt(basicMoney)*0.032));
		taxVO.setEmpolymentInsurance(formatter.format(Integer.parseInt(basicMoney)*0.008));
		
		int finalAmt = (int) (Integer.parseInt(salaryAmt) - (Integer.parseInt(basicMoney)*0.03+Integer.parseInt(basicMoney)*0.003+Integer.parseInt(basicMoney)*0.045+Integer.parseInt(basicMoney)*0.032+Integer.parseInt(basicMoney)*0.008));
		
		taxVO.setTaxSum(formatter.format(Integer.parseInt(basicMoney)*0.03+Integer.parseInt(basicMoney)*0.003+Integer.parseInt(basicMoney)*0.045+Integer.parseInt(basicMoney)*0.032+Integer.parseInt(basicMoney)*0.008));
		taxVO.setFinalSalary(formatter.format(finalAmt));
		
		logger.debug("taxVO ???????????????????????? : {}",taxVO);
		
		SalaryExcelView sev = new SalaryExcelView();
		
		Map<String, Object> beans = new HashMap<String, Object>();
		
		beans.put("salaryVO", resultVO);
		beans.put("year", year);
		beans.put("month", month);
		beans.put("taxVO", taxVO);
		
		sev.download(request, response, beans, year + "/" + month + "_" + sessionVO.getEmpId() + "_salary", "salary2.xlsx", "salary");
		
	}
}
