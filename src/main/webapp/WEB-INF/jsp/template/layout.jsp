<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- bootstrap CDN link -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

  <%-- AJAX를 사용하려면 더 많은 함수가 있는 js를 포함해야 한다. --%>
  <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
  <!-- <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script> -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" integrity="sha512-YWzhKL2whUzgiheMoBFwW8CKV4qpHQAEuvilg9FAn5VJUDwKZZxkJNuGM4XkWuk94WCrrwslk8yWNGmY1EduTA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="/static/css/style.css" type="text/css">
	
</head>
<body>
	<div id="wrap">
		<header class="bgO2">
			<jsp:include page="../include/gnb.jsp" />
		</header>
		<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" /> 
		<c:choose>
			<c:when test="${fn:contains(path, 'admin') || fn:contains(path, 'main/main_view')}">
			</c:when>
			<c:otherwise>
				<nav class="mt-1 mb-3">
				    <ul class="nav nav-fill">
				        <li class="nav-item"><a href="/main/kinds_view?kinds=korean" class="nav-link text-white font-weight-bold">분 식</a></li>
				        <li class="nav-item"><a href="/main/kinds_view?kinds=chickenpizza" class="nav-link text-white font-weight-bold">치킨 / 피자</a></li>
				       	<li class="nav-item"><a href="/main/kinds_view?kinds=chinese" class="nav-link text-white font-weight-bold">중 식</a></li>
				        <li class="nav-item"><a href="/main/kinds_view?kinds=japanese" class="nav-link text-white font-weight-bold">일식 / 돈가츠</a></li>
				        <li class="nav-item"><a href="/main/kinds_view?kinds=nightfood" class="nav-link text-white font-weight-bold">야 식</a></li>
				        <li class="nav-item"><a href="/main/kinds_view?kinds=dessert" class="nav-link text-white font-weight-bold">디저트</a></li>
				    </ul>
				</nav>
			</c:otherwise>
		</c:choose>
		<section class="contents">
			<jsp:include page="../${viewName }.jsp" />
		</section>
		<footer class="d-flex justify-content-center align-items-center">
			<jsp:include page="../include/footer.jsp" />
		</footer>
	
	</div>

</body>

</html>