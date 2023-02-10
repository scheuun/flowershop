<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<title>TAEMOON Flower</title>

<%@ include file ='../include/lib.jsp'%>

<script>

</script>
<style>
<%@ include file ="../../../res/lib.css"%>
</style>
<div class='container'>
	<%@ include file='../include/header.jsp' %>
	<br><br><br><br>
	<h5 style='color:#0f56ba'><b>| 비밀번호 찾기</b></h5><hr><br>
		<form action='findPw-send' method='post'>
			<div class='row justify-content-center'>
				<label for='userName' class='col-form-label'>이름&emsp;&emsp;</label>
				<div class='col-7'>
					<input type='text' class='form-control' id='userName' name='userName' required/>
				</div>
			</div><br>
			<div class='row justify-content-center'>
				<label for='userId' class='col-form-label'>아이디&emsp;</label>
				<div class='col-7'>
					<input type='text' class='form-control' id='userId' name='userId'required/>
				</div>
			</div><br>
			<div class='row justify-content-center'>
				<label for='email' class='col-form-label'>이메일&emsp;</label>
				<div class='col-7'>
					<input type='email' class='form-control' id='emil' name='email' required/>
				</div>
			</div><br>
			 <div class='row justify-content-around'>
				<button type='button' class='btn btn-secondary' onclick='location.href="<%=request.getContextPath() %>/user/login"'
					style='width:130' id='loginBtn'>로그인</button>					
				<button type='submit' class='btn btn-secondary' style='width:130' id='findPwBtn'>비밀번호 찾기</button>		
			</div><br>
		</form>
	<div class='row' style='height:200px'></div>
</div>
<%@ include file='../include/footer.jsp' %>