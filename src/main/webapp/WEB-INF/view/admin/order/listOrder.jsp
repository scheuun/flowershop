<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<title>TAEMOON Flower</title>
<%@ include file ='../include/lib.jsp'%>

<script>
function listOrders() {
	$('#orders').empty()
	
	$.ajax({
		method: 'post',
		url: "<%=request.getContextPath() %>/admin/order/listOrder"
	}).done(orders => {
		if(orders.length) {
			const orderArr = []
	
			$.each(orders, (i, order) => {
				orderArr.unshift(
					`<tr>
						<td>
							<input type='radio' value='\${order.orderNum}' name='orderNum' id='orderNum'/>
						</td>
						<td><a href='/admin/order/detailOrder?orderNum=\${order.orderNum}&flowerNum=\${order.flowerNum}'>
						\${order.orderNum}<input type='hidden' id='flowerNum' name='flowerNum' value='\${order.flowerNum}' readonly/></a></td>
						<td>\${order.userId}</td>
						<td>\${order.payment}</td>
						<td>\${order.hopeDeliDate}</td>
						<td>\${order.deliState}</td>
					</tr>`
				);
			})
	
			$('#orders').append(orderArr.join(''))
		} else {
			$('#orders').append('<tr><td colspan=6 class=text-center>주문내역이 없습니다.</td></tr>')
		}
	})
}

function init() {
	$(listOrders)
		$('#delBtn').click(() => {
		if($('#orderNum:checked').val()) {
			$('#modalTitle').text('구매내역 삭제');
			$('#modalMsg').text('구매를 삭제하시겠습니까?');
			$('#confirmModal').modal();
			$('#noBtn').show();
			$('#yesBtn').show();
			$('#okBtn').hide();
		} else {
			$('#modalMsg').empty();
			$('#modalMsg').text('상품을 선택해주세요.');
			$('#confirmModal').modal();
			$('#noBtn').hide();
			$('#yesBtn').hide();
			$('#okBtn').show();
		}
	})
	$('#yesBtn').click(() => {
		$('#confirmModal').modal('hide')
			$.ajax({
				url: 'del/' + $('#orderNum:checked').val(),
				method: 'delete'
			}).done(listOrders)
	})
	
	$('#completeBtn').click(() => {
		if($('#orderNum:checked').val()) {
			$('#comModalTitle').text('배송 완료');
			$('#comModalMsg').text('구매를 완료하겠습니까?');
			$('#completeModal').modal();
			$('#comNoBtn').show();
			$('#comYesBtn').show();
			$('#comOkBtn').hide();
		} else {
			$('#modalMsg').empty();
			$('#modalMsg').text('상품을 선택해주세요.');
			$('#confirmModal').modal();
			$('#noBtn').hide();
			$('#yesBtn').hide();
			$('#okBtn').show();
		}
	})
	
	$('#comYesBtn').click(() => {
		$('#completeModal').modal('hide')
			$.ajax({
				url: 'fix/' + $('#orderNum:checked').val(),
				method: 'put'
			}).done(listOrders)
	})
}
$(init)
</script>
<style>
<%@ include file ="../../../../res/lib2.css"%>
table.type10 {
    width: 100%;
    text-align: center;
}

table.type10 th {
  padding: 15px;
  font-weight: bold;

  border: 0.5px solid lightgray;
}

table.type10 td {
   border: 0.5px solid lightgray;
   padding: 10px;
}

table.type1 {
    width: 100%;
    text-align: center;
}

table.type1 td{
 	border: 0.5px solid lightgray;
 	padding: 10px;
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
            <h5 style='color: #0f56ba;'><strong>&nbsp;&nbsp;| 주문 현황</strong></h5><hr>    
  			<table class='type1 mb-4'>
				<thead style='background-color:#b1c3e0'>
					<tr>
						<td></td>
						<td><b>주문번호</b></td>
						<td><b>아이디</b></td>
						<td><b>결제 방법</b></td>
						<td><b>희망 배송일</b></td>
						<td><b>주문 상태</b></td>
					</tr>
				</thead>
				<tbody id='orders'>
				</tbody>
			</table>
			<div class='row d-flex justify-content-end mb-5'>
							<button id='completeBtn' class="btn btn-secondary mr-3 d-flex justify-content-center">완료</button>	
				<button id='delBtn' class="btn btn-outline-secondary mr-5 d-flex justify-content-center">삭제</button>		
			</div>	
         </div>
 	</div>
</div>

<div id='confirmModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<h5 id='modalTitle'>상품 미선택</h5>
				<button type='button' class='close' data-dismiss='modal'>
					<span>&times;</span>
				</button>
			</div>
			<div class='modal-body' align='center'>
				<p id='modalMsg'></p>
			</div>
			<div class='modal-footer'>
				<button type='button' class='btn btn-outline-secondary' data-dismiss='modal' id='yesBtn'>예</button>
				<button type='button' class='btn btn-secondary' data-dismiss='modal' id='noBtn'>아니오</button>
				<button type='button' class='btn btn-outline-secondary' data-dismiss='modal' id='okBtn'>확인</button>
			</div>
		</div>
	</div>
</div>

<div id='completeModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<h5 id='comModalTitle'>상품 미선택</h5>
				<button type='button' class='close' data-dismiss='modal'>
					<span>&times;</span>
				</button>
			</div>
			<div class='modal-body' align='center'>
				<p id='comModalMsg'></p>
			</div>
			<div class='modal-footer'>
				<button type='button' class='btn btn-outline-secondary' data-dismiss='modal' id='comYesBtn'>예</button>
				<button type='button' class='btn btn-secondary' data-dismiss='modal' id='comNoBtn'>아니오</button>
				<button type='button' class='btn btn-outline-secondary' data-dismiss='modal' id='comOkBtn'>확인</button>
			</div>
		</div>
	</div>
</div>
<%@ include file='../include/footer.jsp' %>