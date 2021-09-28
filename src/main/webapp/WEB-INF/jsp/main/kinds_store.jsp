<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="d-flex justify-content-center align-items-center">
	<div class="storeList">
		<h1 class="m-3 fontJua">
			<c:choose>
				<c:when test="${kinds eq 'dessert' }">
					디저트
				</c:when>
				<c:when test="${kinds eq 'korean' }">
					분식
				</c:when>
				<c:when test="${kinds eq 'chinese' }">
					중식
				</c:when>
				<c:when test="${kinds eq 'Japanese' }">
					일식/돈가츠
				</c:when>
				<c:when test="${kinds eq 'chickenpizza' }">
					치킨/피자
				</c:when>
				<c:when test="${kinds eq 'nightfood' }">
					야식
				</c:when>
			</c:choose>
		</h1>
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
					<span class="starText text-center">★</span><span class="text-center">     ( ${store.point} )</span><br>
					<span>최소 주문 : ${store.minimumPrice}원</span><br>
					<span>배달팁 ${store.deliveryFee }원</span>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<%-- 플로팅 버튼(주문) --%>
<div class="floBtn1 hidden-md hidden-sm hidden-xs d-flex justify-content-center align-items-center">
  <a href="/main/basket_view" target="_blank">
    <span><i class="fa fa-shopping-cart fa-2x text-white" aria-hidden="true"></i></span>
  </a>
</div>
<script>
	$(document).ready(function(){
		
		$('.storeBox').on('click', function(e){
			e.preventDefault();
			
			var storeId = $(this).data('store-id');

			
		});
	});
</script>