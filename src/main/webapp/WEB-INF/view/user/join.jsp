<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>

<!DOCTYPE html>
<title>TAEMOON Flower</title>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>

<%@ include file ='../include/lib.jsp'%>

<script>
let checkedId = 0;
let checkedTerms = 0;

function isVal(field) {
	let isGood = false
	
	if(!field.val()) errMsg = field.attr('title') + '입력하세요.'
	else isGood = true
		
	if(!isGood) {
		$('#modalMsg').text(errMsg).css('color', 'red')
		$('#modalBtn').hide()
		$('#modal').modal()
	}
}

function constrainId(id) {
	if(id.length >= 4) {
		return true; 
	} else {
		return false;
	}
}

function constrainPw(userPw) {
	if(userPw.length >= 4) {
		return true;
	} else {
		return false;
	}
}

function constrainContactNum(text){
	if(text.length == 11){
		return true;
	} else {
		return false;
	}
}

function searchAddr(){
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
	$('#confirmBtn').click(() => {
		var userId = $('#userId').val();
		if(constrainId(userId)) {
		$.ajax({
			url: '${pageContext.request.contextPath}/user/idChk',
			data:{
				userId:userId
			}
		}).done(result => {
				if(result == userId) {
					$('#modalMsgConfirm').empty()
					$('#modalMsgConfirm').text('이미 사용중인 아이디입니다.')
					$('#modalBtn').show()
					$('#confirmModal').modal()
				} else {
					checkedId = 1;
					$('#modalMsgConfirm').empty()
					$('#modalMsgConfirm').text('사용가능한 아이디입니다.')
					$('#modalBtn').show()
					$('#confirmModal').modal()
				}
			})	
		} else {
			$('#modalMsgConfirm').empty()
			$('#modalMsgConfirm').text('아이디는 4글자 이상입니다.')
			$('#modalBtn').show()
			$('#confirmModal').modal()
		}
	}) 
	
	$('#searchAddr').click(() => {
		searchAddr();
	})
	
	$('#joinConfirmBtn').click(() => {
		if($('#userId').val()) {
			if(checkedId == 1) {
				if($('#userPw').val() && constrainPw($('#userPw').val())) {
					if($('#userName').val()) {
						if($('#birthday').val()) {
							if($('#email').val()) {
								if($('#contactNum').val() && constrainContactNum($('#contactNum').val())) {
									if($('#postcode').val()) {
										if($('#addr').val()) {
											if($('#detailAddr').val()) {
												if($('#terms:checked').val()) {
													$('#joinConfirmModalMsg').text('회원가입이 완료되었습니다.')
													$('#joinConfirmOkBtn').show()
													$('#joinConfirmNoBtn').hide()
													$('#joinConfirmModal').modal()
													
												} else {
													$('#joinConfirmModalMsg').text('약관에 동의해 주세요.')
													$('#joinConfirmOkBtn').hide()
													$('#joinConfirmNoBtn').show()
													$('#joinConfirmModal').modal()
													
												}
											}  else {
											$('#joinConfirmModalMsg').text('상세주소를 확인해주세요.')
											$('#joinConfirmOkBtn').hide()
											$('#joinConfirmNoBtn').show()
											$('#joinConfirmModal').modal()
											
										}
									} else {
										$('#joinConfirmModalMsg').text('기본주소를 확인해주세요.')
										$('#joinConfirmOkBtn').hide()
										$('#joinConfirmNoBtn').show()
										$('#joinConfirmModal').modal()
										
									}
								} else {
									$('#joinConfirmModalMsg').text('우편번호를 확인해주세요.')
									$('#joinConfirmOkBtn').hide()
									$('#joinConfirmNoBtn').show()
									$('#joinConfirmModal').modal()
									
								}
							} else {
								$('#joinConfirmModalMsg').text('전화번호를 확인해주세요.(-를 제외 11자리)')
								$('#joinConfirmOkBtn').hide()
								$('#joinConfirmNoBtn').show()
								$('#joinConfirmModal').modal()
								
							}
						} else {
							$('#joinConfirmModalMsg').text('이메일 형식을 확인해주세요.(@포함)')
							$('#joinConfirmOkBtn').hide()
							$('#joinConfirmNoBtn').show()
							$('#joinConfirmModal').modal()
							
						}
					} else {
						$('#joinConfirmModalMsg').text('생년월일을 확인해주세요.')
						$('#joinConfirmOkBtn').hide()
						$('#joinConfirmNoBtn').show()
						$('#joinConfirmModal').modal()
						
					}
				} else {
					$('#joinConfirmModalMsg').text('이름을 확인해주세요.')
					$('#joinConfirmOkBtn').hide()
					$('#joinConfirmNoBtn').show()
					$('#joinConfirmModal').modal()
					
				}
			} else {
				$('#joinConfirmModalMsg').text('비밀번호를 확인해주세요.(4자리이상)')
				$('#joinConfirmOkBtn').hide()
				$('#joinConfirmNoBtn').show()
				$('#joinConfirmModal').modal()
				
			}
		} else {
			$('#joinConfirmModalMsg').text('아이디 중복체크 해주세요.')
			$('#joinConfirmOkBtn').hide()
			$('#joinConfirmNoBtn').show()
			$('#joinConfirmModal').modal()
			
		}
	} else {
			$('#joinConfirmModalMsg').text('아이디를 확인해주세요.')
			$('#joinConfirmOkBtn').hide()
			$('#joinConfirmNoBtn').show()
			$('#joinConfirmModal').modal()
			
		}
	})

	$('#joinConfirmOkBtn').click(() => {
		let user = {
				userId: $('#userId').val(),
				userPw: $('#userPw').val(),
				userName: $('#userName').val(),
				birthday: $('#birthday').val(),
				contactNum:  $('#contactNum').val(),
				email: $('#email').val(),
				postcode: $('#postcode').val(),
				addr: $('#addr').val(),
				detailAddr: $('#detailAddr').val()	
		};
		$.ajax({
			type:'post',
			url:'${pageContext.request.contextPath}/user/join',
			data: JSON.stringify(user),
			contentType: 'application/json',
		});
	})
	
}

