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
    	
    		if(window.opener){
    		 
    		   window.opener.location.reload(true);
    			window.close();
    		}
    		
    	}
    	
    	
    	function clock(){
    		i=i-1;
    		if(document.getElementById("info")){
    			document.getElementById("info").innerHTML="本窗口将在"+i+"秒后自动关闭";
    		}
    		if(i>0)
    			setTimeout("clock();",1000);
    			else
    			closeWindow();
    	}
    	
    	var i=4;
    	clock();
    	
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
