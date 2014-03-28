<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/admin/main.css"/>
<script type="text/javascript" src="<%=path%>/resources/js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/core/jquery.cms.core.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/admin/inc.js"></script>
<script type="text/javascript" charset="utf-8">
	$(function() {

		$("table").trColorChange({
			evenColor : "#9fbeee"
		});
		var rgb = $("tbody tr:even").css("background-color");

		$("tbody tr:even").changeColor({
			color_attr : "background-color",
			original_color : rgb,
			expect_color : "#dcdddd"
		});
		$("tbody tr:odd").changeColor({
			color_attr : "background-color",
			original_color : "#ffffff",
			expect_color : "#dcdddd"
		});

		$(".delete").confirmOperator();
		$(".clearUser").confirmOperator({
			msg : "清空用户将不可恢复，是否确定清空？"
		});

	});
</script>


</head>

<body>
	<div id="content">
		 

		<table width="800" border="1" cellspacing="0" cellPadding="0" id="listTable">
			<thead>
				<tr>
					<td>缩略图</td>
					<td>名称</td>
				</tr>
			</thead>

			<tbody>
			<c:forEach items="${pics}" var="pic">
				 <tr>
				 	<td>
				 		<img src="<%=path%>/resources/indexPic/thumbnail/${pic}"/>
				 	</td>
				 	<td>
				 		${pic}
				 	</td>
				  
				 
				 </tr>
				 </c:forEach>
			</tbody>
 
		</table>



	</div>
</body>
</html>
