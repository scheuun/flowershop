<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<title>TAEMOON Flower</title>

<%@ include file ='../include/lib.jsp'%>

<script>

</script>
<style>
<%@ include file ="../../../res/lib2.css"%>
</style>
<div class='container-fluid'>
	<c:if test="${empty sessionScope.userId}">
	<br><br><br><br>
	<div class='col'>
		<h5 style='color:#0f56ba'><b>관리자</b></h5>
	</div>
	<hr><br><br>
			<div class='text-center'>
				<h5 style='text-align:center'><b>권한이 없습니다.</b></h5>
			</div>
			<div class='row d-flex justify-content-center'>
				<button type="button" class="btn btn-outline-secondary m-5 d-flex justify-content-center"
					onclick="location.href='<%=request.getContextPath() %>/user/login'">로그인으로</button>
			</div>
	</c:if>
	<c:if test="${not empty sessionScope.userId}">
		<%@ include file='include/headerAdmin.jsp' %>	
		<div class='row mt-5 justify-content-center' >
			<div class='col-11' id="adminOrder">
				<h5 style='color:#0f56ba'><b>| 전체 현황</b></h5><br>
				<table class='table table-bordered mt-3 text-center'>
					<thead class='thead' style='background-color:#b1c3e0'>
						<tr>
							<th>회원</th>
							<th>꽃</th>
							<th>주문</th>
						</tr>
					</thead>
					<tbody class='table-bordered'>
						<tr>
							<td>
								<c:forEach var='user' items="${userList}" varStatus="status">
									<c:if test='${status.first}'>
										${fn:length(userList)}명
									</c:if>
								</c:forEach>
								<c:if test='${fn:length(userList) == 0}'>
									0명
								</c:if>
							</td>
							<td>
								<c:forEach var='flower' items="${flowerList}" varStatus="status">
									<c:if test='${status.first}'>
										${fn:length(flowerList)}개
									</c:if>
								</c:forEach>
								<c:if test='${fn:length(flowerList) == 0}'>
									0개
								</c:if>
							</td>
							<td>
								<c:forEach var='order' items="${orderList}" varStatus="status">
									<c:if test='${status.first}'>
										${fn:length(orderList)}회
									</c:if>
								</c:forEach>
								<c:if test='${fn:length(orderList) == 0}'>
									0회
								</c:if>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class='row justify-content-center' style='height:400px'>
			<div class='col-11 mt-4' id="adminBorder">
				<table class='table table-bordered mt-3 text-center'>
					<thead style='background-color:#b1c3e0'>
						<tr>
							<th>후기</th>
							<th>공지</th>
						</tr>
					</thead>
					<tbody id='borderStatus' class='table-bordered'>
						<tr>
							<td>
								<c:forEach var='review' items="${reviewList}" varStatus="status">
									<c:if test='${status.first}'>
										${fn:length(reviewList)}개
									</c:if>
								</c:forEach>
								<c:if test='${fn:length(reviewList) == 0}'>
									0개
								</c:if>
							</td>
							<td>
								<c:forEach var='notice' items="${noticeList}" varStatus="status">
									<c:if test='${status.first}'>
										${fn:length(noticeList)}개
									</c:if>
								</c:forEach>
								<c:if test='${fn:length(noticeList) == 0}'>
									0개
								</c:if>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</c:if>
</div>
<%@ include file='include/footer.jsp' %>