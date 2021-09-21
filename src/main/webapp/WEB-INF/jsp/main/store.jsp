<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="d-flex justify-content-center align-items-center">
	<div class="menuTable">
		<div class="d-flex m-3 align-items-center">
			<h1 class="textO1 font-weight-bold fontJua mr-5">${store.storeName}</h1>
			<span class="mx-4">♡ 찜 (개수)</span>
			<span class="mx-4">★ 리뷰 수</span>
		</div>
		<hr>
		<div class="my-2">
			<h3>가게소개</h3>
			<span>${store.introduce }</span>
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
	        	<c:forEach var="menu" items="${menuList}">
	            <tr data-menu-id="${menu.id}" data-menu-image="${menu.imagePath}"data-toggle="modal" data-target="#menuModal">
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

<%-- 플로팅 버튼(주문) --%>
<div class="floBtn1 hidden-md hidden-sm hidden-xs d-flex justify-content-center align-items-center">
  <a href="#" target="_blank">
    <span><i class="fa fa-shopping-cart fa-3x text-white" aria-hidden="true"></i></span>
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
           개수 : <input type="number" name="count" id="count" min="1" max="10">
           <strong class="totalPrice"></strong>
         </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn bgGray" data-dismiss="modal">닫기</button>
        <button type="submit" class="btn bgO2 text-white" id="menuSubmit">담기</button>
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
		var image = $(this).data('menu-image');
		var name = td.eq(1).text();
		var price = td.eq(2).text();
		
		
		if(image.trim() == ''){
			image = "/static/images/noImage.png";
		}
		
		$('#menuImage').attr("src", image);
		$('.nameLabel').html(name);
		
	});
});
</script>