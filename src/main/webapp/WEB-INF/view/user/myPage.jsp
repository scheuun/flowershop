<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<title>TAEMOON Flower</title>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>

<%@ include file ='../include/lib.jsp'%>

<script>

function constrainContactNum(text){
	if(text.length == 11){
		return true;
	} else {
		return false;
	}
}

function searchAddr() {
	daum.postcode.load(function(){
		new daum.Postcode({
			oncomplete:function(data){
				$('[name=postcode]').val(data.zonecode); 
				$('[name=addr]').val(data.address);
				$('[name=detailAddr]').val(data.buildingName);
			}
		}).open();
	})
}

function init() {
	$('#fixEmailBtn').click(() => {
		if($('#email').val()) {
			$.ajax({
				type:'post',
				url:'${pageContext.request.contextPath}/user/fixEmail',
				data: JSON.stringify({
					email:$('#email').val()
				}),
				contentType: 'application/json'
			}).done(() => {
				$('#emailModalMsg').text('이메일이 수정되었습니다.');
				$('#emailModal').modal();
				$('#emailNoBtn').hide();
				$('#emailOkBtn').show();
			})
		} else {
			$('#emailModalMsg').text('이메일을 확인해주세요.');
			$('#emailModal').modal();
			$('#emailNoBtn').show();
			$('#emailOkBtn').hide();
		}
	})
	
	$('#fixContactNumBtn').click(() => {
		if($('#contactNum').val() && constrainContactNum($('#contactNum').val())) {
			$.ajax({
				type:'post',
				url:'${pageContext.request.contextPath}/user/fixContactNum',
				data: JSON.stringify({
					contactNum:$('#contactNum').val()
				}),
				contentType: 'application/json'
			}).done(() => {
				$('#contactNumModalMsg').text('전화번호가 수정되었습니다.');
				$('#contactNumModal').modal();
				$('#contactNumNoBtn').hide();
				$('#contactNumOkBtn').show();
			})
		} else {
			$('#contactNumModalMsg').text('전화번호를 확인해주세요.(-를 제외 11자리)');
			$('#contactNumModal').modal();
			$('#contactNumNoBtn').show();
			$('#contactNumOkBtn').hide();
		}
	})
	
	$('#fixAddrBtn').click(() => {
		if($('#postcode').val() && $('#addr').val() && $('#detailAddr').val()) {
			$.ajax({
				type:'post',
				url:'${pageContext.request.contextPath}/user/fixAddr',
				data: JSON.stringify({
					postcode: $('#postcode').val(),
					addr: $('#addr').val(),
					detailAddr: $('#detailAddr').val()
				}),
				contentType: 'application/json'
			}).done(() => {
				$('#addrModalMsg').text('주소가 수정되었습니다.');
				$('#addrModal').modal();
				$('#addrNoBtn').hide();
				$('#addrOkBtn').show();
			})
		} else {
			$('#addrModalMsg').text('주소를 확인해주세요.');
			$('#addrModal').modal();
			$('#addrNoBtn').show();
			$('#addrOkBtn').hide();
		}
	})
	
	$('#searchAddr').click(() => {
		searchAddr();
	})
	
	$('#delUserBtn').click(() => {
		$('#delUserModal').modal()
	})
	
	$('#delUserOkBtn').click(() => {
		$('#delUserModal').modal('hide')
		$.ajax({
			url:'delUser/' + $('#userId').val(),
			method:'delete'
		})
	})
}

