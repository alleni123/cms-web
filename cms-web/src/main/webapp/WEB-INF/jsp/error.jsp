<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/admin/main.css" />
    <title>发生错误</title>
    
	 
  </head>
  
  <body>
   	<div id="container">
   		<div id="error">
   			<span>出现错误</span>
   			<div id="message"><span class="errorContainer">${exception.message}</span></div>
   			
   			<div id="upPage"><a href="javascript:history.go(-1)">返回上一页</a></div>
   			
   		</div>
   	</div>
   
   
  </body>
</html>
