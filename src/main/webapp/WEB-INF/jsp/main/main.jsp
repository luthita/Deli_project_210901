<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<div class="copyright d-flex align-items-center justify-content-center">

	<%--
	<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" /> 
	<h1>${path}</h1>
	 --%>
	 <div>
		 <div class="adBannerMain my-3">
		 	<img src="../static/images/mainBanner.jpg" alt="메인배너" width="800px" height="250px">
		 </div>
		
		 <div class="categorySelectBox py-3 row text-center bgO0">
		 	<div class="col-4">
		 		<a href="/main/kinds_view?kinds=korean">
		 		<div class="categoryBox border border-dark my-3" style="text-align: center;display: inline-block;">
					<img src="/static/images/category1.png" alt="카테고리사진"class="category center-block">
				</div></a><br>
				<strong>분식</strong>
		 	</div>
		 	<div class="col-4">
		 		<a href="/main/kinds_view?kinds=chickenpizza">
		 		<div class="categoryBox border border-dark my-3"style="text-align: center;display: inline-block;">
					<img src="/static/images/category2.png" alt="카테고리사진" class="category">
				</div></a><br>
				<strong>치킨/피자</strong>
		 	</div>
		 	<div class="col-4">
		 		<a href="/main/kinds_view?kinds=chinese">
		 		<div class="categoryBox border border-dark my-3"style="text-align: center;display: inline-block;">
					<img src="/static/images/category1.png" alt="카테고리사진" class="category">
				</div></a><br>
				<strong>중식</strong>
		 	</div>
		 	<div class="col-4">
		 		<a href="/main/kinds_view?kinds=japanese">
		 		<div class="categoryBox border border-dark my-3"style="text-align: center;display: inline-block;">
					<img src="/static/images/category2.png" alt="카테고리사진" class="category">
				</div></a><br>
				<strong>일식/돈가츠</strong>
		 	</div>
		 	<div class="col-4">
		 		<a href="/main/kinds_view?kinds=nightfood">
		 		<div class="categoryBox border border-dark my-3"style="text-align: center;display: inline-block;">
					<img src="/static/images/category1.png" alt="카테고리사진" class="category">
				</div></a><br>
				<strong>야식</strong>
		 	</div>
		 	<div class="col-4">
		 		<a href="/main/kinds_view?kinds=dessert">
		 		<div class="categoryBox border border-dark my-3"style="text-align: center;display: inline-block;">
					<img src="/static/images/category2.png" alt="카테고리사진" width="50px" height="50px" class="category">
				</div></a><br>
				<strong>디저트</strong>
				
		 	</div>
		 </div>
	 </div>
</div>
