<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<title>TAEMOON Flower</title>
<%@ include file ='./include/lib.jsp'%>

<script>

</script>
<style>
<%@ include file ="../../res/lib.css"%>
table {
	width: auto;
	text-align: center;
}


[id*='Carousel']{
   width: 200px;
   height: 200px;
   margin: 0 auto;
}
</style>
<div class='container'>
	<%@ include file ='./include/header.jsp'%>
	<br><br><br><br>
	<!-- login and cart -->
	<c:if test="${empty sessionScope.userId}">
		<div class='col'>
			<div id='rightBar' style='text-align: right'>
				<a href='<%=request.getContextPath() %>/user/login'><i class='fa fa-user fa-lg' style='color:#3C5087'></i></a>&emsp;
				<a href='<%=request.getContextPath() %>/user/login'><i class='fa fa-shopping-cart fa-lg' style='color:#3C5087'></i></a>
			</div>
		</div>
	</c:if>
	<!-- login and cart -->
	
	<!-- logout and cart -->
	<c:if test="${not empty sessionScope.userId}">
		<div class='col'>
			<div id='rightBar' style='text-align: right'>
				<a href='<%=request.getContextPath() %>/user/logout'><i class='fa fa-user-slash fa-lg' style='color:#3C5087'></i></a>&emsp;
				<a href='<%=request.getContextPath() %>/cart/listCart?userId=${userId}'><i class='fa fa-shopping-cart fa-lg' style='color:#3C5087'></i></a>
			</div>
		</div>
	</c:if>
	<!-- logout and cart -->
	
	<p><strong>&nbsp;BEST</strong></p>
	   <div class='row'>
			<div class='col'>
				<div id='bestCarousel' class='carousel slide' data-ride='carousel'>
					<div class='carousel-inner'>
						<table class = 'table table-borderless' id='bestProductImg'>
							<tbody>
							   	<tr>
							      <th>
							      	<c:forEach var='flower' items='${flowerList}' varStatus="status">
								      <c:if test='${flower.flowerCategory == "BEST" && status.first}'>
									      <div class='carousel-item active'>
									      		<a href='/flower/detailFlower?flowerNum=${flower.flowerNum}'>
									      			<img style="width:200; height:200px;"src='<c:url value="/attach/${flower.flowerImgfileName}"/>'/>
									      		</a>
									      		<p>
									      			${flower.flowerName}<br>
									      			<small>
									      				${flower.price}원&nbsp;
									      				<span class='badge badge-primary'>${flower.flowerCategory}</span>
									      			</small>
									      		</p>
									   		</div>
								   		</c:if>
								      	<c:if test='${flower.flowerCategory == "BEST" && !status.first}'>
									      	<div class='carousel-item'>
									      		<a href='/flower/detailFlower?flowerNum=${flower.flowerNum}'>
									      			<img style="width:200; height:200px;"src='<c:url value="/attach/${flower.flowerImgfileName}"/>'/>
									      		</a>
									      		<p>
									      			${flower.flowerName}<br>
									      			<small>
									      				${flower.price}원&nbsp;
									      				<span class='badge badge-primary'>${flower.flowerCategory}</span>
									      			</small>
									      		</p>
									      	</div>
								      	</c:if>
							      	</c:forEach>
							      </th>
							   </tr>
							</tbody>
						</table>
					</div>
					<a href='#bestCarousel' class='carousel-control-prev' data-slide='prev'>
						&nbsp;<i class='fa fa-chevron-left' style='color:#000000'></i>
					</a>
					<a href='#bestCarousel' class='carousel-control-next' data-slide='next'>
						&emsp;<i class='fa fa-chevron-right' style='color:#000000'></i>
					</a>
				</div>
			</div>
		</div><br><br><br><br>	
		
	<p><strong>&nbsp;NEW</strong></p>
	<div class='row'>
		<div class='col'>
				<div id='newCarousel' class='carousel slide' data-ride='carousel'>
					<div class='carousel-inner'>
						<table class = 'table table-borderless' id='bestProductImg'>
							<tbody>
							   	<tr>
							      <th>
							      	<c:forEach var='flower' items='${flowerList}' varStatus="status">
								      <c:if test='${flower.flowerCategory == "NEW" && status.last}'>
									      <div class='carousel-item active'>
									      		<a href='/flower/detailFlower?flowerNum=${flower.flowerNum}'>
									      			<img style="width:200; height:200px;"src='<c:url value="/attach/${flower.flowerImgfileName}"/>'/>
									      		</a>
									      		<p>
									      			${flower.flowerName}<br>
									      			<small>
									      				${flower.price}원&nbsp;
									      				<span class='badge badge-primary'>${flower.flowerCategory}</span>
									      			</small>
									      		</p>
									   		</div>
								   		</c:if>
								      	<c:if test='${flower.flowerCategory == "NEW" && !status.last}'>
									      	<div class='carousel-item'>
									      		<a href='/flower/detailFlower?flowerNum=${flower.flowerNum}'>
									      			<img style="width:200; height:200px;"src='<c:url value="/attach/${flower.flowerImgfileName}"/>'/>
									      		</a>
									      		<p>
									      			${flower.flowerName}<br>
									      			<small>
									      				${flower.price}원&nbsp;
									      				<span class='badge badge-primary'>${flower.flowerCategory}</span>
									      			</small>
									      		</p>
									      	</div>
								      	</c:if>
							      	</c:forEach>
							      </th>
							   </tr>
							</tbody>
						</table>
					</div>
					<a href='#newCarousel' class='carousel-control-prev' data-slide='prev'>
						&nbsp;<i class='fa fa-chevron-left' style='color:#000000'></i>
					</a>
					<a href='#newCarousel' class='carousel-control-next' data-slide='next'>
						&emsp;<i class='fa fa-chevron-right' style='color:#000000'></i>
					</a>
				</div>
			</div>
		</div><br><br><br><br>
</div>

<%@ include file ='./include/footer.jsp'%>
