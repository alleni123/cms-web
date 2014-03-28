package com.lj.cms.controller;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;


import org.jboss.logging.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lj.basic.util.EnumUtils;
import com.lj.cms.auth.AuthClass;
import com.lj.cms.auth.AuthMethod;
import com.lj.cms.dto.AjaxObj;
import com.lj.cms.dto.TreeDto;
import com.lj.cms.service.IChannelService;
import com.lj.cms.web.BaseInfoUtil;
import com.lj.core.model.Channel;
import com.lj.core.model.ChannelTree;
import com.lj.core.model.ChannelType;

@RequestMapping("/admin/channel")
@Controller
@AuthClass
public class ChannelController
{
	@Autowired
	private IChannelService channelService;
 
	
	/**
	 * 初识显示页面
	 * @param model
	 * @return
	 */
	@RequestMapping("/channels")
	public String list(Model model)
	{
		// model.addAttribute("treeDatas",
		// JsonUtil.getInstance().obj2json(channelService.generateTree()));
		return "channel/list";

	}
	
	
	/**
	 * 通过pid查询子栏目的页面。 这个页面是通过ztree的callback.onClick绑定事件来请求获取的。
	 * @param pid
	 * @param refresh
	 * @param model
	 * @return
	 */
	@RequestMapping("/channels/{pid}")
	public String listChild(@PathVariable Integer pid, @Param Integer refresh,
			Model model)
	{
		Channel pc = null;
		if (refresh == null)
		{
			model.addAttribute("refresh", 0);
		}
		else
		{
			model.addAttribute("refresh", 1);
		}

		if (pid == null || pid <= 0)
		{
			pc = new Channel();
			pc.setName(Channel.ROOT_NAME);
			pc.setId(Channel.ROOT_ID);

		}
		else
			pc = channelService.load(pid);

		model.addAttribute("parentChannel", pc);
		List<Channel> channels = channelService.listByParent(pid);
		for (Channel c : channels)
		{
			System.out.println(c);
		}
		model.addAttribute("channels", channels);
		return "channel/list_child";

	}
	
	
	
	
	
	
	

	@RequestMapping("/listdemo")
	public String listDemo()
	{
		return "/channel/listdemo";
	}

	@RequestMapping("/treeAll")
	public @ResponseBody
	List<ChannelTree> tree()
	{	
		return channelService.generateTree();
	}
	
	/**
	 * 这里孔浩用来添加文章时是用上面的/treeAll. 但是我觉得添加文章时不应该在停用的栏目中添加。
	 * 所以这里写了一个获取所有启用的栏目的ChannelTree的List
	 * @return
	 */
	@RequestMapping("/treeEnabled")
	public @ResponseBody List<ChannelTree> treeEnabled(){
		return channelService.generateTreeEnabled();
		
	}

	@RequestMapping(value = "/treeAsy", method = RequestMethod.POST)
	public @ResponseBody
	List<TreeDto> tree(@Param Integer pid)
	{
		List<TreeDto> treeDtos = new ArrayList<TreeDto>();

		if (pid == null)
		{
			treeDtos.add(new TreeDto(0, "网站跟栏目", -1));
			return treeDtos;
		}

		List<ChannelTree> channelTrees = channelService
				.generateTreeByParent(pid);
		for (ChannelTree channelTree : channelTrees)
		{
			treeDtos.add(new TreeDto(channelTree.getId(),
					channelTree.getName(), 1));
		}

		return treeDtos;

	}



	@RequestMapping(value = "/add/{pid}", method = RequestMethod.GET)
	public String add(@PathVariable Integer pid, Model model)
	{
		if (pid == null)
			pid = 0;
		Channel parentChannel = null;
		if (pid == 0)
		{
			parentChannel = new Channel();
			parentChannel.setId(Channel.ROOT_ID);
			parentChannel.setName(Channel.ROOT_NAME);
		}
		else
		{
			parentChannel = channelService.load(pid);
		}

		model.addAttribute("parentChannel", parentChannel);
		model.addAttribute("channelTypes",
				EnumUtils.enumProp2NameMap(ChannelType.class, "name"));
		model.addAttribute(new Channel());
		return "channel/add";
	}

