package com.lj.cms.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.imageio.ImageIO;
import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lj.basic.util.Captcha;
import com.lj.basic.util.JsonUtil;
import com.lj.cms.auth.AuthClass;
import com.lj.cms.dto.AjaxObj;
import com.lj.cms.service.IUserService;
import com.lj.core.model.Role;
import com.lj.core.model.RoleType;
import com.lj.core.model.User;


/**
 * 这个Controller没有设置权限控制， 所以一些基本测试方法也可以放在这里
 * @author Administrator
 *
 */
@Controller
public class LoginController {
	private IUserService userService;
	
	public IUserService getUserService() {
		return userService;
	}
	
	@Inject
	public void setUserService(IUserService userService) {
		this.userService = userService;
	}
	
	@RequestMapping(value="/login")
	public String login(){
		return "admin/login";
	}
	
	@RequestMapping(value="/login",method=RequestMethod.POST)
	public String login(String username, String password,String checkCode, Model model, HttpSession session){
		String cc=(String) session.getAttribute("checkCode");
		if(!cc.equals(checkCode)){
			model.addAttribute("error", "验证码出错,请重新输入");
		//	return "admin/login";
		}
		 User loginUser=userService.login(username, password);
		 
		 
		
		 
		 
		//1.先获取该用户所包含的角色， 然后遍历角色类型查看是否有ADMIN类型。
		 List<Role> roles=userService.listUserRoles(loginUser.getId());
		 
		 
		 boolean isAdmin=isAdmin(roles);
		 session.setAttribute("isAdmin", isAdmin);
		 
		 //2.通过该用户的角色，从包含系统信息的session中获取所有该用户的权限信息。
		 if(!isAdmin){
		 session.setAttribute("allActions",getAllActionsTest(roles, session) );}
		 
		
		 
		 session.setAttribute("loginUser", loginUser);
		 
		 
		
		 
		 System.out.println("看看登录用户能访问哪些功能 ==="+getAllActions(roles, session));
		 
		 return "redirect:/admin/index";
		
	}
	
	 
	
	/**
	 * 验证用户是否拥有管理员角色， 有则返回true，没有则返回false
	 */
	private boolean isAdmin(List<Role> roles){
		 for(Role r:roles){
			 if(r.getRoleType()==RoleType.ROLE_ADMIN)
			 {
				 return true;
			 }
			 
		 }
		 return false;
		
	}
	
	
	
	@RequestMapping("/drawCheckCode")
	public void drawCheckCode(HttpServletResponse res,HttpSession session )
	{
		 res.setContentType("image/jpg");
		  
		 int width=80; 
		  
		 int height=40; 
		 Captcha captcha=Captcha.getInstance();
		 captcha.set(width, height);
		 String checkCode=captcha.generateCheckcode();
		 session.setAttribute("checkCode", checkCode);
		 
		 
		 
		 try {
			OutputStream os=res.getOutputStream();
			ImageIO.write(captcha.generateCheckImg(checkCode), "jpg", os);
		} catch (IOException e) {
			// XXX Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private Set<String> getAllActions(List<Role>roles, HttpSession session){
		Set<String> actions=new HashSet<String>();
		Map<String, Set<String>> allAuths=(Map<String, Set<String>>) session.getServletContext().getAttribute("allAuths");
		actions.addAll(allAuths.get("base"));
		for(Role r:roles){
			if(r.getRoleType()==RoleType.ROLE_ADMIN) continue;
			actions.addAll(allAuths.get(r.getRoleType().name()));
			
		}
		return actions;
	}
	
	
	/**
	 * 获取所有的角色，并存储在session中。
	 * @param roles
	 * @param session
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private Set<String> getAllActionsTest(List<Role>roles, HttpSession session){
		
		//
		Set<String>actions=new HashSet<String>();
		
		//将所有的角色对象放在map中。
		Map<String,Set<String>>allAuths=(Map<String, Set<String>>) session.getServletContext().getAttribute("allAuths");
	
		
		//首先加入基本功能，
		//base= [com.lj.cms.controller.UserController.updatePwd, com.lj.cms.controller.UserController.showSelf] 
		actions.addAll(allAuths.get("base"));
		
		//遍历角色，将roles作为参数，获取allAuths里面所对应的actions(也就是可操作的方法)
		for(Role role:roles){
			//如果是admin，那就不需要管理权限了，直接continue掉。
			if(role.getRoleType()==RoleType.ROLE_ADMIN) continue;
			actions.addAll(allAuths.get(role.getRoleType().name()));
		}
		
		//最终返回actions，这个actions包含了参数roles所对应的方法（权限控制）
		return actions;
	}
	
	
	/**
	 * 返回AjaxObj对象 。 视频64开头
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("/upload") //返回的是json类型的值， 而uplodify只能接受字符串
	public @ResponseBody AjaxObj upload(MultipartFile attach) throws IOException{
	 	System.out.println(attach.getOriginalFilename());
	 	return new AjaxObj(1);
		 
	}
	
	@RequestMapping("/json") //返回的是json类型的值， 而uplodify只能接受字符串
	public @ResponseBody List<String> json() throws IOException{
	 	List<String>list=Arrays.asList("hello","world");
	 	return list;
		 
	}
	
	/**
	 * 视频64 25分钟写的， 感觉和上面是一样的效果。 @responsebody返回的就是json。
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping("/upload2json") //返回的是json类型的值， 而uplodify只能接受字符串
	public void upload(MultipartFile attach,HttpServletResponse res) throws IOException{
	 //	System.out.println(attach.getOriginalFilename());
	 //	return new AjaxObj(1);
		res.setContentType("text/plain;charset=utf-8");
		AjaxObj obj=new AjaxObj();
		res.getWriter().write(JsonUtil.getInstance().obj2json(obj));
	}
	
	
	
	
	
	
}
