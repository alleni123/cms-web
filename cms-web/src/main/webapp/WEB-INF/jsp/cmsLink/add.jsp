<%@ page language="java" import="java.util.*" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
 

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	$("#urlType").change(function(){
		var v=$(this).val();
		//选择其它
		if(v=="-1"){
			$("#type").removeAttr("readonly");
			$("#type").select(); //选择后面输入框的内容
			$("#type").focus(); 
		}else if(v!="0"){
			$("#type").val(v);//将输入框内容改为选择的option的值
			$("#type").attr("readonly",true);
		}
	});
});

</script>


</head>

<body>

	<div id="content">

		<h3 class="admin_link_bar">
			<jsp:include page="inc.jsp"></jsp:include>
		</h3>

		<sf:form method="post" modelAttribute="cmsLink" id="addForm">
			<table width="550px" cellspacing="0" cellPadding="0">
				<thead>
					<tr>
						<td colspan="2"> 
							添加超链接
						</td>
					</tr>
				</thead>
				
				<tr>
					<td class="rightTd" width="96px">超链接标题</td>
					<td class="leftTd"><sf:input path="title" size="50"/><sf:errors cssClass="errorContainer" path="title"/> </td>
				</tr>
				
				<tr>
					<td class="rightTd">超链接地址</td>
					<td class="leftTd">
						<sf:input path="url" size="50"/><sf:errors cssClass="errorContainer" path="url"></sf:errors>
						</td>
				</tr>
				
				<tr>
					<td class="rightTd">超链接类别</td>
					<td class="leftTd">
						<select id="urlType">
							<option value="0">请选择类别</option>
							<c:forEach items="${types}" var="t">
								<option value="${t}">${t}</option>
							</c:forEach>
							<option value="-1">选择其它</option>
						</select>
						<sf:input path="type" readonly="true"/>
					</td>
				</tr>
				
				<tr>
					<td class="rightTd">打开方式:</td>
					<td>
						<sf:radiobutton path="newWin" value="0"/><label for="newWin1">本窗口&nbsp;</label>
						<sf:radiobutton path="newWin" value="1"/><label for="newWin2">新窗口&nbsp;</label>
					</td>
				</tr>
				
				<tr>
					<td class="rightTd">链接标签ID:</td>
					<td>
						<sf:input path="urlId" size="50"/>	
					</td>
				</tr>
				
				<tr>
					<td class="rightTd">链接标签类别:</td>
					<td>
						<sf:input path="urlClass" size="50"/>
					</td>
				</tr>
				
				  
				
	 		
	 		<tr>
	 			<td colspan="2" class="centerTd"><input type="submit" value="添加超链接">&nbsp;<input type="reset" value="重置"> </td>
	 		</tr>
	
			</table>

		</sf:form>

	</div>
	


</body>
</html>
