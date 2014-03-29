<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>精灵的故事</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/frontend/css/main.css" />
<script type="text/javascript" src="<%=path%>/resources/frontend/js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="<%=path%>/resources/frontend/js/jquery.cms.common.js"></script>
<script type="text/javascript" src="<%=path%>/resources/frontend/js/main.js"></script>

  <style type="text/css">
            #blog_container {
                /*  border:1px solid blue;*/
                width: 75%;
                margin: 0 auto;
            }

            .blog {
                padding: 0 20px 40px;
                margin-top: 50px;
            }

            .blog a:visited, a:link, a:hover {
                color: #000;
            }

            .blog .content {
                width: 140px;
            }

            .blog .blog_title_h {
                padding-bottom: 20px;
            }

            .blog .blog_title_h .blog_title {
                text-align:center;
                margin-bottom:5px;
               
                /*margin: 0 auto;
                width: 200px;*/
            }

            .blog .blog_title span{
                 font-family: "微软雅黑";
                font-size: 18px;
            }

            .blog .tagMore {
                height: 15px;
                margin-bottom: 20px;
            }

            .blog .SG_txtc {
                text-align:center;
                color: #878787
            }

            .blog .linedot {
                background: url(css/img/line_dot.jpg);
                height: 2px;
            }

            .blog_comment {
                clear: both;
                margin: 0 auto;
                width: 800px;
            }
            
            .comment_header{
                margin-right:10px;
                
            }
            
            .comment_header_text{
                font-size:14px;
                font-weight:bold;
            }
            
            .comment_body{
                padding:10px 0;
            }

            .edui_container {
                border: 1px solid #ccc;
                font-size: 14px;
                outline: none;
                padding:0 10px;
            }
            
            .edui_container  p{
                margin:5px 0;
            }

        </style>

</head>

<body>
	<input type="hidden" value="<%=path%>" id="ctx" />
	<input type="hidden" value="${sel_page}" id="sel_page" />
	<input type="hidden" value="${nav_index}" id="nav_index" />
	<jsp:include page="/jsp/template/top.jsp" />
	 <div id="content">
            <div id="content_con" style="height:1473px">

                <div id="blog_container">
                    <div class="blog">
                        <div class="blog_title_h">
                            <div class="blog_title">
                                <span>圣诞快乐~</span>
                            </div>
                            <div class="time SG_txtc">
                                 <span>(2013-14-24 23:06)</span>
                            </div>

                        </div>
                        <div class="content">
                            <p>
                                <a href="#" target="_blank"> <img src="css/img/Christmas.jpg" /> </a>
                                <br>
                                <br>
                            </p>
                        </div>
                        <div class="tagMore">
                            <a href="#" target="_blank">阅读</a>(6) ┆ <a href="#" target="_blank">评论</a>(0) ┆ <span class="SG_txtc">禁止转载</span> ┆

                        </div>
                        <div class="linedot">

                        </div>
                    </div>

                    <div class="blog_comment">
                        <div class="comment_header clearfix">
                            <div class="comment_header_text">
                                发表评论
                            </div>
                        </div>
                        <div class="comment_body editor_wrapper">
                            <div class="edui_body">
                                <div class="edui_container" style="height:220px;width:580px" contenteditable="true">
                                    <p>
                                        <br>
                                    </p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="comment_foot">
                            <div class="comment_add">
                                发表评论人:<input type="text" name="commentor_name" size="10" />&nbsp;
                                <input type="button" value="提交评论"/>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
	<jsp:include page="/jsp/template/bottom.jsp" />
</body>
</html>
