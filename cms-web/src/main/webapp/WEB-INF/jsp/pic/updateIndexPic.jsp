<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String cssPath = request.getContextPath() + "/resources/css";
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/validate/main.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/admin/main.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/js/base/jquery.ui.all.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/uploadify/uploadify.css" />
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/jcrop/css/jquery.Jcrop.css" />


<!-- jquery 1.9和xheditor不兼容， 要换成这个1.7.2才行 -->
<!--src="<%=path%>/resources/js/jquery-1.7.2.min.js">-->
<script type="text/javascript" src="<%=path%>/resources/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/ui/jquery-ui.custom.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/ui/jquery.ui.core.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/i18n/jquery-ui-i18n.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/core/jquery.cms.core.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/admin/main.js"></script>
<script type="text/javascript" src="<%=path%>/resources/uploadify/jquery.uploadify.js"></script>
<script type="text/javascript" src="<%=path%>/resources/jcrop/js/jquery.Jcrop.js"></script>






<script type="text/javascript">
	$(function() {

		var indexPicWidth = 0, indexPicHeight = 0, imgWidth = 0, imgHeight = 0;
		var x, y, w, h;
		
		var newName,originalName;

		var path = $("#contextPath").val();
		//图片上传。 视频77 11分钟开始
		$("#indexPic")
				.uploadify(
						{
							swf : path + "/resources/uploadify/uploadify.swf",
							uploader : $("#contextPath").val()
									+ "/admin/pic/uploadIndexPic",
							fileObjName : "pic", //服务器端用来获取对象的名称。 比如这里使用springmvc， 那就要用MultipartFile pic来获取这里的上传文件
							height : 30,
							width : 120,
							multi : false, //Set to false to allow only one file selection at a time.
							auto : false,
							fileTypeExts : "*.jpg;*.png;*.jpeg",
							onUploadSuccess : function(file, data, response) {
								var ajaxObj = $.parseJSON(data);
								console.log(ajaxObj);
								if (ajaxObj.result) {
									newName = ajaxObj.obj.newName;
									originalName = ajaxObj.obj.originalName;
									$("#indexPicView")
											.append(
													"<img src='"
															+ $("#contextPath")
																	.val()
															+ "/resources/indexPic/temp/"
															+ newName + "'/><input type='button' id='confirmSelect' value='确定选择'/>");

									indexPicWidth = ajaxObj.obj.indexPicWidth;
									indexPicHeight = ajaxObj.obj.indexPicHeight;
								 

								  

									imgWidth = ajaxObj.obj.imgWidth;
									imgHeight = ajaxObj.obj.imgHeight;
									
									 

									console.log($("#indexPicView").before());

									$("#indexPicView")
											.before(
													"<div id='pc' class='preview-container' border='1px solid blue' style='width:"+indexPicWidth+"px;height:"+indexPicHeight+
													"px;overflow:hidden;margin-bottom:5px'><img id='preview' src='"+path+"/resources/indexPic/temp/"+newName+"'/>"+
													+"</div>");

									$("#indexPicView img").Jcrop(
											{
												onChange : showPreview,
												onSelect : showPreview,
												setSelect : [ 0, 0,
														indexPicWidth,
														indexPicHeight ],
												aspectRatio : indexPicWidth
														/ indexPicHeight,
											});
										
									$("#confirmSelect").click(confirmSelect);

								} else {
									alert(ajaxObj.message);
								}
							}
						});

		function showPreview(coords) {

			if (parseInt(coords.w) > 0) {
				var rx = indexPicWidth / coords.w;
				var ry = indexPicHeight / coords.h;
				
			 
				x = coords.x;
				y = coords.y;
				h = coords.h;
				w = coords.w;

				//这里必须是preview container里面的图片<img id='preview'>节点。 如果写错写成container,就会让页面乱晃。
				$("#preview").css({
					width : Math.round(rx * imgWidth) + 'px',
					height : Math.round(ry * imgHeight) + 'px',
					marginLeft : '-' + Math.round(rx * coords.x) + 'px',
					marginTop : '-' + Math.round(ry * coords.y) + 'px'
				});
			}
		}

		//将事件方法绑定到uploadFile按钮上
		$("#uploadFile").click(function() {
			$("#indexPic").uploadify("upload", "*");
		});

		function confirmSelect() {
			//alert(w + "," + h + "," + x + "," + y);
			$.getJSON("admin/pic/confirmPic",{w:w,h:Math.round(h),x:x,y:y,newName:newName},function(data){
				console.log(data);
				if($.ajaxCheck(data)){
					console.log(data);
					//alert("hello world");
					$("#indexPicView").prev("#pc").remove();
					$("#indexPicView").html("<img src='"+path+"/resources/indexPic/"+newName+"'/>");
				 
					$("#newName").val(newName);
					$("#originalName").val(originalName);
				}
			});
		};

	});
