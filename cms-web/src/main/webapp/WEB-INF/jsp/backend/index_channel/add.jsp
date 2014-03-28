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
	// $("a.clearUser").confirmOperator({msg:"清空用户操作不可逆，确定操作吗？"});
	
	

});

</script>


</head>

<body>

	<div id="content">

		<h3 class="admin_link_bar">
			<jsp:include page="inc.jsp"></jsp:include>
		</h3>

		<sf:form method="post" modelAttribute="channel" id="addForm">
			<table width="550px" cellspacing="0" cellPadding="0">
				<thead>
					<tr>
						<td colspan="2"> 
							添加首页栏目
						</td>
					</tr>
				</thead>
				
				<tr>
					<td class="rightTd" width="96px">栏目名称</td>
					<td class="leftTd"><sf:input path="name" size="30"/><sf:errors cssClass="errorContainer" path="name"/> </td>
				</tr>
				
				 
				
				 
				
				<tr>
					<td class="rightTd">栏目类型:</td>
					<td>
						<sf:select path="type">
							<sf:options items="${channelTypes}"/>
						</sf:select>
						 
					</td>
				</tr>
				
				<tr>
					<td class="rightTd">是否在主页显示:</td>
					<td>
						<sf:radiobutton path="isIndex" value="1"/><label for="isIndex1">显示</label>
						<sf:radiobutton path="isIndex" value="0"/><label for="isIndex2">不显示</label>
					</td>
				</tr>
				
			 
				
				<tr>
					<td class="rightTd">是否推荐栏目:</td>
					<td>
						<sf:radiobutton path="recommend" value="1"/><label for="recommend1">是</label>
						<sf:radiobutton path="recommend" value="0"/><label for="recommend2">不是</label>
					</td>
				</tr>
				
				<tr>
					<td class="rightTd">状态:</td>
					<td>
						<sf:radiobutton path="status" value="1"/><label for="status1">启用</label>
						<sf:radiobutton path="status" value="0"/><label for="status2">停用</label>
					</td>
				</tr>
				
	 		
	 		<tr>
	 			<td colspan="2" class="centerTd"><input type="submit" value="添加栏目">&nbsp;<input type="reset" value="重置"> </td>
	 		</tr>
	
			</table>

		</sf:form>

	</div>
	


</body>
</html>
