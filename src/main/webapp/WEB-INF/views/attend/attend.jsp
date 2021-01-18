<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Date nowTime = new Date();
	SimpleDateFormat yyyy = new SimpleDateFormat("yyyy");
	SimpleDateFormat MM = new SimpleDateFormat("MM");
%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>근태조회</title>

<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
      rel="stylesheet">

<style type="text/css">
	a{
		color: #858796;
	}
	#dataTable_filter{
		width: 200px;
		float: right;
	}
	#dataTable_filter{
		
	}
	label {
		width: 200px;
	}
	#ok{
	background-color: #042282;
	color : white;
	}
	
	.span2{
		font-size: 1.3em;
	}
	
	.span1{
		font-size: 1.3em;
		color : #042282;
	}
</style>

<script>
$(document).ready(function(){
	
	var nowMonth = <%= MM.format(nowTime) %>;
	if(nowMonth < 10){
		nowMonth = "0" + nowMonth;
	}
	
	$('#year').val(<%= yyyy.format(nowTime) %>);
	$('#month').val(nowMonth);
	
	$("#btn").on("click", function() {
// 		var a = $('#empId').val();
		var a = $('#empId').val();
		var b = $('#year').val()+"/"+$('#month').val();
		console.log(a)
		console.log(b)

		document.location="/excelDown?empId="+a+"&attendDt="+b;
	});
	
	$("#ok").on("click", function() {
		$('#select').submit();
	});
	
});	


</script>
</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">


		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Begin Page Content -->
				<div class="container-fluid">
					<!-- Page Heading -->
					<h2 class="h3 mb-2 text-gray-800">
						<i class="fas fa-fw fa-clock" style="margin-left: 10px;"></i>&nbsp&nbsp근태
						조회
					</h2>
					<br>
					<div class="card shadow mb-4">
						<div class="card-body">
							<table class="table" cellspacing="0" style="text-align : center;">
								<tr style="border : 1px solid #e3e6f0; ">
									<td>이번주 누적<br><br><span class="span1">${myAttendVO.WHour}시간 ${myAttendVO.WMinute}분</span></td>
									<td>이번주 초과<br><br><span class="span1">${myAttendVO.WPHour}시간 ${myAttendVO.WPMinute}분</span></td>
									<td>이번달 누적<br><br><span class="span2">${myAttendVO.MHour}시간 ${myAttendVO.MMinute}분</span></td>
									<td>이번달 초과<br><br><span class="span2">${myAttendVO.MPHour}시간 ${myAttendVO.MPMinute}분</span></td>
								</tr>
							</table>
						</div>
					</div>
					
					
					<div class="card shadow mb-4">
						<div class="card-body">
							<form id="select" action="/selectAttend" method="post">
								<select class="form-control" name="year" id="year"
									style="width: 100px; float: left; margin: 5px;">
									<jsp:useBean id="now" class="java.util.Date" />
	                                <fmt:formatDate value="${now}" pattern="yyyy" var="year"/>
	                                <c:forEach var="i" begin="2018" step="1" end="${year }">
	                                	<option value="${i }">${i }년</option>
	                                </c:forEach>
								</select> <select class="form-control" name="month" id="month"
									style="width: 100px; float: left; margin: 5px;">
									<option value="01">1월</option>
									<option value="02">2월</option>
									<option value="03">3월</option>
									<option value="04">4월</option>
									<option value="05">5월</option>
									<option value="06">6월</option>
									<option value="07">7월</option>
									<option value="08">8월</option>
									<option value="09">9월</option>
									<option value="10">10월</option>
									<option value="11">11월</option>
									<option value="12">12월</option>
								</select>
								<button type="button" class="btn" 
									style="margin: 5px;" id="ok">검색</button>
							</form>
							<form id="frm" action="/excelDown" method="post">
								<div class="table-responsive" style="overflow: hidden;">
									<table class="table table-bordered" id="" cellspacing="0">
										<thead>
											<tr>
												<th>일자</th>
												<th>출근시간</th>
												<th>퇴근시간</th>
												<th>접속IP</th>
												<th>비고</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach items="${attendList}" var="attend">
												<tr>
													<td>${attend.attendDt}</td>
													<td>${attend.workTime}</td>
													<td>${attend.homeTime}</td>
													<td>${attend.loginIp}</td>
													<td>${attend.remark}</td>
												</tr>
											</c:forEach>
											<c:if test="${fn:length(attendList) == 0 }">
                                         <tr>
                                            <td colspan="5" style="text-align: center;">근태기록이 없습니다.</td>
                                         </tr>
                                      </c:if>
										</tbody>
									</table>
									<input id="empId" name="empId" type="hidden"
										value="${EMP.empId}">
									<button id="btn" class="btn btn-outline-success" type="button"
										style="float: right;">엑셀다운로드</button>
								</div>





							</form>
						</div>
					</div>

				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
<!-- 	<a class="scroll-to-top rounded" href="#page-top"> <i -->
<!-- 		class="fas fa-angle-up"></i> -->
<!-- 	</a> -->

	<!-- Core plugin JavaScript-->
	<script src="/admin2form/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="/admin2form/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script src="/admin2form/vendor/datatables/jquery.dataTables.min.js"></script>
	<script
		src="/admin2form/vendor/datatables/dataTables.bootstrap4.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="/admin2form/js/demo/datatables-demo.js"></script>

</body>

</html>