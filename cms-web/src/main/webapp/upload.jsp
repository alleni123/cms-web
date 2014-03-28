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
	href="<%=path%>/resources/uploadify/uploadify.css" />

<script type="text/javascript"
	src="<%=path%>/resources/js/jquery-1.9.0.js"></script>

<script type="text/javascript"
	src="<%=path%>/resources/uploadify/jquery.uploadify.js"></script>



<script type="text/javascript">
	$(function() {
		var path = $("#ctx").val();
		 
		 
		$("#attach").uploadify({
			swf : path + "/resources/uploadify/uploadify.swf",
			uploader : "upload",
			fileObjName : "attach",
			height : 30,
			width : 120,
			auto:false,
			fileSizeLimit:'50MB',
			fileTypeExts:"*.jpg;*.avi;*.wmv;*.txt;*.doc",
			onUploadSuccess:function(file,data,response){
			   console.log(data);
			    var ao=$.parseJSON(data);
				if(ao.result==1){
				alert("文件 "+file.name+" 成功上传");}
			}
		});
		
		
		$("#upload").click(function(){
			$("#attach").uploadify("upload","*");
			
		});
		 
	//	console.log($.ajax("upload")); 

	});
</script>

</head>

<body>
	<input type="hidden" id="ctx" value="<%=path%>">
	<input type="file" id="attach" value="" />
	<input type="button" id="upload" value="点击上传">
</body>
</html>
