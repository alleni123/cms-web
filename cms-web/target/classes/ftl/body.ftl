<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<#macro indexTopicList indexTopic titleSize divId="" hrefClz="" hasDt=true hasH=false df="MM/dd" showDate=true>
	<#--<div ${(divId="")?string("","id='${divId}'")}>  这里不需要div了-->
			
			<div class="dot_line">
	</div>
	<#if hasH>
		<#nested/>
	</#if>
	
	<dl>
		<#if hasDt>
			<dt><#nested></dt>
		</#if>
		
		<#--<#list indexTopic.topics as topic>-->
		<#list indexTopic as topic>
			<dd>
				<span class="index_affairs_link_dot"></span>
				<a href="topic/${topic.id?c}" class="index_affairs_link" target="_blank">
					${(topic.publishDate)?string("${df}")}&nbsp;${topic.title}
				</a>
			</dd>
		</#list>
		
	</dl>
</#macro>


<div id="content">
	<div id="content_con">
		
		<div id="rollpic">
			<div class="cycle-pager"></div>
			<#list pics as pic>
				<img src="<%=request.getContextPath()%>/resources/indexPic/${pic.newName}"
				border="0" width="766px" height="735px" href="${pic.linkUrl}" title="${pic.title}"/>
			</#list>
		</div>
		
		<div id="announcement">
			<div class="dot_line"></div>
			<h3>精灵公告</h3>
			<p>${(annoucement.content)!("暂无简介信息")}
			</p>
		</div>
		
		<div id="affairs">
			<@indexTopicList indexTopic=affairs hasDt=true titleSize=31 divId="annoucement">
				<span>精灵动态</span>
	           						
			</@indexTopicList>
		</div>
		
	
	
	</div>
</div>









