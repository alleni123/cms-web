<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>


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
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery.validate.js"></script>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/core/jquery.cms.validate.js"></script>

<script type="text/javascript">
	$(function() {

		$("#addForm").cmsvalidate();

	});
</script>
<style type="text/css">
	#content table .leftTd{
		text-align: left;
		margin-left:30px;
	}
</style>

</head>

<body>

	<div id="content">

		<h3 class="admin_link_bar">
			<jsp:include page="incBaseInfo.jsp"></jsp:include>
		</h3>

		<sf:form method="post" modelAttribute="baseInfo" id="updateForm">
			<table width="600" cellspacing="0" cellPadding="0">



				<thead>
					<tr>
						<td colspan="2">修改系统信息功能</td>
					</tr>
				</thead>


				<tr>
					<td class="rightTd">网站名称:</td>
					<td class="leftTd"><sf:input path="name" size="30" /></td>

				</tr>

				<tr>
					<td class="rightTd">网站所在地:</td>
					<td class="leftTd"><sf:input path="address" size="30" /></td>

				</tr>
				
				
					<tr>
					<td class="rightTd">网站联系邮箱:</td>
					<td class="leftTd"><sf:input path="email" size="30" /></td>

				</tr>
				
				
					<tr>
					<td class="rightTd">邮政编码:</td>
					<td class="leftTd"><sf:input path="zipCode" size="30" /></td>

				</tr>

					<tr>
					<td class="rightTd">网站备案号:</td>
					<td class="leftTd"><sf:input path="recordCode" size="30" /></td>

				</tr>
				 
					
						<tr>
					<td class="rightTd">网站联系电话:</td>
					<td class="leftTd"><sf:input path="phone" size="30" /></td>
				</tr>
					
					
					<tr>
					<td class="rightTd">首页图片高度:</td>
					<td class="leftTd"><sf:input path="indexPicHeight" size="30" /></td>

				</tr>
				
				
				<tr>
					<td class="rightTd">首页图片宽度:</td>
					<td class="leftTd"><sf:input path="indexPicWidth" size="30" /></td>

				</tr>
				
					<tr>
					<td class="rightTd">首页图片数量:</td>
					<td class="leftTd"><sf:input path="indexPicNumber" size="30" /></td>

				</tr>



				<tr>
					<td colspan="2" class="centerTd"><input type="submit"
						value="提交修改" /> <input type="reset" /></td>
				</tr>

			</table>

		</sf:form>

	</div>



</body>
</html>