$(init)

</script>
<style>
<%@ include file ="../../../res/lib.css"%>
</style>
<div class='container'>
	<%@ include file='../include/header.jsp' %>
	<br><br><br><br>
	<div class='row'>
		<div class='col'>
		<h5 style='color:#0f56ba'><b>| 회원가입</b></h5><hr>
			<table class='table table-borderless' id='classTop'>				
				<tbody>					
					<tr>
						<th><label for='userId' class='form-label'>아이디</label></th>
						<td>
							<input class='mb-1' id='userId' title='아이디' type='text' style='text-align:center; width:130px;' name='userId'/>
							<button type='button' class='btn btn-sm btn-secondary ml-1' id='confirmBtn' data-toggle='modal' data-target='#confirmModal'
								style='height:25px; text-align:center; font-size:10px; color:white;'>중복 확인</button>
						</td>					
					<tr>
						<th><label for='userPw' class='form-label'>비밀번호</label></th>
						<td>
							<input id='userPw' title='비밀번호' type='password' style='text-align:center;' />
						</td>
					<tr>
						<th><label for='userName' class='form-label'>이름</label></th>
						<td>
							<input type='text' style='text-align:center;' id='userName'/>
						</td>
					</tr>
					<tr>
						<th style='width:7rem'><label for='birthday' class='form-label'>생년월일</label></th>
						<td>
							<input style='width:10rem' title='생년월일' id='birthday' type='date'/>
						</td></tr>	
					<tr>
						<th><label for='email' class='form-label'>이메일</label></th>
						<td>
							<input title='이메일' type='email' id='email' style='text-align:center;' placeholder='flower@gmail.com' />
						</td>
					</tr>
					<tr>
						<th class='mt-2'><label for='contactNum' class='form-label'>연락처</label></th>
						<td>
							<input title='연락처' type='text' id='contactNum' style='text-align:center;' placeholder='01012345678'/>
						</td>
					</tr>
					<tr>
						<th><label for='detailAddr' class='form-label'>주소</label></th>
						<td>
						<div class='row'>
							<div class='col'>
								<input type='number' id='postcode' name='postcode' placeholder='(우편번호)' readonly> &nbsp;
								<button type='button' class='btn btn-sm btn-outline-secondary' id='searchAddr'>주소 찾기</button>
							</div>
						</div>
						<div class='row'>
							<div class='col'>
								<input type="text" name="addr" id='addr' style='width:80%' placeholder='(주소)' readonly />
							</div>
						</div>
						<div class='row'>
							<div class='col'>
								<input type="text" name="detailAddr" id='detailAddr' style='width:80%' placeholder='(상세주소)' />
							</div>
						</div>
					</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<input type="checkbox" class='ml-3 mt-2' id="terms" name="terms"/>
							<span style=font-size:10px;>약관에 동의합니다</span>
							<a href='../user/terms'><button type='button' class='btn btn-sm btn-secondary'
								style='height:25px; text-align:center; font-size:10px; color:white;'>약관 보기</button></a>
						</td>
					</tr>
					<tr>
						<td></td>
						<td>
							<button class='btn btn-outline-secondary' 
								id='cancelBtn' data-toggle='modal' data-target='#cancelModal'>취소</button>
							<button class='btn btn-secondary' id='joinConfirmBtn'
								data-toggle='modal' data-target='#joinConfirmModal'>회원가입</button>						
						</td>
					</tr>
				</tbody>				
			</table>
		</div>
	</div>
