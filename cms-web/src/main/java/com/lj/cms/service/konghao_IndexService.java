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
@Service("konghao_indexService")
public class konghao_IndexService implements IIndexService
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
	public konghao_IndexService()
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
	public konghao_IndexService( String ftlPath,String outPath)
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
		System.out.println("=================重新生成了内容信息================");
		//1.获取所有的首页栏目
		List<Channel> channels=channelService.listAllIndexChannel(ChannelType.TOPIC_LIST);
		channels.addAll(channelService.listAllIndexChannel(ChannelType.TOPIC_IMG));
		//2.根据首页栏目创建相应的IndexTopic对象
		//加载indexChannel.properties
		Properties prop=PropertiesUtil.getInstance().load("indexChannel");
		System.out.println(prop.get("10"));
		Map<String,IndexTopic>topics=new HashMap<String,IndexTopic>();
		
		/**
		 * 这个for循环要对首页栏目进行遍历，获取栏目下所有要被生成到主页的文章信息。
		 */
		for(Channel c:channels){
			System.out.println(c.getName());
			
			String[] xs=prop.getProperty(c.getId()+"").split("_"); //1_8这里1是排序号，8表示显示的文章标题数量。
			String order=xs[0];
			int num=Integer.parseInt(xs[1]);
			
			List<Topic>ts=topicService.listTopicByChannelAndNumber(c.getId(), num);
			
			System.out.println("topics= "+ts.size());
			
			IndexTopic it=new IndexTopic();
			it.setChannel_id(c.getId());
			it.setChannel_name(c.getName());
			it.setTopics(ts);
			topics.put(order, it);
		}
		
		String outfile=SystemContext.getRealPath()+outPath+"/body.jsp";
		Map<String,Object>root=new HashMap<String,Object>();
		root.put("ts", topics);
		
		BaseInfo bi=BaseInfoUtil.getInstance().read();
		int picNum=bi.getIndexPicNumber();
		List<IndexPic>indexPics=indexPicService.listIndexPicByNum(picNum);
		
		
//		IndexPic a=new IndexPic();
//		a.setLinkUrl("http://www.baidu.com");
//		a.setTitle("baidu");
//		a.setNewName("1390047601616.jpg");
//		IndexPic a2=new IndexPic();
//		a2.setLinkUrl("http://www.sina.com");
//		a2.setTitle("sina");
//		a2.setNewName("1390131966921.jpg");
//		as.add(a); as.add(a2);
		
//		Topic xxgk=new Topic();
//		xxgk.setSummary("这是学校概况");
		
		Topic introduction=topicService.loadLatestTopicByColumn(1020);
		
		//List<Keyword>keywords=Arrays.asList(new Keyword("ni",2),new Keyword("wo",3));
		List<Keyword> keywords=keywordService.getMaxTimesKeyword(12);
		root.put("keywords", keywords);
		root.put("introduction",introduction);
		root.put("pics", indexPics);
		util.fprint(root,"/body_exercise.ftl", outfile);
	}

}
