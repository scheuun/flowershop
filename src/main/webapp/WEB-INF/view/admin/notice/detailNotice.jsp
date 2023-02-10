<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='f' uri='http://www.springframework.org/tags/form' %>
<title>TAEMOON Flower</title>

<%@ include file ='../include/lib.jsp'%>

<script>

function init() {
	$('#fixBtn').click(() => {
		if($('#title').val()) {
			$.ajax({
				url:'fixNotice',
				type: 'put',
				contentType: 'application/json',
				data: JSON.stringify ({
					noticeNum: $('#noticeNum').val(),
					title: $('#title').val(),
					content: $('#content').val()
				})
			}).done(() => {
				$('#fixModalMsg').empty();
				$('#fixModalMsg').text('공지가 수정되었습니다.');
				$('#fixOkBtn').show();
				$('#fixConfirmBtn').hide();
				$('#fixModal').modal();
			})
		} else {
			$('#fixModalMsg').empty();
			$('#fixModalMsg').text('공지를 입력해주세요.');
			$('#fixOkBtn').hide();
			$('#fixConfirmBtn').show();
			$('#fixModal').modal();
		}
	})
	
	$('#delBtn').click(() => {
		$('#delModal').modal();
	})
	
	$('#delOkBtn').click(() => {
		$('#delModal').modal('hide');
		$.ajax({
			url: 'del/' + $('#noticeNum').val(),
			method: 'delete'
		})
	})
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
						<th><i class='fas fa-comment-dots' style='color:#0f56ba; font-size:100px'></i></th>
					</tr>
					<tr style='background-color:#b1c3e0;'>
						<th>공지 관리</th>
					</tr>
				</thead>
				<tbody id='noticeBorder' class='table-borderless'>
					<tr><td></td></tr>
					<tr>
						<td><a href='../notice/listNotice' style='color:black; font-weight: bold;'>공지 조회</a></td>
					</tr>
					<tr>
						<td><a href='../notice/addNotice' style='color:black;'>공지 등록</a></td>
					</tr>
					<tr><td></td></tr>
				</tbody>
				<thead>
					<tr style='background-color:#b1c3e0;'>
						<th>후기 관리</th>
					</tr>
				</thead>
				<tbody id='reviewBorder' class='table-borderless'>
					<tr><td></td></tr>
					<tr>
						<td><a href='../review/listReview' style='color:black'>후기 조회</a></td>
					</tr>
					<tr><td></td></tr>
				</tbody>
			</table>
		</div>
		<div class='col-1'></div>
		<div class='col-7 mt-4'>
      <h5 style='color:#0f56ba'><b>| 공지 상세</b></h5>
	      <div class='flex-column ml-5'>
			    <form>
				     <table class='table' style="margin: auto; text-align: center;">
				        <thead class='text-center'><tr><th>번호</th><th>제목</th><th>작성자</th><th>작성일</th></tr></thead>
				        <c:forEach var="notice" items="${noticeList}">
				        <tbody class='text-center'>
				        	<tr>
				        		<td><input type='number' id='noticeNum' size='2' style='width:2em; border:none;' value='${notice.noticeNum}' readonly></td>
				           		<td><input type='text' id='title' style='width:10em; text-align:center; border:none;' value='${notice.title}'/></td>
				           		<td>관리자</td>
				           		<td>${notice.regdate}</td>
				           	</tr>                   
						</tbody>
						</c:forEach>
					</table>
					<table class='table'>
						<c:forEach var="notice" items="${noticeList}">
							<tr>
								<td><textarea id='content' style='width:100%' rows='15'>${notice.content}</textarea></td>
							</tr>
						</c:forEach>
						<tr>
							<td>
								<div style='float:right;'>
									<button type='button' id='listBtn' class='btn btn-outline-secondary btn-sm' 
										onclick="location.href='./listNotice'">목록</button>
									<button type='button' id='fixBtn' class='btn btn-outline-secondary btn-sm' 
										>수정 </button>
									<button type='button' id='delBtn' class='btn btn-outline-secondary btn-sm' 
										>삭제 </button>
								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</div><span style="line-height:300%"><br></span>

<div id='cofirmModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<h5 id='modalTitle'>공지 상세</h5>
				<button type='button' class='close' data-dismiss='modal'>
					<span>&times;</span>
				</button>
			</div>
			<div class='modal-body' align='center'>
				<p id='modalMsg'></p>
			</div>
			<div class='modal-footer'>
				<button type='button' class='btn btn-outline-secondary' data-dismiss='modal' id='okBtn'>예</button>
				<button type='button' class='btn btn-secondary' data-dismiss='modal' id='noBtn'>아니오</button>
				<button type='button' class='btn btn-outline-secondary' data-dismiss='modal' id='confirmBtn'>확인</button>
			</div>
		</div>
	</div>
</div>

<div id='fixModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<h5 id='modalTitle'>공지 수정</h5>
				<button type='button' class='close' data-dismiss='modal'>
					<span>&times;</span>
				</button>
			</div>
			<div class='modal-body' align='center'>
				<p id='fixModalMsg'></p>
			</div>
			<div class='modal-footer'>
				<button type='button' class='btn btn-outline-secondary' id='fixOkBtn'
					onclick="location.href='./listNotice'">확인</button>
				<button type='button' class='btn btn-outline-secondary' data-dismiss='modal' id='fixConfirmBtn'>확인</button>
			</div>
		</div>
	</div>
</div>

<div id='delModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<h5 id='modalTitle'>공지 삭제</h5>
				<button type='button' class='close' data-dismiss='modal'>
					<span>&times;</span>
				</button>
			</div>
			<div class='modal-body' align='center'>
				<p id='delModalMsg'>공지를 삭제하시겠습니까?</p>
			</div>
			<div class='modal-footer'>
				<button type='button' class='btn btn-outline-secondary' id='delOkBtn'
					onclick="location.href='./listNotice'">예</button>
								<button type='button' class='btn btn-secondary' data-dismiss='modal' id='delNoBtn'>아니오</button>
			</div>
		</div>
	</div>
</div>
<%@ include file='../include/footer.jsp' %>