    <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     
     <div id="header">
            <div id="header_con">
                <div id="header_con_wrapper">
                    <div id="logo"></div>
                    <div id="search">
                        <input type="text" value="Search.." />
                        <div id="search_btn"></div>
                    </div>
                </div>
            </div>
        </div>
        <div id="nav">
            <div id="nav_con">
                <ul>
                    <li class="nav_hover">
                        <span href="<%=request.getContextPath()%>/story" class="nav_con_mainli"><span class="nav_con_li_eng">About</span> <span class="nav_con_li_chn">精灵的故事</span></span>
                    </li>
                    <li class="nav_hover">
                        <span href="<%=request.getContextPath()%>/gallery" class="nav_con_mainli"><span class="nav_con_li_eng">Gallery</span> <span class="nav_con_li_chn">精灵的作品</span></span>
                    </li>
                    <li class="nav_hover">
                        <span href="<%=request.getContextPath()%>/blog" class="nav_con_mainli"><span class="nav_con_li_eng">Blog</span> <span class="nav_con_li_chn">精灵的博客</span></span>
                    </li>
                    <li class="nav_hover" style="margin-right: 0px;padding-right: 5px">
                        <span href="<%=request.getContextPath()%>/link" class="nav_con_mainli"><span class="nav_con_li_eng">Link</span> <span class="nav_con_li_chn">精灵的链接</span></span>
                    </li>
                </ul>
            </div>
        </div>