package com.lj.cms.controller;




import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;

import com.lj.cms.auth.AuthClass;
import com.lj.cms.auth.AuthMethod;
 
import com.lj.cms.service.IUserService;
import com.lj.core.model.User;


@RequestMapping(value = "/admin")
@Controller
@AuthClass(value="login")
public class AdminController {
	
	@Autowired
	private IUserService userService;
	
	@Autowired
	private HttpServletRequest req;
	

	@RequestMapping(value = "/hello")
	public String helloCms() {
		System.out.println("cms");
		return "user/list";
	}

	@RequestMapping(value = "/index")
	@AuthMethod
	public String index() {
		
 //	 User u=new User(1,"admin","23315","你好",null,null,1);
 //	 userService.add(u, null, null);
		
		return "admin/index";
	}
	
 

}
