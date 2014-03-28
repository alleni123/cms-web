package com.lj.cms.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lj.basic.util.EnumUtils;
import com.lj.cms.auth.AuthClass;
import com.lj.cms.service.IRoleService;
import com.lj.cms.service.IUserService;
import com.lj.core.model.Role;
import com.lj.core.model.RoleType;

@Controller
@RequestMapping("/admin/role")
@AuthClass
public class RoleController {
	
	@Autowired
	private IUserService userService;
	
	@Autowired
	private IRoleService roleService;
	
 

	@RequestMapping("/roles")
	public String list(Model model){
		model.addAttribute("roles",roleService.listRole());
		return "role/list";
		
	}
	
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model){
		model.addAttribute(new Role());
	//	model.addAttribute("roleType",EnumUtils.enum2Name(RoleType.class));
		
		model.addAttribute("roleTypes", EnumUtils.enumProp2NameMap(RoleType.class, "name"));
		
		model.addAttribute("roleOrdinal", EnumUtils.enum2Ordinal(RoleType.class));
		return "role/add";
	}

	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(Role role){
		if(role.getRoleType()==null){
			return "role/add";
		}
		roleService.add(role);
		return "redirect:/admin/role/roles";
	
	}
	
	
	
	@RequestMapping(value="/update/{id}",method=RequestMethod.GET)
	public String update(@PathVariable int id,Model model){
		model.addAttribute(roleService.load(id));
		//model.addAttribute("roleType",EnumUtils.enum2Name(RoleType.class));
		model.addAttribute("roleTypes", EnumUtils.enumProp2NameMap(RoleType.class, "name"));
		return "role/update";
	}

	@RequestMapping(value="/update/{id}",method=RequestMethod.POST)
	public String update(@PathVariable int id,Role role){
		Role _role=roleService.load(id);
		_role.setName(role.getName());
		System.out.println("roletype= "+role.getRoleType());
		_role.setRoleType(role.getRoleType());
		roleService.update(_role);
		return "redirect:/admin/role/roles";
	
	}
	
	
	@RequestMapping(value="/show/{id}",method=RequestMethod.GET)
	public String show(@PathVariable int id,Model model){
		model.addAttribute("role", roleService.load(id));
		model.addAttribute("users",userService.listRoleUsers(id) );
		return "role/show";
	}
	
	@RequestMapping(value="/delete/{id}")
	public String delete(@PathVariable int id){
			roleService.delete(id);
			return "redirect:/admin/role/roles";
	}
	
	@RequestMapping(value="/clearUsers/{id}")
	public String clearUsers(@PathVariable int id){
			roleService.deleteRoleUsers(id);
			return "redirect:/admin/role/roles";
	}
}
