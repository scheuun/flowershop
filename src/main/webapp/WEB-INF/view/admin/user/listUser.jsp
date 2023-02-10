<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<title>TAEMOON Flower</title>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>

<%@ include file ='../include/lib.jsp'%>

<script>

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

function listUsers() {
	$('#users').empty();
	$('#userId').val(null);
	$('#userPw').val(null);
	$('#userName').val(null);
	$('#birthday').val(null);
	$('#email').val(null);
	$('#contactNum').val(null);
	$('#postcode').val(null);
	$('#addr').val(null);
	$('#detailAddr').val(null);
	
	
	$.ajax({
		url: 'list'
	}).done(users => {
		if(users.length) {
			const userArr = []
		
			$.each(users, (i, user) => {
				userArr.unshift(
					`<tr>
						<td><input type='radio' id='userId' name='userId' value='\${user.userId}'/></td>
						<td>\${user.userId}</td>
						<td>\${user.userPw}</td>
						<td nowrap>\${user.userName}</td>
						<td nowrap>\${user.birthday}</td>
						<td>\${user.email}</td>
						<td>\${user.contactNum}</td>
						<td><font size='2rem'>\${user.postcode} \${user.addr} \${user.detailAddr}</font></td>
					</tr>`		
				)
			})
			
			$('#users').append(userArr.join(''))
		} else $('#users').append(
		 '<tr><td colspan=8 class=text-center>유저가 없습니다.</td></tr>')
	})
}


function init() {
	$('#listUsersBtn').click(() => {
		listUsers()
	})
	
	$('#fixUserBtn').click(() => {
		if($('#userId:checked').val()) {
			if($('#userPw').val() && constrainPw($('#userPw').val())) {
				if($('#userName').val()) {
					if($('#birthday').val()) {
						if($('#email').val()) {
							if($('#contactNum').val() && constrainContactNum($('#contactNum').val())) {
								if($('#postcode').val()) {
									if($('#addr').val()) {
										if($('#detailAddr').val()) {
											$('#fixModalMsg').text('회원을 수정하시겠습니까?')
											$('#fixUserOkBtn').show()
											$('#fixUserNoBtn').show()
											$('#fixConfirmBtn').hide()
											$('#fixModal').modal()
										} else {
											$('#fixModalMsg').text('상세주소를 확인해주세요.')
											$('#fixUserOkBtn').hide()
											$('#fixUserNoBtn').hide()
											$('#fixConfirmBtn').show()
											$('#fixModal').modal()
										}
									} else {
										$('#fixModalMsg').text('기본주소를 확인해주세요.')
										$('#fixUserOkBtn').hide()
										$('#fixUserNoBtn').hide()
										$('#fixConfirmBtn').show()
										$('#fixModal').modal()
									}
								} else {
									$('#fixModalMsg').text('우편번호를 확인해주세요.')
									$('#fixUserOkBtn').hide()
									$('#fixUserNoBtn').hide()
									$('#fixConfirmBtn').show()
									$('#fixModal').modal()
								}
							} else {
								$('#fixModalMsg').text('전화번호를 확인해주세요.(-를 제외 11자리)')
								$('#fixUserOkBtn').hide()
								$('#fixUserNoBtn').hide()
								$('#fixConfirmBtn').show()
								$('#fixModal').modal()
							}
						} else {
							$('#fixModalMsg').text('이메일 형식을 확인해주세요.(@포함)')
							$('#fixUserOkBtn').hide()
							$('#fixUserNoBtn').hide()
							$('#fixConfirmBtn').show()
							$('#fixModal').modal()
						}
					} else {
						$('#fixModalMsg').text('생년월일을 확인해주세요.')
						$('#fixUserOkBtn').hide()
						$('#fixUserNoBtn').hide()
						$('#fixConfirmBtn').show()
						$('#fixModal').modal()
					}
				} else {
					$('#fixModalMsg').text('이름을 확인해주세요.')
					$('#fixUserOkBtn').hide()
					$('#fixUserNoBtn').hide()
					$('#fixConfirmBtn').show()
					$('#fixModal').modal()
				}
			} else {
				$('#fixModalMsg').text('비밀번호를 확인해주세요.(4자리이상)')
				$('#fixUserOkBtn').hide()
				$('#fixUserNoBtn').hide()
				$('#fixConfirmBtn').show()
				$('#fixModal').modal()
			}
		} else {
			$('#fixModalMsg').text('회원을 선택해주세요.')
			$('#fixUserOkBtn').hide()
			$('#fixUserNoBtn').hide()
			$('#fixConfirmBtn').show()
			$('#fixModal').modal()
		}
	})
	
	$('#fixUserOkBtn').click(() => {
		$.ajax({
			url: 'fix',
			method: 'put',
			contentType: 'application/json',
			data: JSON.stringify ({
				userId: $('#userId:checked').val(),
				userPw: $('#userPw').val(),
				userName: $('#userName').val(),
				birthday: $('#birthday').val(),
				email: $('#email').val(),
				contactNum: $('#contactNum').val(),
				postcode: $('#postcode').val(),
				addr: $('#addr').val(),
				detailAddr: $('#detailAddr').val()
			})
		}).done(listUsers)
	})
	
	$('#delUserBtn').click(() => {
		if($('#userId:checked').val()) {
			$('#delModalMsg').text('회원을 삭제하시겠습니까?')
			$('#delUserOkBtn').show()
			$('#delUserNoBtn').show()
			$('#delConfirmBtn').hide()
			$('#delModal').modal()
		} else {
			$('#delModalMsg').text('회원을 선택해주세요.')
			$('#delUserOkBtn').hide()
			$('#delUserNoBtn').hide()
			$('#delConfirmBtn').show()
			$('#delModal').modal()
		}
	})
	
	$('#delUserOkBtn').click(() => {
		$('#delModal').modal('hide')
		$.ajax({
			url: 'del/' + $('#userId:checked').val(),
			method: 'delete'
		}).done(listUsers)
	})

	
	$('#searchAddrBtn').click(() => {
		searchAddr();
	})
	
	$('#users').on({
		change() {
			$('#userId').val($(this).parent().next().text())
			$('#userPw').val($(this).parent().next().next().text())
			$('#userName').val($(this).parent().next().next().next().text())
			$('#birthday').val($(this).parent().next().next().next().next().text())
			$('#email').val($(this).parent().next().next().next().next().next().text())
			$('#contactNum').val($(this).parent().next().next().next().next().next().next().text())
		}
	}, '#userId')
}

