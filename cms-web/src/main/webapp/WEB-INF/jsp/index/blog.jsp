<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>精灵的故事</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/frontend/css/main.css" />
<script type="text/javascript" src="<%=path%>/resources/frontend/js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="<%=path%>/resources/frontend/js/jquery.cms.common.js"></script>
<script type="text/javascript" src="<%=path%>/resources/frontend/js/main.js"></script>

<style type="text/css">
#blog_container { /*  border:1px solid blue;*/
	width: 75%;
	margin: 0 auto;
	position: relative;
	top: 100px;
}

#content_con #sort_order {
	width: 100%;
	height: 20px;
	margin-left: 20px;
}

#content_con #sort_order ul li {
	list-style: none;
	float: left;
	font-family: "宋体"
}

.bloglist .blog {
	padding: 0 20px 40px;
}

.blog a:visited,a:link,a:hover {
	color: #000;
}

.blog .content {
	width: 140px;
}

.blog .blog_title_h {
	padding-bottom: 20px;
}

.blog .blog_title {
	font-size: 18px;
	display: inline;
}

.blog .tagMore {
	height: 15px;
	margin-bottom: 20px;
}

.blog .SG_txtc {
	color: #878787
}

.blog .linedot {
	background: url(<%=path%>/resources/frontend/css/img/line_dot.jpg);
	height: 2px;
}
</style>

</head>

<body>
	<input type="hidden" value="<%=path%>" id="ctx" />
	<input type="hidden" value="${sel_page}" id="sel_page" />
	<input type="hidden" value="${nav_index}" id="nav_index" />
	<jsp:include page="/jsp/template/top.jsp" />
	<div id="content">
		<div id="content_con" style="height:1273px">

			<div id="blog_container">

				<div id="sort_order" class="clearfix">
					<ul class="clearfix">
						<li>排序|</li>
						<li>时间<img src="<%=path%>/resources/frontend/css/img/descending.jpg" alt="descending" /></li>
						<li>名称</li>
					</ul>

				</div>

				<div id="bloglist" class="bloglist">
					<div class="blog">
						<div class="blog_title_h">
							<div class="blog_title">
								<a href="<%=path%>/blog_content" target="_blank">圣诞快乐~</a>
							</div>
							<span class="time SG_txtc">(2013-14-24 23:06)</span>
						</div>
						<div class="content">
							<p>
								<a href="#" target="_blank"> <img src="#" width="134px" height="187px" /> </a> <br> <br>
							</p>
						</div>
						<div class="tagMore">
							<a href="#" target="_blank">阅读</a>(6) ┆ <a href="#" target="_blank">评论</a>(0) ┆ <span
								class="SG_txtc">禁止转载</span> ┆ <a href="#" target="_blank">查看全文</a>
						</div>
						<div class="linedot"></div>
					</div>

					<div class="blog">
						<div class="blog_title_h">
							<div class="blog_title">
								<a href="#" target="_blank">圣诞快乐~</a>
							</div>
							<span class="time SG_txtc">(2013-14-24 23:06)</span>
						</div>
						<div class="content">
							<p>
								<a href="#" target="_blank"> <img src="#" width="134px" height="187px" /> </a> <br> <br>
							</p>
						</div>
						<div class="tagMore">
							<a href="#" target="_blank">阅读</a>(6) ┆ <a href="#" target="_blank">评论</a>(0) ┆ <span
								class="SG_txtc">禁止转载</span> ┆ <a href="#" target="_blank">查看全文</a>
						</div>
						<div class="linedot"></div>
					</div>

					<div class="blog">
						<div class="blog_title_h">
							<div class="blog_title">
								<a href="#" target="_blank">圣诞快乐~</a>
							</div>
							<span class="time SG_txtc">(2013-14-24 23:06)</span>
						</div>
						<div class="content">
							<p>
								<a href="#" target="_blank"> <img src="#" width="134px" height="187px" /> </a> <br> <br>
							</p>
						</div>
						<div class="tagMore">
							<a href="#" target="_blank">阅读</a>(6) ┆ <a href="#" target="_blank">评论</a>(0) ┆ <span
								class="SG_txtc">禁止转载</span> ┆ <a href="#" target="_blank">查看全文</a>
						</div>
						<div class="linedot"></div>
					</div>

				</div>

			</div>
		</div>
	</div>
	<jsp:include page="/jsp/template/bottom.jsp" />
</body>
</html>
