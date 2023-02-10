<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<title>TAEMOON Flower</title>
<%@ include file ='../include/lib.jsp'%>

<script>
function listOrders() {
	$('#orders').empty()
	
	$.ajax({
		method: 'post',
		url: "<%=request.getContextPath() %>/order/listOrder"
	}).done(orders => {
		if(orders.length) {
			const orderArr = []
	
			$.each(orders, (i, order) => {
				orderArr.unshift(
					`<tr>
						<td>
							<input type='radio' value='\${order.orderNum}' name='orderNum' id='orderNum'/>
						</td>
						<td><a href='/order/detailOrder?orderNum=\${order.orderNum}&flowerNum=\${order.flowerNum}'>
						\${order.orderNum}</a><input type='hidden' id='flowerNum' name='flowerNum' value='\${order.flowerNum}' readonly/></td>
						<td><small>\${order.payment}</small></td>
						<td><small>\${order.hopeDeliDate}<small></td>
						<td><small>\${order.deliState}</small></td>
					</tr>`
				);
			})
			
			$('#orders').append(orderArr.join(''))
		} else {
			$('#orders').append('<tr><td colspan=5 class=text-center>구매내역이 없습니다.</td></tr>')
		}
	})
}

function init() {
	$(listOrders)
		$('#delBtn').click(() => {
		if($('#orderNum:checked').val()) {
			$('#modalTitle').text('취소/환불');
			$('#modalMsg').text('취소/환불 하시겠습니까?');
			$('#confirmModal').modal();
			$('#noBtn').show();
			$('#yesBtn').show();
			$('#okBtn').hide();
		} else {
			$('#modalTitle').text('상품 미선택');
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
				url: 'fix/' + $('#orderNum:checked').val(),
				type: 'put'
			}).done(console.log('${result}'))
	})
	
}
$(init)
</script>
<style>
<%@ include file ="../../../res/lib.css"%>
table {
	width: auto;
	text-align: center;
}

table {
    width: 100%;
    border-collapse: collapse;
    text-align: center;
  }

th {
    border-bottom: 1px solid #444444;
    padding: 10px;
  }
  
tr {
	height: auto;
}
</style>
<div class='container'>
	<%@ include file='../include/header.jsp' %>
	<br><br>
	<div class='row d-flex justify-content-center mt-5'>
		<div class='col'>
			<h5 style='color: #0f56ba;'><b>| 구매 내역</b></h5>
			<br>

			<table>
				<thead>
					<tr><th></th><th>주문번호</th><th>결제방법</th><th>희망 배송일</th><th>상태</th></tr>
				</thead>
                 <tbody id='orders'>
                 
				</tbody>
				<tr>
					<td colspan='5' style='text-align:left;'><small>※환불 상담은 문의로 진행됩니다. 아래 링크를 이용해 주세요.</small></td>
				</tr>
			</table>

		</div>
	</div>
	<div class='row d-flex justify-content-end mt-1'>
		<button id='delBtn' class="btn btn-outline-secondary m-5 d-flex justify-content-center">취소/환불</button>
	</div>
</div>

<div id='confirmModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<p id='modalTitle'></p>
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
<%@ include file='../include/footer.jsp' %>