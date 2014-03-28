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
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/tree/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/dwr/engine.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/dwr/interface/dwrService.js"></script>

<script type="text/javascript">
	$(function() {

		var t = $("#tree").mytree(
				{
					url : $("#treePath").val(),
					mine : {
						listChild : 0
					},
					callback : {
						onAsyncSuccess : initTree,
						beforeCheck : function(treeId, treeNode) {

							//如果该节点没有被选中，则进行添加操作
							if (!treeNode.checked) {
								var parents = getCheckedParentsNodes(treeNode,
										false);
								parents.push(treeNode);
								addGroupChannel(parents);
							} 
							//如果该节点已经被选中，则进行删除操作
							else {
								var childNodes = new Array();
								childNodes = getCheckedChildNodes(treeNode,
										false, childNodes);
								childNodes.push(treeNode);
								deleteGroupChannel(childNodes);

							}

						}
					},
					check : {
						enable : true,
						chkboxType : {
							"Y" : "p",
							"N" : "ps"
						}
					}
				});

		function initTree() {

			t.expandAll(true);
			//var node=t.getNodeByTId("tree_10");

			var cids = $("input[name='cids']");
			for ( var i = 0; i < cids.length; i++) {
				var cid = cids[i].value;
				var node = t.getNodeByParam("id", cid, null);
				t.checkNode(node, true, true);
			}

		}

		//获取
		function getCheckedParentsNodes(treeNode, checked) {
			//_parentNodes= 参数treeNode的所有的父节点
			var _parentNodes = new Array();
			var pn;
			while ((pn = treeNode.getParentNode())) {
				if (pn.checked == checked) {
					_parentNodes.push(pn);
				}
				treeNode = pn;
			}

			return _parentNodes;

		}

		function getCheckedChildNodes(treeNode, checked, _childNodes) {

			if (treeNode.children) {
				var cns = treeNode.children;
				for ( var i = 0; i < cns.length; i++) {

					var node = cns[i];
					if (node.checked == checked) {
						_childNodes.push(node);
					}
					getChildren(node, checked, _childNodes);
				}
				;
			}

			return _childNodes;
		}

		function addGroupChannel(addNodes) {
			var gid = $("#gid").val();

			if (typeof addNodes === "number") {
				var thisId = addNodes;
				dwrService.addGroupChannel(gid, thisId);
				return;
			}

			for ( var i = 0; i < addNodes.length; i++) {
				var c = addNodes[i];
				if (c.id > 0) {
					//alert(c.id);
					dwrService.addGroupChannel(gid, c.id);
				}
			}

		}

		function deleteGroupChannel(deleteNodes) {
			//alert("delete");
			console.log(deleteNodes);
			var gid = $("#gid").val();
			console.log(gid);
			console.log(deleteNodes.length);
			for ( var i = 0; i < deleteNodes.length; i++) {
				var c = deleteNodes[i];
				console.log(c);
				if (c.id > 0) {
					dwrService.deleteGroupChannel(gid, c.id);
				}
			}

		}

	});
</script>

</head>

<body>
	<div id="content">
		<h3 class="admin_link_bar">
			<jsp:include page="inc.jsp"></jsp:include>
		</h3>

		<c:forEach items="${cids}" var="cid">
			<input type="hidden" name="cids" value="${cid}">
		</c:forEach>

		<input type="hidden" id="gid" value="${group.id}" /> <input
			type="hidden" id="treePath" value="admin/channel/treeAll" />
		<div style="padding-left:10px;font-size:12px;">当前组名称
			:${group.name}</div>


		<div id="tree" class="ztree"></div>
	</div>








</body>
</html>
