<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<title>TAEMOON Flower</title>
<%@ include file ='../include/lib.jsp'%>
<script>

</script>
<style>
<%@ include file ="../../../res/lib.css"%>
</style>
<div class='container'>
	<%@ include file='../include/header.jsp' %>
	<br><br><br><br>
	<div class='row'>
			<h5 style='display:block;color:#0f56ba;'><b>| 공지 상세</b></h5>
		     <table class='table'>
		        <thead class='text-center'><tr><th>번호</th><th>제목</th><th>작성자</th><th>작성일</th></tr></thead>
		        <c:forEach var="notice" items="${noticeList}">
		        <tbody class='text-center'>
		        	<tr>
		        		<td>${notice.noticeNum}</td>
		           		<td>${notice.title}</td>
		           		<td>관리자</td>
		           		<td>${notice.regdate}</td>
		           	</tr>                   
				</tbody>
				</c:forEach>
			</table>
			<table class='table'>
				<c:forEach var="notice" items="${noticeList}">
					<tr>
						<td><textarea id='content' style='width:100%' rows='15' readonly>${notice.content}</textarea></td>
					</tr>
				</c:forEach>
				<tr>
					<td>
						<div style='float:right;'>
							<button type='button' id='listBtn' class='btn btn-outline-secondary btn-sm' 
								onclick="location.href='./listNotice'">목록</button>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</div>

<%@ include file='../include/footer.jsp' %>