<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <head>
        <meta http-equiv="keywords" content="精灵网站,精灵博客">
        <meta http-equiv="description" content="精灵网站">
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
        <title>欢迎访问${baseInfo.name}</title>
        <!-- Replace favicon.ico & apple-touch-icon.png in the root of your domain and delete these references -->
        <link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/index/demo-slideshow.css"/>
        <link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/index/web.css"/>
        <script type="text/javascript" src="<%=path%>/resources/js/jquery-1.9.0.js"></script>
        <script type="text/javascript" src="<%=path%>/resources/js/jquery.cycle2.min.js"></script>

        <script type="text/javascript" src="<%=path%>/resources/js/core/jquery.cms.common.js"></script>
        <script type="text/javascript" src="<%=path%>/resources/js/index/index.js"></script>
		<script type="text/javascript" src="<%=path%>/resources/js/index/main.js"></script>
	<script type="text/javascript">
		$(function(){
			 
		});
	</script>
	
    </head>

    <body>
       <input type="hidden" value="<%=path%>" id="contextPath"/>
     <!-- 顶部的通过aop来实现。 当ChannelService中的add* update* delete*被调用时，就会自动更新top.jsp -->  
	<jsp:include page="/jsp/template/top.jsp"/>
	
	
	<jsp:include page="/jsp/template/body.jsp"/>
	 
   
		
		<!-- 底部的更新直接在SystemController中实现 -->
		<jsp:include page="/jsp/template/bottom.jsp"></jsp:include>

    </body>
</html>
