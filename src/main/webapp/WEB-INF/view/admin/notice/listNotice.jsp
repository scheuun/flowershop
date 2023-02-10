<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<title>TAEMOON Flower</title>

<%@ include file ='../include/lib.jsp'%>

<script>
function listNotices(){
	$('#notices').empty();
	$.ajax({
		type:'post',
		url:"<%=request.getContextPath() %>/notice/listNotice"
	}).done(notices => {
		if(notices.length) {
			const noticeArr = []
			
			$.each(notices, (i, notice) => {
				noticeArr.unshift(
					`<tr>
						<td>
						\${notice.noticeNum}</a></td>
						<td><a href='/admin/notice/detailNotice?noticeNum=\${notice.noticeNum}'>
						\${notice.title}</td>
						<td>관리자</td>
						<td>\${notice.regdate}</td>
					</tr>`
				);
			})
			$('#notices').append(noticeArr.join(''))
		} else {
			$('#notices').append('<tr><td colspan=5 class=text-center>공지가 없습니다.</td></tr>')
		}
	}) 
}
$(listNotices)

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
						<td><a href='../notice/listNotice' style='color:black; font-weight:bold'>공지 조회</a></td>
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
						<td><a href='../review/listReview' style='color:black'>후기 조회</a></td>
					</tr>
					<tr><td></td></tr>
				</tbody>
			</table>
		</div>
	<div class='col-1'></div>
		<div class='col-8 mt-4'>
        	<h5 style='color:#0f56ba'><b>| 공지 조회</b></h5>
        	<br>
			<table class='table'>
              <thead class='text-center'><tr><th>번호</th><th>제목</th><th>작성자</th><th>작성일</th></tr></thead>
              <tbody class='text-center' id='notices'>
              </tbody>            
				<tr></tr>
			</table>
		<div class='col d-flex justify-content-center' id='pagination'>
			<a href='#'>&lt;이전&nbsp;</a>	
		   <strong>[1]</strong>
		   <a href='#'>&nbsp;다음&gt;</a>
		</div>
		</div>
	</div>
</div><span style="line-height:300%"><br></span>	
<%@ include file='../include/footer.jsp' %>