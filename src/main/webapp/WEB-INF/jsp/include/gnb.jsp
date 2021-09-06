<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="d-flex">
	<div class="logo">
		<h1 class="textGray p-4 font-weight-bold fontJua">Deli Eats</h1>
	</div>
		<c:if test="${empty userName }">
			<div class="login-info d-flex justify-content-end align-items-center">
				<div class="mt-5 mr-5">
					<a href="/user/sign_in_view" class="textGray font-weight-bold ml-3">로그인</a>
				</div>
			</div>
		</c:if>
</div>