<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<title>TAEMOON Flower</title>

<%@ include file ='../include/lib.jsp'%>

<script>
function init() {
	$('#fixFlowerBtn').click(() => {
		let flowerNum = $('#flowerNum').val();
		let flowerName = $('#flowerName').val();
		let price = $('#price').val();
		let flowerCategory = $('#flowerCategory:checked').val();
		let kind = $('#kind').val();
		if(kind) {
			if(kind=='꽃다발'|| kind=='꽃바구니') {
				if(flowerCategory) {	
					if(flowerName) {	
						if(price) {	
									$.ajax({
										url: 'fix',
										method:'post',
										contentType: 'application/json',
										data: JSON.stringify ({
											flowerNum: flowerNum,
											flowerName: flowerName,
											price: price,
											flowerCategory: flowerCategory,
											kind: kind
										})
									}).done(() => {
										$('#modalMsg').empty();
										$('#modalMsg').text('수정 되었습니다.');
										$('#cofirmModal').modal();
										$('#okBtn').hide();
										$('#fixOkBtn').show();
									})
								} else {
									event.preventDefault();
									$('#modalMsg').empty();
									$('#modalMsg').text('가격을 입력해주세요.');
									$('#cofirmModal').modal();
									$('#okBtn').show();
									$('#fixOkBtn').hide();
								}
						} else {
							event.preventDefault();
							$('#modalMsg').empty();
							$('#modalMsg').text('꽃 이름을 입력해주세요.');
							$('#cofirmModal').modal();
							$('#okBtn').show();
							$('#fixOkBtn').hide();
						}
					} else {
						event.preventDefault();
						$('#modalMsg').empty();
						$('#modalMsg').text('분류를 선택해주세요.');
						$('#cofirmModal').modal();
						$('#okBtn').show();
						$('#fixOkBtn').hide();
					}
				} else{
					event.preventDefault();
					$('#modalMsg').empty();
					$('#modalMsg').text('종류를 선택해주세요.');
					$('#cofirmModal').modal();
					$('#okBtn').show();
					$('#fixOkBtn').hide();
				}
			}
		})
}  
$(init)
</script>
<style>
<%@ include file ="../../../../res/lib2.css"%>

#flowerImage{
	width: 300px;
	height:250px;
    margin: auto;
}

#searchbtn {
	margin: auto;
	display: block;
}

.bold {
	font-weight: bold;
}

#ProductTable {
	margin-left:auto; 
    margin-right:auto;
	width: 70%;
}

#ProductList { 
	top:0; 
	bottom:0; 
	left:0; 
	right:0; 
	margin:auto; 
	height:auto; 
	}
	
#detailImg {
   width: 900;
   height: 1000;
   border: 1px solid lightgrey;
   text-align: center;
   margin: auto;
}
</style>
<div class='container-fluid'>
	<%@ include file='../include/headerAdmin.jsp' %>
		</div>
<div class='col'>	
	<div class='row'>
		<div class='col-2' id="adminBorder">
			<table class='table table-bordered mt-3 text-center'>
				<thead>
					<tr>
						<th><i class="fa fa-gift" style='color:#0f56ba; font-size:100px'></i></th>
					</tr>
					<tr style='background-color:#b1c3e0;'>
						<th>꽃 관리</th>
					</tr>
				</thead>
				<tbody id='flowerBorder' class='table-borderless'>
					<tr><td></td></tr>
					<tr>
						<td><a href='./listFlower' style='color:black; font-weight: bold'>꽃 조회</a></td>
					</tr>
					<tr>
						<td><a href='./addFlower' style='color:black'>꽃 등록</a></td>
					</tr>
					<tr><td></td></tr>
				</tbody>
			</table>
		</div>
		<div class='col mt-3'>
			<div class='row' id='flowerImage'>
				<div class='col'>
					<c:forEach var="flower" items="${flowerList}">
						<img style="max-width: 100%; height:250px;"src='<c:url value="/attach/${flower.flowerImgfileName}"/>'/><br>
					</c:forEach>
				</div>
			</div>
			<div class='col text-center mt-5'>
			<form>
			<c:forEach var="flower" items="${flowerList}">
				<p><b>꽃 번호:&emsp;&emsp;</b><input type='number' id='flowerNum' name='flowerNum' value='${flower.flowerNum}' style='width: 5em; border: none;' readonly/></p>
				<p><label><b>꽃 이름:&emsp;</b><input type='text' id='flowerName' name=' flowerName' value='${flower.flowerName}'/></label></p>
				<p><label><b>가격:&emsp;</b><input type='number' id='price' name='price' value='${flower.price}'/></label></p>
				<p><b>등록일:&emsp;</b>${flower.regDate}</p>
				<p>
					<label>
					<b>종류:&emsp;</b>${flower.kind}&emsp;
					<select id='kind' name='kind' class='text-center col-4'>
					<option>--</option>
					<option>꽃다발</option>
					<option>꽃바구니</option>
					</select>
					</label>	
				</p>
				<p><b>분류:</b> ${flower.flowerCategory}
					&nbsp;&emsp;&emsp;&emsp;<label for='flowerCategory' class='col-form-label'><strong>분류:&emsp;</strong></label>
					<input type='radio' value='BEST' id='flowerCategory' name='flowerCategory'>&emsp;BEST&emsp;&emsp;
					<input type='radio' value='NEW' id='flowerCategory' name='flowerCategory'>&emsp;NEW&emsp;&emsp;
				</p>
			</c:forEach>
			</form>
			</div>
		</div>
	</div><br><hr>
<div class='col'>
	<div class='row'>
		<div class='col-2'></div>
			<div class='col-10 text-center'>				
				<c:forEach var="flower" items="${flowerList}">
					<img style='max-width: 1000; height:1000' src='<c:url value="/attach/${flower.detailImgfileName}"/>'/><br>
				</c:forEach>
			</div>
		</div><br><br><hr>
		<div class='col'>
			<c:forEach var="flower" items="${flowerList}">
				<button id='fixFlowerBtn' class='btn btn-outline-secondary  float-right  mr-2' >수정</button>
			</c:forEach>
		</div>
	</div>
</div>
<br><br><br><br>

<div id='cofirmModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<h5 class='modalTitle'>꽃 수정</h5>
				<button type='button' class='close' data-dismiss='modal'>
					<span>&times;</span>
				</button>
			</div>
			<div class='modal-body'>
				<p id='modalMsg' style='text-align: center'></p>
			</div>
			<div class='modal-footer'>
				<button type='button' class='btn btn-outline-secondary' id='fixOkBtn'
					onclick='location.href="<%=request.getContextPath() %>/admin/flower/listFlower"'>확인</button>
				<button type='button' class='btn btn-outline-secondary' data-dismiss='modal' id='okBtn'>확인</button>
			</div>
		</div>
	</div>
</div>

<%@ include file='../include/footer.jsp' %>