	/**
	 *  3/15 个人修改
	 *  要加入令indexChannel.properties随着channel的变化而变化。
	 *  即如果加入了新的首页栏目， 那么properties文件才会有数字。
	 *  to be done
	 */
	@RequestMapping(value = "/add/{pid}", method = RequestMethod.POST)
	public String add(@PathVariable Integer pid, Channel channel,
			BindingResult br, Model model)
	{
		if (br.hasErrors())
		{
			System.out.println("add/pid post error");
			if (pid == null)
				pid = 0;
			Channel parentChannel = null;
			if (pid == 0)
			{
				parentChannel = new Channel();
				parentChannel.setId(Channel.ROOT_ID);
				parentChannel.setName(Channel.ROOT_NAME);

			}
			else
			{
				parentChannel = channelService.load(pid);
			}

			model.addAttribute("parentChannel", parentChannel);
			model.addAttribute("channelTypes",
					EnumUtils.enumProp2NameMap(ChannelType.class, "name"));

			return "channel/add";
		}
		if(channel.getIsIndex()!=1){
		channelService.add(channel, pid);}
		else{
			URL url=ChannelController.class.getClassLoader().getResource("indexChannel.properties");
			
			channelService.addIndexChannel(channel,pid,BaseInfoUtil.getInstance().read(),url);
		}
		return "redirect:/admin/channel/channels/" + pid + "?refresh=1";
	}

	@RequestMapping(value = "/delete/{pid}/{id}", method = RequestMethod.GET)
	public String delete(@PathVariable Integer pid, @PathVariable Integer id,
			Model model)
	{
		channelService.delete(id);
		return "redirect:/admin/channel/channels/" + pid + "?refresh=1";
	}

	@RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
	public String update(Model model, @PathVariable Integer id)
	{
		Channel channel = channelService.load(id);
		model.addAttribute("channel", channel);
		
		
		Channel parent_channel=null;
		/**
		 * 父栏目为空的栏目，最高层的主栏目。此时new一个父栏目，并调用默认的ROOT_ID->0和ROOT_NAME->"网站系统栏目"
		 */
		if(channel.getParent()==null){ 
			parent_channel=new Channel();
			parent_channel.setId(Channel.ROOT_ID);      
			parent_channel.setName(Channel.ROOT_NAME); 
		}else{
			parent_channel=channel.getParent();
		}
		
		
		model.addAttribute("channelTypes",
				EnumUtils.enumProp2NameMap(ChannelType.class, "name"));
		// model.addAttribute(new Channel());
		return "channel/update";
	}

	@RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
	public String update(Model model, @PathVariable Integer id,
			Channel channel, BindingResult br)
	{
		if (br.hasErrors())
		{
			// # TODO model.addAttribute("channelTypes",
			// EnumUtils.enumProp2NameMap(ChannelType.class, "name"));

			return "channel/update";
		}

		Channel update_channel = channelService.load(id);
		int pid=0;
		if (update_channel.getParent() != null)
		{
			pid=update_channel.getParent().getId();
		}

		System.out.println("pid= " + update_channel.getParent());
		update_channel.setCustomLink(channel.getCustomLink());
		update_channel.setCustomLinkUrl(channel.getCustomLinkUrl());
		update_channel.setIsIndex(channel.getIsIndex());
		update_channel.setIsTopNav(channel.getIsTopNav());
		update_channel.setName(channel.getName());
		update_channel.setOrders(channel.getOrders());

		update_channel.setRecommend(channel.getRecommend());
		update_channel.setStatus(channel.getStatus());
		update_channel.setType(channel.getType());
		update_channel.setNavOrder(channel.getNavOrder());
		channelService.update(update_channel);
		return "redirect:/admin/channel/channels/"
				+ pid + "?refresh=1";

	}

	@RequestMapping("/channels/updateSort")
	public @ResponseBody
	AjaxObj updateSort(@Param Integer[] ids)
	{
		try
		{
			channelService.updateSort(ids);
		}
		catch (Exception e)
		
		
		{
			return new AjaxObj(0, e.getMessage());
		}

		return new AjaxObj(1);
	}

}
