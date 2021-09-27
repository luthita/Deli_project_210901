<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="d-flex justify-content-center align-items-center">
	<div class="p-5">
		<img src="../static/images/adminBanner.jpg" alt="adminMainBanner" width="800px">
		
		<%-- 해당 계정에 가게 등록이 되어 있다면 가게관리 / 메뉴 관리 보이기 --%>
		<c:if test="${existStore eq true}">
			<div class="d-flex">
				<a href="/admin/store_manage_view" class="btn btn-secondary w-50 my-3 mr-3 btn-lg ">가게 관리</a>
				<a href="/admin/menu_view" class="btn btn-success w-50 my-3 ml-3 btn-lg">메뉴 관리</a>
			</div>
		</c:if>
		
		<%-- 해당 계정에 가게 등록이 안되어 있다면 가게 등록 버튼 보이기 --%>
		<c:if test="${existStore eq false }">
			<div>
				<a href="/admin/store_sign_up_view" class="btn btn-primary w-100 mt-3 btn-lg">가게 등록하기</a>
			</div>
		</c:if>
		
	</div>
</div>