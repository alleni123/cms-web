package com.lj.cms.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.lj.core.model.User;

public class AuthInterceptor extends HandlerInterceptorAdapter
{	
	
	private static Logger logger=Logger.getLogger(AuthInterceptor.class);
	
	/**
	 * 提交给任何一个对象之前，就会执行preHandler()<br/>
	 * 此时还没有视图
	 */
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception
	{	
		//获取调用方法的信息对象HandlerMethod
		HandlerMethod hm=(HandlerMethod) handler;
		System.out.println("hello interceptor");
		logger.info("\""+hm.getBean().getClass().getName()+"."+hm.getMethod().getName()+"\"");
		
		
		//从session获取loginUser信息，如果为空，则说明没有登录信息，将用户导回登录页面。
		User user=(User) request.getSession().getAttribute("loginUser");
		System.out.println(user);
		if(user==null){
			 response.sendRedirect(request.getContextPath()+"/login");
		}
		//获取是否管理员的boolean值
		System.out.println("isdamin="+request.getSession().getAttribute("isAdmin"));
		//boolean isAdmin=(Boolean) request.getSession().getAttribute("isAdmin");
		return super.preHandle(request, response, handler);
	}
	
	
	/**
	 * 提交给视图对象。
	 */
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception
	{
		// XXX Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}
	
	
	/**
	 * 提交完成之后，用来释放资源的
	 */
	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception
	{
		// XXX Auto-generated method stub
		super.afterCompletion(request, response, handler, ex);
	}
	
	
 
}
