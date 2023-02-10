<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<title>TAEMOON Flower</title>

<%@ include file ='../include/lib.jsp'%>

<script>

</script>
<style>
<%@ include file ="../../../res/lib.css"%>
</style>
<div class='container'>
<%@ include file='../include/header.jsp' %><br><br><br><br>
<c:set var="URL" value="${pageContext.request.queryString}"/>
<c:if test='${fn:containsIgnoreCase(URL, "posy")}'>
	<c:forEach var='flower' items='${flowerList}' varStatus="status">
		<c:if test='${status.first}'>
			<h5 style='color: #0f56ba;'><b>| 꽃다발</b></h5><hr><br>
		</c:if>
	</c:forEach>
	<div class='row'  id='flowers'>
		<c:forEach var='flower' items='${flowerList}'>
			<c:if test='${flower.kind == "꽃다발"}'>
				<div class='col text-center'>
					<div><a href='/flower/detailFlower?flowerNum=${flower.flowerNum}'><img style="width:150px; height:150px;"src='<c:url value="/attach/${flower.flowerImgfileName}"/>'/></a></div>
					<p><a href='/flower/detailFlower?flowerNum=${flower.flowerNum}' style='color:#000000;'>${flower.flowerName}</a><br><small>${flower.price}&nbsp;<span class='badge badge-primary'>${flower.flowerCategory}</span></small></p>		
				</div>
			</c:if>
		</c:forEach>
	</div>
</c:if>

<c:if test='${fn:containsIgnoreCase(URL, "basket")}'>
	<c:forEach var='flower' items='${flowerList}' varStatus="status">
		<c:if test='${status.first}'>
			<h5 style='color: #0f56ba;'><b>| 꽃바구니</b></h5><hr><br>
		</c:if>
	</c:forEach>
	<div class='row'  id='flowers'>
		<c:forEach var='flower' items='${flowerList}'>
			<c:if test='${flower.kind == "꽃바구니"}'>
				<div class='col text-center'>
					<div><a href='/flower/detailFlower?flowerNum=${flower.flowerNum}'><img style="width:165px; height:165px;"src='<c:url value="/attach/${flower.flowerImgfileName}"/>'/></a></div>
					<p><a href='/flower/detailFlower?flowerNum=${flower.flowerNum}' style='color:#000000;'>${flower.flowerName}</a><br><small>${flower.price}&nbsp;<span class='badge badge-primary'>${flower.flowerCategory}</span></small></p>		
				</div>
			</c:if>
		</c:forEach>
	</div>
</c:if>
</div>	<br><br><br><br>
<%@ include file='../include/footer.jsp' %>