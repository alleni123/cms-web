<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String cssPath = request.getContextPath() + "/resources/css";
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
 
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/admin/main.css" />
 


<!-- jquery 1.9和xheditor不兼容， 要换成这个1.7.2才行 -->
<!--src="<%=path%>/resources/js/jquery-1.7.2.min.js">-->
<script type="text/javascript" src="<%=path%>/resources/js/jquery-1.7.2.min.js"></script>
 
<script type="text/javascript" src="<%=path%>/resources/js/admin/main.js"></script>
 






<script type="text/javascript">
 
</script>


</head>

<body>


	<input type="hidden" id="sid" value="<%=session.getId()%>" />
	<input type="hidden" id="contextPath" value="<%=path%>" />
	 




	<div id="container">
		<div id="contents">
			<input type="hidden" id="ctx" value="<%=path%>" />
			<h3 class="admin_link_bar" style="text-align:center">
				<span>添加首页图片</span>
			</h3>

			 
				<table width="980" cellspacing="0" cellpadding="0" id="addTable">


					<!-- 图片 -->
					<tr>
						<td colspan="2">
							<img alt="" src="<%=path%>/resources/indexPic/${indexPic.newName}">
						</td>
					</tr>

				  	

					<tr>
						<td class="rightTd" width="120px">首页图片标题:</td>
						<td class="leftTd">${indexPic.title}
						</td>
					</tr>


					<tr>
						<td class="rightTd">首页图片子标题:</td>
						<td class="leftTd">${indexPic.subTitle}
						</td>
					</tr>

					<tr>
						<td class="rightTd">状态:</td>
						<td class="leftTd">
						<c:if test="${indexPic.status eq 0}">未发布</c:if>
						<c:if test="${indexPic.status eq 1}">已发布</c:if>
						</td>
					</tr>


					<tr>
						<td class="rightTd">链接类型:</td>
						<td class="leftTd">
						<c:if test="${indexPic.linkType eq 0}">站内链接</c:if>
						<c:if test="${indexPic.linkType eq 1}">站外链接</c:if>
						</td>
					</tr>

					<tr>
						<td class="rightTd">链接地址:</td>
						<td class="leftTd">${indexPic.linkUrl }
						</td>
					</tr>

 						

				</table>
 

		</div>
	</div>

</body>
</html>
