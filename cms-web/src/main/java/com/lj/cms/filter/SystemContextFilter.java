package com.lj.cms.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import com.lj.basic.model.SystemContext;

public class SystemContextFilter implements Filter {

	private Integer pageSize;
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		
		try {
			//这里的pageSize在web.xml中的<filter-name>SystemContextFilter</filter-name>
			//<filter-class>com.lj.cms.filter.SystemContextFilter</filter-class>
			//中设置
			pageSize=Integer.parseInt(filterConfig.getInitParameter("pageSize"));
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			pageSize=5;
		}
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		request.setAttribute("hello", "world");
		
		
		
		try{
			 //这里的offset设置好像是孔浩通过pager-taglib来设置的。 由于我没有用该模块,所以这里得不到'pager.offset'。
			 //我要在controller里设置SystemContext.setOffSet。
	    // offset=Integer.parseInt(request.getParameter("pager.offset"));
	   // System.out.println("pager.offset= "+offset+" from SystemContextFilter");
		 }catch(NumberFormatException e){
			 
		 }
	    
	    try { 
	 //	 	SystemContext.setPageOffset(offset);
	 	 	SystemContext.setPageSize(pageSize);
	 	 	SystemContext.setRealPath(((HttpServletRequest)request).getSession().getServletContext().getRealPath("/"));
			//request.setAttribute("pageSize", pageSize);
			
	 	 	chain.doFilter(request, response);
		}  finally{
			 
			SystemContext.removeAll();
		}
	    
	 
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
	}

}
