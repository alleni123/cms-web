<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<!-- 该网页是管理页面左边的导航页面。  -->

<title></title>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/admin/main.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/core/jquery.cms.core.js"></script>
<script type="text/javascript">
	$(function() {
		$("#left").myaccordion();
		var original_color = $("#left h3").css("color");
		//alert(original_color);
		$("#left h3").changeColor({
			original_color : original_color,
			expect_color : "#e3e6f6"
		});

	});
</script>
</head>

<body>
	
	<div id="left">
	   <!-- 如果是管理员，才会显示用户管理导航，否则不显示 -->
	   <c:if test="${isAdmin}">
		<ul class="navMenu navSelected">
			<h3 class="navTitle">
				<span class="navTitleTxt">用户管理</span>
			</h3>
			
			<li class="navChild"><a
				href="<%=request.getContextPath()%>/admin/user/users"
				target="content">用户信息管理</a>
			</li>

			<li class="navChild"><a
				href="<%=request.getContextPath()%>/admin/group/groups"
				target="content">用户组管理</a>
			</li>
			<li class="navChild"><a
				href="<%=request.getContextPath()%>/admin/role/roles"
				target="content">用户角色管理</a>
			</li>

		</ul>
		</c:if>
		
		

		<ul class="navMenu navSelected">
			<h3 class="navTitle">
				<span class="navTitleTxt">栏目管理</span>
			</h3>
			 <c:if test="${isAdmin}">
			<li class="navChild"><a
				href="<%=request.getContextPath()%>/admin/channel/channels"
				target="content">栏目信息管理</a></li>
				
			<li class="navChild">
				<a href="<%=path%>/admin/indexChannel/channels" target="content">首页栏目管理</a>
			</li>	
				
				</c:if>
			 

		 
		</ul>
		
		
		
		
		
		<ul class="navMenu navSelected">
			<h3 class="navTitle">
				<span class="navTitleTxt">文章图片管理</span>
			</h3>
			 
			<li class="navChild"><a
				href="<%=request.getContextPath()%>/admin/topic/listByPage/0/1?published=2"
				target="content">文章信息管理</a></li>

		 
			
			
			<li class="navChild"><a
				href="<%=request.getContextPath()%>/admin/galleryPic/list"
				target="content">图片信息管理</a></li>
				
				<li class="navChild"><a
				href="<%=request.getContextPath()%>/admin/comment/list"
				target="content">评论信息管理</a></li>
 
			
		</ul>
		
		
		
		
		
		
		
		
		
		
		<c:if test="${isAdmin }">
		<ul class="navMenu navSelected">
			<h3 class="navTitle">
				<span class="navTitleTxt">系统配置</span>
			</h3>
			<li class="navChild"><a
				href="<%=request.getContextPath()%>/admin/cmsLink/links"
				target="content">超级链接管理</a></li>
			<li class="navChild"><a
				href="<%=request.getContextPath()%>/admin/system/baseinfo"
				target="content">网站信息管理</a></li>
			<li class="navChild"><a
				href="<%=request.getContextPath()%>/admin/pic/indexPics"
				target="content">首页图片管理</a></li>
			<li class="navChild"><a
				href="<%=request.getContextPath()%>/admin/backup/sqls"
				target="content">网站数据备份</a></li>
			<li class="navChild"><a
				href="<%=request.getContextPath()%>/admin/system/cleans"
				target="content">系统清理管理</a></li>
		</ul>
		</c:if>


	</div>

</body>
</html>
