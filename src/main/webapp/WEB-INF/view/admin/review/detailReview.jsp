<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<title>TAEMOON Flower</title>

<%@ include file ='../include/lib.jsp'%>

<script>
function init() {
	$('#delBtn').click(() => {
		$('#delModal').modal();
	})
	
	$('#delOkBtn').click(() => {
		$('#delModal').modal('hide');
		$.ajax({
			url: 'admin/del/' + $('#reviewNum').val(),
			method: 'delete'
		})
	})
}

$(init)
</script>
<style>
<%@ include file ="../../../../res/lib2.css"%>
</style>
<div class='container-fluid'>
<%@ include file='../include/headerAdmin.jsp' %>
	
	<div class='row'>
		<div class='col-2' id="adminBorder">
			<table class='table table-bordered mt-3 text-center'>
				<thead>
					<tr>
						<th><i class='fas fa-comment-dots' style='color:#0f56ba; font-size:100px'></i></th>
					</tr>
					<tr style='background-color:#b1c3e0;'>
						<th>공지 관리</th>
					</tr>
				</thead>
				<tbody id='noticeBorder' class='table-borderless'>
					<tr><td></td></tr>
					<tr>
						<td><a href='../notice/listNotice' style='color:black'>공지 조회</a></td>
					</tr>
					<tr>
						<td><a href='../notice/addNotice' style='color:black'>공지 등록</a></td>
					</tr>
					<tr><td></td></tr>
				</tbody>
				<thead>
					<tr style='background-color:#b1c3e0;'>
						<th>후기 관리</th>
					</tr>
				</thead>
				<tbody id='reviewBorder' class='table-borderless'>
					<tr><td></td></tr>
					<tr>
						<td><a href='../review/listReview' style='color:black; font-weight:bold'>후기 조회</a></td>
					</tr>
					<tr><td></td></tr>
				</tbody>
			</table>
		</div>
		<div class='col-1'></div>
 	 		<div class='col-7 mt-4'>
				<h5 style='color:#0f56ba;'><b>| 후기 상세</b></h5>
				<div class='flex-column ml-5'>
				<form>
		     <table class='table' style="margin: auto; text-align: center;">
		        <thead class='text-center'><tr><th>번호</th><th>제목</th><th>작성자</th><th>작성일</th></tr></thead>
		        <c:forEach var="review" items="${reviewList}">
		        <tbody class='text-center'>
		        	<tr>
		        		<td><input type='number' id='reviewNum' size='2' style='width:2em; border:none;' value='${review.reviewNum}' readonly></td>
		           		<td><input type='text' id='title' style='width:10em; text-align:center; border:none;' value='${review.title}' readonly /></td>
		           		<td>${review.userId}</td>
		           		<td>${review.regDate}</td>
		           	</tr>                   
				</tbody>
				</c:forEach>
			</table>
			<table class='table'>
				<c:forEach var="review" items="${reviewList}">
					<tr>
						<td><textarea id='content' style='width:100%' rows='15' readonly>${review.content}</textarea></td>
					</tr>
				</c:forEach>
				<tr>
					<td>
						<div style='float:right;'>
							<button type='button' id='listBtn' class='btn btn-outline-secondary btn-sm' 
								onclick="location.href='../review/listReview'">목록</button>
								<button type='button' id='delBtn' class='btn btn-outline-secondary btn-sm' 
								>삭제 </button>
						</div>
					</td>
				</tr>
			</table>
			</form>
		</div>
	</div>
</div>	
 	</div><span style="line-height:300%"><br></span>
<!-- include: modal -->	
<div id='delModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<h5 id='modalTitle'>후기 삭제</h5>
				<button type='button' class='close' data-dismiss='modal'>
					<span>&times;</span>
				</button>
			</div>
			<div class='modal-body' align='center'>
				<p id='delModalMsg'>후기를 삭제하시겠습니까?</p>
			</div>
			<div class='modal-footer'>
				<button type='button' class='btn btn-outline-secondary' id='delOkBtn'
					onclick="location.href='../review/listReview'">예</button>
				<button type='button' class='btn btn-secondary' data-dismiss='modal' id='delNoBtn'>아니오</button>
			</div>
		</div>
	</div>
</div>
<%@ include file='../include/footer.jsp' %>