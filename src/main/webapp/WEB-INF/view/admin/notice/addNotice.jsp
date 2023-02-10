<%@ page language='java' contentType='text/html; charset=UTF-8' pageEncoding='UTF-8'%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ taglib prefix='f' uri='http://www.springframework.org/tags/form' %>
<title>TAEMOON Flower</title>

<%@ include file ='../include/lib.jsp'%>

<script>

function init() {
	let title = $('#title').val();
	let content = $('#content').val();
	$('#registerBtn').click(() => {
		if($('#title').val()) {
			$.ajax({
				url: '${pageContext.request.contextPath}/admin/notice/addNotice',
				type: 'post',
				data: {
					title: $('#title').val(),
					content: $('#content').val()
				}
			}).done(notices => {
				$('#modalMsg').text('공지가 등록되었습니다.');
				$('#cofirmModal').modal();
				$('#noBtn').hide();
				$('#okBtn').hide();
				$('#confirmBtn').show();
				$('#confirmBtn').click(() => {
					location.href='./listNotice'
				})	
			})
			}else {
				$('#modalMsg').text('공지를 입력해 주세요.');
				$('#cofirmModal').modal();
				$('#noBtn').hide();
				$('#okBtn').hide();
				$('#confirmBtn').show();
			}
	})
	
	$('#cancelBtn').click(() => {
		$('#modalMsg').text('작성을 취소 하시겠습니까?');
		$('#cofirmModal').modal();
		$('#noBtn').show();
		$('#okBtn').show();
		$('#confirmBtn').hide();
		$('#okBtn').click(() => {
			location.href='./listNotice'
		})	
	})
}  

$(init)
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
						<td><a href='../notice/listNotice' style='color:black;'>공지 조회</a></td>
					</tr>
					<tr>
						<td><a href='../notice/addNotice' style='color:black; font-weight:bold;'>공지 등록</a></td>
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
      <h5 style='color:#0f56ba'><b>| 공지 등록</b></h5>
      <br>
           <f:form modelAttribute='notice' id='noticeForm' method='post'>
			<input type='text' class='form-control' placeholder='제목을 입력해 주세요.'
			style='height:20; border:none;' minlength='3' id='title'/><hr>
			 <textarea placeholder='내용을 입력하세요.' style='width:100%' rows='15'  id='content'></textarea>
			</f:form>
			<div style='float:right; margin-top:10px;'>
				<button class='btn btn-outline-secondary btn-sm' id='cancelBtn'>취소</button>
				<button class='btn btn-outline-secondary btn-sm' id='registerBtn'>등록</button>
			</div>
		</div>
	</div>
</div><span style="line-height:300%"><br></span>

<div id='cofirmModal' class='modal fade' tabindex='-1'>
	<div class='modal-dialog'>
		<div class='modal-content'>
			<div class='modal-header'>
				<h5 id='modalTitle'>공지 등록</h5>
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
<%@ include file='../include/footer.jsp' %>