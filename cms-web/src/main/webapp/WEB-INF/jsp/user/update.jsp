<%@ page language="java" import="java.util.*" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
 

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/validate/main.css"/>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/admin/main.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.js"></script>
	<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery.validate.js"></script>
	
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/core/jquery.cms.validate.js"></script>

	<script type="text/javascript">
$(function(){
 
	 $("#addForm").cmsvalidate();
	 

});

</script>


</head>

<body>

	<div id="content">

		<h3 class="admin_link_bar">
			<jsp:include page="inc.jsp"></jsp:include>
		</h3>

		<sf:form method="post" modelAttribute="userDto" id="addForm">
			<table width="800" cellspacing="0" cellPadding="0">
				<sf:hidden path="id"/><sf:hidden path="username"/>
				<sf:hidden path="password"/>
			
			<thead>
				<tr>
					<td colspan="2">修改用户-->${userDto.username}</td>
				</tr>
			</thead>
			 

				<tr>
					<td class="rightTd">请输入用户昵称:</td>
					<td class="leftTd"><sf:input path="nickname" size="30" />
				
					</td>
						
				</tr>

 

				<tr>

					<td class="rightTd">请输入电话:</td>
					<td><sf:input path="phone" size="30" />
					</td>
				</tr>

				<tr>
					<td class="rightTd">邮箱地址:</td>
					<td><sf:input path="email" size="30" />
						<sf:errors path="email" />
					</td>
				</tr>
				
				<tr>
					<td class="rightTd">用户组1</td>
					<td>
						<sf:checkboxes items="${groups}" path="groupIds" itemLabel="name" itemValue="id"
						/>
					</td>
				</tr>
				
				<tr>
				<td class="rightTd">用户角色:</td>
				<td>
					<sf:checkboxes items="${roles}" path="roleIds" itemLabel="name" itemValue="id" />
				</td>
				</tr>
				
				<tr>
				<td class="rightTd">用户状态:</td>
				<td>
					<sf:select path="status">
						<sf:option value="0">关闭</sf:option>
						<sf:option value="1">开启</sf:option>
					</sf:select>
				</td>
				</tr>

	
	<tr>
		<td colspan="2" class="centerTd"><input type="submit" value="提交修改"/>
			<input type="reset"/>
		</td>
	</tr>
	
			</table>

		</sf:form>

	</div>
	


</body>
</html>
