<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>欢迎访问${baseInfo.name}</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/index/web.css" />
<script type="text/javascript" src="<%=path%>/resources/js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/index/channel.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/index/main.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/core/jquery.cms.common.js"></script>
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/index/channel.css" />

<style type="text/css">
#channel_img_container {
	margin-top: 10px;
	float: left;
	margin-bottom: 10px;
}

div .channel_img {
	float: left;
	width: 140px;
	margin: 10px 12px;
}
div .channel_img_title{
	padding:10px 2px;
	border-bottom:1px solid #aaa;
	border-top:1px solid #aaa;
}

div .channel_img_title span{
	position: relative;
	left:2px;
	width:140px;
	display: block;
overflow: hidden;
white-space: nowrap;
}

div .channel_img_intro{
	padding:10px 2px;
}

div.channel_img_intro span {
	position:relative;
	left:2px;
	width:140px;
	display:inline-block;
	overflow: hidden;
	white-space: nowrap;
}
#channel_img_pager{
	float:left;
	height: 40px;
width: 700px;
text-align: center;
}

#channel_img_pager span{
position: relative;
top: 5px;}

</style>

</head>

<body>
	<input type="hidden" value="<%=path%>" id="contextPath" />
	<jsp:include page="/jsp/template/top.jsp"></jsp:include>

	<div id="content">
		<div id="content_con">
			<div id="breadcrumb">
				<span>你的位置&nbsp;<a href="<%=path%>/index">首页</a>/<a
					href="<%=path%>/channel/${parent_channel.id}">${parent_channel.name}</a>
				<c:if test="${parent_channel ne null}">/</c:if><a href="<%=path%>/channel/${channel.id}">${channel.name}</a>
				</span>
			</div>

			<div id="channel_content">
				<div id="channel_left">
					<dl>
						<dt>
							<span>${parent_channel.name}</span>
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
						<span>${channel.name}</span>
					</div>

					<div id="channel_img_container">
						<c:if test="${datas.total le 0}">
							该栏目没有图片..
						</c:if>
						<c:if test="${datas.total gt 0}">
							<c:forEach var="att" items="${datas.datas}">
								<div class="channel_img">
									<div class="channel_img_img">
										<a href="<%=path%>/topic/${att.topic.id}" title="${att.topic.title}"> <img alt=""
											src="<%=path%>/resources/upload/thumbnail/${att.newName}" width="140" height="110" /> </a>
									</div>
									<div class="channel_img_title">
										<span><a href="<%=path%>/topic/${att.topic.id}" title="${att.topic.title}">${att.topic.title
												}</a>
										</span>
									</div>
									<div class="channel_img_intro">
										<span> <fmt:formatDate value="${att.topic.publishDate}" type="date"
												dateStyle="medium" /> &nbsp;${att.topic.author} </span>
									</div>
								</div>
							</c:forEach>

							<div id="channel_img_pager">
								<span> <jsp:include page="/jsp/pagerlj.jsp">
										<jsp:param value="channel/${channel.id}" name="url" />
										<jsp:param value="${datas.total}" name="items" />
										<jsp:param value="?type=img" name="custom" />
									</jsp:include> </span>
							</div>

						</c:if>
					</div>

				</div>
			</div>
		</div>
	</div>


	<jsp:include page="/jsp/template/bottom.jsp"></jsp:include>

</body>
</html>
