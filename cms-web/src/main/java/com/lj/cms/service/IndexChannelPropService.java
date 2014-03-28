package com.lj.cms.service;

import java.util.Enumeration;
import java.util.List;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lj.basic.util.PropertiesUtil;
import com.lj.cms.web.BaseInfoUtil;
import com.lj.core.model.BaseInfo;
import com.lj.core.model.Channel;
import com.lj.core.model.ChannelType;


@Service("indexChannelPropService")
public class IndexChannelPropService
{	
	PropertiesUtil util;
	
	@Autowired
	private IChannelService channelService;
	
	 
	
	
	public void generateProp(){
		Properties props=util.load("indexChannel");
		List<Channel>channels=channelService.listAllIndexChannel(ChannelType.TOPIC_CONTENT);
		channels.addAll(channelService.listAllIndexChannel(ChannelType.TOPIC_IMG));
		
		Enumeration<String> cids=(Enumeration<String>) props.propertyNames();
		
		BaseInfo bi=BaseInfoUtil.getInstance().read();
		int propICN=bi.getIndexChannelNumber();
		
		
		
	}
	
}
