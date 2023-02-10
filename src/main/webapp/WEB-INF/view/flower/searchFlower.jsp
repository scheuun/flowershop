<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<title>TAEMOON Flower</title>

<%@ include file ='../include/lib.jsp'%>

<script>

function isVal(field) {
	let check = false;
	let fieldName;
	
	if(field.length)
		if(field.val()) check = true;
	return check;
}

function changeView(address){
	window.location.href=address;
}

function showResult() {
	$.ajax({
		type:'post',
		url: '<%=request.getContextPath() %>/flower/searchFlower'
	}).done(result => {
		let flowerList = [];
		if(result.length){
			$.each(result, (idx, flower) => {
				flowerList.push(
					`<div class='col text-center'>
						<div><a href='/flower/detailFlower?flowerNum=\${flower.flowerNum}'><img style="width:165px; height:165px;"src='<c:url value="/attach/\${flower.flowerImgfileName}"/>'/></a></div>
						<p><a href='/flower/detailFlower?flowerNum=\${flower.flowerNum}' style='color:#000000;'>\${flower.flowerName}</a><br><small>\${flower.price}&nbsp;<span class='badge badge-primary'>\${flower.flowerCategory}</span></small></p>
					</div>`
				);
			});
			
			$('#flowerList').append(flowerList.join(''));
		} else {
			$('#flowerList').append('<tr><td>검색결과가 없습니다.</td></tr>');
		}
	});
}

function init() {
	showResult();
}

$(init);
</script>
<style>
<%@ include file ="../../../res/lib.css"%>
</style>
<div class='container'>
<%@ include file='../include/header.jsp' %>
	<br><br><br><br>
	<h5 style='color:#0f56ba'><b>| 검색 결과</b></h5><hr><br>
		<div class='row ml-3' style='text-align: center;' id='flowerList'>
		</div>
</div><br><br><br>
<%@ include file='../include/footer.jsp' %>