$(init);
</script>
<style>
</style>
<style>
<%@ include file ="../../../res/lib.css"%>
</style>
<div class='container'>
<%@ include file='../include/header.jsp' %><br><br>
	<!-- 로그인 하지 않았을 때 -->
	<c:if test="${empty sessionScope.userId}">
	<br><br><br><br>
	<div class='col'>
		<h5 style='color:#0f56ba'><b>| My Page</b></h5>
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
	<!-- 로그인 했을 때 -->
	<c:if test="${not empty sessionScope.userId}">
	<div class='row d-flex justify-content-center mt-5'>
		<div class='col'>
			<h5 style='color:#0f56ba'><b>| My Page</b></h5>
			<ul>
				<li><a href='<%=request.getContextPath() %>/order/listOrder'> 구매내역</a></li>
				<li><a href='<%=request.getContextPath() %>/cart/listCart?userId=${userId}'> 장바구니</a></li>
				<li><a href='<%=request.getContextPath() %>/review/listReview'> 후기 남기기</a></li>
			</ul>
		</div>
	</div>
	
	<div class='row d-flex justify-content-center'>
		<div class='col'>
			<h5 style='color:#0f56ba'><b>| 회원정보 수정</b></h5>
			<table class='table table-borderless' id='classTop'>				
				<tbody>					
					<tr>
						<th style='width:100px;'><label for='userId' class='form-label'>아이디</label></th>
						<td><p>${userId}</p></td>					
					<tr>
						<th style='width:100px;'><label for='userId' class='form-label'>비밀번호 </label></th>
						<td>
							<a href='<%=request.getContextPath() %>/user/fixPw'><button type='button' class='btn btn-sm btn-secondary' 
							style='height:2rem; text-align:center; font-size:1rem; color:white;'>비밀번호수정</button></a>
						</td>
					<tr>
						<th>이름</th>
						<td><p>${user.userName}</p></td>
					</tr>
					<tr>
						<th>생년월일</th>
						<td>${user.birthday}</td>
					</tr>	
					<tr>
						<th><span>이메일</span></th>
						<td>
							<input type='email' id='email' name='email' style='text-align:center;' value='${user.email}'/>
							<button type='button' id='fixEmailBtn' class='btn btn-sm btn-secondary mt-2' 
							style='height:2rem; text-align:center; font-size:1rem; color:white;'>이메일 수정</button>
						</td>
					</tr>
					<tr>
						<th><span>전화번호</span></th>
						<td>
							<input type='text' id='contactNum' style='text-align:center;' value='${user.contactNum}'/>
							<button type='button' id='fixContactNumBtn' class='btn btn-sm btn-secondary mt-2' 
							style='height:2rem; text-align:center; font-size:1rem; color:white;'>전화번호 수정</button>
						</td>
					</tr>
					<tr>
						<th><span>주소</span></th>
						<td>
						<div class='row'>
							<div class='col'>
								<input type='number' id='postcode' name='postcode' value='${user.postcode}' readonly > &nbsp;
								<button type='button' id='searchAddr' name='searchAddr' class='btn btn-sm btn-outline-secondary mt-2 mb-2'>주소 찾기</button>
							</div>
						</div>
						<div class='row'>
							<div class='col'>
								<input type="text" id='addr' name="addr" style='width:100%' value='${user.addr}' readonly/>
							</div>
						</div>
						<div class='row'>
							<div class='col'>
								<input type="text" id='detailAddr' name="detailAddr" style='width:100%' value='${user.detailAddr}'/>
							</div>
						</div>
						<div class='row justify-content-center mt-2 float-right'>
							<div class='col'>
								<button type='button' id='fixAddrBtn' class='btn btn-sm btn-secondary' 
							style='height:2rem; text-align:center; font-size:1rem; color:white;'>주소 수정</button>
							</div>
						</div>
					</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<hr>
	<div class='row d-flex justify-content-center float-right'>
		<div class='col'>				
			<button type='button' id='delUserBtn' class='btn btn-secondary sm-btn' >회원탈퇴</button>					
		</div>
	</div>
	</c:if>
	<br><br>
</div>

<div id='emailModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<p class="modal-title float-left" id='emailTitle'>이메일 수정</p>
				<button type='button' class='close' data-dismiss='modal'>
					<span>&times;</span>
				</button>
			</div>
			<div class='modal-body' align='center'>
				<p id='emailModalMsg'></p>
			</div>
			<div class='modal-footer' id='emailModalBtn'>
				<button type='button' class='btn btn-secondary' data-dismiss='modal' id='emailNoBtn'>확인</button>
				<button type='button' class='btn btn-outline-secondary' id='emailOkBtn' 
					onclick='location.href="<%=request.getContextPath() %>/user/myPage"'>확인</button>
			</div>
		</div>
	</div>
</div>

<div id='contactNumModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<p class="modal-title float-left" id='contactNumTitle'>전화번호 수정</p>
				<button type='button' class='close' data-dismiss='modal'>
					<span>&times;</span>
				</button>
			</div>
			<div class='modal-body' align='center'>
				<p id='contactNumModalMsg'></p>
			</div>
			<div class='modal-footer' id='contactNumModalBtn'>
				<button type='button' class='btn btn-secondary' data-dismiss='modal' id='contactNumNoBtn'>확인</button>
				<button type='button' class='btn btn-outline-secondary' id='contactNumOkBtn'
					onclick='location.href="<%=request.getContextPath() %>/user/myPage"'>확인</button>
			</div>
		</div>
	</div>
</div>

<div id='addrModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<p class="modal-title float-left" id='addrTitle'>주소 수정</p>
				<button type='button' class='close' data-dismiss='modal'>
					<span>&times;</span>
				</button>
			</div>
			<div class='modal-body' align='center'>
				<p id='addrModalMsg'></p>
			</div>
			<div class='modal-footer' id='addrModalBtn'>
				<button type='button' class='btn btn-secondary' data-dismiss='modal' id='addrNoBtn'>아니오</button>
				<button type='button' class='btn btn-outline-secondary' id='addrOkBtn'
					onclick='location.href="<%=request.getContextPath() %>/user/myPage"'>확인</button>
			</div>
		</div>
	</div>
</div>

<div id='delUserModal' class='modal fade' tabindex='-1'>
     <div class='modal-dialog'>
        <div class='modal-content'>
           <div class='modal-header'>
              <p class='modal-title'>회원탈퇴</p>
              <button type='button' class='close' data-dismiss='modal'><i class='fa fa-times'></i></button>
           </div>
         <div class='modal-body' align='center'>
         	<p id='delUserModalMsg'>회원 탈퇴하시겠습니까?</p>
         </div>
         <div class='modal-footer' id='modalBtn'>
            <button type='button' class='btn btn-outline-secondary' id='delUserOkBtn' 
				onclick='location.href="<%=request.getContextPath() %>/user/successWithdraw"'>예</button>
			<button type='button' class='btn btn-secondary' id='delUserNoBtn' data-dismiss='modal'>아니오</button>
         </div>
      </div>
   </div>
</div>

<%@ include file='../include/footer.jsp' %>