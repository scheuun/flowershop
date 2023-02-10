<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<title>TAEMOON Flower</title>
<%@ include file ='../include/lib.jsp'%>
<script>
function listReviews(){
	$('#reviews').empty();
	$.ajax({
		type:'post',
		url:"<%=request.getContextPath() %>/review/listReview"
	}).done(reviews => {
		if(reviews.length) {
			const reviewArr = []
			
			$.each(reviews, (i, review) => {
				reviewArr.unshift(
					`<tr>
						<td>
						\${review.reviewNum}</a></td>
						<td><a href='/review/detailReview?reviewNum=\${review.reviewNum}'>
						\${review.title}</td>
						<td>\${review.userId}</td>
						<td>\${review.regDate}</td>
					</tr>`
				);
			})
			$('#reviews').append(reviewArr.join(''))
		} else {
			$('#reviews').append('<tr><td colspan=5 class=text-center>후기가 없습니다.</td></tr>')
		}
	})
	
	$('#noLoginBtn').click(() => {
		$('#noLoginModal').modal()
	})
}
$(listReviews)
</script>
<style>
<%@ include file ="../../../res/lib.css"%>
</style>
<div class='container'>
	<%@ include file='../include/header.jsp' %>
<br><br><br><br>
	<div class='row'>
         <h5 style='color:#0f56ba'><b>| 후기</b></h5>
           <table class='table'>
              <thead class='text-center'><tr><th style='width:4em'>번호</th><th>제목</th><th style='width:5em'>작성자</th><th>작성일</th></tr></thead>
              <tbody class='text-center' id='reviews'>
              </tbody>            
			  <tr>
				<td></td><td></td><td></td>
				<td>
					<c:if test="${not empty sessionScope.userId}">
						<button type='button' id='addBtn' class='btn btn-outline-secondary btn-sm' 
							style='float:right' onclick="location.href='./addReview'">글쓰기 </button>
					</c:if>
					<c:if test="${empty sessionScope.userId}">
						<button type='button' id='noLoginBtn' class='btn btn-outline-secondary btn-sm' 
							style='float:right'>글쓰기</button>	
					</c:if>	
				</td>
			 </tr>
		</table>
		<div class='col d-flex justify-content-center' id='pagination'>
			<a href='#'>&lt;이전&nbsp;</a>
		   <strong>[1]</strong>
		   <a href='#'>&nbsp;다음&gt;</a>
		</div>
	</div>
</div>

<div id='noLoginModal' class='modal fade' tabindex='-1'>
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
					로그인으로
				</p>
			</div>
			<div class='modal-footer'>
				<button type='button' class='btn btn-outline-secondary' id='noWriterConfirmBtn'
					onclick="location.href='../user/login'">확인</button>
			</div>
		</div>
	</div>
</div>
<%@ include file='../include/footer.jsp' %>