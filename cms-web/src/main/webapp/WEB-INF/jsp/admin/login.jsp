<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/admin/login.css" />
	
	<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.js"></script>
	<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery.validate.js"></script>
	
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/core/jquery.cms.validate.js"></script>
	
<script type="text/javascript">
	$(function(){
	$("#myForm").cmsvalidate();
	
	});
	
</script>	
	


<script type="text/javascript">
	function reCheckCode(img){
		 console.log(img.src+Math.random());
		 img.src="drawCheckCode?"+Math.random();
		}


</script>


</head>

<body>
	<div id="container">
		<div id="top"></div>

		<div id="loginBar">
			<span id="showDate">欢迎使用${baseInfo.name}后台管理系统，请登录</span>
		</div>

		<div id="content">
		  
			
				<form method="post" id="myForm" action="">
				<div id="loginForm">
				
					<table cellpadding="0" cellspacing="0" style="width:400px"
						id="loginTable">
						
						 			
						 <span style="display:inline-block;;white-space:nowrap">${error }</span>			 
						 	
						
						<tr>
							<td align="right" width="90px">登录用户:</td>
							<td align="left"><input type="text" name="username"
								size="25" />
							</td>
						</tr>
						<tr>
							<td align="right">登录密码:</td>
							<td align="left"><input type="password" name="password"
								size="25" />
							</td>
						</tr>
						<tr>
							<td align="right">输入验证码:</td>
							<td align="left"><input type="text" name="checkCode"
								id="validateCode" size="15" />
								 
								</td>
						</tr>

						<tr>
							<td align="left" colspan="2"><span
								style="margin-left:94px; cursor:pointer"> <img
									src="drawCheckCode" onclick="reCheckCode(this)" />
							</span></td>
						</tr>

						<tr>
							<td align="center" colspan="2"><input type="submit" size="15" style="width:45px;height:25px;margin-top:-10px;margin-left:20px"
								value="登录">&nbsp;&nbsp;&nbsp; <input type="reset"
								value="重置" style="width:45px;height:25px;margin-top:-10px"></td>
						</tr>

					</table>
					</div>
				</form>
			

		</div>

	</div>

</body>
</html>
