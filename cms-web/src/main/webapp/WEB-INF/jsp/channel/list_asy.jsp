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
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/ztree/zTreeStyle.css" />

<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/core/jquery.cms.core.js"></script>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/tree/jquery.ztree.core-3.5.js"></script>

<script type="text/javascript"></script>

<script type="text/javascript">
	$(function() {
		var setting = {
			data : {
				simpleData : {
					enable : true,
					idKey : "id",
					pIdKey : "pid",
					rootPid : 0
				}
			},

			view : {
				dblClickExpand : true,
				selectedMulti : false
			},
			async : {
				enable : true,
				url : "http://localhost:8888/cms/admin/channel/treeAsy",
				autoParam : [ "id=pid" ]
			//用来指定树的传递参数的key的名称

			},

			callback : {
				onClick : function(event, treeId, treeNode) {
					console.log(treeId);
					console.log(treeNode);
				}
			}

		};

		$.fn.zTree.init($("#tree"), setting);

		//	  var n={id:"7",name:"系统管理2",pid:"8"};
		// var t=$.fn.zTree.init($("#tree"),setting, datas);
		// t.addNodes(t.getNodeByParam("id",8,null),n);

	});
</script>

</head>

<body>
	<div id="content" class="ztree">
		<div id="tree"></div>
	</div>

</body>
</html>
