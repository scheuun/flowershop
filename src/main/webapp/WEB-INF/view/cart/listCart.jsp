<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<title>TAEMOON Flower</title>

<%@ include file ='../include/lib.jsp'%>
<script>
/*window.onload = function() {
    if(!window.location.hash) {
        window.location = window.location + '#loaded';
        window.location.reload();
    }
}*/
function init() {
	$('#delBtn').click(() => {
		if($('#cartNum:checked').val()) {
			$('#modalMsg').empty();
			$('#modalMsg').text('상품을 삭제하시겠습니까?');
			$('#confirmModal').modal();
			$('#okBtn').hide();
			$('#noBtn').show();
			$('#yesBtn').show();
			$('#yesBtn').click(() => {
				$('#confirmModal').modal('hide')
					$.ajax({
						url: 'del/' + $('#cartNum:checked').val(),
						method: 'get'
					}).done(console.log('${result}'))	
			})
						
		} else {
			$('#modalMsg').empty();
			$('#modalMsg').text('상품을 선택해주세요.');
			$('#confirmModal').modal();
			$('#noBtn').hide();
			$('#yesBtn').hide();
			$('#okBtn').show();
		}
	})
	
	$('#emptyBtn').click(() => {
			$('#modalMsg').empty();
			$('#modalMsg').text('장바구니를 비우시겠습니까?');
			$('#confirmModal').modal();
			$('#okBtn').hide();
			$('#noBtn').show();
			$('#yesBtn').show();
			$('#yesBtn').click(() => {
				$('#confirmModal').modal('hide')
					$.ajax({
						url: 'empty',
						method: 'delete'
					}).done(console.log('${result}'))
			})
			
		})
}



$(init)
</script>
<style>
table {
	width: auto;
	text-align: center;
}
 
table.type1 {
    width: 100%;
    border-collapse: collapse;
    text-align: center;
  }
  
table.type1 tr {
	height: 100px;
}

#image {
	width: 8rem;
	height: 8rem;
	border: 1px solid lightgrey;
}
<%@ include file ="../../../res/lib.css"%>
</style>
<div class='container'>
<%@ include file='../include/header.jsp' %>
	<div class='container'>
	<%@ include file ="../include/header.jsp"%>
	<br><br><br><br>
	<div class='row d-flex justify-content-center mt-5'>
		<div class='col'>
			<h5 style='color: #0f56ba;'><b>| 장바구니</b></h5><br>
			<form action='<%=request.getContextPath() %>/order/addOrder'>
			
				<table id='cartTable' class="type1">
					<tbody id='carts' class='border-bottom border-top lightgray'>
						<c:forEach var="cart" items="${cartList}">
							<tr>
								<td id='cartNum'>
									<input type='checkbox' value='${cart.cartNum}' name='cartNum' id='cartNum'/>
									<input type='hidden' value='${cart.flowerNum}' name='flowerNum' id='flowerNum'/>
									
								</td>
								<td id='image'>
								<input type='hidden' value='${cart.cartNum}' name='cartNum' id='cartNum'/>
									<a href='/flower/detailFlower?flowerNum=${cart.flowerNum}'>
										<img style="width:150px; height:150px;"src='<c:url value="/attach/${cart.flowerImgfileName}"/>'/>
									</a>
								</td>
								<td><b>${cart.flowerName}</b><br>수량: ${cart.amount}<br>가격: ${cart.price * cart.amount}원</td>
							</tr>
						
						</c:forEach>
						<c:if test="${not empty cartList}">
							<tr><td colspan='4'><button id='orderBtn' type='submit' class="btn btn-secondary">전체 구매</button></td></tr>
						</c:if>
						<c:if test="${empty cartList}">
							<div class='text-center'>
								<h6 style='text-align:center'><b>장바구니가 비었습니다.<br>상품을 추가해주세요.</b></h6>
							</div>
						</c:if>
					</tbody>
				</table>
			</form>
			<div class='row d-flex justify-content-end mt-5 mx-2'>
				<button type='button' id='emptyBtn' class="btn btn-outline-secondary mr-2">비우기</button>
				<button type='button' id='delBtn' class="btn btn-outline-secondary">삭제</button>
				
			</div>
		</div>
	</div>
	</div>
</div>
<div id='confirmModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<h5 id='modalTitle'>장바구니</h5>
				<button type='button' class='close' data-dismiss='modal'>
					<span>&times;</span>
				</button>
			</div>
			<div class='modal-body' align='center'>
				<p id='modalMsg'></p>
			</div>
			<div class='modal-footer'>
				<button type='button' class='btn btn-outline-secondary' id='yesBtn'>예</button>
				<button type='button' class='btn btn-secondary' data-dismiss='modal' id='noBtn'>아니오</button>
				<button type='button' class='btn btn-outline-secondary' data-dismiss='modal' id='okBtn'>확인</button>
			</div>
		</div>
	</div>
</div>
<br><br><br><br>
<%@ include file='../include/footer.jsp' %>