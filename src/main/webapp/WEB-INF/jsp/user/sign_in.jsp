<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- bootstrap CDN link -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

  <%-- AJAX를 사용하려면 더 많은 함수가 있는 js를 포함해야 한다. --%>
  <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
  <!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script> -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="/static/css/style.css" type="text/css">
</head>
<body>
	<div class="container d-flex align-items-center justify-content-center">
		<div class="border border-dark p-5 bg-light">
			<h1 class="m-5 fontJua">Deli Eats</h1>
			<form id="loginForm" method="post" action="/admin/sign_in">
				<div class="input-group mb-3">
					<%-- input-group-prepend : input 앞에 ID 부분을 회색으로 붙인다. --%>
					<div class="input-group-prepend">
						<span class="input-group-text"><i class="fa fa-user-o" aria-hidden="true"></i></span>
					</div>
					<input type="text" class="form-control" id="loginId" name="loginId">
				</div>
				
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text"><i class="fa fa-key" aria-hidden="true"></i></span>
					</div>
					<input type="password" class="form-control" id="password" name="password">
				</div>
				
				<a href="/user/forgot_password_view" class="textBlue pb-3">Forgotten password?</a>
				<hr>
				<input type="submit" class="btn btn-primary btn-block" value="로그인">
				<a href="/user/sign_up_view" class="btn btn-dark btn-block">회원가입</a>
			</form>
		</div>
	</div>
</body>
<script>
	$(document).ready(function(){
		$('#loginForm').submit(function(e){
			e.preventDefault();
			
			// validation
			let loginId = $('#loginId').val().trim();
			if(loginId == ''){
				alert("아이디를 입력하세요");
				return;
			}
			
			let password = $('#password').val();
			if(password == ''){
				alert("비밀번호를 입력하세요.");
				return;
			}
			
			let url = $(this).attr('action');
			let data = $(this).serialize();
			
			$.post(url, data).done(function(data){
				if(data.result == 'success'){
					location.href="/main/main_view";
				} else{
					alert("로그인에 실패했습니다. 다시 시도 해주세요");
				}
			});
		});
	});
</script>
</html>
