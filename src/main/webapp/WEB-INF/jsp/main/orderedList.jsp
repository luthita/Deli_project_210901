<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="d-flex justify-content-center align-items-center">
	<div>
	<h1 class="fontJua my-3">주문 내역</h1>
	<hr>
		<div class="bgGray orderBox p-3">
			<c:forEach var="orderedMenuView" items="${orderedMenuViewList }">
				<div class="p-3 mb-3 border bg-white">
					<h3>주문번호 <span class="textO1" id="orderId" data-orderid="${orderedMenuView.order.id}">${orderedMenuView.order.id}</span></h3>
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
						<h3 class="ml-2"id="storeName" data-storename="${orderedMenuView.store.storeName }">${orderedMenuView.store.storeName }</h3><br>
					</div>
					
					<%-- 주문 메뉴가 1 개 이상일 경우 --%>
					<c:if test="${fn:length(orderedMenuView.menuName) > 1 }">
						<span>${orderedMenuView.menuName[0] } 외 ${fn:length(orderedMenuView.menuName)-1}개</span>
						<span><fmt:formatNumber  value="${orderedMenuView.payment }" />원</span>
					</c:if>
					
					<%-- 주문 메뉴가 1 개일 경우 --%>
					<c:if test="${fn:length(orderedMenuView.menuName) == 1 }">
						<span>${orderedMenuView.menuName[0] }</span>
						<span><fmt:formatNumber  value="${orderedMenuView.payment }" />원</span>
					</c:if>
					
					<div class="my-3 d-flex justify-content-center">
						<div class="btn-group" role="group" aria-label="Basic example">
							<a href="/main/store_view?storeId=${orderedMenuView.store.id }" class="btn btn-outline-dark px-5 py-2">가게 가기</a>
							<a href="#" class="btn btn-outline-dark px-5 py-2">리뷰 쓰기</a>
							<a href="#" class="btn btn-outline-dark px-5 py-2 orderDetail" data-orderedmenuview="${orderedMenuView}" data-toggle="modal" data-target="#orderDetailModal">주문 상세</a>
						</div>
					</div>
				</div>
				
				<%-- 데이터 받아온 변수들... --%>
				<div class="fade">
					<fmt:formatDate value="${orderedMenuView.order.orderedAt}" var="orderedAt" pattern="yyyy년 MM월 dd일 HH시 ss분"/>
					<span id="orderedAt"data-orderedat="${orderedAt}">${orderedAt}</span>
					<span id="storeId" data-storeid="${orderedMenuView.store.id }">${orderedMenuView.store.id }</span>
					<span id="payment" data-totalprice="${orderedMenuView.order.payment }">${orderedMenuView.order.payment }</span>
					<span id="payMethod" data-paymethod="${orderedMenuView.order.payMethod }">${orderedMenuView.order.payMethod }</span>
					<span id="deliveryfee" data-deliveryfee="${orderedMenuView.store.deliveryFee }">${orderedMenuView.store.deliveryFee }</span>
					<span id="address" data-address="${orderedMenuView.address}">${orderedMenuView.address}</span>
				</div>
			</c:forEach>
		</div>
	</div>
</div>

<script>
	$(document).ready(function(){
		$('.orderDetail').click(function(){
			
			var orderedMenuView = $(this).data('orderedmenuview');
			
			$('#orderDetailModal').data('orderedmenuview',orderedMenuView);

			$.ajax({
				type: 'POST',
				url: '/main/order_detail_modal_view',
				data:{
					orderedMenuView
				},
				success:function(data){
					location.href="order_detail_modal_view"
				}
			});
			/*
			 var orderId = $('#orderId').html();
			var storeName = $('#storeName').html();
			var orderedAt = $('#orderedAt').html();
			var storeId = $('#storeId').html();
			var payment = $('#payment').html();
			var payMethod = $('#payMethod').html();
			var address = $('#address').html();
			var deliveryfee = $('#deliveryfee').html();
			var totalPrice = payment - deliveryfee;
			
			if(payMethod == 'meetCard'){
				payMethod = '만나서 카드 결제';
			} else if(payMethod == 'meetCash'){
				payMethod = '만나서 현금 결제';
			} else if(payMethod == 'kakaoPay'){
				payMethod = '카카오페이'
			} else if(payMehotd == 'creditCard'){
				payMethod = '신용/체크카드'
			}
			
			$('#modalStoreName').html(storeName);
			$('#modalOrderedAt').html("주문일시 : " + orderedAt);
			$('#modalOrderId').html("주문번호 : " + orderId);
			$('#modalTotalPrice').html(totalPrice + "원");
			$('#modalDeliveryFee').html(deliveryfee + "원");
			$('#modalPayment').html(payment + "원");
			$('#modalPayMethod').html(payMethod);
			$('#modalAddress').html(address);
			*/
		});
	});
</script>