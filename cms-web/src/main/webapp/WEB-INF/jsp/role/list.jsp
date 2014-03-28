<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/admin/main.css"/> 
	 <script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/core/jquery.cms.core.js"></script>
<script type="text/javascript" charset="utf-8">  

	 $(function(){
	 
	 
	
	 
	  $("table").trColorChange({evenColor:"#9fbeee"});
	  var rgb=$("tbody tr:even").css("background-color");
	 
	  
	 $("tbody tr:even").changeColor({color_attr:"background-color",original_color:rgb,expect_color:"#dcdddd"});
	  $("tbody tr:odd").changeColor({color_attr:"background-color",original_color:"#ffffff",expect_color:"#dcdddd"});
	
	 $(".delete").confirmOperator();
		$(".clearUser").confirmOperator({msg:"清空用户将不可恢复，是否确定清空？"});
	
	 });

</script>
    
	 
  </head>
  
  <body>
	 <div id="content">
	 	<h3 class="admin_link_bar">
	 		<jsp:include page="inc.jsp"></jsp:include>
	 		
	 	</h3>
	 	
	 	<table width="800" border="1" cellspacing="0" cellPadding="0" id="listTable">
	 	<thead>
		<tr>
			<td>组标识</td>
			<td>组名称</td>
			<td width="350">组描述</td>
			<td>用户操作</td>
		</tr>
		</thead>
	 	
	 	<tbody>
	 		<c:forEach items="${roles}" var="role">
	 			<tr>
	 				<td>${role.id}&nbsp;</td>
	 				<td><a href="admin/role/show/${role.id}" class="list_link">${role.name}</a></td>
	 				<td>${role.roleType} &nbsp;</td>
	 				 
	 				<td>
	 					<a href="admin/role/delete/${role.id}" class="list_op delete">删除</a>&nbsp;
	 					<a href="admin/role/update/${role.id}" class="list_op">更新</a>&nbsp;
	 					<a href="admin/role/clearUsers/${role.id}" class="list_op clearUser">清空用户</a>&nbsp;
	 				</td>
	 				
	 			</tr>
	 		
	 		</c:forEach>
	 	</tbody>
	 	
	 	 
	 	
	 	</table>
	 	
	 	
	 	
	 </div>
  </body>
</html>
