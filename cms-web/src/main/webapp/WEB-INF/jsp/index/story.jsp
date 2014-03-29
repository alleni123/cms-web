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
        
            #content_con #about {
                height: 773px;
                background: url(<%=path%>/resources/frontend/css/img/story_bg.jpg) no-repeat 100px 50px;
            }

            #content_con #about_content {
                position: relative;
                top: 212px;
                width: 597px;
                margin: 0 auto;
            }

            #content_con .linedot {
                position: relative;
                background: url(<%=path%>/resources/frontend/css/img/line_dot.jpg);
                height: 1px;
                width: 95%;
                margin: 0 auto;
            }

            #content_con .top_linedot {
                top: 18px;
            }
            #content_con .bottom_linedot {
                top: 703px;
            }

        </style>
	 	
	 	<script type="text/javascript">
	 		$(function(){
	 			
	 			//alert(sel_page);
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

                <div id="about">
                    <div class="linedot top_linedot">

                    </div>
                    <div id="about_content">
                        今天不写了 明天写 今天不写了 明天写
                        今天不写了 明天写
                        今天不写了 明天写
                        今天不写了 明天写
                        今天不写了 明天写
                        今天不写了 明天写
                        今天不写了 明天写
                        今天不写了 明天写
                    </div>

                    <div class="linedot bottom_linedot">

                    </div>

                </div>
            </div>
        </div>
        
        
        <jsp:include page="/jsp/template/bottom.jsp"/>
  </body>
</html>
