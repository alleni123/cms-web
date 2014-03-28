package com.lj.cms.controller;

import java.util.List;

import javax.inject.Inject;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lj.cms.auth.AuthClass;
import com.lj.cms.auth.AuthMethod;
import com.lj.cms.service.IGroupService;
import com.lj.core.model.ChannelTree;
import com.lj.core.model.Group;



@RequestMapping(value="/admin/group")
@Controller
@AuthClass(value="admin")
public class GroupController {

	private IGroupService groupService;
	
	
	public IGroupService getGroupService() {
		return groupService;
	}

	@Inject
	public void setGroupService(IGroupService groupService) {
		this.groupService = groupService;
	}


	@RequestMapping("/groups")
	public String list(Model model){
		model.addAttribute("datas",groupService.findGroup());
		return "group/list";
	}
	
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model){
		model.addAttribute(new Group());
		return "group/add";
		
	}
	
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(@Validated Group group, BindingResult br){
		 if(br.hasErrors()){
			 return "group/add";
		 }
		 groupService.add(group);
		return "redirect:/admin/group/groups";
		
	}
	
	
	@RequestMapping(value="/update/{id}",method=RequestMethod.GET)
	public String update(@PathVariable int id,Model model){
		model.addAttribute("group",groupService.load(id));
		return "group/update";
		
	}
	
	
	@RequestMapping(value="/update/{id}",method=RequestMethod.POST)
	public String add(@PathVariable int id,@Validated Group group, BindingResult br){
		 if(br.hasErrors()){
			 return "group/update";
		 }
		 Group ug=groupService.load(id);
		 ug.setDesc(group.getDesc());
		 ug.setName(group.getName());
		 
		 groupService.update(ug);
		return "redirect:/admin/group/groups";
		
	}
	
	
	@RequestMapping("/delete/{id}")
	public String delete(@PathVariable int id){
		groupService.delete(id);
		return "redirect:/admin/group/groups";
	}
	
	
	@RequestMapping("/show/{id}")
	public String show(@PathVariable int id,Model model)
	{	
		model.addAttribute("group",groupService.load(id));
		model.addAttribute("users", groupService.listGroupUsers(id));
		return "group/show";
	}
	
	@RequestMapping("/clearUsers/{id}")
	public String clearGroupUsers(@PathVariable int id){
		groupService.deleteGroupUsers(id);
		return "redirect:/admin/group/groups";
	}
	
	@RequestMapping("/listChannels/{gid}")
	public String listChannels(@PathVariable int gid,Model model){
		model.addAttribute(groupService.load(gid));
		return "group/listChannel";
		
	}
	
	@RequestMapping("/groupChannelTree/{gid}")
	public @ResponseBody List<ChannelTree> groupTree(@PathVariable Integer gid){
		return groupService.generateGroupChannelTree(gid);
		
	}
	
	@RequestMapping("/setChannels/{gid}")
	public String setChannels(@PathVariable int gid, Model model){
		model.addAttribute(groupService.load(gid));
		model.addAttribute("cids", groupService.listGroupChannelIds(gid));
		return "group/setChannel";
		
		
	}
	
 
	
}
