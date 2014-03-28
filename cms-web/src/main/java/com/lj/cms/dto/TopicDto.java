package com.lj.cms.dto;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotEmpty;

import com.lj.core.model.Topic;
import com.lj.core.model.User;

public class TopicDto
{	
	
	private final static SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm");
	
	private int id;
	private String title;
	
	
	 
	private String keyword;
	
 
	private int status;
	
	 
	private int recommend;
	 
	private String content;
	
	private String summary;
	
	private int channelPicId;
	 
	
	 
	private String publishDate;
	
 
	private int channel_id;
	
	private Topic topic;
	
	
	
	
	
	 
	 public void setTopic(Topic topic,TopicDto dto)
	{	
		this.topic = topic;
	}

	
	public int getId()
	{
		return id;
	}


	public void setId(int id)
	{
		this.id = id;
	}

	@NotEmpty(message="文章标题不能为空")
	public String getTitle()
	{
		return title;
	}


	public void setTitle(String title)
	{
		this.title = title;
	}


	public String getKeyword()
	{
		return keyword;
	}


	public void setKeyword(String keyword)
	{
		this.keyword = keyword;
	}


	public int getStatus()
	{
		return status;
	}


	public void setStatus(int status)
	{
		this.status = status;
	}


	public int getRecommend()
	{
		return recommend;
	}


	public void setRecommend(int recommend)
	{
		this.recommend = recommend;
	}


	public String getContent()
	{
		return content;
	}


	public void setContent(String content)
	{
		this.content = content;
	}


	public String getSummary()
	{
		return summary;
	}


	public void setSummary(String summary)
	{
		this.summary = summary;
	}

	
	public int getChannelPicId()
	{
		return channelPicId;
	}


	public void setChannelPicId(int channelPicId)
	{
		this.channelPicId = channelPicId;
	}


	public String getPublishDate()
	{
		return publishDate;
	}


	public void setPublishDate(String publishDate)
	{
		this.publishDate = publishDate;
	}
	//@NotEmpty(message="栏目必须选择")
	//@NotNull(message="栏目必须选择")
	@Min(value=1,message="必须选择一个栏目id")
	public int getChannel_id()
	{
		return channel_id;
	}


	public void setChannel_id(int channel_id)
	{
		this.channel_id = channel_id;
	}


	public TopicDto()
	{
		// XXX Auto-generated constructor stub
	}
	
	//setPublishDate这里要参考61_文章管理 35分钟。 和这里略微不同
	public Topic getTopic(){
		Topic t = new Topic();
		t.setChannelPicId(this.getChannelPicId());
		t.setContent(this.getContent());
		t.setId(this.getId());
		t.setKeyword(this.getKeyword());
		 try{
			 t.setPublishDate(sdf.parse(this.getPublishDate()));
		 }catch(ParseException p){
			 t.setPublishDate(new Date());
		 }
		t.setRecommend(this.getRecommend());
		t.setStatus(this.getStatus());
		t.setSummary(this.getSummary());
		t.setTitle(this.getTitle());
		return t;
	}
	 
	 public TopicDto(Topic topic,Integer channel_id){
		// 会报空指针 this.setChannel_id(topic.getChannel().getId());
		 this.setChannel_id(channel_id);
		 
		 this.setChannelPicId(topic.getChannelPicId());
		 this.setContent(topic.getContent());
		 this.setId(topic.getId());
		 this.setKeyword(topic.getKeyword());
		 this.setPublishDate(sdf.format(topic.getPublishDate()));
		 this.setRecommend(topic.getRecommend());
		 this.setStatus(topic.getStatus());
		 this.setSummary(topic.getSummary());
		 this.setTitle(topic.getTitle());
		 
	 }
	
	 public TopicDto(Topic topic){
		this(topic,0);// 添加文章的时候，先传进去一个0. 但愿别出啥问题。 
	 }
	 
	
 
}
