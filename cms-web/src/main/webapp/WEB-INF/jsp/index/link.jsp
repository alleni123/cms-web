<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>精灵的故事</title>
     <link rel="stylesheet" type="text/css" href="<%=path%>/resources/frontend/css/main.css"/>
     <script type="text/javascript" src="<%=path%>/resources/frontend/js/jquery-1.9.0.js"></script>
     <script type="text/javascript" src="<%=path%>/resources/frontend/js/jquery.cms.common.js"></script>
     <script type="text/javascript" src="<%=path%>/resources/frontend/js/main.js"></script>
	
      <style type="text/css">
            #content_con {
                background-color: #fff;
                border-radius: 7px;
            }

            .link_container {
                margin: 0 auto;
                width: 75%;
                border: 1px solid blue;
                padding-top:50px;
            }
            
            .linklists .link{
                padding:22px 10px 5px 10px;
            }
            
            .link .link_img{
                padding:10px 0;
            }
            
            .link_title span{
                font-size:18px;
                
            }

        </style>
	 	
	 	<script type="text/javascript">
	 		$(function(){
	 			
	 		});
	 	</script>
  </head>
  
  <body>
  <input type="hidden" value="<%=path%>" id="ctx"/>
  <input type="hidden" value="${sel_page}" id="sel_page"/>
  <input type="hidden" value="${nav_index}" id="nav_index"/>
  		<jsp:include page="/jsp/template/top.jsp"/>
  
   <div id="content">
            <div id="content_con" style="height:773px">
                <div class="link_container">

                    <div class="linklists">
                        <div class="link">
                            <div class="link_title">
                                <span>精灵事务所</span>
                            </div>
                            <div class="link_img">
                               <a href="#" target="_blank"> <img src="#" width="320px" height="100px"/></a>
                            </div>
                            <div class="link_intro">
                                <span>负责精灵网站产品的生产与设计</span>
                            </div>
                            
                        </div>
                        
                        
                         <div class="link">
                            <div class="link_title">
                                <span>精灵事务所</span>
                            </div>
                            <div class="link_img">
                                <a href="#" target="_blank"><img src="#" width="320px" height="100px"/></a>
                            </div>
                            <div class="link_intro">
                                <span>负责精灵网站产品的生产与设计</span>
                            </div>
                            
                        </div>
                        
                         <div class="link">
                            <div class="link_title">
                                <span>精灵事务所</span>
                            </div>
                            <div class="link_img">
                                <a href="#" target="_blank"><img src="#"  width="320px" height="100px"/></a>
                            </div>
                            <div class="link_intro">
                                <span>负责精灵网站产品的生产与设计</span>
                            </div>
                            
                        </div>
                        
                        
                        
                    </div>

                </div>

            </div>
        </div>
        
        
        <jsp:include page="/jsp/template/bottom.jsp"/>
  </body>
</html>
