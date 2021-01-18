package kr.or.ddit.address.vo;

import kr.or.ddit.comm.vo.BaseVO;

public class AddrEmpVO extends BaseVO {

	private String deptId;
	private int authLv;
	private String jobtitleId;
	private String zipcode;
	private String managerId;
	private String empQuitYn;
	private String authId;
	private String addr2;
	private String empId;
	private String addr1;
	private String password;
	private String bankAcctNo;
	private String empNm;
	private String realfilename;
	private String filepath;
	private String empMail;
	private String empHp;
	private String standard;
	
	private String deptName;
	private String jobtitleNm;
	
	
	public String getStandard() {
		return standard;
	}
	public void setStandard(String standard) {
		this.standard = standard;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId; 
	}
	public String getDeptId() {
		return deptId; 
	}
	public void setAuthLv(int authLv) {
		this.authLv = authLv; 
	}
	public int getAuthLv() {
		return authLv; 
	}
	public void setJobtitleId(String jobtitleId) {
		this.jobtitleId = jobtitleId; 
	}
	public String getJobtitleId() {
		return jobtitleId; 
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode; 
	}
	public String getZipcode() {
		return zipcode; 
	}
	public void setManagerId(String managerId) {
		this.managerId = managerId; 
	}
	public String getManagerId() {
		return managerId; 
	}
	public void setEmpQuitYn(String empQuitYn) {
		this.empQuitYn = empQuitYn; 
	}
	public String getEmpQuitYn() {
		return empQuitYn; 
	}
	public void setAuthId(String authId) {
		this.authId = authId; 
	}
	public String getAuthId() {
		return authId; 
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2; 
	}
	public String getAddr2() {
		return addr2; 
	}
	public void setEmpId(String empId) {
		this.empId = empId; 
	}
	public String getEmpId() {
		return empId; 
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1; 
	}
	public String getAddr1() {
		return addr1; 
	}
	public void setPassword(String password) {
		this.password = password; 
	}
	public String getPassword() {
		return password; 
	}
	public void setBankAcctNo(String bankAcctNo) {
		this.bankAcctNo = bankAcctNo; 
	}
	public String getBankAcctNo() {
		return bankAcctNo; 
	}
	public void setEmpNm(String empNm) {
		this.empNm = empNm; 
	}
	public String getEmpNm() {
		return empNm; 
	}
	public void setRealfilename(String realfilename) {
		this.realfilename = realfilename; 
	}
	public String getRealfilename() {
		return realfilename; 
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath; 
	}
	public String getFilepath() {
		return filepath; 
	}
	public void setEmpMail(String empMail) {
		this.empMail = empMail; 
	}
	public String getEmpMail() {
		return empMail; 
	}
	public void setEmpHp(String empHp) {
		this.empHp = empHp; 
	}
	public String getEmpHp() {
		return empHp; 
	}
	
	
	
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getJobtitleNm() {
		return jobtitleNm;
	}
	public void setJobtitleNm(String jobtitleNm) {
		this.jobtitleNm = jobtitleNm;
	}

}
