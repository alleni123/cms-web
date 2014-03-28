<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'show.jsp' starting page</title>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/admin/main.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/core/jquery.cms.core.js"></script>
</head>

<body>
	<div id="content">
		<h3 class="admin_link_bar">
			<jsp:include page="inc.jsp"></jsp:include>
		</h3>
		<table width="800" cellspacing="0" cellPadding="0">
			<thead>
				<tr>
					<td colspan="2">查询用户组功能: 用户组id [${role.id}]</td>
				</tr>
			</thead>

			<tr>
				<td class="rightTd" width="200px">角色名称:</td>
				<td class="leftTd">${role.name}&nbsp;</td>
			</tr>

			<tr>
				<td class="rightTd">角色类型:</td>
				<td class="leftTd">${role.roleType}&nbsp;</td>
			</tr>

			<tr>
				<td class="rightTd">角色成员:</td>
				<td><c:forEach items="${users}" var="u">
						<a href=" admin/user/show/${u.id}" class="list_op">${u.nickname
							}&nbsp;</a>
					</c:forEach>
				</td>
			</tr>

			<tr>
				<td colspan="2" class="centerTd"><a href="update/${group.id }"
					class="list_op">修改角色</a></td>
			</tr>

		</table>
	</div>
</body>
</html>
