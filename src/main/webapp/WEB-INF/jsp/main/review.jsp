<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="d-flex justify-content-center">
	<div class="contents-box">
	
		<%-- 리뷰 쓰기 영역 - 주문한 상태일때만 보임 --%>
		<c:if test="${not empty orderId}">
			<%-- textarea의 테두리는 없애고 div에 테두리를 준다. --%>
			<div class="write-box border rounded m-3">
				<textarea id="writeTextArea" placeholder="내용을 입력해주세요" class="w-100 border-0"></textarea>
				
				<%-- 이미지 업로드를 위한 아이콘과 업로드 버튼을 한 행에 멀리 떨어뜨리기 위한 div --%>
				<div class="d-flex justify-content-between">
					<span>별점 : </span>
					<button id="writeBtn" class="btn btn-info">게시</button>
				</div>
			</div>
		</c:if>
		
		<div class="timeline-box my-5">
			<h1 class="fontJua">${store.storeName } 리뷰</h1>
			<%-- 반복문(리뷰) 없을경우 --%>
			<c:if test="${empty reviewList}">
				<div class="d-flex justify-content-center align-items-center storeBox my-3">
					<h1 class="textO3 fontJua">리뷰가 없습니다.</h1>
				</div>
			</c:if>
			<%-- 반복문 --%>
			<c:forEach var="review" items="${reviewList}">
				<div class="card border rounded mt-3">
					
					<%-- 글쓴이 아이디 및 ... 버튼(삭제) : 이 둘을 한 행에 멀리 떨어뜨려 나타내기 위해 d-flex, between --%>
					<div class="p-2 d-flex justify-content-between">
						<span class="font-weight-bold">${review.userName}</span>
						<span>${review.point }</span>
						<%-- 클릭할 수 있는 ... 버튼 이미지 --%>
						<%-- 로그인 된 사용자가 작성한 경우에만 버튼 노출 --%>
						<%-- 삭제될 글번호를 modal창에 넣기 위해 더보기 클릭시 이벤트에서 심어준다. --%>
						<c:if test="${userId eq review.userId}">
							<a href="#" class="more-btn" data-toggle="modal" data-target="#moreModal" data-review-id="${review.id}">
								<img src="https://www.iconninja.com/files/860/824/939/more-icon.png" width="30">
							</a>
						</c:if>
					</div>
=
					<%-- 글(Post) --%>
					<div class="card-post m-3">
						<span class="font-weight-bold">${review.userName}</span> 
						<span>
							${review.review}
						</span><br>
						<span class="textGray2">${review.createdAt }</span>
						
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
