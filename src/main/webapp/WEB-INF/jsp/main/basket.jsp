<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="basketView d-flex justify-content-center bg-white">
	<div>
	<h1 class="text03 fontJua text-center my-4">[ 장바구니 ]</h1>
	<div class="basket">
		<%-- 반복문 --%>
		<c:if test="${empty basketList }">
			<div class="basketBox">
				<h1 class="m-5 fontJua text-center">장바구니에 상품이 없습니다.</h1>
			</div>
		</c:if>
		<c:forEach var="basket" items="${basketList }">
			<div class="basketBox border rounded mt-3">
			
				<div class="p-2 d-flex justify-content-between">
					<h5 class="font-weight-bold">${basket.name}</h5>
					
					<a href="#" class="more-btn" data-toggle="modal" data-target="#moreModal" data-basket-id="${basket.id}">
						<img src="https://www.iconninja.com/files/860/824/939/more-icon.png" width="30">
					</a>
				</div>	
				<div class="m-3">
					<span class="textGray2"> * 가격 : ${basket.price}</span><br>
					<span class="textGray2"> * 개수 : ${basket.count}</span><br><br>
					<h5><fmt:setLocale value="ko_KR"/><fmt:formatNumber type="currency" value="${basket.price * basket.count}" />원</h5>
				</div>
			</div>
			<c:set var="totalPrice" value="${totalPrice + basket.price * basket.count }"/>
			
		</c:forEach>
		
	</div>
	
	<div class="total mt-3 bgGray d-flex justify-content-between p-3">
		<strong>총 주문 금액</strong>
		<strong><fmt:setLocale value="ko_KR"/><fmt:formatNumber type="currency" value="${totalPrice}" />원</strong>
	</div>
	
	<div class="order my-3">
		<a href="/main/order_view" class="btn bgYellow w-100 fontJua orderBtn text-dark">${totalPrice} 배달 주문하기</a>
	</div>
	<div>
</div>


<%-- 글 삭제를 위한 Modal Layer --%>
<div class="modal" id="moreModal" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-sm modal-dialog-centered" role="document">
		<div class="modal-content">
			<%-- Modal 창 안에 내용 넣기 --%>
			<div class="w-100">
				<div class="my-3 text-center">
					<a href="#" class="del-basket d-block">삭제하기</a><%-- 클릭할 수 있는 영역을 넓히기 위해 d-block --%>
				</div>
				<div class="border-top py-3 text-center">
					<%-- data-dismiss: 모달창 닫힘 --%>
					<a href="#" class="cancel d-block" data-dismiss="modal">취소</a> <%-- 클릭할 수 있는 영역을 넓히기 위해 d-block --%>
				</div>
			</div>
		</div>
	</div>
</div>


<script>
	
	$(document).ready(function(){
		
		// 삭제될 글번호를 더보기 클릭시 모달에 넣어준다.
		$('.more-btn').on('click', function(e) {
			var id = $(this).data('basket-id');
			$('#moreModal').data('basket-id', id);
		});
		
		// 더보기 > 글삭제 클릭
		$('#moreModal .del-basket').on('click', function(e) {
			e.preventDefault();
			
			var id = $('#moreModal').data('basket-id');
			
			$.ajax({
				type:'POST',
				url:'/main/delete_basket',
				data: {"id":id},
				success: function(data) {
					if (data.result == 'success') {
						location.reload(); // 새로고침
					}
				},
				error: function(jqXHR, textStatus, errorThrown) {
					var errorMsg = jqXHR.responseJSON.status;
					alert(errorMsg + ":" + textStatus);
				}
			});
		});
	});
</script>