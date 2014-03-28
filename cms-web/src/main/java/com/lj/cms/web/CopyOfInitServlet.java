package com.lj.cms.web;

import java.util.Map;
import java.util.Set;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.lj.cms.auth.AuthUtil;

public class CopyOfInitServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static WebApplicationContext webApplicationContext;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		// XXX Auto-generated method stub
		//初始化spring的工厂
		super.init(config);
		webApplicationContext=WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
		
		
		//初始化权限信息
		Map<String,Set<String>>auths=AuthUtil.initAuth("com.lj.cms.controller");
		
		this.getServletContext().setAttribute("allAuths", auths);
		System.out.println("-------------系统初始化成功:"+auths+"------------");
	
	}
	
	public static WebApplicationContext getWc(){
		return webApplicationContext;
	}

}
