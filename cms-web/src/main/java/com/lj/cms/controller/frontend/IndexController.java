package com.lj.cms.controller.frontend;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lj.basic.model.Pager;
import com.lj.basic.model.SystemContext;
import com.lj.cms.service.IAttachmentService;
import com.lj.cms.service.IChannelService;
import com.lj.cms.service.ITopicService;
import com.lj.cms.web.BaseInfoUtil;
import com.lj.core.model.Attachment;
import com.lj.core.model.Channel;
import com.lj.core.model.ChannelType;
import com.lj.core.model.Topic;

/**
 * 这个是用来访问前台首页的
 * 
 * @author Administrator
 * 
 */
@Controller
public class IndexController
{
	@Autowired
	private IChannelService channelService;

	@Autowired
	private ITopicService topicService;

	@Autowired
	private IAttachmentService attachmentService;

	@RequestMapping({ "/", "/index" })
	public String index(Model model)
	{
		model.addAttribute("baseInfo", BaseInfoUtil.getInstance().read());
		return "index/index";
	}

	
	@RequestMapping("/story")
	public String story(Model model){
		model.addAttribute("sel_page", true);
		model.addAttribute("nav_index",0);
		return "index/story";
	}
	
	@RequestMapping("/gallery")
	public String gallery(Model model){
		model.addAttribute("sel_page", true);
		model.addAttribute("nav_index",1);
		return "index/gallery";
	}
	
	@RequestMapping("/blog")
	public String blog(Model model){
		model.addAttribute("sel_page", true);
		model.addAttribute("nav_index",2);
		return "index/blog";
	}
	
	@RequestMapping("/blog_content")
	public String blog_content(Model model){
		model.addAttribute("sel_page", true);
		model.addAttribute("nav_index",2);
		return "index/blog_content";
	}
	
	
	@RequestMapping("/link")
	public String link(Model model){
		model.addAttribute("sel_page", true);
		model.addAttribute("nav_index",3);
		return "index/link";
	}
	
	

}
