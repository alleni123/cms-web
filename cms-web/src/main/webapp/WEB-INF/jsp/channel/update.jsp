<%@ page language="java" import="java.util.*" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
 

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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/validate/main.css"/>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/admin/main.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.js"></script>
	<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery.validate.js"></script>
	
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/core/jquery.cms.validate.js"></script>

	<script type="text/javascript">
$(function(){
 
	 $("#addForm").cmsvalidate();
	 
	  
	 // if($("#customLink1").val()==0){
	 // 	$("#customLinkUrl").attr("readonly",true).css("opacity",0.3);
	 // };
	  
	   
	  if($("input:radio[name='customLink'][checked=checked]").val()==0){
	  	$("#customLinkUrl").attr("readonly",true).css("opacity",0.3);
	  }
	  $("input:radio[name='customLink']").change(function(){
	  	//alert($(this).val());
	  	if($(this).val()==0){
	  		$("#customLinkUrl").attr("readonly",true).css("opacity",0.3);
	  		
	  	}else if($(this).val()==1){
	  		$("#customLinkUrl").attr("readonly",false).css("opacity",1);
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

		<sf:form method="post" modelAttribute="channel" id="addForm">
			<table width="550px" cellspacing="0" cellPadding="0">
				 <sf:hidden path="id" />
				<thead>
					<tr>
						<td colspan="2"> 
							更新 <b>[${channel.name}]</b> 子栏目功能
							 
						</td>
						
					</tr>
				</thead>
				
				<tr>
					<td class="rightTd" width="96px">栏目名称</td>
					<td class="leftTd"><sf:input path="name" size="30"/><sf:errors cssClass="errorContainer" path="name"/> </td>
				</tr>
				
				<tr>
					<td class="rightTd">是否指定链接</td>
					<td class="leftTd">
						<sf:radiobutton path="customLink" value="1"/><label for="customLink1">指定</label>
						<sf:radiobutton path="customLink" value="0"/><label for="customLink2">不指定</label>
					</td>
				</tr>
				
				<tr>
					<td class="customLinkUrl rightTd">链接地址</td>
					<td><sf:input path="customLinkUrl" size="50"/></td>
				</tr>
				
				<tr>
					<td class="rightTd">栏目类型:</td>
					<td>
						<sf:select path="type">
							<sf:options items="${channelTypes}"/>
						</sf:select>
					</td>
				</tr>
				
				<tr>
					<td class="rightTd">是否在主页显示:</td>
					<td>
						<sf:radiobutton path="isIndex" value="1"/><label for="isIndex1">显示</label>
						<sf:radiobutton path="isIndex" value="0"/><label for="isIndex2">不显示</label>
					</td>
				</tr>
				
				<tr>
					<td class="rightTd">导航顶部栏目:</td>
					<td>
						<sf:radiobutton path="isTopNav" value="1"/><label for="isTopNav1">是</label>
						<sf:radiobutton path="isTopNav" value="0"/><label for="isTopNav2">不是</label>
					</td>
				</tr>
				
				<tr>
					<td class="rightTd">是否推荐栏目:</td>
					<td>
						<sf:radiobutton path="recommend" value="1"/><label for="recommond1">是</label>
						<sf:radiobutton path="recommend" value="0"/><label for="recommond2">不是</label>
					</td>
				</tr>
				
				<tr>
					<td class="rightTd">状态:</td>
					<td>
						<sf:radiobutton path="status" value="1"/><label for="status1">启用</label>
						<sf:radiobutton path="status" value="0"/><label for="status2">停用</label>
					</td>
				</tr>
				
				<tr>
					<td class="rightTd">导航序号:</td>
					<td>
						<sf:input path="navOrder" size="5"/>
					</td>
				</tr>
				
	 		
	 		<tr>
	 			<td colspan="2" class="centerTd"><input type="submit" value="更新栏目"><input type="reset" value="重置"> </td>
	 		</tr>
	
			</table>

		</sf:form>

	</div>
	


</body>
</html>