$(init);

</script>
<style>
<%@ include file ="../../../../res/lib2.css"%>
</style>
<div class='container-fluid'>
<%@ include file='../include/headerAdmin.jsp' %>
	<div class='row'>
			<div class='col-2' id="adminBorder">
				<table class='table table-bordered mt-3 text-center'>
					<thead>
						<tr>
							<th><i class="fa fa-users" style='color:#0f56ba; font-size:100px'></i></th>
						</tr>
						<tr style='background-color:#b1c3e0;'>
							<th>회원 관리</th>
						</tr>
					</thead>
					<tbody id='borderStatus' class='table-borderless'>
						<tr><td></td></tr>
						<tr>
							<td><a href='../user/listUser' style='color:black; font-weight:bold'>회원 관리</a></td>
						</tr>
						<tr><td></td></tr>
					</tbody>
				</table>
			</div>
			
			<div class='col-8 mt-5 ml-2'>
			<form>
				<h5 style='color:#0f56ba'><b>| 회원 관리</b></h5><hr>
				<table class='table table-bordered'>
					<thead class='text-center' style='background-color:#b1c3e0;'>
						<tr><th>아이디</th><th>비밀번호</th><th>이름</th>
						<th>생년월일</th><th>이메일</th><th>연락처</th><th>주소</th>
					</tr>
				</thead>
				<tbody class='text-center'>
				<tr>
					<td><br><input style='width:6rem; text-align:center; border:none;' type='text' id='userId' name='userId' title='아이디' readonly /></td>
					<td><br><input style='width:6rem; text-align:center;' type='password' id='userPw' name='userPw' title='비밀번호' /></td>
					<td><br><input style='width:5rem; text-align:center;' type='text' id='userName' name='userName' title='이름'  minlength='2'/></td>
					<td><br><input style='width:10rem;' type='date' id='birthday' name='birthday' title='생년월일'></td>
					<td><br><input style='width:12rem; text-align:center;' type='email' id='email' name='email' title='이메일' /></td>
					<td><br><input style='width:7rem;' type='text' id='contactNum' name='contactNum' title='전화번호'/></td>
					<td>							
						<div class='row mb-2'>
							<div class='col'>
								<input style='width:5rem;' type='text' id='postcode' name='postcode' title='우편번호' style='width:100' placeholder='(우편번호)' readonly >
							</div>
						</div>
						<div class='row mb-2'>
							<div class='col'>
								<input style='width:7rem;' type='text' id='addr' name='addr' title='기본주소' style='width:120' placeholder='(기본주소)' readonly />
							</div>
						</div>
						<div class='row'>
							<div class='col'>
								<input style='width:7rem;' type='text' id='detailAddr' name='detailAddr' title='상세주소' style='width:120' placeholder='(상세주소)' />
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan='4'></td>					
					<td style='border-right:hidden; border-left:hidden;'>
						<button type='button' class='btn btn-outline-secondary' id='fixUserBtn'
						>수정</button>
					</td>
					<td>
						<button type='button' class='btn btn-outline-secondary' id='delUserBtn'
						>삭제</button>
					</td>
					<td>
						<button type='button' class='btn btn-outline-secondary' id='searchAddrBtn'>주소 찾기</button>
					</td>
				</tr>
			</tbody>
		</table>
		</form>
		</div>
		<div class='row mt-5 mr-2'>
		<div class='col-2'></div>
		 	<div class='col ml-2'>
			<h5 style='color:#0f56ba'><b>| 회원 목록</b></h5>
			<table class='table table-bordered pr-3' id='userTable'>
				<thead class='text-center' style='background-color:#b1c3e0;'>
					<tr>
						<th style='width:4rem;'></th>
						<th style='width:18rem;'>아이디</th>
						<th style='width:26rem;'>비밀번호</th>
						<th style='width:18rem;'>이름</th>
						<th style='width:40rem;'>생년월일</th>
						<th style='width:60rem;'>이메일</th>
						<th style='width:60rem;'>연락처</th>
						<th style='width:80rem;'>주소</th>
					</tr>
				</thead>
				<tbody class='text-center' id='users'>
					  <tr><td colspan='8' class='text-center'>유저가 없습니다. 회원 조회를 눌러주세요.</td></tr>             
				</tbody>
			</table>
		  		<button type='button' id='listUsersBtn' class='btn btn-outline-secondary' style='float:right'>회원 조회</button>
	  		</div>
		</div><span style="line-height:300%"><br></span>
	</div>
