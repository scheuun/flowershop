<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<title>TAEMOON Flower</title>

<%@ include file ='../include/lib.jsp'%>

<script>
let pwOk = 0;

function constrainPw(str) {
	if(str.length >= 4 ) {
		$('#pw-fail').text("");
		$('#pw-success').text("사용가능한 비밀번호 입니다.");
	}
	else {
		$('#pw-success').text("");
		$('#pw-fail').text("비밀번호는 4글자 이상 입력해야 합니다.");
	}
}
	
function init() {
	$("#password1").keyup(() => { 
		var pwd1 = $("#password1").val(); 
		constrainPw(pwd1);
	});
	$("#password2").keyup(() => { 
		var pwd1=$("#password1").val(); 
		var pwd2=$("#password2").val(); 
		if(pwd1 != "" || pwd2 != "") { 
			if((pwd1 == pwd2) && (pwd2.length >= 4) ) { 
				pwOk = 1;
				$('#pw2-fail').text("");
				$('#pw2-success').text("비밀번호가 일치합니다.")
			} else {
				pwOk = 0;
				$('#pw2-fail').text("비밀번호가 일치하지 않거나 4자리 미만입니다.")
				$('#pw2-success').text("")
			} 
		}
	});
	
	$("#fixBtn").click(() => {
		if(pwOk == 1){
			$('#modalMsg').text('비밀번호가 수정되었습니다.');
			$('#fixOkBtn').show();
			$('#cancelBtn').hide();
			$('#confirmModal').modal();
		} else {
			pwOk = 0; 
			$('#modalMsg').text('비밀번호를 확인해주세요.');
			$('#fixOkBtn').hide();
			$('#cancelBtn').show();
			$('#confirmModal').modal();
		}
	})
	$('#fixOkBtn').click(() => {
		$.ajax({
			type:'post',
			url:"${pageContext.request.contextPath}/user/fixPw2",
			data:({
				userPw:$('#password2').val()
			})
		})
	})
}

$(init);
	
</script>

<style>
<%@ include file ="../../../res/lib.css"%>
</style>
<div class='container'>
<%@ include file='../include/header.jsp' %>
<br><br><br><br>
<h5 style='color: #0f56ba;'><strong>&nbsp;&nbsp;&nbsp;| 비밀번호 수정</strong></h5><hr><br>
	<div class='row mt-5' >	
		<div class='col-5'>
			<label for='password2' class='d-flex justify-content-center'><span class='req'></span>새 비밀번호</label>
		</div>
		<div class='col-6'>
			<input type='password' name='password1' id='password1' class='form-control text-center' placeholder='비밀번호 수정'/>
			<div>
	    		<span class="text-success" id="pw-success"></span>
				<span style="color:#a94442;" class="text-fail" id="pw-fail"></span>
	    	</div>
		</div>
	</div>
	<div class='row mt-4' >
		<div class='col-5'>
			<label for="password2" class='d-flex justify-content-center'><span class="req"></span>새 비밀번호 확인</label>
		</div>
		<div class='col-6'>
			<input type="password" name="password2" id="password2" class="form-control text-center" placeholder='비밀번호 수정'/>
			<div>
	    		<span class="text-success" id="pw2-success"></span>
				<span style="color:#a94442;" class="text-fail" id="pw2-fail"></span>
	    	</div>
		</div>
	</div>
	<br><br>
	<div class="midBottom" align="center">
		<div class='row mt-5' >
			<div class='col' align="right">
				<button type="button" class="btn btn-outline-secondary"  onclick='location.href="<%=request.getContextPath() %>/user/myPage"' id='LoginPage'>MYPAGE</button>
			</div>
			<div class='col mb-5' align="left">
				<button type="button" class="btn btn-outline-secondary" id='fixBtn' >비밀번호 수정</button>
			</div>
		</div>
	</div>	
</div>

<div id='confirmModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<h5 class='modal-title'>비밀번호 수정</h5>
				<button type='button' class='close' data-dismiss='modal'>
					<span>&times;</span>
				</button>
			</div>
			<div class='modal-body' align='center'>
				<p id='modalMsg'></p>
			</div>
			<div class='modal-footer'>
				<button id='cancelBtn' type='button' class='btn btn-outline-secondary' data-dismiss ='modal'>확인</button>
				<button id='fixOkBtn' type='button' class='btn btn-outline-secondary' onclick='location.href="<%=request.getContextPath() %>/user/login"'>확인</button>
			</div>
		</div>
	</div>
</div> 

<%@ include file='../include/footer.jsp' %>