</script>


</head>

<body>


	<input type="hidden" id="sid" value="<%=session.getId()%>" />
	<input type="hidden" id="contextPath" value="<%=path%>" />
	<input type="hidden" id="w" value="${baseInfo.indexPicWidth}" />
	<input type="hidden" id="h" value="${baseInfo.indexPicHeight}" />





	<div id="container">
		<!-- <jsp:include page="/jsp/admin/top_inc.jsp"></jsp:include> -->
		<div id="contents">
			<input type="hidden" id="ctx" value="<%=path%>" />
			<h3 class="admin_link_bar" style="text-align:center">
				<span>更新首页图片</span>
			</h3>

			<sf:form method="post" modelAttribute="indexPic" id="addForm">
				<table width="980" cellspacing="0" cellpadding="0" id="addTable">


					<!-- 上传图片 -->
					<tr>
						<td colspan="2"><input type="file" id="indexPic" name="indexPic" /> <input type="button"
							id="uploadFile" value="上传文件" />
							<input id="newName" name="newName" value="${indexPic.newName}" readonly/>
							<input type="hidden" id="originalName" name="originalName" readonly/>
						</td>
					</tr>

					  <tr>
						<td class="rightTd" width="120px">
							 当前图片:
						</td>
						<td>
							<img src="<%=path%>/resources/indexPic/${indexPic.newName}"/>
						</td>
					</tr> 

					<!-- 图片上传完成之后， 在这里显示上传结果 -->
					<tr>
						<td colspan="2">
							<div id="indexPicView"></div>
						</td>
						 
					</tr>

					<tr>
						<td class="rightTd" width="120px">首页图片标题:</td>
						<td class="leftTd"><sf:input path="title" size="80" /> <sf:errors
								cssClass="errorContainer" path="title" />
						</td>
					</tr>


					<tr>
						<td class="rightTd">首页图片子标题:</td>
						<td class="leftTd"><sf:input path="subTitle" size="80" /> <sf:errors
								cssClass="errorContainer" path="subTitle" />
						</td>
					</tr>

					<tr>
						<td class="rightTd">状态:</td>
						<td class="leftTd"><sf:radiobutton path="status" value="0" />未发布 <sf:radiobutton
								path="status" value="1" />已发布</td>
					</tr>


					<tr>
						<td class="rightTd">链接类型:</td>
						<td class="leftTd"><sf:radiobutton path="linkType" value="0" />内部链接 <sf:radiobutton
								path="linkType" value="1" />外部链接</td>
					</tr>

					<tr>
						<td class="rightTd">链接地址:</td>
						<td class="leftTd"><sf:input path="linkUrl" size="100"/> <sf:errors cssClass="errorContainer"
								path="linkUrl" />
						</td>
					</tr>






					<tr>
						<td colspan="2" class="centerTd"><input type="submit" id="addBtn" value="更新首页图片" /> <input
							type="reset" value="重置" />
						</td>
					</tr>


				</table>


			</sf:form>

		</div>
	</div>

</body>
</html>
