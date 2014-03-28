<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<!-- 视频62_文章管理_11 文章添加的关键字的简易实现 -->
<head>
<base href="<%=basePath%>">
<script type="text/javascript"
	src="<%=path%>/resources/js/jquery-1.9.0.js"></script>

<title>My JSP 'add.jsp' starting page</title>

<style type="text/css">
#keyword-container {
	border: 1px solid #bbb;
	width: 700px;
}

input.keyword-input {
	border: none;
	width: 300px;
	color: #aaa;
	height: 28px;
}

div .keyword-in {
	float: left;
	font-size: 12px;
	margin: 0 3px;
	background: #3fa7cb;
	padding: 3px;
	color: #fff;
}

a.keyword-shut:link,a.keyword-shut:visited {
	color: #fff;
	text-decoration: none;
}

a.keyword-shut:hover {
	color: #ff0;
}
</style>

<script type="text/javascript">
	$(function() {
		
		var num=5;
		
		
		$("#keyword-input").focus(function() {
			$(this).val("");
		});

		$("#keyword-input").blur(function() {
			if ($(this).val().length == 0) {
				$(this).val("请输入关键字，通过逗号或者回车确认");
			}
		});

		$("#keyword-input").keyup(function(event) {
			var code = event.keyCode;
			var add=true;
			if (code == 188 || code == 13) {
				//c是要添加的关键字
				var c = $(this).val();

				if (c != "") {
					if ($(".keyword-in").length >= num) {
						alert("最多只能添加" + num + "个关键字");
						event.preventDefault();
						return false;
					}
					
					 var addedkeys=$("input[name='added_keywords']");
					 console.log(addedkeys);
				/*	$("input[name='added_keywords']").each(function(){
						console.log($(this).val());
						if($(this).val()==c){
							alert("关键字已经存在");
							event.preventDefault();
							
						}else{
							add=true;
						}
					});*/
					var aks=$("input[name='added_keywords']");
					for(var i=0;i<aks.length;i++){
						console.log(aks[i]);
						if(aks[i].value==c){
							alert("关键字已经存在");
							add=false;
							return false;
						}
					}
					 
					 
					 
					if(add){
					var ki = createKeyword(c);
					$("#keywords-wrap").append(ki);
					$(this).val("");}
				}
			}
		});

		//36分钟
		$("#keywords-wrap").on("click", "a.keyword-shut", function() {
			$(this).parent(".keyword-in").remove();
			event.preventDefault();
		});

		$(".keyword-shut").click(function() {

		});

	});

	//创建关键字
	function createKeyword(val) {
		return "<div class='keyword-in'><span>"
				+ val
				+ "</span><a href='add.jsp#' class='keyword-shut'>&nbsp;X</a>"
				+"<input type='hidden' name='added_keywords' value='"+val+"'/></div>";
	}
</script>

</head>

<body>
	<div id="keyword-container">

		<div id="keywords-wrap">
			<div class="keyword-in">
				<span>我的电脑</span> <a href="add.jsp#" class="keyword-shut">X</a>
				<input type='hidden' name='added_keywords' value='我的电脑'/>
			</div>

			<div class="keyword-in">
				<span>我的电脑</span> <a href="add.jsp#" class="keyword-shut">X</a>
				<input type='hidden' name='added_keywords' value='我的电脑'/>
			</div>

		</div>

		<input type="text" class="keyword-input" id="keyword-input" value="请输入关键字，通过逗号或者回车确认"/>
	</div>
</body>
</html>
