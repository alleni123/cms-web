package com.lj.cms.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.lj.basic.model.SystemContext;
import com.lj.basic.util.FreemarkerUtil;
import com.lj.basic.util.PropertiesUtil;
import com.lj.cms.web.BaseInfoUtil;
import com.lj.core.model.Attachment;
import com.lj.core.model.BaseInfo;
import com.lj.core.model.Channel;
import com.lj.core.model.ChannelType;
import com.lj.core.model.IndexPic;
import com.lj.core.model.IndexTopic;
import com.lj.core.model.Keyword;
import com.lj.core.model.Topic;


/**
 * 该类包含了生成主页静态jsp模板的方法
 * @author Administrator
 *
 */
@Service("indexService")
public class IndexService implements IIndexService
{
	private String outPath;
	private FreemarkerUtil util;
	
	@Autowired
	private IChannelService channelService;
	@Autowired
	private ITopicService topicService;
	@Autowired
	private IIndexPicService indexPicService;
	@Autowired
	private IKeywordService keywordService;
	
	
	
	
	/**
	 * http://stackoverflow.com/questions/13711347/spring-constructor-dependency-injection-issues
	 */
	public IndexService()
	{
		// XXX Auto-generated constructor stub
	}
	
	
	/**
	 * 视频122  35分钟，这里的ftlPath值要通过依赖注入。 在beans.xml中配置了id=ftlPath的对象值。
	 * @param ftlPath
	 * @param outPath
	 */
//	@Autowired(required=true)
//	public IndexService(@Value("${ftlPath}") String ftlPath,@Value("${outPath}") String outPath)
//	{
//		
//		if(util==null){ 
//		this.outPath = outPath;
//		util=FreemarkerUtil.getInstance(ftlPath);//ftlPath在beans.xml中配置了依赖注入，值为/ftl
//		}
//	}
	
	
	@Autowired(required=true)
	public IndexService( String ftlPath,String outPath)
	{
		
		if(util==null){ 
		this.outPath = outPath;
		util=FreemarkerUtil.getInstance(ftlPath);//ftlPath在beans.xml中配置了依赖注入，值为/ftl
		}
	}

	@Override
	public void generateTop()
	{
		System.out.println("================重新生成了顶部信息================");
		List<Channel>channels = channelService.listTopNavChannel();
		Map<String,Object> root=new HashMap<String,Object>();
		root.put("navs", channels);
		root.put("baseInfo", BaseInfoUtil.getInstance().read());
		String outfile=SystemContext.getRealPath()+outPath+"/top.jsp";
		util.fprint(root, "/top.ftl", outfile);
	}

	@Override
	public void generateBottom()
	{
		System.out.println("================重新生成了底部信息================");
		Map<String,Object> root = new HashMap<String,Object>();
		root.put("baseInfo",BaseInfoUtil.getInstance().read());
		String outfile=SystemContext.getRealPath()+outPath+"/bottom.jsp";
		util.fprint(root, "/bottom.ftl", outfile);
	}

	@Override
	public void generateBody()
	{
		System.out.println("================开始生成内容信息================");
		
		Map<String,Object>root=new HashMap<String,Object>();
		String outfile=SystemContext.getRealPath()+outPath+"/body.jsp";
		
		
		//1. 获取精灵动态栏目
		List<Topic>affairs=topicService.listTopicByChannelAndNumber(139, 5);
		
		
		//2. 获取首页图片
		List<IndexPic>indexPics=indexPicService.listIndexPicByNum(3);
		
		//3. 获取精灵公告
		Topic annoucement = topicService.loadLatestTopicByColumn(140);
		
		
		root.put("annoucement", annoucement);
		root.put("pics", indexPics);
		root.put("affairs", affairs);
		
		util.fprint(root, "/body.ftl", outfile);

	}

}
