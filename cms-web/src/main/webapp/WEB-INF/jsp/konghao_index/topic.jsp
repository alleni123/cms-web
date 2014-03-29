<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>${topic.title}</title>
<script type="text/javascript" src="<%=path%>/resources/js/jquery-1.9.0.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/index/web.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/index/topic.css" />
<script type="text/javascript" src="<%=path%>/resources/js/core/jquery.cms.common.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/index/topic.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/index/main.js"></script>
<style type="text/css">
.attch_img:hover {
	cursor: pointer;
}
</style>

<script type="text/javascript">
	$(function() {
		$(".attch_img").click(function() {
			window.location.href = $(this).attr("path");
		});

	});
</script>

</head>

<body>
	<input type="hidden" id="contextPath" value="<%=path%>">
	<jsp:include page="/jsp/template/top.jsp"></jsp:include>

	<div id="content">
		<div id="content_con">
			<div id="article_title">
				<span>${topic.title}</span>
			</div>
			<div id="article_info">
				<fmt:formatDate value="${topic.publishDate}" pattern="yyyy-MM-dd HH:mm" />
				&nbsp;${topic.author}
			</div>

			<div id="article_content">${topic.content}</div>

			<div class="article_atts">
				<c:if test="${!hasAtts}">该文章没有附件</c:if>
				<c:if test="${hasAtts}">
				文章附件: 
					<c:forEach items="${attachments}" var="att">
						<span><a href="<%=path%>/resources/upload/${att.newName}" class="article_att_link">${att.originalName
								}</a>
						</span>
					</c:forEach>
				</c:if>
			</div>

		</div>
	</div>


	<jsp:include page="/jsp/template/bottom.jsp"></jsp:include>
</body>
</html>
