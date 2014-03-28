package com.lj.cms.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lj.basic.model.Pager;
import com.lj.basic.model.SystemContext;
import com.lj.cms.service.ICmsLinkService;
import com.lj.core.model.CmsLink;


@Controller
@RequestMapping("/admin/cmsLink")
public class CmsLinkController
{	
	@Autowired
	private ICmsLinkService cmsLinkService;
	
	//显示
	/**
	 * 如果有type参数，就根据type选择，否则全部显示
	 * @param type 类似于/admin/cmsLink/links?type=hello, 就可以获取type数值
	 * @return
	 */
	@RequestMapping("/links")
	public String list(Model model,String type,HttpServletRequest req){
		req.setAttribute("curPage", 1);
		model.addAttribute("datas",cmsLinkService.findByType(type));
		model.addAttribute("types", cmsLinkService.ListAllType());
		Map<String,Integer>map=cmsLinkService.getMinAndMaxPos();
		
		model.addAttribute("max", map.get("max"));
		model.addAttribute("min", map.get("min"));
		return "cmsLink/list";
	}
	
	
	@RequestMapping(value="/show/{id}",method=RequestMethod.GET)
	public String show(@PathVariable int id,Model model){
		 model.addAttribute(cmsLinkService.load(id));
		 return "cmsLink/show";
	}
	
	
	//添加
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model){
		model.addAttribute(new CmsLink());
		model.addAttribute("types", cmsLinkService.ListAllType());
		return "cmsLink/add";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(@Validated CmsLink cl,BindingResult br){
		if(br.hasErrors()){
			return "cmsLink/add";
		}
		cmsLinkService.add(cl);
		return "redirect:/admin/cmsLink/links";
	}
	
	//删除
	@RequestMapping(value="/delete/{id}",method=RequestMethod.GET)
	public String delete(@PathVariable int id) {
		cmsLinkService.delete(id);
		return "redirect:/admin/cmsLink/links";
	}
	
	//更新
	@RequestMapping(value="/update/{id}",method=RequestMethod.GET)
	public String update(@PathVariable int id,Model model){
		 model.addAttribute(cmsLinkService.load(id));
		 model.addAttribute("types", cmsLinkService.ListAllType());
		 return "cmsLink/update";
	}
	@RequestMapping(value="/update/{id}",method=RequestMethod.POST)
	public String update(@PathVariable int id, @Validated CmsLink cl, BindingResult br){
		if(br.hasFieldErrors()){
			return "cmsLlink/update";
		}
		CmsLink tcl=cmsLinkService.load(id);
		tcl.setNewWin(cl.getNewWin());
		tcl.setPos(cl.getPos());
		tcl.setTitle(cl.getTitle());
		tcl.setType(cl.getTitle());
		tcl.setUrl(cl.getUrl());
		tcl.setUrlClass(cl.getUrlClass());
		tcl.setUrlId(cl.getUrlId());
		cmsLinkService.update(tcl);
		return "redirect:/admin/cmsLink/links";
	}
	
	
	@RequestMapping(value="/listByPage/{pageOffset}/{tarPage}")
	public String listByPage(Model model,@PathVariable Integer pageOffset, @PathVariable Integer tarPage,HttpSession session){
		SystemContext.setPageOffset(pageOffset);
		String type=(String) session.getAttribute("type");
		Pager<CmsLink>links=cmsLinkService.findByType(type);
		model.addAttribute("datas",links);
		model.addAttribute("types", cmsLinkService.ListAllType());
		model.addAttribute("curPage", tarPage);
		return "cmsLink/list";
		
	}
	

}
