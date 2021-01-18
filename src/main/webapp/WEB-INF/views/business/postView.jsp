<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>게시글 조회</title>

    <!-- Custom fonts for this template -->
<!--     <link href="/admin2form/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css"> -->
<!--     <link -->
<!--         href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" -->
<!--         rel="stylesheet"> -->

    <!-- Custom styles for this template -->
<!--     <link href="/admin2form/css/sb-admin-2.min.css" rel="stylesheet"> -->

    <!-- Custom styles for this page -->
    <link href="/admin2form/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	<!-- Bootstrap core JavaScript-->
    <!-- <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script> -->
    <!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	
	<!-- 글씨체 -->
<!--     <link rel="preconnect" href="https://fonts.gstatic.com"> -->
<!-- 	<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@700;800&display=swap" rel="stylesheet"> -->
    
	<script>
    $(document).ready(function() {
    	
        $('#summernote').summernote({toolbar : false, disableResizeEditor : true, disableDragAndDrop: true});    
        $('#summernote').summernote('disable');
        
        /* $('#updater').on('click', function(){
        	var postid = '1'
        	document.location = "/updatePostView?postSeq=${busiPostVo.postSeq}";
        });
        
        $('#deleter').on('click', function(){
        	var isDelete = confirm('정말 삭제하시겠습니까?');
        	if(isDelete){
        		document.location = "/deletePost?postSeq=${busiPostVo.postSeq}&boardId=${busiPostVo.boardId}";
        	}
        })
        
        $('#replier').on('click', function(){
        	document.location = "/insertPostView?boardId=${busiPostVo.boardId}&parentpostId=${busiPostVo.postSeq}";
        }) */
        
        /* $('#btnList').on('click', function(){
        	document.location="/selectPostList?boardId=${busiPostMap.busiPost.boardId}";
        }) */
        
 		setTimeout(function(){
	        msgLoad();
    	}, 2);
        
    });
    msgLoad = function(){
      var msg = "${busiPostVo.msg}";
      if(msg != null && msg != ''){
      	alert(msg);
      }    	
    }
  	</script>
<style>
	
	.note-editable{
		height: 350px;
	}
	.vl {
	  float : left;
	  text-align: center;
	}
	#d1{
	  border-left: 2px solid gray;
	}
	
	.front{
		text-align: center;
		font-family: 'Nanum Gothic', sans-serif;
	}
		
	table {
    width: 100%;
    border-top: 3px solid #858796;
    border-bottom: 3px solid #858796;
    border-collapse: collapse;
  	}
  th, td {
     border-bottom: 1px solid #858796;
  }
  
  #reple{
  	vertical-align: text-top;
  	resize: none;
  }
		
  #repleContent{
		width: 92%;
	}
	#repleInsertBtn{
		height: 75px;
		font-size: 20px;
		vertical-align: top;
	}
		
</style>
</head>

