<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="modal fade" id="orderDetailModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="menuModalLabel">주문 상세</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form class="menuForm">
      <div class="modal-body">
         <div class="form-group">
         	<h4 id="modalStoreName">가게이름</h4>
         </div>
         <span id="modalOrderedAt" class="textGray2">주문일시</span><br>
         <span id="modalOrderId" class="textGray2">주문번호</span>

		<div class="d-flex justify-content-between mt-3">
			<strong>총 주문금액</strong>
			<strong id="modalTotalPrice"></strong>
		</div>
		<div class="d-flex justify-content-between">
			<strong>배달비</strong>
			<strong id="modalDeliveryFee"></strong>
		</div>
		<hr class="my-2">
		<div class="d-flex justify-content-between">
			<strong>총 결제금액</strong>
			<strong id="modalPayment"></strong>
		</div>
		<div class="d-flex justify-content-between">
			<strong>결제방법</strong>
			<strong id="modalPayMethod"></strong>
		</div>
         <hr>
         <div>
         	<span>배달주소</span><br>
         	<span class="textGray2" id="modalAddress"></span>
         </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn bgGray" data-dismiss="modal">닫기</button>
      </div>
      </form>
    </div>
  </div>
</div>
