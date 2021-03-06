<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>欢迎访问${baseInfo.name}</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/index/web.css" />
<script type="text/javascript" src="<%=path%>/resources/js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/index/main.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/index/search.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/core/jquery.cms.common.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/index/channel.css" />

</head>

<body>
 <input type="hidden" value="<%=path%>" id="contextPath"/>
	<jsp:include page="/jsp/template/top.jsp"></jsp:include>

	<div id="content">
		<div id="content_con">
			<div id="breadcrumb">
				<span>你的位置&nbsp;<a href="<%=path%>/index">首页</a>
				|检索:${con}
				</span>
			</div>

			<div id="channel_content">
				<div id="channel_left">
					<dl>
						<dt>
							<span>导航栏目</span>
						</dt>
						<c:forEach items="${channels}" var="channel">
							<dd>
								<a href="channel/${channel.id}" class="channel_left_href">${channel.name}</a>
							</dd>
						</c:forEach>
					</dl>
				</div>

				<div id="channel_right">
					<div id="channel_title">
						<span>检索内容:[${con}]</span>
					</div>
					<table>
						<c:if test="${datas.total le 0}">
							<tr>
								<td>没有检索到任何文章..</td>
							</tr>
						</c:if>
						<c:if test="${datas.total gt 0 }">
							<c:forEach items="${datas.datas}" var="topic">
								<tr>
									<td><a href="<%=path%>/topic/${topic.id}" class="channel_right_href"> ${topic.title}
									</a></td>
								
									<td>
										[<fmt:formatDate value="${topic.publishDate }" pattern="yyyy-MM-dd"/>]
									</td>
								</tr>
								
							</c:forEach>
							
							<tfoot>
								<tr>
									<td colspan="6" style="text-align:right;margin-right:10px">
										<jsp:include page="/jsp/pagerlj.jsp">
											<jsp:param value="search" name="url"/>
											<jsp:param value="${datas.total}" name="items"/>
											<jsp:param value="?con=${con}" name="custom"/>
										</jsp:include>
									</td>
								</tr>
							</tfoot>
							
						</c:if>
					</table>
				</div>
			</div>
		</div>
	</div>


	<jsp:include page="/jsp/template/bottom.jsp"></jsp:include>

</body>
</html>
