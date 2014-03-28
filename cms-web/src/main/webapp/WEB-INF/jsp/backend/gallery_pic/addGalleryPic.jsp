<%@ page language="java" import="java.util.*" contentType="text/html;charset=utf-8"
	pageEncoding="utf-8"%>


<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title></title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/validate/main.css" />

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/admin/main.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/uploadify/uploadify.css" />





<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.validate.js"></script>
<script type="text/javascript" src="<%=path%>/resources/uploadify/jquery.uploadify.js"></script>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/core/jquery.cms.validate.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/engine.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/dwr/interface/dwrService.js"></script>

<style type="text/css">
#uploadFile {
	width: 120px;
	height: 30px;
	position: absolute;
	top: 23px;
	left: 150px;
}
</style>

<script type="text/javascript">
	$(function() {
		var path = $("#ctx").val();

		$("#addForm").cmsvalidate();
		// $("a.clearUser").confirmOperator({msg:"清空用户操作不可逆，确定操作吗？"});

		$("#galleryPic")
				.uploadify(
						{
							swf : $("#ctx").val()
									+ "/resources/uploadify/uploadify.swf",
							uploader : $("#ctx").val()
									+ "/admin/galleryPic/uploadGalleryPic",
							buttonText : "选择文件",
							fileObjName : "pic",
							multi : true,
							auto : false,

							onUploadSuccess : function(file, data, response) {

								var ajaxObj = $.parseJSON(data);
								if (ajaxObj.result) {
									console.log(ajaxObj.obj);
									newName = ajaxObj.obj.newName;
									originalName = ajaxObj.obj.originalName;
									$("#addTable")
											.append(
													"<tr><td width='20%' class='centerTd'><img width='120' height='160' src='"+
			 	path+"/resources/user/gallery/thumbnail/"+ajaxObj.obj.newName+"'/></td><td width='40%' class='leftTd'>原标题:"
															+ originalName
															+ "</td>"
															+
															"<td width='40%' class='centerTd'>输入新标题:<input type='text' name='title' pic_id='"+ajaxObj.obj.id+"'/>"
															+ " &nbsp; <input type='button' class='title_confirm' value='确认'/></td>"
															+ "</tr>");
								}

							}
						});

		$("#addTable").on("click", ".title_confirm", function() {
			var pic_id = $(this).prev().attr("pic_id");
			var title = $(this).prev().val();

			dwrService.updateGalleryPicTitle(pic_id, title, function(data) {
				console.log(data);
			});

		});

		$("#uploadFile").click(function() {
			$("#galleryPic").uploadify("upload", "*");
		});

	});
</script>


</head>

<body>

	<input type="hidden" id="ctx" value="<%=path%>">



	<div id="container">

		<div id="contents">

			<h3 class="admin_link_bar" style="text-align:center">
				<span>添加画廊图片</span>
			</h3>

			<div style="white-space: nowrap;">
				<input type="file" id="galleryPic" name="galleryPic" /> <input
					class="handpointer uploadify-button" type="button" id="uploadFile" value="确认上传" />

			</div>

			<sf:form method="post" modelAttribute="galleryPic" id="addForm">
				<table width="800" cellspacing="0" cellpadding="0" id="addTable" border="1px solid blue"
					style="table-layout:fixed;">

					<!-- 
			<tr colspan="2" class="centerTd">
				<input type="file" id="galleryPic" name="galleryPic"/>
				<input type="button" id="uploadFile" value="上传文件"/>
				<input type="hidden" id="newName" name="newName" readonly/>
				<input type="text" id="originalName" name="originalName" readonly/>
			</tr>
			
			
			<tr>
				<td class="rightTd">原文件名</td>
				<td class="leftTd">
					<sf:input path="title"/>
					<sf:errors cssClass="errorContainer" path="title"/>
				</td>
			</tr>
			
			<thead>
				<tr>
				<td class='centerTd'>缩略图</td>
				<td class="centerTd">原文件名</td>
				<td class="centerTd">
					输入新标题
				</td>
			</tr>
			</thead> -->



					<tfoot>
						<tr>
							<td colspan="2" class="centerTd"><input type="submit" id="addBtn" value="添加首页图片" /></td>
						</tr>
					</tfoot>
				</table>

			</sf:form>

		</div>
	</div>




</body>
</html>
