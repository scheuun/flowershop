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
						<td><a href='/notice/detailNotice?noticeNum=\${notice.noticeNum}'>
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
<%@ include file ="../../../res/lib.css"%>
</style>
<div class='container'>
	<%@ include file='../include/header.jsp' %>
<br><br><br><br>
	<div class='row'>
         <h5 style='color:#0f56ba'><b>| 공지</b></h5>
           <table class='table'>
              <thead class='text-center'><tr><th style='width:4em'>번호</th><th>제목</th><th style='width:5em'>작성자</th><th>작성일</th></tr></thead>
              <tbody class='text-center' id='notices'>
              </tbody>            
			  <tr>
				<td></td><td></td><td></td>
			 </tr>
		</table>
		<div class='col d-flex justify-content-center' id='pagination'>
			<a href='#'>&lt;이전&nbsp;</a>	
		   <strong>[1]</strong>
		   <a href='#'>&nbsp;다음&gt;</a>
		</div>
	</div>
</div><span style="line-height:300%"><br></span>
<%@ include file='../include/footer.jsp' %>