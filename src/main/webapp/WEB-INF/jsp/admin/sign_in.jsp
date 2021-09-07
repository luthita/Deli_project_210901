<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="d-flex align-items-center justify-content-center">
	<div class="p-5 m-5 bgImage2">
		<h1 class="m-4 fontJua text-center">사장님 광장</h1>
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
			
			<a href="#" class="textBlue pb-3">Forgotten password?</a>
			<hr>
			<input type="submit" class="btn btn-primary btn-block" value="로그인">
			<a href="/admin/sign_up_view" class="btn btn-dark btn-block">회원가입</a>
		</form>
	</div>
</div>