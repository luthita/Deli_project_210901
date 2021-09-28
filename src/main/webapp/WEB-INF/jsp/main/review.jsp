<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="d-flex justify-content-center">
	<div class="contents-box">
	
		<%-- 리뷰 쓰기 영역 - 주문한 상태일때만 보임(단, 주문하고 리뷰를 작성했으면 안보임) --%>
		<c:if test="${not empty orderId && isExistReview == false}">
			<%-- textarea의 테두리는 없애고 div에 테두리를 준다. --%>
			<div class="write-box border rounded m-3" id="reviewBox" data-orderid="${orderId }">
				<textarea id="writeReviewArea" placeholder="리뷰를 적어주세요" class="w-100 border-0" rows=4></textarea>
				
				<%-- 이미지 업로드를 위한 아이콘과 업로드 버튼을 한 행에 멀리 떨어뜨리기 위한 div --%>
				<div class="d-flex justify-content-between">
					<div class="d-flex align-items-center">
					<div class="star-rating ml-3">
					  <input type="radio" id="5-stars" name="rating" value="5" />
					  <label for="5-stars" class="star">&#9733;</label>
					  <input type="radio" id="4-stars" name="rating" value="4" />
					  <label for="4-stars" class="star">&#9733;</label>
					  <input type="radio" id="3-stars" name="rating" value="3" />
					  <label for="3-stars" class="star">&#9733;</label>
					  <input type="radio" id="2-stars" name="rating" value="2" />
					  <label for="2-stars" class="star">&#9733;</label>
					  <input type="radio" id="1-star" name="rating" value="1" />
					  <label for="1-star" class="star">&#9733;</label>
					</div>
					</div>
					<button id="writeBtn" class="btn btn-info">게시</button>
				</div>
			</div>
		</c:if>
		
		<div class="my-5">
			<h1 class="fontJua">${store.storeName } 리뷰</h1>
			<%-- 반복문(리뷰) 없을경우 --%>
			<c:if test="${empty reviewList}">
				<div class="d-flex justify-content-center align-items-center storeBox my-3">
					<h1 class="textO3 fontJua">리뷰가 없습니다.</h1>
				</div>
			</c:if>
			<%-- 반복문 --%>
			<c:forEach var="review" items="${reviewList}">
				<div class="reviewBox my-3 mt-3">
					
					<%-- 글쓴이 아이디 및 ... 버튼(삭제) : 이 둘을 한 행에 멀리 떨어뜨려 나타내기 위해 d-flex, between --%>
					<div class="p-2 d-flex justify-content-between align-items-center reviewBoxHeader">
						<span class="font-weight-bold ml-3">${review.userName}</span>
						<%-- 클릭할 수 있는 ... 버튼 이미지 --%>
						<%-- 로그인 된 사용자가 작성한 경우에만 버튼 노출 --%>
						<%-- 삭제될 글번호를 modal창에 넣기 위해 더보기 클릭시 이벤트에서 심어준다. --%>
						<c:if test="${userId eq review.userId}">
							<a href="#" class="more-btn" data-toggle="modal" data-target="#delReviewModal" data-review-id="${review.id}">
								<img src="https://www.iconninja.com/files/860/824/939/more-icon.png" width="30">
							</a>	
						</c:if>
					</div>
					<span class="ml-3 mt-3">
						<c:forEach var="i" begin="1" end="${review.point }">
							<span class="starText">&#9733;</span>
						</c:forEach><br>
					</span>
				
					<%-- 글(Post) --%>
					<div class="m-3">
						<span>
							${review.review}
						</span><br>
						<span class="textGray2"><fmt:formatDate value="${review.createdAt }" pattern="yyyy년 MM월 dd일"/></span>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
<%-- 플로팅 버튼(주문) --%>
<div class="floBtn1 hidden-md hidden-sm hidden-xs d-flex justify-content-center align-items-center">
  <a href="/main/basket_view" target="_blank">
    <span><i class="fa fa-shopping-cart fa-2x text-white" aria-hidden="true"></i></span>
  </a>
</div>
<%-- 글 삭제를 위한 Modal Layer --%>
<div class="modal" id="delReviewModal" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-sm modal-dialog-centered" role="document">
		<div class="modal-content">
			<%-- Modal 창 안에 내용 넣기 --%>
			<div class="w-100">
				<div class="my-3 text-center">
					<a href="#" class="delReview d-block">삭제하기</a><%-- 클릭할 수 있는 영역을 넓히기 위해 d-block --%>
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
		
		$('#writeBtn').click(function(){
			var point = $('input[name="rating"]:checked').val();
			var reviewText = $('#writeReviewArea').val();
			var orderId = $('#reviewBox').data('orderid');
			
			if(point == null){
				alert("별점을 매겨주세요");
				return;
			}
			$.ajax({
				type: 'POST',
				url: '/main/write_review',
				data:{"orderId":orderId,
						"point":point,
						"reviewText":reviewText},
				success:function(data){
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
		// 삭제될 글번호를 더보기 클릭시 모달에 넣어준다.
		$('.more-btn').on('click', function(e) {
			var id = $(this).data('review-id');
			$('#delReviewModal').data('review-id', id);
		});
		
		
		$('#delReviewModal .delReview').on('click', function(e){
			e.preventDefault();
	    	var id = $('#delReviewModal').data('review-id');


	    	$.ajax({
	    		type:'post'
	    		, url: '/main/delete_review'
	    		, data: {"id": id}
	    		, success: function(data){
	    			if(data.result == 'success'){
	    				location.reload();
	    			}
	    		},error: function(jqXHR, textStatus, errorThrown) {
					var errorMsg = jqXHR.responseJSON.status;
					alert(errorMsg + ":" + textStatus);
				}
	    	});
	    });
	});
</script>