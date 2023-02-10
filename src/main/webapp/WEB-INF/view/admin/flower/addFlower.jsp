<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='f' uri='http://www.springframework.org/tags/form' %>
<title>TAEMOON Flower</title>
<%@ include file ='../include/lib.jsp'%>

<script>
function init() {
$('#registerBtn').click(() => {
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
									type: 'post',
									url: '${pageContext.request.contextPath}/admin/flower/addFlower',
									data: {
										flowerName: flowerName,
										price: price,
										flowerCategory: flowerCategory,
										kind: kind
									}
								}).done(function() {
									location.href='../flower/listFlower'
								})
							} else {
								event.preventDefault();
								$('#modalMsg').empty();
								$('#modalMsg').text('가격을 입력해주세요.');
								$('#cofirmModal').modal();
								$('#okBtn').show();
								$('#noBtn').hide();
							}
					} else {
						event.preventDefault();
						$('#modalMsg').empty();
						$('#modalMsg').text('꽃 이름을 입력해주세요.');
						$('#cofirmModal').modal();
						$('#okBtn').show();
						$('#noBtn').hide();
					}
				} else {
					event.preventDefault();
					$('#modalMsg').empty();
					$('#modalMsg').text('분류를 선택해주세요.');
					$('#cofirmModal').modal();
					$('#okBtn').show();
					$('#noBtn').hide();
				}
			} else{
				event.preventDefault();
				$('#modalMsg').empty();
				$('#modalMsg').text('종류를 선택해주세요.');
				$('#cofirmModal').modal();
				$('#okBtn').show();
				$('#noBtn').hide();
			}
		}
	})
}  
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
</div>
	<div class='row'>
		<div class='col-2 ml-3' id="adminBorder">
			<table class='table table-bordered mt-3 text-center'>
				<thead>
					<tr>
						<th><i class="fa fa-gift" style='color:#0f56ba; font-size:100px'></i></th>
					</tr>
					<tr style='background-color:#b1c3e0;'>
						<th>꽃 관리</th>
					</tr>
				</thead>
				<tbody  class='table-borderless'>
					<tr><td></td></tr>
					<tr>
						<td><a href='./listFlower' style='color:black;'>꽃 조회</a></td>
					</tr>
					<tr>
						<td><a href='./addFlower' style='color:black; font-weight: bold'>꽃 등록</a></td>
					</tr>
					<tr><td></td></tr>
				</tbody>
			</table>
		</div>
	<div class='col-8 mt-3'>
		<h5 style='color:#0f56ba'><b>| 꽃 등록</b></h5>
		<hr><br>
		<form id='form' method='post' encType='multipart/form-data'>
			<div class='col-8 d-flex'>
				<h5 style='color:#0f56ba'><b>종류 선택&nbsp;</b></h5><p>*필수</p>
			</div>
			<div class='col-8'>
				<select id='kind' name='kind' class='text-center col-4'>
					<option>--</option>
					<option>꽃다발</option>
					<option>꽃바구니</option>
				</select>
				<hr><br>
			</div>	
			<div class='col-8'>
				<h5 style='color:#0f56ba'><b>분류&nbsp;</b></h5><br>
			</div>
		<div class='col'>
			&nbsp;<label for='flowerCategory' class='col-form-label'><strong>분류&emsp;&emsp;&emsp;</strong></label>
			<input type='radio' value='BEST' id='flowerCategory' name='flowerCategory'>&emsp;BEST&emsp;&emsp;
			<input type='radio' value='NEW' id='flowerCategory' name='flowerCategory'>&emsp;NEW&emsp;&emsp;
		</div><hr><br>
			<div class='col-8 d-flex'>
				<h5 style='color:#0f56ba'><b>꽃 기본 사항&nbsp;</b></h5>
			</div><br>	
				<table class='table table-borderless' id='classTop'>				
					<tbody>					
						<tr>
							<th><label>꽃 이미지: </label></th>
							<td>
								<input type="file" id='flowerImgfile' name="flowerImgfile" >
							</td>					
						<tr>
							<th><label>꽃 이름 : </label></th>
							<td>
								<input type='text' id='flowerName' name='flowerName'/>
							</td>
						<tr>
							<th>가격 : </th>
							<td>
								<input type='number' id='price' name='price'/>
							</td>
						</tr>
						<tr>
							<th>제품상세 : </th>
							<td>
								<input type='file' name="detailImgfile"/>
							</td>
						</tr>
						<tr>
							<th></th>
							<td align='right'><button class='btn btn-outline-secondary btn-sm' type='submit' id='registerBtn'>등록</button></td>
						</tr>
				</tbody>
			</table>
		</form>
	</div>
</div>

<div id='cofirmModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<h5 class='modalTitle'>꽃 등록</h5>
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