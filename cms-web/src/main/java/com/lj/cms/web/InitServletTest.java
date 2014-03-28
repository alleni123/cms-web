package com.lj.cms.web;

import java.util.Map;
import java.util.Set;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.lj.cms.auth.AuthUtilTest;
import com.lj.cms.service.IUserService;

public class InitServletTest extends HttpServlet
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7272932551830124586L;
	
	
	private static WebApplicationContext wac;
	
	@Autowired
	private IUserService userService;
	
	@Override
	public void init(ServletConfig config) throws ServletException
	{	
		System.out.println("initServlet");
		super.init(config);
		
		//初始化Spring工厂
		wac=WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
		
		//初始化权限信息
		Map<String,Set<String>>auths=AuthUtilTest.initAuth("com.lj.cms.controller");
		
		//之所以使用ServletContext来设置属性，是因为ServletContext是全局的，任何一个浏览器发来的请求，都会调用同样的ServletContext对象。
		this.getServletContext().setAttribute("allAuths",auths );
		this.getServletContext().setAttribute("baseInfo", BaseInfoUtil.getInstance().read());
		System.out.println("---------系统初始化成功---------");
	}
	
	public static WebApplicationContext getWac(){
		return wac;
	}
	
	
	

}
