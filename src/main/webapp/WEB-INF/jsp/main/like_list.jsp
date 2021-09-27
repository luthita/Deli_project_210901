<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="d-flex justify-content-center align-items-center">
	<div class="storeList">
		<h1 class="m-3 fontJua">찜 목록</h1>
		<c:if test="${empty storeList}">
			<div class="d-flex justify-content-center align-items-center storeBox my-3">
				<h1 class="textO3 fontJua">찜 가게가 없습니다.</h1>
			</div>
		</c:if>

		<c:forEach var="store" items="${storeList}">
			<div class="d-flex justify-content-left storeBox my-3"data-store-id="${store.id}" onclick="location.href='/main/store_view?storeId=${store.id}' ">
				<div class="storeLogoBox p-2 m-2">
					<c:choose>
		            	<c:when test="${store.logoImagePath eq null}">
		            		<img src="/static/images/noImage.png"  class="storeLogo" alt="가게로고 없음">
		            	</c:when>
		            	<c:otherwise>
		            		<img src="${store.logoImagePath }" alt="가게로고" class="storeLogo">
		            	</c:otherwise>
		            </c:choose>
				</div>
				<div class="p-2 ml-4 m-2">
					<strong>${store.storeName }</strong><br>
					<span class="textO1">★</span><span>(평점점수)</span><br>
					<span>최소 주문 : ${store.minimumPrice}원</span><br>
					<span>배달팁 ${store.deliveryFee }원</span>
				</div>
			</div>
		</c:forEach>
	</div>
</div>