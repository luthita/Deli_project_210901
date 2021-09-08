<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<div class="copyright d-flex align-items-center justify-content-center">

	<c:set var="path" value="${requestScope['javax.servlet.forward.servlet_path']}" /> 
	<h1>${path}</h1>
</div>
