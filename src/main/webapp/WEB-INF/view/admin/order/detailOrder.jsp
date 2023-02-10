<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='f' uri='http://www.springframework.org/tags/form' %>
<title>TAEMOON Flower</title>
<%@ include file ='../include/lib.jsp'%>

<script>

</script>
<style>
<%@ include file ="../../../../res/lib2.css"%>
table.type1 {
    width: 100%;
    text-align: center;
}

table.type1 th {
  padding: 15px;
  font-weight: bold;
  vertical-align: top;
  width: 150px;
}

table.type2 {
    width: 100%;
    border-collapse: collapse;
    text-align: center;
  }

table.type2 th {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
  
table.type2 tr {
	height: 50px;
}
</style>
<div class='container-fluid'>
	<%@ include file='../include/headerAdmin.jsp' %>
   	<div class='row'>
		<div class='col-2 mt-3' id="adminBorder">
			<table class='table table-bordered text-center'>
				<thead>
					<tr>
						<th><i class="fa fa-cash-register" style='color:#0f56ba; font-size:100px'></i></th>
					</tr>
					<tr style='background-color:#b1c3e0;'>
						<th>주문 관리</th>
					</tr>
				</thead>
				<tbody id='borderStatus' class='table-borderless'>
					<tr><td></td></tr>
					<tr>
						<td><a href='../order/listOrder' style='color:black; font-weight:bold'><b>주문 현황</b></a></td>
					</tr>
					<tr><td></td></tr>
				</tbody>
			</table>
		</div>
<div class='col mt-5'>
	<h5 style='color: #0f56ba;'><b>| 주문 상품</b></h5>
	<br>
	<table class='type2'>
		<thead>
		</thead>
		<tbody class='border-bottom lightgray'>
			<tr><th>주문번호</th><th>상품</th></tr>
			<tr>
				<c:forEach var="flower" items="${flowerList}">
					<c:forEach var="order" items="${orderList}">
						<td>${order.orderNum}</td>
						<td>${flower.flowerName}<br>외 ${order.amount-1}개</td>
					</c:forEach>
				</c:forEach>
			</tr><tr></tr>
		</tbody>
	</table><br>
	<h5 style='color: #0f56ba;'><b>| 주문 정보</b></h5><br>
	<table class="type1">
		<c:forEach var="order" items="${orderList}">
		<tr>
			<th>수령인 : </th><td>${order.recName}</td>
		</tr>
		<tr>	
			<td><b>수령인연락처 : </b></td><td>${order.recContactNum}</td>
		</tr>
		<tr>
			<th>희망 배송일 : </th><td>${order.hopeDeliDate}</td>
		</tr>
		<tr>
			<th>결제방법 : </th><td>${order.payment}</td>
		</tr>
		<tr>
			<th>상태 : </th><td>${order.deliState}</td>
		</tr>
		<tr>
			<th>배송지 : </th>
			<td>${order.recPostCode}<br>${order.recAddr}<br>${order.recDetailAddr}</td>
		<tr>
		<tr>
			<th>요청사항: </th><td>${order.request}</td>
		</tr>
		</c:forEach>
	</table><hr>
	<h5 style='color: #0f56ba;'><b>| 총 금액</b></h5><br>
	<c:forEach var="order" items="${orderList}">
		<p><strong>금액 :</strong> ${order.price}원</p>
		<p><strong>배송비 포함 :</strong> ${order.price + order.deliFee}원</p>
	</c:forEach>
</div>
</div>
<div class='row d-flex justify-content-center mt-1'>
	<button id='listBtn' class='btn btn-outline-secondary m-5 d-flex justify-content-center' onclick='history.go(-1)'>목록</button>
	</div>
</div>



<div id='confirmModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<h5 class='modal-title'>상품 미선택</h5>
				<button type='button' class='close' data-dismiss='modal'>
					<span>&times;</span>
				</button>
			</div>
			<div class='modal-body' align='center'>
				<p id='modalMsg'></p>
			</div>
			<div class='modal-footer'>
				<button type='button' class='btn btn-secondary' data-dismiss='modal' id='noBtn'>아니오</button>
				<button type='button' class='btn btn-outline-secondary' data-dismiss='modal' id='okBtn'>확인</button>
			</div>
		</div>
	</div>
</div>
<%@ include file='../include/footer.jsp' %>