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
			url: 'del/' + $('#reviewNum').val(),
			method: 'delete'
		})
	})
	
	$('#noWriterDelBtn').click(() => {
		$('#noWriterModal').modal();
	})
	
	$('#noWriterFixBtn').click(() => {
		$('#noWriterModal').modal();
	})
}

$(init);
</script>
<style>
<%@ include file ="../../../res/lib.css"%>
</style>
<div class='container'>
	<%@ include file='../include/header.jsp' %>
	<br><br><br><br>
	<div class='row'>
			<h5 style='color:#0f56ba;'><b>| 후기 상세</b></h5>
		     <table class='table'>
		        <thead class='text-center'><tr><th>번호</th><th>제목</th><th>작성자</th><th>작성일</th></tr></thead>
		        <c:forEach var="review" items="${reviewList}">
		        <tbody class='text-center'>
		        	<tr>
		        		<td>${review.reviewNum}<input type='hidden' id='reviewNum' value='${review.reviewNum}' readonly></td>
		           		<td>${review.title}<input type='hidden' id='title' value='${review.title}' /></td>
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
								onclick="location.href='./listReview'">목록</button>
							<c:forEach var="review" items="${reviewList}">
							<c:if test="${sessionScope.userId == review.userId}">
								<button type='button' id='delBtn' class='btn btn-outline-secondary btn-sm' 
								>삭제 </button>
								<button type='button' id='fixBtn' class='btn btn-outline-secondary btn-sm' 
									onclick="location.href='/review/modReview?reviewNum=${review.reviewNum}'">수정 </button>
							</c:if>
							<c:if test="${sessionScope.userId != review.userId}">
								<button type='button' id='noWriterDelBtn' class='btn btn-outline-secondary btn-sm' 
									>삭제</button>
								<button type='button' id='noWriterFixBtn' class='btn btn-outline-secondary btn-sm' 
									>수정</button>
							</c:if>
							</c:forEach>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>

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
					onclick="location.href='./listReview'">예</button>
				<button type='button' class='btn btn-secondary' data-dismiss='modal' id='delNoBtn'>아니오</button>
			</div>
		</div>
	</div>
</div>

<div id='noWriterModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<h5 id='modalTitle'>후기 권한</h5>
				<button type='button' class='close' data-dismiss='modal'>
					<span>&times;</span>
				</button>
			</div>
			<div class='modal-body' align='center'>
				<p id='noWriterModalMsg'>
					권한이 없습니다.<br>
				</p>
			</div>
			<div class='modal-footer'>
				<button type='button' class='btn btn-outline-secondary' id='noWriterConfirmBtn'
					onclick="location.href='../review/listReview'">확인</button>
			</div>
		</div>
	</div>
</div>

<%@ include file='../include/footer.jsp' %>