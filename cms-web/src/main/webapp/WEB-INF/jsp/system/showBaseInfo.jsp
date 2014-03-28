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
	#content table td{
		width:300px;
	}
</style>

</head>

<body>

	<div id="content">

		<h3 class="admin_link_bar">
			<jsp:include page="incBaseInfo.jsp"></jsp:include>
		</h3>

			<table width="600" cellspacing="0" cellPadding="0">



				<thead>
					<tr>
						<td colspan="2">修改系统信息功能</td>
					</tr>
				</thead>


				<tr>
					<td class="rightTd">网站名称:</td>
					<td class="leftTd">${baseInfo.name}</td>

				</tr>

				<tr>
					<td class="rightTd">网站所在地:</td>
					<td class="leftTd">${baseInfo.address}</td>

				</tr>
				
				
					<tr>
					<td class="rightTd">网站联系邮箱:</td>
					<td class="leftTd">${baseInfo.email}</td>

				</tr>
				
				
					<tr>
					<td class="rightTd">邮政编码:</td>
					<td class="leftTd">${baseInfo.zipCode}</td>

				</tr>

					<tr>
					<td class="rightTd">网站备案号:</td>
					<td class="leftTd">${baseInfo.recordCode}</td>

				</tr>
				 
					
						<tr>
					<td class="rightTd">网站联系电话:</td>
					<td class="leftTd">${baseInfo.phone}</td>
				</tr>
					
					
					<tr>
					<td class="rightTd">首页图片高度:</td>
					<td class="leftTd">${baseInfo.indexPicHeight}</td>

				</tr>
				
				
				<tr>
					<td class="rightTd">首页图片宽度:</td>
					<td class="leftTd">${baseInfo.indexPicWidth}</td>

				</tr>
				
				<tr>
					<td colspan="2" class="centerTd">
						<a href="<%=path%>/admin/system/baseinfo/update" class="list_op">修改网站基本信息</a>
					</td>
				</tr>


				

			</table>


	</div>



</body>
</html>
