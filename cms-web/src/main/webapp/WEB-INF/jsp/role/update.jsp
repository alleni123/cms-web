<%@ page language="java" import="java.util.*" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>


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
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/validate/main.css" />

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/admin/main.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.validate.js"></script>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/core/jquery.cms.validate.js"></script>

<script type="text/javascript">
	$(function() {

		$("#addForm").cmsvalidate();

	});
</script>


</head>

<body>

	<div id="content">

		<h3 class="admin_link_bar">
			<jsp:include page="inc.jsp"></jsp:include>
		</h3>

		<sf:form method="post" modelAttribute="role" id="addForm">
			<table width="800" cellspacing="0" cellPadding="0">
				<tr>
					<td class="rightTd" width="200px">请输入角色名称</td>
					<td class="leftTd"><sf:input path="name" size="30" /> <sf:errors cssClass="errorContainer"
							path="name" /></td>
				</tr>

				<tr>
					<td class="rightTd">请选择角色类型:</td>
					<td class="leftTd"><sf:select path="roleType" items="${roleTypes}" />
					</td>
				</tr>





				<tr>
					<td colspan="2" class="centerTd"><input type="submit" value="提交修改" /> <input type="reset" />
					</td>
				</tr>

			</table>

		</sf:form>

	</div>



</body>
</html>
