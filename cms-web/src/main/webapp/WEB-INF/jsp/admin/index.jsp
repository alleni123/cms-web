<%@ page language="java" import="java.util.*" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">

<title>欢迎使用精灵网站后台管理程序</title>


</head>

<!-- 1: 这里先用一个大的frameset来当框架，里面是frame-frameset-frame,两个frame指向一个没有内容的background.html,纯粹只是当空白站位置的背景 -->
<frameset cols="*,1235px,*" border="0" frameSpacing="0">

	<!-- 1.1背景 -->
	<frame
		src="<%=request.getContextPath()%>/resources/admin/background.html"
		scrolling="no">


	<!-- 1.2: 这才是真正的网页内容，这里是由一个表示顶部页面的frame和一个用于具体系统操作的frameset组成的。 -->
	<frameset rows="120,*" frameSpacing="0" frameborder="no" border="no">
		<!-- 1.2.1 这是top网页 -->
		<frame name="top"
			src="<%=request.getContextPath()%>/jsp/admin/top.jsp"
			frameborder="0" scrolling="no" />
		
		<!-- 1.2.2这是具体系统操作的frameset，系统的大部分功能都跟这里打交道 -->
		<frameset cols="164,*" frameSpacing="0">
			<!-- 1.2.2.1这是左边的信息导航页面，用户选择自己要操作的对象 -->
			<frame name="nav"
				src="<%=request.getContextPath()%>/jsp/admin/nav.jsp"
				frameborder="0" scrolling="no" />
			
			
			<!-- 1.2.2.2 这是右边的具体操作页面，name是content,所有的具体操作在此进行。 页面排版到这里为止 -->
			<frame name="content"
				src="<%=request.getContextPath()%>/resources/admin/01.html"
				frameborder="0"  />
		</frameset>
	</frameset>


	<!-- 1.3 背景 -->
	<frame
		src="<%=request.getContextPath()%>/resources/admin/background.html"
		scrolling="no">
</frameset>

</html>
