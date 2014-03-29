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
//@Controller
public class konghao_IndexController
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

	@RequestMapping("/channel/{channel_id}")
	public String showChannel(@PathVariable int channel_id, Model model, HttpServletResponse res, HttpServletRequest req) throws IOException
	{
		Channel channel = channelService.load(channel_id);
		Channel parent_channel = null;
		ChannelType type = channel.getType();
		if (type == ChannelType.NAV_CHANNEL)
		{
			parent_channel = channel;
			// 如果是导航栏目，需要获取该栏目中的第一个栏目
			channel = channelService.loadFirstChannelByNav(channel.getId());
		}
		else
		{
			parent_channel = channel.getParent();
		}

		if (type == ChannelType.TOPIC_CONTENT)
		{
			res.sendRedirect(req.getContextPath() + "/topic/" + (topicService.loadLatestTopicByColumn(channel_id)).getId());
		}
		else if (type == ChannelType.TOPIC_LIST)
		{
			SystemContext.setSort("t.publishDate");
			SystemContext.setOrder("desc");
			Pager<Topic> datas = topicService.find(channel.getId(), null, 1);
			model.addAttribute("datas", datas);
		}

		else if (type == ChannelType.TOPIC_IMG)
		{
			SystemContext.setPageSize(6);
			SystemContext.setSort("a.topic.publishDate");
			SystemContext.setOrder("desc");
			System.out.println(SystemContext.getPageSize());
			Pager<Attachment> datas = attachmentService.findChannelPic(channel_id);
			model.addAttribute("datas", datas);

		}

		SystemContext.removeOrder();
		SystemContext.removeSort();
		List<Channel> channels = channelService.ListChannelInUseByParent(parent_channel == null ? null : parent_channel.getId());

		model.addAttribute("parent_channel", parent_channel);
		model.addAttribute("channel", channel);
		model.addAttribute("channels", channels);
		model.addAttribute("curPage", 1);

		if (type != ChannelType.TOPIC_IMG)
		{
			return "index/channel";
		}
		else
		{
			return "index/channel_pic";
		}

	}

	@RequestMapping("/topic/{topic_id}")
	public String showTopic(@PathVariable int topic_id, Model model)
	{
		model.addAttribute(topicService.load(topic_id));
		List<Attachment> atts = attachmentService.listAttachByTopic(topic_id);

		if (atts.size() > 0)
		{
			model.addAttribute("hasAtts", true);
			model.addAttribute("attachments", atts);
		}
		else
		{
			model.addAttribute("hasAtts", false);
		}
		return "/index/topic";
	}

	@RequestMapping(value = "channel/{channel_id}/listByPage/{pageOffset}/{tarPage}")
	public String listByPage(Model model, @PathVariable int channel_id, @PathVariable Integer pageOffset, @PathVariable Integer tarPage, HttpServletRequest req,
			@RequestParam(required = false) String type)
	{
		SystemContext.setPageOffset(pageOffset);
		Channel channel = channelService.load(channel_id);

		if (!type.equals("img"))
		{	
			SystemContext.setPageOffset(pageOffset);
			SystemContext.setSort("t.publishDate");
			SystemContext.setOrder("desc");
			
			Pager<Topic> datas = topicService.find(channel_id, null, 1);
			model.addAttribute("datas", datas);
			model.addAttribute("curPage", tarPage);
			model.addAttribute("channel", channel);
			req.setAttribute("curPage", tarPage);
			SystemContext.removeOrder();
			SystemContext.removeSort();
			return "index/channel";
		}
		else
		{	
			SystemContext.setPageSize(6);
			SystemContext.setSort("a.topic.publishDate");
			SystemContext.setOrder("desc");
			Pager<Attachment> datas = attachmentService.findChannelPic(channel_id);
			model.addAttribute("datas", datas);
			model.addAttribute("channel", channel);
			req.setAttribute("curPage", tarPage);
			req.setAttribute("pageSize", 1);
			SystemContext.removeOrder();
			SystemContext.removeSort();
			return "index/channel_pic";
		}
	}
	
	@RequestMapping("/search/{con}")
	public String search(@PathVariable String con,Model model){
		SystemContext.setSort("t.publishDate");
		SystemContext.setOrder("desc");
		Pager<Topic> datas=topicService.find(null, con, 1);
		emphasize(datas, con);
		
		SystemContext.setSort("c.orders");
		SystemContext.setOrder("asc");
		List<Channel> channels=channelService.listChannelByType(ChannelType.NAV_CHANNEL);
		model.addAttribute("datas", datas);
		model.addAttribute("con", con);
		model.addAttribute("channels", channels);
		return "index/search";
	}
	
	@RequestMapping("/search/listByPage/{pageOffset}/{tarPage}")
	public String searchByPage(Model model,@PathVariable Integer pageOffset, @PathVariable Integer tarPage,
			@RequestParam String con){
		SystemContext.setPageOffset(pageOffset);
		SystemContext.setSort("c.orders");
		SystemContext.setOrder("asc");
		List<Channel> channels=channelService.listChannelByType(ChannelType.NAV_CHANNEL);
		model.addAttribute("channels", channels);
		
		SystemContext.setSort("t.publishDate");
		SystemContext.setOrder("desc");
		Pager<Topic> datas=topicService.find(null, con, 1);
		emphasize(datas, con);
		model.addAttribute("datas", datas);
		model.addAttribute("con", con);
		model.addAttribute("curPage", tarPage);
		return "index/search";
	}
	
	/**
	 * 这个方法是将所有检索出来的文章标题上的关键字加入效果
	 * 加入<span class='xx'>关键字<span>这种方法来实现。
	 * @param datas
	 * @param con
	 */
	private void emphasize(Pager<Topic>datas,String con){
		for(Topic t:datas.getDatas()){
			String title=t.getTitle().replaceAll(con, "<em>"+con+"</em>");
			t.setTitle(title);
		}
	}
	
	

}
