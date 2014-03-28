package com.lj.cms.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.jboss.logging.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lj.basic.model.Pager;
import com.lj.basic.model.SystemContext;
import com.lj.cms.auth.AuthClass;
import com.lj.cms.auth.AuthMethod;
import com.lj.cms.dto.UserDto;
import com.lj.cms.service.IChannelService;
import com.lj.cms.service.IGroupService;
import com.lj.cms.service.IRoleService;
import com.lj.cms.service.IUserService;
import com.lj.core.model.ChannelTree;
import com.lj.core.model.Role;
import com.lj.core.model.RoleType;
import com.lj.core.model.User;


@RequestMapping(value="/admin/user")
@Controller
@AuthClass("login") //登录用户都可以访问
public class UserController {
	@Autowired
	private IUserService userService;
	@Autowired
	private IGroupService groupService;
	@Autowired
	private IRoleService roleService;
	@Autowired
	private IChannelService channelService;
	
	
	
	
	
	
	
	@RequestMapping(value="/hello")
	public String helloCms(){
		System.out.println("cms");
		return "user/list";
	}
	
	@RequestMapping("/showSelf")
	@AuthMethod //AuthMethod默认base，表示所有人员都可以访问
	public String showSelf(Model model, HttpSession session){
		User user=(User) session.getAttribute("loginUser");
		model.addAttribute(user);
		model.addAttribute("groups",userService.listUserGroups(user.getId()));
		model.addAttribute("roles", userService.listUserRoles(user.getId()));
		return "user/show";
	}
	
	@RequestMapping(value="/updateSelf",method=RequestMethod.GET)
	@AuthMethod //表示所有人员都可以访问
	public String updateSelf(Model model, HttpSession session){
		User user=(User) session.getAttribute("loginUser");
		model.addAttribute(new UserDto(user));
		return "user/updateSelf";
	}
	
	@RequestMapping(value="/updateSelf",method=RequestMethod.POST)
	@AuthMethod
	public String updateSelf(Model model, @Valid UserDto userDto,  BindingResult br ){
		 
		
		if(br.hasErrors()){
			model.addAttribute("roles",roleService.listRole());
			model.addAttribute("groups",groupService.listGroup());
			return "user/updateSelf";
		}
 		 User ou=userService.load(userDto.getId());
		 ou.setNickname(userDto.getNickname());
		 ou.setPhone(userDto.getPhone());
		 ou.setEmail(userDto.getEmail());
		 ou.setStatus(userDto.getStatus());
		userService.update(ou, userDto.getRoleIds(), userDto.getGroupIds());
		return "redirect:/admin/user/showSelf";
		
	}
	
	@RequestMapping(value="/updatePwd",method=RequestMethod.GET)
	@AuthMethod
	public String updatePwd(Model model, HttpSession session){
		User u=(User)session.getAttribute("loginUser");
		model.addAttribute(u);
		return "user/updatePwd";
	}
	
	@RequestMapping(value="/updatePwd",method=RequestMethod.POST)
	@AuthMethod
	public String updatePwd(int id, String oldPwd, String password){
		userService.updatePwd(id, oldPwd, password);
		 
		return "redirect:/admin/user/showSelf";
	}
	
 
	
	@RequestMapping(value="/users")
	public String list(Model model,HttpServletRequest req){
		req.setAttribute("curPage", 1);
		System.out.println(1);
		 model.addAttribute("datas", userService.findUser());
		return "user/list";
	}
	
	@RequestMapping(value="/listByPage/{pageOffset}/{tarPage}")
	public String listByPage(Model model,@PathVariable Integer pageOffset, @PathVariable Integer tarPage){
		SystemContext.setPageOffset(pageOffset);
		
		Pager<User>users=userService.findUser();
		model.addAttribute("datas", users);
		
		// res.setAttribute("curPage", tarPage);
		model.addAttribute("curPage",tarPage);
		 
		System.out.println("pagesize= "+SystemContext.getPageSize());
		return "user/list";
	}
	
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model){
		model.addAttribute("userDto",new UserDto());
		model.addAttribute("roles",roleService.listRole());
		model.addAttribute("groups",groupService.listGroup());
		return "user/add";
	}
	
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String add(@Validated UserDto userDto, BindingResult br, Model model){
		if(br.hasErrors()){
			model.addAttribute("roles",roleService.listRole());
			model.addAttribute("groups",groupService.listGroup());
			return "user/add";
		}
		 
		userService.add(userDto.getUser(), userDto.getRoleIds(), userDto.getGroupIds());
		return "redirect:/admin/user/users";
		
	}
	
	 
	@RequestMapping(value="/delete/{id}",method=RequestMethod.GET)
	public String delete(@PathVariable int id){
		
		userService.delete(id);
		return "redirect:/admin/user/users";
		
	}
	
	@RequestMapping(value="/updateStatus/{id}",method=RequestMethod.GET)
	public String updateStatus(@PathVariable int id){
		userService.updateStatus(id);
		return "redirect:/admin/user/users";
	}
	
	
	
	@RequestMapping(value="/update/{id}",method=RequestMethod.GET)
	public String update(@PathVariable int id,Model model){
		User u=userService.load(id);
	 	model.addAttribute("userDto",new UserDto(u,userService.listUserRoleIds(id),userService.listUserGroupIds(id)));
		model.addAttribute("roles",roleService.listRole());
		model.addAttribute("groups",groupService.listGroup());
		return "user/update";
	}
	
	@RequestMapping(value="/update/{id}", method=RequestMethod.POST)
	public String update(@PathVariable int id,@Validated UserDto userDto, BindingResult br, Model model){
		if(br.hasErrors()){
			model.addAttribute("roles",roleService.listRole());
			model.addAttribute("groups",groupService.listGroup());
			return "user/update";
		}
 		 User ou=userService.load(id);
		 ou.setNickname(userDto.getNickname());
		 ou.setPhone(userDto.getPhone());
		 ou.setEmail(userDto.getEmail());
		 ou.setStatus(userDto.getStatus());
		userService.update(ou, userDto.getRoleIds(), userDto.getGroupIds());
		return "redirect:/admin/user/users";
		
	}
	
	
	@RequestMapping(value="/show/{id}",method=RequestMethod.GET)
	public String show(@PathVariable int id,Model model){
		model.addAttribute(userService.load(id));
		model.addAttribute("groups",userService.listUserGroups(id));
		model.addAttribute("roles",userService.listUserRoles(id));
		return "user/show";
		
	}
	
	@RequestMapping("/listChannels/{uid}")
	public String listChannels(@PathVariable int uid, Model model){
		List<Role> roles=userService.listUserRoles(uid);
		for( Role r:roles){
			if(r.getRoleType()==RoleType.ROLE_ADMIN){
				model.addAttribute("isAdmin", 1);
			}
		}
		model.addAttribute(userService.load(uid));
		return "user/listChannel";
	}
	
	@RequestMapping("/userChannelTree/{uid}")
	public @ResponseBody List<ChannelTree> userTree(@PathVariable Integer uid,@Param Integer isAdmin ){
		if(isAdmin!=null&&isAdmin==1){
			return channelService.generateTree();
		}
		return groupService.generateUserChannelTree(uid);
	}
	
	@AuthMethod
	@RequestMapping("/logout")
	public String logout(HttpSession session){
		session.invalidate();
		return "redirect:/login";
	}
}
