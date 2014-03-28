package com.lj.cms.controller;

import java.net.URL;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.lj.basic.util.EnumUtils;
import com.lj.cms.auth.AuthClass;
import com.lj.cms.service.IChannelService;
import com.lj.cms.web.BaseInfoUtil;
import com.lj.core.model.Channel;
import com.lj.core.model.ChannelType;


/**
 * 用于设置主页文章栏目列表信息的。 
 * 也就是存放在indexChannel.properties文件中的信息。
 * @author Administrator
 *
 */

@RequestMapping("/admin/indexChannel")
@Controller
@AuthClass
public class IndexChannelController
{	
	@Autowired
	private IChannelService channelService;
	
	private static URL url= IndexChannelController.class.getClassLoader().getResource("indexChannel.properties");
	

	
	
	@RequestMapping("/channels")
	public String list(Model model){
		model.addAttribute("indexChannels", channelService.listAllIndexChannel(new ChannelType[]{ChannelType.TOPIC_LIST,ChannelType.TOPIC_IMG}));
		model.addAttribute("indexChannelNum", BaseInfoUtil.getInstance().read().getIndexChannelNumber());
		
		return "backend/index_channel/list";
	}
	
	
	@RequestMapping(value="/add",method=RequestMethod.GET)
	public String add(Model model){
		model.addAttribute(new Channel());
		Map<String,String> types=EnumUtils.enumProp2NameMap(ChannelType.class, "name");
		types.remove(ChannelType.NAV_CHANNEL.name());
		types.remove(ChannelType.TOPIC_CONTENT.name());
		model.addAttribute("channelTypes", types);
		return "backend/index_channel/add";
	}
	
	@RequestMapping(value="/add",method=RequestMethod.POST)
	public String add(Channel channel, BindingResult br, Model model){
		if(br.hasErrors()){
			return "backend/index_channel/list";
		}
		
		channelService.addIndexChannel(channel,Channel.ROOT_ID , BaseInfoUtil.getInstance().read(),url);
		return "redirect:/admin/indexChannel/channels/?refresh=1";
	}
	
	@RequestMapping(value="/delete/{id}")
	public String delete(@PathVariable Integer id){
		channelService.deleteIndexChannel(id, url);
		return "redirect:/admin/indexChannel/channels?refresh=1";
	}
	
	
	
	
	
	
}
