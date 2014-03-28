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
	href="<%=path%>/resources/css/admin/main.css" />
<script type="text/javascript"
	src="<%=path%>/resources/js/jquery-1.9.0.js"></script>
<script type="text/javascript"
	src="<%=path%>/resources/js/core/jquery.cms.core.js"></script>
	
	<script type="text/javascript"
	src="<%=path%>/resources/js/admin/main.js"></script>
	
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
		
		
		
		$("#search").click(function(){
			var path="admin/topic/audits?title_con="+$("#title_con").val()+"&channel_id="+$("#channel_id").val();
			//alert(path);
			window.location.href=path;
		});

	});
</script>


</head>

<body>
	<div id="content">
		<h3 class="admin_link_bar">
			<jsp:include page="inc.jsp"></jsp:include>

		</h3>
		
		${hello}	
			
		<table width="800" border="1" cellspacing="0" cellPadding="0"
			id="listTable">
			<thead>
			
			<!-- 搜索文章开始 -->
				<tr>
					<td colspan="6">
						搜索文章：<input type="text" name="con" size="30" id="title_con" value="${con}">
						<select name="channel_id" id="channel_id">
							<option value="0">选择栏目</option>
							<c:forEach items="${channels}" var="channel">
								<c:if test="${channel.id eq channel_id}">
								<option value="${channel.id}" selected="selected">${channel.name}</option>
								</c:if>
								<c:if test="${channel.id ne channel_id}">
									<option value="${channel.id}">${channel.name}</option>
								</c:if>
								
							</c:forEach>
						</select>
						<input type="button" id="search" value="搜索文章"/>
					</td>
				</tr>
				<!-- 搜索文章结束 -->
			
			
				<tr>
					<td width="300">文章标题</td>
					<td>文章作者</td>
					<td>是否推荐</td>
					<td>所属频道</td>
					<td>文章状态</td>
					<td>操作</td>
				</tr>
				
				 
				
			</thead>

			<tbody>
				<c:forEach items="${datas.datas}" var="topic">
					<tr>
						<td><a href="${topic.id}" class="list_link">${topic.title}</a>
						</td> 
						<td>${topic.author}</td>
						<td><c:if test="${topic.recommend eq 0}">不推荐</c:if> <c:if
								test="${topic.recommend eq 1}">推荐</c:if></td>
						<td>${topic.channel_name }</td>

						<td><c:if test="${topic.status eq 0}">未发布</c:if> <c:if
								test="${topic.status eq 1}">已发布</c:if></td>


						<td><a href="admin/topic/delete/${topic.id}"
							class="list_op delete">删除</a>&nbsp; 
							<a href="admin/topic/update/${topic.id}" class="list_op">更新</a>&nbsp;
                            <a href="admin/topic/changeStatus/${topic.id}/${topic.status}" class="list_op">取消发布</a>&nbsp;
						</td>

					</tr>

				</c:forEach>
			</tbody>

			<tfoot>
				<tr>
					<td colspan="6" style="text-align:right;margin-right:10px;"><jsp:include
							page="/jsp/pagerlj.jsp">
							<jsp:param value="audits" name="url" />
							<jsp:param value="${datas.total}" name="items" />
						</jsp:include></td>
				</tr>

			</tfoot>

		</table>



	</div>
</body>
</html>
