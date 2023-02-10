<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>	   
	   <div class='header'>
			<div id='btn_group' class='float-right mt-2'>
				 <label style='font-size:13;'>관리자님</label>&emsp;
				 <a href='<%=request.getContextPath() %>/user/logout'><button style='font-size:13;'>로그아웃</button></a>
			 </div><br>
		 <div class='row mt-4'>
			 <div class='col'>
				<nav class='navbar navbar-expand-sm navbar-light'>          	
					<a class='navbar-brand' href='<%=request.getContextPath() %>/admin'>TAEMOONFLOWER</a>
					<button class='navbar-toggler' type='button' data-toggle='collapse' data-target='#menu'>
						<i class='fa fa-bars'></i>
					</button>
					<div class='collapse navbar-collapse' id='menu'>
						<ul class='nav navbar-nav w-100 justify-content-around'>
							<li class='nav-item active'>
								<a class='nav-link' href='/admin/user/listUser'>회원</a>
							</li>
							<li class='nav-item active'>
								<a class='nav-link' href='/admin/flower/listFlower'>꽃</a>
							</li>
							<li class='nav-item active'>
								<a class='nav-link' href='/admin/order/listOrder'>주문</a>
							</li>
							<li class='nav-item active'>
								<a class='nav-link' href='/admin/notice/listNotice'>게시판</a>
							</li>
						</ul>
					</div>
				</nav>
			 </div>
		</div>
	 </div>