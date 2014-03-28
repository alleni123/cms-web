<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String cssPath = request.getContextPath() + "/resources/css";
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- fmt的使用在视频71 44分钟-->

<!-- 该网页创建在视频71- 40分钟开始  -->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/validate/main.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/resources/css/admin/main.css" />
<link rel="stylesheet" type="text/css"
	href="<%=cssPath%>/ztree/zTreeStyle.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/resources/xeditor/demos/common.css" />


<link rel="stylesheet" type="text/css"
	href="<%=path%>/resources/js/base/jquery.ui.all.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/resources/uploadify/uploadify.css" />


<!-- jquery 1.9和xheditor不兼容， 要换成这个1.7.2才行 -->
<!--src="<%=path%>/resources/js/jquery-1.7.2.min.js">-->
<script type="text/javascript"
	src="<%=path%>/resources/js/jquery-1.7.2.min.js">
	
</script>
<script type="text/javascript"
	src="<%=path%>/resources/js/ui/jquery-ui.custom.js">
	
</script>

<script type="text/javascript"
	src="<%=path%>/resources/js/ui/jquery.ui.core.js">
	
</script>
 
<script type="text/javascript"
	src="<%=path%>/resources/js/core/jquery.cms.core.js"></script>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/js/core/jquery.cms.keywordinput.css" />


<script type="text/javascript"
	src="<%=path%>/resources/js/admin/main.js">
</script>




	


<script type="text/javascript">
	/*文章添加下拉功能：60文章管理 35分钟*/
	/*js文件路径-> resources/js/admin/topicAdd.js*/
	var mt;
	jQuery(function(){
		 
	});

	
</script>


</head>

<body>


	<input type="hidden" id="sid" value="<%=session.getId()%>" />
	<input type="hidden" id="contextPath" value="<%=path%>" />
	<!--???-->

	<!-- ztree显示下拉隐藏菜单的地方 -->
	<div id="menuContent" class="menuContent"
		style="display:none;position:absolute;background:#eee;z-index:999;border:1px solid #999">
		<ul id="mytree" class="ztree" style="margin-top:0;width:160px;"></ul>
	</div>


	<div id="container">
		<jsp:include page="/jsp/admin/top_inc.jsp"></jsp:include>
		<div id="contents">
			<input type="hidden" id="ctx" value="<%=path%>" />
			<h3 class="admin_link_bar" style="text-align:center">
				<span>${topic.title}</span>
			</h3>
		
			
				<table width="980" cellspacing="0" cellpadding="0" id="addTable">
					<tr>
						<td class="rightTd" width="120px">文章标题:</td>
						<td class="leftTd">
							${topic.title}[${topic.user.nickname}]
						</td>
					</tr>


					<tr>
						<td class="rightTd">文章栏目:</td>
						<td class="leftTd">
							${topic.channel.name}
						</td>
					</tr>


					
						
							<tr>
								<td class="rightTd">文章状态:</td>
								<td class="leftTd">
									<c:if test="${topic.status eq 0}">未发布</c:if>
									<c:if test="${topic.status eq 1}">已发布</c:if>
								</td>
							</tr>
					
						

					
					<tr>
						<td class="rightTd">是否推荐该文章</td>
						<td class="leftTd">
							<c:if test="${topic.recommend eq 0}">不推荐</c:if>
							<c:if test="${topic.recommend eq 1}">推荐</c:if></td>
					</tr>
					 
					<tr>
						<td class="rightTd">发布时间:</td>
						<td class="leftTd">
							<fmt:formatDate value="${topic.publishDate}"/>(<fmt:formatDate value="${topic.createDate}" pattern="yyyy-MM-dd HH:ss"/>)
						</td>
					</tr>

					<tr>
						<td class="rightTd">文章关键字:</td>
						<td class="leftTd">
							${topic.keyword}
						</td>
					</tr>

					<tr> 
						<td class="rightTd">文章附件</td>
						<td class="leftTd" >
							<c:forEach items="${atts}" var="att">
								<a href="<%=path%>/resources/upload/${att. newName}" >${att.originalName}</a>
							</c:forEach>
							 </td>
					</tr>

					 

				 

					<tr>
						<td colspan="2">文章内容</td>
					</tr>
					<tr>
						<td colspan="2">
							${topic.content}
						</td>
					</tr>
					
					

					<tr>
						<td colspan="2">文章摘要</td>
					</tr>
					<tr>
						<td colspan="2">
							${topic.summary}
						</td>
					</tr>


					<tr>
						<td colspan="2" class="centerTd"><input type="button" onclick="window.close()" value="关闭"/></td>
					</tr>


				</table>



		</div>
	</div>

</body>
</html>
