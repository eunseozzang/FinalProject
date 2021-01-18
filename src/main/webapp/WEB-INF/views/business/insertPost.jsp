<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>업무보고 작성</title>


    <!-- Custom styles for this template -->
<!--     <link href="/admin2form/css/sb-admin-2.min.css" rel="stylesheet"> -->

    <!-- Custom styles for this page -->
    <link href="/admin2form/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
	<!-- Bootstrap core JavaScript-->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
	
	<script>
    $(document).ready(function() {
    	fileSlotCnt = 1;
    	maxFileSlot = 5;
    	idx = 0;
        $('#summernote').summernote();
        
/*         $('#sender').on('click', function(){
        	$('form').submit();
        }); */
        
/*        $('#resetter').on('click', function(){
    	   $('#summernote').summernote('reset');
       }); */
       
       $('#btnPlus').on('click', function(){
    	   if(maxFileSlot <= fileSlotCnt){
    		   alert("파일은 총 "+maxFileSlot+"개 까지만 첨부가능합니다.");
    	   }
    	   else{
			   fileSlotCnt++;
			   idx++;
	    	   console.log("click!!");
	    	   var html = '<br><input type="file" name="realfilename['+idx+']">'
	    	   				+'<button type="button" class="btn btn-primary btnMinus" style="margin-left: 5px; outline: 0; border: 0;">'
								+'<i class="fas fa-fw fa-minus" style="color: white; font-size:10px;"></i>'
							+'</button>';
	    	   $(this).parent().append(html);    		   
    	   }
    	   
       })
       
       $('#fileDiv').on('click', '.btnMinus', function(){
    	   if(fileSlotCnt > 1){
    		   fileSlotCnt--;
    		   idx--;
    		   console.log(fileSlotCnt);
    	   }
    	   $(this).prev().prev().remove();
    	   $(this).prev().remove();
    	   $(this).remove();
       })
       
      
      //summernote modal title 과 close 버튼 위치 변경  
       title = $('h4.modal-title');
  		for(var i = 0; i< title.length; i++){
  			$(title[i]).insertBefore($(title[i]).prev());
  		}
        
    });
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
    border-collapse: collapse;
  }
  th, td {
    border-bottom: 1px solid #858796;
    padding: 10px;
  }
  /* modal 창 출력 시 배경 투명화   */
  .in {
	background: rgba(0, 0, 0, 0.2);
  }
  
  /* .modal-title{
  	display : none;
  } */
		
		
</style>
</head>

<body id="page-top">
    <!-- Page Wrapper -->
    <div id="wrapper">
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
            <div id="content">
                <!-- Begin Page Content -->
                <div class="container-fluid"  style="max-width: 90%;">
                    <!-- Page Heading -->
                    <h2 class="h3 mb-2 text-gray-800" style="display: inline;"><i class="fas fa-fw fa-users-cog" style="margin-left: 10px; "></i>&nbsp;&nbsp;업무보고서 작성</h2>
                    <hr>
                    <br>
                    <!-- summernote -->
					<form:form id="busiPostForm" commandName="busiPostVo" action="/insertPost" method="post" enctype="multipart/form-data">
						<form:hidden path="boardId"/>
						<form:hidden path="empId"/>
						<form:hidden path="postSeq"/>
						<form:hidden path="pageIndex"/>
						<form:hidden path="recordCountPerPage"/>
						<form:hidden path="searchCondition"/>
						<form:hidden path="searchKeyword"/>
						<form:hidden path="parentpostId"/>
						<input type="hidden" name="uploadtoken" value="insertPost">
				<%-- 	<input type="hidden" name="boardId" value="${busiPost.boardId}">
					<input type="hidden" name="empId" value="${EMP.empId }">
					<input type="hidden" name="postSeq" value="${busiPostVo.postSeq }"/>
					<input type="hidden" name="pageIndex" value="${busiPostVo.pageIndex }">
                    <input type="hidden" name="recordCountPerPage" value="${busiPostVo.recordCountPerPage }"/>
                    <input type="hidden" name="searchCondition" value="${busiPostVo.searchCondition }"/>
                    <input type="hidden" name="searchKeyword" value="${busiPostVo.searchKeyword }"/>
					<c:if test="${busiPost.parentpostId != null }">
						<input type="hidden" name="parentpostId" value="${busiPost.parentpostId }">					
					</c:if> --%>
                    <table  width="100%" cellspacing="0">
                    	
                    	<tr>
                    		<td class="front">제목</td>
                    		<td>
                    			<!-- <input type="text" id="title" name="title" autofocus maxlength="30" minlength="1" style="margin-left: 10px; width: 90%;"> -->
                    			<form:input id="title" path="title" cssStyle="margin-left: 10px; width: 90%;" maxlength="30" minlength="1"/>
                    		</td>
                    	</tr>
						<tr>
							<td class="front">
								<i class="fas fa-fw fa-paperclip" style="margin-left: 10px;"></i>
								첨부파일
							</td>
							<td>
								<div id="fileDiv" class="col-sm-10">
									<input type="file" name="realfilename[0]">
									<button type="button" id="btnPlus" class="btn btn-primary" style="outline: 0; border: 0;">
										<i class="fas fa-fw fa-plus" style="color: white; font-size:10px;"></i>
									</button>
								</div>
							</td>
						</tr>
						<tr >
							<td colspan="2">
								<!-- <textarea id="summernote" name="content"></textarea> -->
							 	<form:textarea id="summernote" path="content"></form:textarea>
							</td>
						</tr>
					</table>
					 	<br>
					 	<button type="button" onclick="javascript:insertPost()" id="sender" class="btn btn-outline-secondary" style="display:inline; float: right;">등록</button>
					 	<button type="button" onclick="javascript:resetForm()" id="resetter" class="btn btn-outline-secondary" style="display:inline; margin-right : 10px; float: right;">초기화</button>
					 	<button type="button" onclick="javascript:postListPage()" class="btn btn-outline-secondary"  tyle="display:inline;margin-right : 10px; float: left;">목록으로</button>
					</form:form>
					<script>
						function postListPage(){
							var form = document.getElementById('busiPostForm');
							form.action = "/selectPostList";
							form.submit();
						}
					
						function insertPost(){
							var form = document.getElementById('busiPostForm');
							form.action = "/insertPost";
							form.submit();
						}
						
						function resetForm(){
							 document.getElementById('summernote').summernote('reset');
							 document.getElementById('busiPostForm').reset();
						}
					
					</script>
				<!-- End summernote -->
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