</div>		
<!-- include modal -->
<div id='confirmModal' class='modal fade' tabindex='-1'>
     <div class='modal-dialog'>
        <div class='modal-content'>
           <div class='modal-header'>
              <p class='modal-title'>아이디 중복 확인</p>
              <button type='button' class='close' data-dismiss='modal'><i class='fa fa-times'></i></button>
           </div>
         <div class='modal-body' align='center'>
         	<p id='modalMsgConfirm'></p>
            <button data-dismiss='modal' class='btn btn-outline-secondary'>확인</button>
         </div>
      </div>
   </div>
</div>

<div id='joinConfirmModal' class='modal fade' tabindex='-1'>
     <div class='modal-dialog'>
        <div class='modal-content'>
           <div class='modal-header'>
              <p class='modal-title'>회원가입</p>
              <button type='button' class='close' data-dismiss='modal'><i class='fa fa-times'></i></button>
           </div>
         <div class='modal-body' align='center'>
         	<p id='joinConfirmModalMsg'></p>
         </div>
         <div class='modal-footer' id='modalBtn'>
         	<button type='button' class='btn btn-outline-secondary' data-dismiss='modal' id='joinConfirmNoBtn'>확인</button>
            <button type='button' class='btn btn-outline-secondary' id='joinConfirmOkBtn' onclick='location.href="<%=request.getContextPath() %>/user/successJoin"'>확인</button>
         </div>
      </div>
   </div>
</div>

<div id='cancelModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<p class="modal-title float-left" id="myModalLabel">회원가입 취소</p>
				<button type='button' class='close' data-dismiss='modal'><i class='fa fa-times'></i></button>					
			</div>
			<div class='modal-body' align='center'>
				<p>회원 가입을 취소하시겠습니까?</p>
				<button data-dismiss='modal' class='btn btn-outline-secondary'
					onclick='location.href="<%=request.getContextPath() %>/user/login"'>예</button>&emsp;&emsp;         	
				 <button type='button' data-dismiss='modal' class='btn btn-secondary'>아니오</button>         
			</div>
	      </div>
	 </div>
</div>
	

<%@ include file='../include/footer.jsp' %>