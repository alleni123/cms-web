      <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<#--孔浩的dateFormat写的是df.
	titleSize->文章标题所显示的最长长度，多余这个长度要显示...
	hasHx->是否有<h3>标题</h3>类似的东西
	hasDt->是否有<dt></dt>
	showDot->是否显示...
	
	
	这里的map结构
	1-->IndexTopic --> cid,cname,List<Topic>topics
	
-->
<#macro indexTopicList indexTopic titleSize  showDate=true hasHx=false hasDt=true showDot=true dateFormat="MM/dd" divId="" hrefClz="">
	
	<#--divId是否为空，为空则空，否则id=divId-->
	<div ${(divId=="")?string("","id=${divId}")}>
		
				
					<#if hasHx> <#--如果有h3之类的，就会写入具体的nested内容-->
						 <#nested/>
					</#if>
				
					    <dl>
		                <#if hasDt>
		                	 <dt>
		                	 	<#--这是文章的栏目名称-->
                                <span>${indexTopic.cname}</span>
                            </dt>
		                </#if>
		                
		                <#list indexTopic.topics as topic>
		               		 <dd>
		               			 <a title="${topic.title}" href="topic/${topic.id}" ${hrefClz==""?string("","class='${hrefClz}'")} class="index_link">
		               		 		<#if showDate>[${topic.publishDate?date("${df}")}]</#if>
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
                	
                	<@indexTopicList indexTopic=topics["1"] titleSize=12 showDate=true divId="notice" hrefClz="index_link">
                		 <span>${topics["1"].cname}</span>
                	</@indexTopicList>
                    <div id="notice">
                        <dl>
                            <dt>
                                <span>校内通知</span>
                            </dt>
                            <dd>
                                <a href="" class="index_link">关于xxx的通知</a>
                            </dd>
                            <dd>
                                <a href="" class="index_link">关于xxx的通知</a>
                            </dd>
                            <dd>
                                <a href="" class="index_link">关于xxx的通知</a>
                            </dd>
                            <dd>
                                <a href="" class="index_link">关于xxx的通知</a>
                            </dd>
                            <dd>
                                <a href="" class="index_link">关于xxx的通知</a>
                            </dd>
                            <dd>
                                <a href="" class="index_link">关于xxx的通知</a>
                            </dd>
                        </dl>
                    </div>
                    <div id="rollpic">
                        <div class="cycle-pager"></div>
                        <img src="<%=path%>/resources/css/index/img/01.jpg" width="695" height="262"/>
                        <img src="<%=path%>/resources/css/index/img/02.jpg" width="695" height="262"/>
                    </div>
                </div>
                <div id="split_line"></div>
                <!--校务概况 学校概况-->
                <div id="xwgk_xxgk">
                    <div id="xwgk">
                    
                   <@indexTopicList indexTopic=topics["2"] titleSize=37 divId="xwgk" hrefClz="index_link">
                		   <h3>${topics["2"].cname}</h3>
                       	 <div id="xwgk_bg"></div>
                	</@indexTopicList>
                    </div>
                    
                    <div id="xxgk">
                        <h3>学校概况</h3>
                        <div id="xxgk_bg"></div>

                        学校概况文字 学校概况文字 学校概况文字 学校概况文字 学校概况文字
                        学校概况文字 学校概况文字 学校概况文字 学校概况文字 学校概况文字
                        学校概况文字 学校概况文字 学校概况文字 学校概况文字 学校概况文字
                        学校概况文字 学校概况文字 学校概况文字 学校概况文字 学校概况文字
                        学校概况文字 学校概况文字 学校概况文字 学校概况文字 学校概况文字
                        学校概况文字 学校概况文字 学校概况文字 学校概况文字 学校概况文字
                        学校概况文字 学校概况文字 学校概况文字 学校概况文字 学校概况文字
                        学校概况文字 学校概况文字 学校概况文字 学校概况文字 学校概况文字
                        学校概况文字 学校概况文字 学校概况文字 学校概况文字 学校概况文字
                        学校概况文字 学校概况文字 学校概况文字 学校概况文字 学校概况文字
                        学校概况文字 学校概况文字 学校概况文字 学校概况文字 学校概况文字
                        学校概况文字 学校概况文字 学校概况文字 学校概况文字 学校概况文字
                        学校概况文字 学校概况文字 学校概况文字 学校概况文字 学校概况文字
                    </div>

                </div>
                <!--活动简讯，教育科研-->
                <div id="hdjx_jyky">
                	<@indexTopicList indexTopic=topics["3"] titleSize=31 showDate=true divId="hdjx" hrefClz="index_link">
                		  <span class="t_title">${topics["3"].cname}</span><span class="more"><a href="channel/${topics["3"].cid}">更多</a></span>
                	</@indexTopicList>
                
                 
                 	<@indexTopicList indexTopic=topics["4"] titleSize=31 showDate=true divId="jyky" hrefClz="index_link">
                		  <span class="t_title">${topics["4"].cname}</span><span class="more"><a href="channel/${topics["4"].cid}">更多</a></span>
                	</@indexTopicList>
                 
                  
                </div>

                <!--关键字-->
                <div id="chief_keyword">
                    <div>
                        <span class="keyword">关键字1</span>
                        <span class="keyword">关键字2</span>
                        <span class="keyword">关键字3</span>
                        <span class="keyword">关键字4</span>
                        <span class="keyword">关键字5</span>
                          <span class="keyword">关键字1</span>
                        <span class="keyword">关键字2</span>
                        <span class="keyword">关键字3</span>
                        <span class="keyword">关键字4</span>
                        <span class="keyword">关键字5</span>
                          <span class="keyword">关键字1</span>
                        <span class="keyword">关键字2</span>
                        <span class="keyword"> 关键字3</span>
                        <span class="keyword">关键字4</span>
                        <span class="keyword">关键字5</span>
                          <span class="keyword">关键字1</span>
                        <span class="keyword">关键字2</span>
                        <span class="keyword">关键字3</span>
                        <span class="keyword">关键字4</span>
                        <span class="keyword">关键字5</span>
                    </div>
                </div>
            </div>

        </div>