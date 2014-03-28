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
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/js/css/jquery-ui-1.10.3.custom.css" />
<style type="text/css">
a:hover {
	cursor: pointer;
	color: red;
}
</style>

<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/core/jquery.cms.core.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/ui/jquery.ui.core.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/ui/jquery.ui.widget.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/ui/jquery.ui.mouse.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/ui/jquery.ui.sortable.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/tree/jquery.ztree.core-3.5.js"></script>

<script type="text/javascript">
	$(function() {
		console.log("显示栏目信息的列表通过iframe引入了jsp/channel/list_child.jsp。  栏目排序的算法也在这个页面里面");
	
		if ($("#refresh").val() == "1") {

			parent.refreshTree();
		}

		var _isSort = false;
		var sortEle = $(".listTable tbody");

		$(".delete").confirmOperator({
			msg : "删除频道不可逆， 是否确认删除?"
		});

		$(".listTable tbody").sortable({

			helper : function(e, ele) {
				console.log(ele.children());
				//得到原始元素的td对象
				var _original = ele.children();
				var _helper = ele.clone();
				_helper.children().each(function(index) {
					$(this).width(_original.eq(index).width());
				});
				_helper.css("background-color", "#eef");
				return _helper;

			},
			update : function(e, ui) {
				setOrders();
			}

		}

		);

		$(".listTable tbody").sortable("disable");
		$("#beginOrder").click(function() {

			if (_isSort) {
				alert("已经处于排序状态");
				return;
			}
			$(".listTable thead tr").append("<td>序号</td>");

			$(".listTable tbody tr").each(function(index) {
				$(this).append("<td>" + (index + 1) + "</td>");
			});

			$(".listTable tfoot tr").append("<td>拖动排序</td>");

			$(".listTable tbody").sortable("enable");
			_isSort = true;
		});

		$("#saveOrder").click(
				function() {
					if (_isSort) {

						var ids = sortEle.sortable("serialize", {
							key : "ids"
						});
						$.post("admin/channel/channels/updateSort?" + ids,
								function(data) {
									if ($.ajaxCheck(data)) {
										$(".listTable tr").each(function() {
											$(this).children().last().remove();
										});
										_isSort = false;
										sortEle.sortable("disable");
										parent.refreshTree();

									}

								});

					} else {
						alert("不在排序状态");
					}
				});

		function setOrders() {
			$(".listTable tbody tr").each(function(index) {

				if (_isSort) {
					$(this).find("td:last").html(index + 1);
				} else {
					$(this).append("<tr>" + (index + 1) + "</td>");
				}
			});
		}

	});
</script>


</head>

<body>
	<div id="content">
		<h3 class="admin_link_bar">
			<jsp:include page="inc.jsp"></jsp:include>

		</h3>

		<!-- 这个值通过channel/channels/{pid}?refresh=x 传入这个页面.用于决定是否刷新 -->
		<input type="hidden" id="refresh" value="${refresh}">

		<table width="580" border="1" cellspacing="0" cellPadding="0" id="listTable" class="listTable">
			<thead>
				<tr>
					<td>栏目名称</td>
					<td>栏目类型</td>
					<td>是否推荐</td>
					<td>主页栏目</td>
					<td>栏目状态</td>
					<td>排列序号</td>
					<td>操作</td>
				</tr>
			</thead>

			<tbody>
				<c:forEach items="${channels}" var="channel">
					<tr id="id_${channel.id}">
						<td>${channel.name}</td>

						<td class="ctype">${channel.type.name}</td>

						<td><c:if test="${channel.recommend eq 0 }">
								<span class="emp">不推荐</span>
							</c:if> <c:if test="${channel.recommend eq 1 }">推荐</c:if> &nbsp;</td>

						<td><c:if test="${channel.isIndex eq 0}">
								<span class="emp">不是</span>
							</c:if> <c:if test="${channel.isIndex eq 1 }">是</c:if> &nbsp;</td>

						<td><c:if test="${channel.status eq 0}">
								<span class="emp">停用</span>
							</c:if> <c:if test="${channel.status eq 1}">启用</c:if> &nbsp;</td>
							<td> 
								<c:if test="${channel.type eq 'NAV_CHANNEL'}">${channel.navOrder}</c:if>
								<c:if test="${channel.type ne 'NAV_CHANNEL' }"><span class="emp">非导航栏目</span></c:if>
							</td>

						<td class="centerTd"><a href="admin/channel/update/${channel.id}" class="list_op"> 更新</a>&nbsp;
							<a href="admin/channel/delete/${pid}/${channel.id}" class="list_op delete"> 删除</a>&nbsp;</td>




					</tr>

				</c:forEach>



			</tbody>

			<tfoot>
				<tr>
					<td colspan="6" class="rightTd"><a id="beginOrder" style="text-decoration:underline;"
						class="order_link">开始排序</a>&nbsp; <a id="saveOrder" class="list_op order_link">存储排序</a>
					</td>
				</tr>
			</tfoot>

		</table>



	</div>

</body>
</html>
