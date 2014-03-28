package com.lj.cms.web;

import java.util.Map;
import java.util.Set;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.lj.cms.auth.AuthUtil;
import com.lj.core.model.BaseInfo;


public class InitServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static WebApplicationContext webApplicationContext;
	
	 @Override	
	 public void init(ServletConfig config){
		 try {
			super.init(config);
		} catch (ServletException e) {
			// XXX Auto-generated catch block
			e.printStackTrace();
		}
		 
		 //初始化spring工厂
		 webApplicationContext=WebApplicationContextUtils.getWebApplicationContext(this.getServletContext());
		 Map<String,Set<String>> auths=AuthUtil.initAuth("com.lj.cms.controller");
		 
		 this.getServletContext().setAttribute("allAuths", auths);
		 this.getServletContext().setAttribute("baseInfo", BaseInfoUtil.getInstance().read());
		 
		 
		 System.out.println("-------------系统初始化成功："+auths+"-----------------");
	 
	 }

}
