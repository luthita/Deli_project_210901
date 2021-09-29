package com.luthita.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
public class PermissionInterceptor implements HandlerInterceptor{

	// private Logger logger = LoggerFactory.getLogger(PermissionInterceptor.class);
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// 세션 확인 => 있으면 로그인 된 상태
		HttpSession session = request.getSession();
		String adminLoginId = (String)session.getAttribute("adminLoginId");
		String userLoginId = (String)session.getAttribute("userLoginId");
		
		// URI - url path 확인
		String uri = request.getRequestURI();
		logger.info("##### uri : " + uri);
		
		// admin 관련 
		
		// 비 로그인 && /main , /store		=> 로그인 페이지로 리다이렉트
		if(adminLoginId == null && (uri.contains("/admin/main_view")|| uri.contains("/admin/menu")|| uri.startsWith("/admin/store"))) {
			response.sendRedirect("/admin/sign_in_view");
			return false;
		}
		// 로그인 && /user		=> 포스트 페이지로 리다이렉트
		if(adminLoginId != null && uri.startsWith("/admin/sign_in_view")) {
			response.sendRedirect("/admin/main_view");
			return false;
		}
		
		// user 관련
		
		// 비 로그인 && main 		=> 로그인 페이지로 리다이렉트
		if(userLoginId == null && (uri.startsWith("/main"))) {
			response.sendRedirect("/user/sign_in_view");
			return false;
		}
		// 로그인 && /sign
		if(userLoginId != null && (uri.startsWith("/user/sign_in_view"))) {
			response.sendRedirect("/main/main_view");
			return false;
		}
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			@Nullable ModelAndView modelAndView) throws Exception {
		
		String uri = request.getRequestURI();
		logger.info("#### postHandle(): " + uri);
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
			@Nullable Exception ex) throws Exception {
		
		String uri = request.getRequestURI();
		logger.info("#### afterComplete() : " + uri);
	}
}