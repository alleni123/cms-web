<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<!-- 视频62_文章管理_11 文章添加的关键字的简易实现 -->
<head>
<base href="<%=basePath%>">
<script type="text/javascript"
	src="<%=path%>/resources/js/jquery-1.9.0.js"></script>

<title>My JSP 'add.jsp' starting page</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/js/core/jquery.cms.keywordinput.css" />

 <script type="text/javascript" src="<%=path%>/resources/js/core/jquery.cms.keyword.js">
 </script>

<script type="text/javascript">
	$(function() {
		
	 	$("#keyword-input").keywordinput();
 

	});

	 
</script>

</head>

<body>
	<div id="keyword-container">

		 

		<input type="text" class="keyword-input" id="keyword-input"/>
	</div>
</body>
</html>
