<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="d-flex justify-content-center align-items-center">
	<div>
	<h1 class="fontJua my-3">주문 내역</h1>
	<hr>
		<div class="bgGray orderBox p-3">
			<div class="p-3 mb-3 border bg-white">
				<h3>주문번호 <span class="textO1">14</span></h3>
				<hr>
				<div class="d-flex">
					<div class="storeLogoBox2">
						<c:choose>
			            	<c:when test="${store.logoImagePath eq null}">
			            		<img src="/static/images/noImage.png"  class="storeLogo" alt="가게로고 없음">
			            	</c:when>
			            	<c:otherwise>
			            		<img src="${store.logoImagePath }" alt="가게로고" class="storeLogo">
			            	</c:otherwise>
			            </c:choose>
			        </div>
					<h3 class="ml-2">가게이름</h3><br>
				</div>
				<span>싱글레귤러 외 2개 7,200원</span><br>
				<div class="my-3 d-flex justify-content-center">
					<div class="btn-group" role="group" aria-label="Basic example">
						<a href="#" class="btn btn-outline-dark px-5 py-2">가게 상세</a>
						<a href="#" class="btn btn-outline-dark px-5 py-2">리뷰 쓰기</a>
						<a href="#" class="btn btn-outline-dark px-5 py-2">주문 상세</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>