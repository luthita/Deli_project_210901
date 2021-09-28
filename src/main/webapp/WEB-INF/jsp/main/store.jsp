<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="d-flex justify-content-center align-items-center">
	<div class="menuTable">
		<div class="d-flex m-3 align-items-center">
			<h1 class="textO1 font-weight-bold fontJua mr-5">${storeContent.store.storeName}</h1>
			<%-- 좋아요 --%>
			<div class="like m-3">
				<a href="#" class="like-btn"data-store-id="${storeContent.store.id}" data-user-id="${userId}">
					<%-- 좋아요 해제 상태 --%>
					<c:if test="${storeContent.filledLike eq false}">
						<img src="https://www.iconninja.com/files/214/518/441/heart-icon.png" width="20px" height="20px">
					</c:if>
					<%-- 좋아요 상태 --%>
					<c:if test="${storeContent.filledLike eq true}">
						<img src="https://www.iconninja.com/files/527/809/128/heart-icon.png" width="20px" height="20px">
					</c:if>
				</a>
				<a href="#" class="likeComment"><span class="text-danger font-weight-bold">찜</span> ${storeContent.likeCount}개</a>
			</div>
			<div class="mx-4">
				<img  src="https://www.iconninja.com/files/851/501/305/star-icon.png" width="20px" height="20px">
				<span class="likeComment">리뷰 ${storeContent.reviewCount }개</span>
			</div>
		</div>
		<hr>
		<div class="my-2">
			<h3>가게소개</h3>
			<span>${storeContent.store.introduce }</span>
		</div>
		<hr>
		<table class="table text-center table-hover" id="menuTable">
	        <thead>
	            <tr>
	                <th>메뉴 이미지</th>
	                <th>메뉴</th>
	                <th>가격</th>
	            </tr>
	        </thead>
	        <tbody>
	        	<c:forEach var="menu" items="${storeContent.menuList}">
	            <tr data-menu-id="${menu.id}" data-menu-image="${menu.imagePath}" data-menu-name="${menu.name }" data-menu-price="${menu.price }"data-toggle="modal" data-target="#menuModal">
	            	<c:choose>
		            	<c:when test="${menu.imagePath eq null}">
		            		<td class="align-middle col-3"><img src="/static/images/noImage.png" width="100px" class="imageScale"></td>
		            	</c:when>
		            	<c:otherwise>
		            		<td class="align-middle col-3"><img src="${menu.imagePath }" width="100px" class="imageScale">
		            	</c:otherwise>
		            </c:choose>
	                <td class="align-middle col-3">${menu.name}</td>
	                <td class="align-middle col-3"><fmt:formatNumber value="${menu.price}" pattern="#,###" />원</td>
	            </tr>
	            </c:forEach>
	        </tbody>
	    </table>
	</div>
</div>

<%-- 플로팅 버튼(리뷰) --%>
<div class="floBtn2 hidden-md hidden-sm hidden-xs d-flex justify-content-center align-items-center">
  <a href="/main/review_view?storeId=${storeContent.store.id }" target="_blank">
    <span><i class="fa fa-comment-dots fa-2x text-white" aria-hidden="true"></i></span>
  </a>
</div>

<%-- 플로팅 버튼(주문) --%>
<div class="floBtn1 hidden-md hidden-sm hidden-xs d-flex justify-content-center align-items-center">
  <a href="/main/basket_view" target="_blank">
    <span><i class="fa fa-shopping-cart fa-2x text-white" aria-hidden="true"></i></span>
  </a>
</div>

<%-- 모달 --%>
<div class="modal fade" id="menuModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="menuModalLabel">메뉴 주문</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
         <div class="form-group">
           <h4 class="nameLabel"></h4>
           <img src="#" alt="메뉴 사진" id="menuImage" width="100px" class="my-3 ml-3"><br>
           <span class="menuPrice"></span><br>
           개수 : <input type="number" name="count" id="count" min="1" max="10">
           <hr>
           <h4 class="textO4 totalPrice"></h4>
         </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn bgGray" data-dismiss="modal">닫기</button>
        <button type="button" class="btn bgO2 text-white" id="menuSubmit">담기</button>
      </div>
    </div>
  </div>
</div>
<script>
$(document).ready(function(){
	$("#menuTable tr").click(function(){ 	

		var str = ""
		var tdArr = new Array();	// 배열 선언
		
		// 현재 클릭된 Row(<tr>)
		var tr = $(this);
		var td = tr.children();
		
		// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
		// alert("클릭한 Row의 모든 데이터 : "+tr.text());
		
		
		// 반복문을 이용해서 배열에 값을 담아 사용할 수 도 있다.
		 td.each(function(i){
		 	tdArr.push(td.eq(i).text());
		 });
		
		// td.eq(index)를 통해 값을 가져올 수도 있다.
		var menuId = $(this).data('menu-id');
		var image = $(this).data('menu-image');
		var name = $(this).data('menu-name');
		var price = $(this).data('menu-price');
		
		
		if(image.trim() == ''){
			image = "/static/images/noImage.png";
		}
		
		$('#menuImage').attr("src", image);
		$('.nameLabel').html(name);
		$('.menuPrice').html("가격 : " + price);
		
		$('#count').change(function(){
			let count = $('#count').val();
			$('.totalPrice').html("총 금액 : " + price * count + "원");
		});
		
		// 메뉴
		$('#menuSubmit').click(function(){
			var count = $('#count').val();
			
			// alert(name + price + count);
			
			$.ajax({
				url: '/main/add_basket',
				type: 'POST',
				data: {"menuId":menuId,
						"name":name,
						"price":price,
						"count":count},
				success:function(data){
					if(data.result == 'success'){
	    				alert("장바구니에 담았습니다.");
	    				location.reload();
	    			} else if(data.result == 'incorrect'){
	    				alert("한 가게의 메뉴만 담아주세요.");
	    				location.reload();
	    			}
	    		}, error: function(e){
	    			alert("error" + e.message);
	    		}
			});
		});
	});
	
	// 좋아요 버튼 클릭
	$('.like-btn').on('click', function(e){
		e.preventDefault(e);
		
		var storeId = $(this).data("store-id");
		var userId = $(this).data("user-id");
		
		if(userId == ''){
			alert("로그인 후에 이용 가능합니다.");
			return;
		}

		$.ajax({
			type: 'POST',
			url: '/main/like',
			data: {"storeId":storeId},
			success: function(data){
				if(data.result == 'success'){
					location.reload();
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