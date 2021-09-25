<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>


<div class="d-flex">

	<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" /> 
	<c:choose>
		<%-- url에 admin 이 포함되어 있으면 사장님 광장 gnb 로 출력 --%>
		<c:when test="${fn:contains(path, 'admin')}">
			<div class="logo">
				<h1 class="textGray p-4 fontJua">사장님광장</h1>
			</div>
			<c:if test="${empty adminLoginId }">
				<div class="login-info d-flex justify-content-end align-items-center">
					<div class="mt-5 mr-5">
						<a href="/admin/sign_in_view" class="textGray font-weight-bold ml-3">로그인</a>
					</div>
				</div>
			</c:if>
			<c:if test="${not empty adminLoginId }">
			<div class="login-info d-flex justify-content-end align-items-center">
				<div class="mt-5 mr-5">
					<span class="textGray"><b>${adminLoginId}</b>님 안녕하세요</span>
					<a href="/admin/sign_out" class="textGray font-weight-bold ml-3">로그아웃</a>
				</div>
			</div>
		</c:if>
		</c:when>
		<%-- url에 admin 이 포함되어 있지 않으면 Deli Eats gnb 로 출력 --%>
		<c:otherwise>
			<div class="logo">
				<a href="/main/main_view"><h1 class="textGray p-4 font-weight-bold fontJua">Deli Eats</h1></a>
			</div>
			<c:if test="${empty userLoginId }">
				<div class="login-info d-flex justify-content-end align-items-center">
					<div class="mt-5 mr-5">
						<a href="/user/sign_in_view" class="textGray font-weight-bold ml-3">로그인</a>
					</div>
				</div>
			</c:if>
			<c:if test="${not empty userLoginId }">
			<div class="login-info d-flex justify-content-end align-items-center">
				<div>
					<div class="d-flex justify-content-end mr-5">
						<div class="d-flex justify-content-end mr-2">
							<a href="#" class="btn bgYellow text-dark w-100">찜 목록</a>
						</div>
						<div class="d-flex justify-content-end">
							<a href="/main/orderedList_view" class="btn bgYellow text-dark w-100">주문내역</a>
						</div>
					</div>
					<div class="mt-2 mr-5">
						<span class="textGray"><b>${userLoginId}</b>님 안녕하세요</span>
						<a href="/user/sign_out" class="textGray font-weight-bold ml-3">로그아웃</a>
					</div>
				</div>
			</div>
			</c:if>
		</c:otherwise>
	</c:choose>
</div>