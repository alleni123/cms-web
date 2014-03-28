<%@page language="java" contentType="text/html;charset=utf-8"
pageEncoding="utf-8"%>

<#macro indexTopicList indexTopic titleSize divId="" hrefClz="" hasDt=true hasH=false df="MM/dd" showDate=true>
	<div ${(divId="")?string("","id='${divId}'")}>
	<#if hasH>
		<#nested/>
	</#if>
	
	
	<dl>
		<#if hasDt>
			<dt><#nested/></dt>
		</#if>
		
		<#list indexTopic.topics as topic>
			<dd>
				<a title="${topic.title}" href="topic/${topic.id?c}" target="_blank" ${(hrefClz=="")?string("","class='${hrefClz}'")}>
					<#if showDate>[${(topic.publishDate)?string("${df}")}]</#if>
					<#if topic.title?length gt titleSize>
						${topic.title[0..titleSize]}<#if showDot>...</#if>
					<#else>
						${topic.title}
					</#if>
					
				</a>
			</dd>
		</#list>
		
	</dl>
	
	</div>
	
</#macro>



<div id="content">
	<div id="content_con">
		<div id="slogan"></div>
		<div id="notice_rollpic">
			<@indexTopicList indexTopic=ts["1"] titleSize=12 divId="notice" hrefClz="index_link">
			 	<span><a href="channel/${ts["1"].channel_id?c}" class="index_title_href">${ts["1"].channel_name}</a></span>
			 </@indexTopicList>
			<div id="rollpic">
				<div class="cycle-pager"></div>
					<#list pics as pic>
						<#--<a href="${pic.linkUrl}" title="${pic.title}">-->
							<img src="<%=request.getContextPath()%>/resources/indexPic/${pic.newName}" border="0" width="695" height="262" href="${pic.linkUrl}" title="${pic.title}"/>
						<#--</a>-->
					</#list>
			</div>
		</div>
		
		<div id="split_line"></div>
		
		<div id="xwgk_xxgk">
			<@indexTopicList indexTopic=ts["2"] hasH=true hasDt=false titleSize=37 divId="xwgk" hrefClz="index_link">
				<h3><a href="channel/${ts["2"].channel_id?c}" class="index_title_href">${ts["2"].channel_name}</a></h3>
				<div id="wxgk_bg"></div>
			</@indexTopicList>
			
			<div id="xxgk">
				<h3><a href="channel/1020" class="index_title_href">玲玲简介</a></h3>
				<div id="xxgk_bg"></div>
				 ${(introduction.summary)!("暂无简介信息")}
			</div>
		</div>
		
		<div id="hdjx_jyky">
			<@indexTopicList indexTopic=ts["3"] titleSize=31 divId="hdjx" hrefClz="index_link">
				<span class="t_title"><a href="channel/${ts["3"].channel_id?c}">${ts["3"].channel_name}</a></span>
				<span class="more"><a href="channel/${ts["3"].channel_id?c}">更多</a></span>
			</@indexTopicList>
			
			<@indexTopicList indexTopic=ts["4"] titleSize=31 divId="jyky" hrefClz="index_link">
				<span class="t_title"><a href="channel/${ts["4"].channel_id?c}">${ts["4"].channel_name}</a></span>
				<span class="more"><a href="channel/${ts["4"].channel_id?c}">更多</a></span>
			</@indexTopicList>
			
		</div>
		
		<div id="chief_keyword">
				<div>
					<#list keywords as kw>
						<span class="keyword" href="keyword/${kw.name}">${kw.name}</span>
					</#list>
				</div>
			
		</div>
		
		
		
	</div>
</div>
