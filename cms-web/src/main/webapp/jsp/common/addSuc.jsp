<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>添加记录成功</title>
    <script type="text/javascript">
    	function closeWindow(){
    		window.open("jsp/common/addSuc2.jsp");
    		console.log(window.window.window.window);
    		console.log(window.chrome.loadTimes().commitLoadTime);
    		console.log(window.opener);
    		if(window.opener){
    		alert(1);}
    	}
    </script>
	 
  </head>
  
  <body>
	<center>
		添加记录成功!<p>
		<div id="info">本窗口将在3秒后自动关闭</div>
		<input type="button" value="关闭窗口" onclick="closeWindow();"/>
	</center>
  </body>
</html>
