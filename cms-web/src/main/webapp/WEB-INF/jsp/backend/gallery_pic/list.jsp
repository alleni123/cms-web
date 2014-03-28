<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- fmt的使用在视频71 44分钟-->


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


		<table width="800" border="1px solid blue" cellspacing="0" cellPadding="0" id="listTable">
			<thead>
				<tr>
					<td class="centerTd">缩略图</td>
					<td class="centerTd">图片标题</td>
					<td class="centerTd">创建日期</td>
					<td class="centerTd">文件大小</td>
					<td class="centerTd">状态</td>
					<td class="centerTd">用户操作</td>

				</tr>
			</thead>

			<tbody border="1">
				<c:forEach items="${datas.datas}" var="pic">
					<tr>
						<!-- 缩略图 -->
						<td class="centerTd">
							<img width='120' height='160' src="<%=path%>/resources/user/gallery/thumbnail/${pic.newName}"/>
						</td>
						
						<!-- 图片标题 -->
						<td>
							<a href="<%=path%>/resources/user/gallery/${pic.newName}"/>${pic.title}</a>
						</td>
						
						<!-- 创建日期 -->
						<td class="centerTd">
							<fmt:formatDate value="${pic.createDate}" pattern="yyyy-MM-dd"/>
						</td>
						
						<!-- 文件大小 -->
						<td class="centerTd">
							<fmt:formatNumber value="${pic.imgSize/1024}" pattern="#.#" minFractionDigits="1"/>K
						</td>
						
						<!-- 状态 -->
						<td class="centerTd">
							<c:if test="${pic.status eq 0}">
								<span class="emp">停用</span>
								<a href="admin/galleryPic/updateStatus/${pic.id}" class="list_op">启用</a>
							</c:if>
							
							<c:if test="${pic.status eq 1}">
								<span class="emp">启用</span>
								<a href="admin/galleryPic/updateStatus/${pic.id}" class="list_op">停用</a>
							</c:if>
						</td>
						
						<!-- 用户操作 -->
						<td class="centerTd">
							<a href="<%=path%>/admin/galleryPic/delete/${pic.id}" class="list_op delete">删除</a>&nbsp;
							<a href="<%=path%>/admin/galleryPic/update/${pic.id}" class="list_op">更新</a>
						</td>
					
					</tr>
				
				</c:forEach>
			</tbody>
			
			<tfoot>
				<tr>
					<td colspan="6" style="text-align:right;margin-right:10px;">
					<jsp:include page="/jsp/pagerlj.jsp">
						<jsp:param value="admin/galleryPic" name="url" />
							<jsp:param value="${datas.total}" name="items" />
						 	</jsp:include>
					
					</td>
				</tr>
			
			</tfoot>



		</table>

	</div>

</body>
</html>
