<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'show.jsp' starting page</title>
    
	 <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/admin/main.css"/> 
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
		<thead><tr><td colspan="2">查询用户功能：用户id[${user.id }]</td></tr></thead>
		<tr>
			<td class="rightTd" width="200px">用户名:</td><td class="leftTd">${user.username }&nbsp;</td>
		</tr>
		<tr>
			<td class="rightTd">显示名称:</td><td class="leftTd">${user.nickname }&nbsp;</td>
		</tr>
		<tr>
			<td class="rightTd">联系电话:</td><td>${user.phone}&nbsp;</td>
		</tr>
		<tr>
			<td class="rightTd">电子邮件:</td><td>${user.email }&nbsp;</td>
		</tr>
		<tr>
			<td class="rightTd">状态:</td>
			<td>
				<c:if test="${user.status eq 0 }">
					<span class="emp">停用</span>
				</c:if>
				<c:if test="${user.status eq 1 }">
					<span>启用</span>
				</c:if>
				&nbsp;
			</td>
		</tr>
		 
		<tr>
			<td class="rightTd">拥有角色:</td>
			<td>
				<c:forEach items="${roles}" var="r">
					<a href="<%=request.getContextPath()%>/admin/role/show/${r.id}" class="list_op">
					[${r.name }]</a>&nbsp;
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td class="rightTd">所在用户组:</td>
			<td>
				<c:forEach items="${groups}" var="g">
					<a href="<%=request.getContextPath()%>/admin/group/show/${g.id}" class="list_op">[${g.name}]</a>&nbsp;
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td colspan="2" class="centerTd"><a href="admin/user/update/${user.id }" class="list_op">修改用户</a></td>
		</tr>
	</table>
</div>
  </body>
</html>
