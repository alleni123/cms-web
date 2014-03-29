<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>精灵个人网站首页</title>
    
    
      <link rel="stylesheet" type="text/css" href="<%=path%>/resources/frontend/css/demo-slideshow.css"/>
        <link rel="stylesheet" type="text/css" href="<%=path%>/resources/frontend/css/index.css"/>
        <link rel="stylesheet" type="text/css" href="<%=path%>/resources/frontend/css/main.css"/>

        <script type="text/javascript" src="<%=path%>/resources/frontend/js/jquery-1.9.0.js"></script>
        <script type="text/javascript" src="<%=path%>/resources/frontend/js/jquery.cycle2.min.js"></script>
        <script type="text/javascript" src="<%=path%>/resources/frontend/js/jquery.cms.common.js"></script>
   		<script type="text/javascript" src="<%=path%>/resources/frontend/js/main.js"></script>
	
     <script type="text/javascript">
			/*调用myInput*/

			$(function() {
				$("#search input").myInput();

				$("#rollpic").cycle({
					fx : 'fade',
					speed : 1500,
					timeout : 1500
				});

				
			});

        </script>
	 
  </head>
  
  <body>
  	<input type="hidden" value="<%=path%>" id="ctx"/>
  	<jsp:include page="/jsp/template/top.jsp"/>
  	
  	<jsp:include page="/jsp/template/body.jsp"/>
  	
  	<jsp:include page="/jsp/template/bottom.jsp"/>
  
  
  </body>
</html>
