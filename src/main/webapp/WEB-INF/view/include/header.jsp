<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>
<script>

function changeView(address){
	window.location.href=address;
}
function init(){
	
	$('#searchBtn').click(()=>{
		var target = $('#searchBar').val();
		$.ajax({
			type:'post',
			url: '<%=request.getContextPath() %>/flower/saveKeyword',
			data: ({
				keyword:target
			})
		}).done(() => {
			changeView('<%=request.getContextPath() %>/flower/searchFlower');
		});
	});
}

$(init);
</script>
	<c:if test="${empty sessionScope.userId}">
	<div class='header'>
		<div class='row'>
			<div class='col'>
				<nav class='navbar navbar-expand-sm navbar-light fixed-top' style='background-color:#fcfdff'>
					<a class='navbar-brand' href='<%=request.getContextPath() %>/'>TAEMOONFLOWER</a>
					<button class='navbar-toggler' type='button' data-toggle='collapse' data-target='#menu'>
						<i class='fa fa-bars'></i>
					</button>
				
					<div class='collapse navbar-collapse' id='menu'>
						<ul class='nav navbar-nav w-100 justify-content-around'>
							<li class='nav-item active'>
								<a class='nav-link' href='<%=request.getContextPath() %>/flower/listFlower?posy'>꽃다발</a>
							</li>
							<li class='nav-item active'>
								<a class='nav-link' href='<%=request.getContextPath() %>/flower/listFlower?basket'>꽃바구니</a>
							</li>
							<li class='nav-item active'>
								<a class='nav-link' href='<%=request.getContextPath() %>/notice/listNotice'>공지</a>
							</li>
							<li class='nav-item active'>
								<a class='nav-link' href='<%=request.getContextPath() %>/review/listReview'>후기</a>
							</li>
							<li class='nav-item active'>
								<a class='nav-link' href='<%=request.getContextPath() %>/user/login'>MyPage</a>
							</li>
							<li>
							<div class='d-flex align-items-center'>
		    					<input id='searchBar' class='form-control form-control-sm' type='search' placeholder='Search'>
		    					&emsp;<button  id='searchBtn' type='button' class='btn btn-outline-secondary'><i class="fa fa-search" style='color:#3C5087'></i></button>&nbsp;
	  						</div>
	  						</li>
						</ul>
					</div>
				</nav>
			</div>
		</div>
	</div>
	</c:if>
	
	<c:if test="${not empty sessionScope.userId}">
	<div class='header'>
		<div class='row'>
			<div class='col'>
				<nav class='navbar navbar-expand-sm navbar-light fixed-top' style='background-color:#fcfdff'>
					<a class='navbar-brand' href='<%=request.getContextPath() %>/'>TAEMOONFLOWER</a>
					<button class='navbar-toggler' type='button' data-toggle='collapse' data-target='#menu'>
						<i class='fa fa-bars'></i>
					</button>
				
					<div class='collapse navbar-collapse' id='menu'>
						<ul class='nav navbar-nav w-100 justify-content-around'>
							<li class='nav-item active'>
								<a class='nav-link' href='<%=request.getContextPath() %>/flower/listFlower?posy'>꽃다발</a>
							</li>
							<li class='nav-item active'>
								<a class='nav-link' href='<%=request.getContextPath() %>/flower/listFlower?basket'>꽃바구니</a>
							</li>
							<li class='nav-item active'>
								<a class='nav-link' href='<%=request.getContextPath() %>/notice/listNotice'>공지</a>
							</li>
							<li class='nav-item active'>
								<a class='nav-link' href='<%=request.getContextPath() %>/review/listReview'>후기</a>
							</li>
							<li class='nav-item active'>
								<a class='nav-link' href='<%=request.getContextPath() %>/user/myPage'>MyPage</a>
							</li>
							<li>
							<div class='d-flex align-items-center'>
		    					<input id='searchBar' class='form-control form-control-sm' type='search' placeholder='Search'>
		    					&emsp;<button  id='searchBtn' type='button' class='btn btn-outline-secondary'><i class="fa fa-search" style='color:#3C5087'></i></button>&nbsp;
	  						</div>
	  						</li>
						</ul>
					</div>
				</nav>
			</div>
		</div>
	</div>
	</c:if>