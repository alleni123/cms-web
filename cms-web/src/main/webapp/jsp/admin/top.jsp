<%@ page language="java" pageEncoding="utf-8"%>
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
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/admin/main.css" />
<title>My JSP 'top.jsp' starting page</title>

<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.js"></script>

<script type="text/javascript">
	function exitSystem() {
		window.parent.location.href = $("#contextPath").val()
				+ "/admin/user/logout";
	}

	$(function() {
		$("#logo").click(
				function() {
					window.parent.location.href = $("#contextPath").val()
							+ "/admin/index";
				});

		//这个不管用，貌似要把hover改成mouseover,on的事件对象必须是js相关的。
		//	$("#logo").on("hover",function(){
		//		$(this).css("cursor","pointer");
		//	});
		$("#logo").hover(function() {
			$(this).css("cursor", "pointer");
		});
	});
</script>

</head>

<body>
	<input type="hidden" value="<%=path%>" id="contextPath">
	<jsp:include page="top_inc.jsp"></jsp:include>
</body>
</html>