<body id="page-top">
    <!-- Page Wrapper -->
    <div id="wrapper">
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
            <div id="content">
            	<form:form id="busiBoardForm" commandName="busiPostVo" method="post" >
            		<form:hidden id="pageIndex" path="pageIndex"/>
                    <form:hidden path="recordCountPerPage"/>
                    <form:hidden path="searchCondition"/>
                    <form:hidden path="searchKeyword"/>
                    <form:hidden id="postSeq" path="postSeq"/>
                    	<%-- 글 id : ${busiPostVo.postSeq } --%>
                    <input type="hidden" id="parentpostId" name="parentpostId" value="${busiPostVo.parentpostId }"/>
                    <form:hidden id="boardId" path="boardId"/>
            	</form:form>
                <!-- Begin Page Content -->
                <div class="container-fluid"  style="max-width: 90%;">
                    <!-- Page Heading -->
                    <h2 class="h3 mb-2 text-gray-800" style="display: inline;"><i class="fas fa-fw fa-users-cog" style="margin-left: 10px; "></i>&nbsp;&nbsp;글 조회</h2>
                    <hr>
                    <br>
                    <!-- summernote -->
                    <table  width="100%" cellspacing="0">
                    	<tr>
                    		<td class="front">제목</td>
                    		<td><span autofocus maxlength="30" minlength="1" style="margin-left: 10px; width: 90%;"><b>${busiPostVo.title }</b></span></td>
                    	</tr>
                    	<tr>
                    		<td class="front">글쓴이</td>
                    		<td><span autofocus maxlength="30" minlength="1" style="margin-left: 10px; width: 90%;"><b>${busiPostVo.empNm} ${busiPostVo.jobtitleNm}</b></span></td>
                    	</tr>
                    	<tr>
                    		<td class="front">작성일자</td>
                    		<td><span autofocus maxlength="30" minlength="1" style="margin-left: 10px; width: 90%;"><b>
                    			<fmt:parseDate var="regDt" value="${busiPostVo.regDt }" pattern="yyyy-MM-dd HH:mm"/>
                    			<fmt:formatDate value="${regDt }" pattern="yyyy-MM-dd HH:mm"/>
                    		</b></span></td>
                    	</tr>
						<tr>
							<td class="front"><i class="fas fa-fw fa-paperclip" style="margin-left: 10px;"></i>첨부파일</td>
							<td>
								<div class="col-sm-10">
									<c:forEach items="${busiPostVo.busiFileList }" var="busiFile" varStatus="status">
										<span><a href="/postFileDownload?attachfileSeq=${busiFile.attachfileSeq }"> • ${busiFile.realfilename }</a></span>
										<br>									
									</c:forEach>
								</div>
							</td>
						</tr>
						<tr >
							<td colspan="2">
							 	<textarea id="summernote" name="post_content">${busiPostVo.content }</textarea>
							</td>
						</tr>
					</table>
					 	<br>
					 	<button type="button" id="replier" class="btn" style="display:inline; float: right; background-color:#104467; color:white;" onclick="javascript:insertPostView()">답글</button>
					 	<c:if test="${EMP.empId == busiPostVo.empId }">
						 	<button type="button" id="updater" class="btn btn-warning" style="display:inline; margin-right : 10px; float: right; color:white;" onclick="javascript:updatePostView()">수정</button>
						 	<button type="button" id="deleter" class="btn btn-danger" style="display:inline; margin-right : 10px; float: right; color:white;" onclick="javascript:deletePost()">삭제</button>					 	
					 	</c:if>
					 	<button type="button" id="btnList" class="btn" style="display:inline; margin-right : 10px; float: left; color:white; background-color:#104467; " onclick="javascript:postListPage()">목록</button>
						<br>
						<script>
							function deletePost(){
								var form = document.getElementById('busiBoardForm');
								var isDelete = confirm('정말 삭제하시겠습니까?');
					        	if(isDelete){
					        		form.action = "/deletePost";
					        		form.submit();
					        	}
							}
						
							function updatePostView(){
								var form = document.getElementById('busiBoardForm');
								form.action = "/updatePostView";
								form.submit();
							}
						
							function insertPostView(){								
								var form = document.getElementById('busiBoardForm');
								var parentId = document.getElementById('parentpostId');
								var postSeq = document.getElementById('postSeq');
								parentId.value = postSeq.value;
								form.action = "/insertPostView";
								form.submit();
							}
							function postListPage(){
								var form = document.getElementById('busiBoardForm');
								form.action = "/selectPostList";
								form.submit();
							}
						</script>			
				<!-- End summernote -->
					
				<br>
				  <div id="repleDivParent">
		                	<div id="repleDivHeader"><span>댓글 목록</span></div>
		                	<hr>
							<div id="repleDivBody" style="margin-left: 3%;">
								<c:if test="${busiPostVo.busiRepleList.size() > 0}">
									<c:forEach items="${busiPostVo.busiRepleList }" var="reple">
									<form class="delteRepleForm" action="/deleteBusiReple" method="post">
										<input type="hidden" name="pageIndex" value="${busiPostVo.pageIndex }">
					                    <input type="hidden" name="recordCountPerPage" value="${busiPostVo.recordCountPerPage }"/>
					                    <input type="hidden" name="searchCondition" value="${busiPostVo.searchCondition }"/>
					                    <input type="hidden" name="searchKeyword" value="${busiPostVo.searchKeyword }"/>
					                    <input type="hidden" name="boardId" value="${busiPostVo.boardId }"/>
					                    <input type="hidden" name="parentpostId" value="${busiPostVo.parentpostId }">
					                
										<div class="showRepleDiv" 
											style="color: black; background: #F1F1F1; border-radius: 20px; padding: 20px; font-size: 15px; font-family: inherit;">
											<input type="hidden" class="repleSeq" name="repleSeq" value="${reple.repleSeq }" />
											<input type="hidden" class="postSeq" name="postSeq" value="${reple.postSeq }" />
											${reple.empNm} ${reple.jobtitleNm}<br>
											<div style="float: right;">
												작성일자 : <fmt:parseDate value="${reple.regDt }" pattern="YYYY-MM-dd" var="regDt"/>
												<fmt:formatDate value="${regDt}" pattern="YYYY-MM-dd"/>
												&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<c:if test="${EMP.empId == reple.empId}">
													<c:if test="${reple.repleSt=='Y'}">
														<br><button type="button" class="btn delRepleBtn" onclick="repleDelete(this)"
														style="float: right; margin-right: 5px; margin-top: -5px; background-color: white;" id="replDeleter">삭제</button>
													</c:if>											
												</c:if>
											</div>
											<br>
											<c:choose>
												<c:when test="${reple.repleSt=='N'}">
													<span>삭제된 댓글입니다.</span>
												</c:when>
												<c:otherwise>
													<span>${reple.repleCont }</span>
												</c:otherwise>
											</c:choose>
										</div>
										<br>
									</form>
									</c:forEach>
									<script>
										function repleDelete(id){
											var form = $(id).parents('.delteRepleForm');
											console.log("form : "+form);
											form.submit();
											
										}
									</script>
								</c:if>
							</div>
		                	<hr>
		                	${uploadtoken }
							<form id="repleWriteForm" action="/insertBusiReple" method="post">
								<input type="hidden" name="postSeq" value="${busiPostVo.postSeq }"/>
								<input type="hidden" id="empId" name="empId" value="${EMP.empId }"/>
								<input type="hidden" name="pageIndex" value="${busiPostVo.pageIndex }">
			                    <input type="hidden" name="recordCountPerPage" value="${busiPostVo.recordCountPerPage }"/>
			                    <input type="hidden" name="searchCondition" value="${busiPostVo.searchCondition }"/>
			                    <input type="hidden" name="searchKeyword" value="${busiPostVo.searchKeyword }"/>
			                    <input type="hidden" name="boardId" value="${busiPostVo.boardId }"/>
			                    <input type="hidden" name="parentpostId" value="${busiPostVo.parentpostId }">
			                    <input type="hidden" id="insertRepleToken" name="uploadtoken" value="">
								<div id="writeRepleDiv" style="margin-left: 3%;">
									<textarea id="repleContent" name="repleCont" rows="3" cols="10" style="resize: none;"></textarea>
									<button type="button" onclick="javascript:insertReple()" id="repleInsertBtn"class="btn" style="background-color: white;">등록</button>
								</div>	
							</form>
							<script>
								function insertReple(){
									document.getElementById("insertRepleToken").value = "${uploadtoken}";
									console.log("${uploadtoken}");
									document.getElementById("repleWriteForm").submit();
								}
							
							
							</script>
		                	<hr>
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
<!--     <a class="scroll-to-top rounded" href="#page-top"> -->
<!--         <i class="fas fa-angle-up"></i> -->
<!--     </a> -->

    
</body>

</html>