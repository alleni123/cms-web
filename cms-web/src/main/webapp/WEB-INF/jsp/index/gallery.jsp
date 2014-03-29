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
      <link  rel="stylesheet" type="text/css" href="<%=path%>/resources/frontend/js/top_zoom.css"/>
     <script type="text/javascript" src="<%=path%>/resources/frontend/js/jquery-1.9.0.js"></script>
     <script type="text/javascript" src="<%=path%>/resources/frontend/js/jquery.cms.common.js"></script>
     <script type="text/javascript" src="<%=path%>/resources/frontend/js/main.js"></script>
       <script type="text/javascript" src="<%=path%>/resources/frontend/js/top_zoom.js"></script>
	 <script type="text/javascript" src="<%=path%>/resources/frontend/js/jquery_draggable.js"></script>
           <style type="text/css">
            #content_con {
                background-color: #fff;
                border-radius: 7px;
            }

            #content_con #sort_order {
                width: 100%;
                height: 100px;
                position: relative;
                top: 80px;
                left: 150px;
            }

            #content_con #sort_order ul li {
                list-style: none;
                float: left;
                font-family: "宋体"
            }

            #img_container {
                margin-left: 140px
            }

            .gallery_img {
                float: left;
                width: 160px;
                margin: 10px 12px;
            }
            
            #img_container li{
                float:left;
                display:inline;
                overflow:hidden;
                width:235px;
                height:270px;
                padding:40px 0 0 0;
                position:relative;
            }
            
            #img_container li img{
                cursor:pointer;
            }
            
            .clearfix:after{
                content:".";
                display:block;
                height:0;
                visibility:hidden;
                clear:both;
            }

        </style>
	 	
	 	<script type="text/javascript">
	 		$(function(){
	 			 $("#appendParent").imgzoom({
                    imgSelector : ".click_img"
                });
	 		});
	 	</script>
  </head>
  
  <body>
  <input type="hidden" value="<%=path%>" id="ctx"/>
  <input type="hidden" value="${sel_page}" id="sel_page"/>
  <input type="hidden" value="${nav_index}" id="nav_index"/>
  		<jsp:include page="/jsp/template/top.jsp"/>
  
    <div id="appendParent"></div>
        
        <div id="content">
            <div id="content_con" style="height:773px">

                <div id="sort_order">
                    <ul>
                        <li>
                            排序|
                        </li>
                        <li>
                            时间<img src="<%=path%>/resources/frontend/css/img/descending.jpg" alt="descending"/>
                        </li>
                        <li>
                            名称
                        </li>
                    </ul>

                </div>
                
                
                <div id="img_container" class="clearfix">
                    <ul class="clearfix">
                        <li>
                            <div class="gallery_img_img">
                               <img alt=""
                            src="css/img/roll-01.jpg" width="160" height="160" w="766" h="786" class="click_img" />
                            </div>
                             <div class="gallery_img_title">
                            <span><a href="*id" title="title">title</a> </span>
                        </div>
                        <div class="gallery_img_intro">
                            <span> 1977/7/7</span>
                        </div>
                        </li>
                        
                        
                          <li>
                            <div class="gallery_img_img">
                               <img alt=""
                            src="css/img/roll-02.jpg" width="160" height="160"  class="click_img" w="766" h="786" />
                            </div>
                             <div class="gallery_img_title">
                            <span><a href="*id" title="title">title</a> </span>
                        </div>
                        <div class="gallery_img_intro">
                            <span> 1977/7/7</span>
                        </div>
                        </li>
                        
                        
                        
                          <li>
                            <div class="gallery_img_img">
                               <img alt=""
                            src="css/img/roll-03.jpg" width="160" height="160" class="click_img" w="766" h="786" />
                            </div>
                             <div class="gallery_img_title">
                            <span><a href="*id" title="title">title</a> </span>
                        </div>
                        <div class="gallery_img_intro">
                            <span> 1977/7/7</span>
                        </div>
                        </li>
                        
                          <li>
                            <div class="gallery_img_img">
                               <img alt=""
                            src="css/img/roll-01.jpg" width="160" height="160" class="click_img" w="766" h="786"/>
                            </div>
                             <div class="gallery_img_title">
                            <span><a href="*id" title="title">title</a> </span>
                        </div>
                        <div class="gallery_img_intro">
                            <span> 1977/7/7</span>
                        </div>
                        </li> 
                        
                        
                    </ul>
                </div>
                


            </div>
        </div>
        
        <jsp:include page="/jsp/template/bottom.jsp"/>
  </body>
</html>
