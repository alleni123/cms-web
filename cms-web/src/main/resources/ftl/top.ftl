    <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <div id="header">
            <div id="header_con">
                <div id="logo"></div>
                <div id="main_nav">
                    <ul>
                      <!-- 3/5改成玲玲要求的样子
                        <li>
                            <a href="#" class="main_nav_link">精灵网站首页</a>
                        </li>
                        <li>
                            <a href="#" class="main_nav_link">勤耕园</a>
                        </li>
                        <li>
                            <a href="#" class="main_nav_link">精灵论坛</a>
                        </li>
                        <li>
                            <a href="#" class="main_nav_link">精灵博客</a>
                        </li>
                        <li>
                            <a href="#" class="main_nav_link">精灵后台管理</a>
                        </li> -->
                        <li>
                            <a href="#" class="main_nav_link">联系精灵</a>
                        </li>
                    </ul>
                </div>
                <div id="search">
                    <input type="text" value="Search.." />
                    <!--<input type="button" value="搜索" id="search_btn"/>-->
                    <div id="search_btn"></div>
                </div>
            </div>

        </div>
        
        
        

        <div id="nav">
            <div id="nav_con">
                <ul>
                <#list navs as nav>
                    <li>
                    	<#if nav.customLink==0><#--0表示没有自定义链接-->
                        <span href="<%=request.getContextPath()%>/channel/${nav.id?c}">${nav.name}</span> <#--如果要生成html，就要去baseinfo.property里面取出domain name值，然后根据domain_name生成-->
                    	
                    	<#else>
                    	<span href="${nav.customLinkUrl}">${nav.name}</span>
                    	
                    	</#if>
                    </li>
                  </#list>

                </ul>
            </div>
        </div>
        
        
        
        
        
        
        
        
        
        
        
        