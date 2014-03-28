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
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/admin/main.css" />
<script type="text/javascript" src="<%=path%>/resources/js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/core/jquery.cms.core.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/admin/inc.js"></script>




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

		$("a.delete").confirmOperator();
		$(".clearUser").confirmOperator({
			msg : "清空用户将不可恢复，是否确定清空？"
		});

		//搜索功能
		//	$("#search").click(function(){
		//		search();
		//	});
		var search = function(event) {
			var title_con = $("#title_con").val();
			var cid = $("#cid").val();
			var href = window.location.href;
			//alert("href="+href);
			var len = href.lastIndexOf("?");
			//alert("len= "+len);
			if (len > 0) {
				//alert(href);
				href = href.substr(0, len);
				//alert(href);
			}
			window.location.href = href + "?title_con=" + title_con
					+ "&&channel_id=" + cid;
		};

		$("#search").click(search);
		//	$("#seach").on("click",search);

		$("*").keydown(function(event) {
			var c = event.keyCode;
			if (c == 13) {
				search();
			}
		});

		//设置被选中的文章类型的下滑线。
		var link = $("#chosen_link").val();

		if (link == 0) {
			$(".unpublished_topic").addClass("chosen_link");
		}
		;
		if (link == 1) {
			$(".published_topic").addClass("chosen_link");
		}
		;
		if (link == 2) {
			$(".all_topic").addClass("chosen_link");
		}
		;
		//结束

	});
</script>

<style type="text/css">
.chosen_link {
	text-decoration: none;
}
</style>

</head>

<body>
	 
	<div id="content">
		<h3 class="admin_link_bar">
			<jsp:include page="inc.jsp"></jsp:include>

		</h3>

		<table width="800" border="1" cellspacing="0" cellPadding="0" id="listTable">
			<thead>
 				
 				<tr>
 					<td colspan="6">搜索评论:
 						<input type="text" name="comment_con" size="30" id="comment_con"
 						value="${comment_con}"/>
 					</td>
 				</tr>
 				


				<tr>
					<td>评论人</td>
					<td>评论时间</td>
					<td width="240">评论内容</td>
					 
					<td>所属文章</td>
					
					<td>操作</td>
				</tr>
			</thead>

			<tbody>
				<c:forEach items="" var="topic">
				 

				</c:forEach>
			</tbody>

			<tfoot>
				 

			</tfoot>

		</table>



	</div>
</body>
</html>
