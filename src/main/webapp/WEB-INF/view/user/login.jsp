<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='f' uri='http://www.springframework.org/tags/form' %>
<title>TAEMOON Flower</title>
<%@ include file ='../include/lib.jsp'%>
<script>

function init() {
	$('#loginBtn').click(() => {
		let userId = $('#userId').val();
		let userPw = $('#userPw').val();
		let rememberId = $('#rememberId:checked').val();
		if(userId == "") {
			$('#modalMsg').empty();
			$('#modalMsg').text('아이디를 입력해주세요.');
			$('#commonModal').modal();
			$('#noBtn').hide();
			$('#userId').focus();
			return;
		}
		if(userPw == "") {
			$('#modalMsg').empty();
			$('#modalMsg').text('비밀번호를 입력해주세요.');
			$('#commonModal').modal();
			$('#noBtn').hide();
			$('#userPw').focus();
			return;
		}
		$.ajax({
			type: 'post',
			url:'${pageContext.request.contextPath}/user/login',
			data:{
				userId: userId,
				userPw: userPw,
				rememberId: rememberId
			}
		}).done(result => {
			if(userId =='admin' && userPw =='admin') {
				location.href='${pageContext.request.contextPath}/admin';
			} else {
				location.href='${pageContext.request.contextPath}/';
			}
		}).fail(err => {
			$('#modalMsg').empty();
			$('#modalMsg').text('아이디 또는 비밀번호를 확인해주세요.');
			$('#commonModal').modal();
			$('#noBtn').hide();
		});
	});
	$('#okBtn').click(() => {
		$('#commonModal').modal('hide');
		location.href='${pageContext.request.contextPath}/user/login';
	});
}

$(init);
</script>	
<style>
<%@ include file ="../../../res/lib.css"%>
</style>
<body>
<div class='container'>

<%@ include file='../include/header.jsp' %>

<br><br><br><br>

	<h5 style='color:#0f56ba'><b>| 로그인</b></h5><hr><br>
   	<f:form modelAttribute='user' id='loginForm' method='post'>
		<div class='form-group row justify-content-center'>
			<label for='userId' class='col-form-label'>아이디&emsp;</label>
			<div class='col-7'>
				<input type='text' class='form-control' id='userId' name='userId' value='${user.userId}' required/>
			</div>
		</div><br>
		<div class='form-group row justify-content-center'>
			<label for='userPw' class='col-form-label'>비밀번호</label>
			<div class='col-7'>
				<input type='password' class='form-control' id='userPw' name='userPw' required/>
			</div>
		</div><br>
		 <div class='form-group row' style='text-align:center;'>
			<div class='col'>
					<!-- <input type='checkbox' class='form-check-input' id='saveId' name='saveId' ${checked}/>
					<label class='form-check-label' for='saveId'>아이디 저장</label> -->		
			</div>
			<div class='col' >
				<button type='button' class='btn btn-secondary btn-block'
					style='width:120' id='loginBtn'>로그인</button>
			</div>	
		</div><br>
	</f:form>
	</div><br>
	<div class='row'>
		<div class='col-1'></div>
	   	<div class='col' style='text-align:center;'>
	   		<a style='color:black' href = '<%=request.getContextPath() %>/user/findId'>아이디 찾기</a>
	   		<span>|</span>
			<a style='color:black' href = '<%=request.getContextPath() %>/user/findPw'><span>비밀번호 찾기</span></a>
			<span>|</span>
			<a style='color:black' href = '<%=request.getContextPath() %>/user/join'><span>회원 가입</span></a>
			<span>|</span>
	   	</div>
	</div>
<div class='row' style='height:100px'></div>

<%@ include file='../include/footer.jsp' %>

<div id='commonModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<h5 class='modal-title'>로그인</h5>
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
