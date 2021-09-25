<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="d-flex justify-content-center">
	<div>
	<h1 class="fontJua text-center my-3">[ 주문 확인 ]</h1>
	<div class="bgGray orderBox m-3 p-2">
		<div class="deliveryInfo m-3 bgYellow p-4">
			<h3 class="fontJua">< 회원 정보 ></h3>
			<strong>회원 이름 : ${user.userName }</strong><br>
			<hr>
			<h5 class="my-3">배달주소 : ${user.address }</h5>
		</div>
		
		<div class="orderInfo m-3 bgYellow p-4">
			<h3 class="fontJua">< 주문확인 ></h3>
			<div>
				<h4 class="store fontJua" data-storeid="${store.id }">${store.storeName }</h4>
				<c:forEach var="basket" items="${basketList }">
					<div class="d-flex justify-content-between menu" >
						<span>${basket.name } x ${basket.count }</span>
						<span><fmt:formatNumber  value="${basket.price * basket.count}" />원</span>
					</div>
					<c:set var="totalPrice" value="${totalPrice + basket.price * basket.count }"/>
				</c:forEach>
				
			</div>
			<hr class="mt-2">
			<div class="d-flex justify-content-between">
				<span>최소결제 금액 : ${store.minimumPrice }원</span>
				<span>총 <fmt:formatNumber value="${totalPrice}" />원</span>
			</div>
		</div>
		
		<div class="payInfo m-3 bgYellow p-4">
			<h3 class="fontJua">< 결제 및 결제 수단 ></h3>
			<div class="d-flex justify-content-between">
				<div>
					<select name="payMethod" id="payMethod" class="form-control">
						<option>결제수단</option>
						<option value="meetCard">만나서 카드결제</option>
						<option value="meetCash">만나서 현금결제</option>
						<option value="kakaoPay">카카오페이</option>
						<option value="creditCard">카드결제</option>
					</select>
				</div>
				<div>
					<span>주문 금액 : <fmt:formatNumber value="${totalPrice}" />원</span><br>
					<span>배달비 : ${store.deliveryFee }원</span><br>
					<hr>
					<span class="payment" data-payment="${totalPrice + store.deliveryFee}">총 결제금액 : <fmt:formatNumber value="${totalPrice + store.deliveryFee}" />원</span>
				</div>
			</div>
		</div>
		<div class="d-flex justify-content-end">
			<button id="orderBtn"class="btn btn-dark w-25 text-white p-3 m-3">결제하기</button>
		</div>
	</div>
	</div>
</div>

<div class="modal fade" id="orderSuccessModal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title text-center">결제 완료</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      	<h5 class="text-center">주문번호 ${orderId }</h5>
        <p class="text-center">결제가 완료되었습니다.</p>
      </div>
      <div class="modal-footer">
        <a href="/main/main_view" class="btn bgYellow text-dark w-100">닫기</a>
      </div>
    </div>
  </div>
</div>

<script>
	$(document).ready(function(){
		
		$('#orderBtn').click(function(){
			let storeId = $('.store').data('storeid');
				
			let payMethod = $('#payMethod').val();
			if(payMethod == '결제수단'){
				alert("결제수단을 선택해주세요");
				return;
			}
			
			let payment = $('.payment').data('payment');
			
			// alert(storeId + " " + payMethod + " " + payment);
			
			
			
			let param = [{'storeId': storeId, 'payMethod':payMethod, 'payment':payment}];
			
			// 반복문을 통해 menuId, count 가져오기
			<c:forEach items="${basketList}" var="basket">
				param.push({
					menuId:"${basket.menuId}",
					count:"${basket.count}"
				});
			</c:forEach>
			
			// for(var i = 0; i < arr.length; i++){
			// 		alert(arr[i].menuId + "  " + arr[i].count);
			// }
			
			$.ajax({
				url: '/main/order',
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify(param),
				success:function(data){
					if(data.result == 'success'){
	    				$('.modal').modal();
	    			}
	    		}, error: function(e){
	    			alert("error" + e.message);
	    		}
			});
			
			
			/*
				$.ajax({
					type:'POST'
					, contentType: 'application/json'
					, data: JSON.stringify(param)
					, url : '/main'
					, success: function(data){
						alert(data)
					}, error: function(e){
						alert("error: " + e);
					}
				});
			
			
			@ResponseBody
			@PostMapping("/main")
			public List<Map<String, Object>> ajax(
					@RequestBody List<Map<String, Object>> param){
				
				return param;
			}
			*/
		});
	});
</script>