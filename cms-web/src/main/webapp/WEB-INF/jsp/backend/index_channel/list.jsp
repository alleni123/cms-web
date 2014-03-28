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
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/admin/main.css" />


<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/core/jquery.cms.core.js"></script>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/tree/jquery.ztree.core-3.5.js"></script>



</head>

<body>
	<div id="content">
		<h3 class="admin_link">
			<jsp:include page="inc.jsp"></jsp:include>
		</h3>


		<table width="800" border="1" cellspacing="0" cellPadding="0" id="listTable">
			<thead>
				<tr>
					<td>栏目名称</td>
					<td>是否推荐</td>
					<td>栏目状态</td>
					<td>操作</td>

				</tr>
			</thead>

			<tbody>
				<c:forEach items="${indexChannels}" var="c">
					<tr>

						<td>${c.name}&nbsp;</td>
						<td><c:if test="${c.recommend eq 0 }">
								<span class="emp">不推荐</span>
							</c:if> <c:if test="${c.recommend eq 1 }">推荐</c:if> &nbsp;</td>
						<td><c:if test="${channel.status eq 0}">
								<span class="emp">停用</span>
							</c:if> <c:if test="${channel.status eq 1}">启用</c:if> &nbsp;</td>

						<td class="centerTd"><a href="admin/channel/update/${c.id}" class="list_op"> 更新</a>&nbsp;
							<a href="admin/indexChannel/delete/${c.id}" class="list_op delete"> 删除</a>&nbsp;</td>



					</tr>

				</c:forEach>
			</tbody>



		</table>

	</div>

</body>
</html>