</div> 
<!-- include: modal -->
 <div id='fixModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<p class='modal-title float-left'>회원 수정</p>
				<button type='button' class='close' data-dismiss='modal'><i class='fa fa-times'></i></button>
			</div>
			<div class='modal-body' align='center'>
				<p id='fixModalMsg'></p>
				<button type='button' id='fixUserOkBtn' data-dismiss='modal' class='btn btn-outline-secondary' 
					data-toggle='modal'>예</button>&emsp;&emsp;         	
				 <button type='button' id='fixUserNoBtn' data-dismiss='modal' class='btn btn-secondary'>아니오</button>
				 <button type='button' id='fixConfirmBtn' data-dismiss='modal' class='btn btn-outline-secondary'>확인</button>        
			</div>
	    </div>
	</div>
</div>

 <div id='delModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<p class='modal-title float-left'>회원 삭제</p>
				<button type='button' class='close' data-dismiss='modal'><i class='fa fa-times'></i></button>
			</div>
			<div class='modal-body' align='center'>
				<p id='delModalMsg'></p>
				<button type='button' id='delUserOkBtn' data-dismiss='modal' class='btn btn-outline-secondary' 
					data-toggle='modal' >예</button>&emsp;&emsp;         	
				 <button id='delUserNoBtn' type='button' data-dismiss='modal' class='btn btn-secondary'>아니오</button>
				 <button type='button' id='delConfirmBtn' data-dismiss='modal' class='btn btn-outline-secondary'>확인</button>        
			</div>
	    </div>
	</div>
</div>

<div id='modal' class='modal fade' tabindex='-1' id='modal'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<button type='button' class='close' data-dismiss='modal'>
					<span>&times;</span>
				</button>
			</div>
			<div class='modal-body' align='center'>
				<p id='modalMsg'></p>
			</div>
			<div class='modal-footer' id='modalBtn'>
				<button type='button' class='btn btn-secondary' data-dismiss='modal' id='noBtn'>아니오</button>
				<button type='button' class='btn btn-outline-secondary' id='okBtn'>예</button>
				<button type='button' class='btn btn-outline-secondary' id='confirmBtn'>확인</button>
			</div>
		</div>
	</div>
</div>
	
<%@ include file='../include/footer.jsp' %>