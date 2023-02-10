<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<title>TAEMOON Flower</title>

<%@ include file ='../include/lib.jsp'%>

<script>
function init() {
	$('#plusBtn').click(() => {
		amount = $('input[name="amount"]').val();
		$('input[name="amount"]').val(parseInt(amount) + 1);
	})
	
	$('#minusBtn').click(() => {
		amount = $('input[name="amount"]').val();
		if(parseInt(amount) > 1) {
			$('input[name="amount"]').val(parseInt(amount) - 1);
		} else {
			$('input[name="amount"]').val(1);
		}	
	});
	
	$('#orderBtn').click(() => {
		if(${not empty sessionScope.userId}) {
			$.ajax({
				url: 'fix',
				method: 'post',
				contentType: 'application/json',
				data: JSON.stringify({
					flowerNum: $('#flowerNum').val(),
					amount: $('#amount').val()
				})
			}).done()
		} else {
			location.href='${pageContext.request.contextPath}/user/login'
		}
	})
	
	$('#cartBtn').click(() => {
		if(${not empty sessionScope.userId}) {
			$.ajax({
				url: '${pageContext.request.contextPath}/flower/addCart',
				type: 'post',
				contentType: 'application/json',
				data: JSON.stringify ({
					flowerNum: $('#flowerNum').val(),
					amount: $('#amount').val()
				})
			}).done()
		} else {
			location.href='${pageContext.request.contextPath}/user/login'
		}
	})
};

$(init);
</script>
<style>
<%@ include file ="../../../res/lib.css"%>
#flowerImage{
	width: 300px;
	height:250px;
    margin: auto;
}

#detailImg {
   width: 100%;
   height: 1000;
   border: 1px solid lightgrey;
   text-align: center;
   margin: auto;
}
</style>
<div class='container'>
<%@ include file='../include/header.jsp' %><br><br><br><br>
	<div class='row'> 
		<div class='col mt-3'>
			<div class='row' id='flowerImage'>
				<div class='col'>
					<c:forEach var="flower" items="${flowerList}">
						<img style="width: 100%; height:250px;"src='<c:url value="/attach/${flower.flowerImgfileName}"/>'/><br>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<div class='row'> 
		<div class='col text-center mt-5'>
			<c:forEach var="flower" items="${flowerList}">
				<p><input type='hidden' id='flowerNum' name='flowerNum' value='${flower.flowerNum}' readonly/>&emsp;&emsp;</p>
					<h5><b>${flower.flowerName}</b></h5>
					<h6>${flower.price}</h6>
			</c:forEach>
			<div class='form-group row mt-3'>
			<div class='col-1'></div>
				<label for='amount' class='col-3 col-form-label'><b>수량</b></label>
				<button type='button' class='btn btn-outline-secondary small' id='minusBtn'>-</button>
				<input type='text' class='col-3 text-center' name='amount' id='amount' value='1' readonly='readonly' />
				<button type='button' class='btn btn-outline-secondary' id='plusBtn'>+</button>
			</div>
			<div class='form-group col mt-5'>
				<div class='col'>
					<div class='row d-flex justify-content-center'>
											<c:forEach var="flower" items="${flowerList}">
						<button type='button'class='btn btn-outline-secondary' id='cartBtn'
							onclick='location.href="<%=request.getContextPath() %>/cart/listCart?userId=${userId}"'>장바구니</button>
						<div style='width:60px'></div>

							<button class='btn btn-outline-secondary' id='orderBtn' 
								onclick='location.href="/order/addOrder?flowerNum=${flower.flowerNum}"'>구매</button>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br><br><hr>
	<div class='row'>
		<div class='col text-center'>
			<c:forEach var="flower" items="${flowerList}">
				<img style='max-width: 100%; height:1000' src='<c:url value="/attach/${flower.detailImgfileName}"/>'/><br>
			</c:forEach>	
		</div>
	</div><br><br>
</div>
<%@ include file='../include/footer.jsp' %>