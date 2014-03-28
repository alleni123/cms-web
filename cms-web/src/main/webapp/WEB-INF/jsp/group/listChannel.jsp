<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/admin/main.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/ztree/zTreeStyle.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/core/jquery.cms.core.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/tree/jquery.ztree.core-3.5.js"></script>

<script type="text/javascript">
	$(function() {

		var t=$("#tree").mytree({
			url : $("#treePath").val(),
			mine:{listChild:0},
			callback:{
				onAsyncSuccess:function(){
					t.expandAll(true);
				}
			}
		});
	});
</script>

</head>

<body>
	<div id="content">
		<h3 class="admin_link_bar">
			<jsp:include page="inc.jsp"></jsp:include>
		</h3>

		<input type="hidden" id="treePath" value="admin/group/groupChannelTree/${group.id}"/>
		<div style="padding-left:10px;font-size:12px;">当前组名称
			:${group.name}</div>


		<div id="tree" class="ztree"></div>
	</div>








</body>
</html>
