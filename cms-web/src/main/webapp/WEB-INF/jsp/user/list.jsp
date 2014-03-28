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
			<td>用户标识</td>
			<td>用户名称</td>
			<td>用户昵称</td>
			<td>用户状态</td>
			<td>用户邮箱</td>
			<td>用户操作</td>
		</tr>
		</thead>
	 	
	 	<tbody>
	 		<c:forEach items="${datas.datas}" var="user">
	 			<tr> 
	 				 
	 				<td>${user.id}&nbsp;</td>
	 				<td><a href="admin/user/show/${user.id}" class="list_link">${user.username}</a></td>
	 				<td>${user.nickname} &nbsp;</td>
	 				<td>
	 					<c:if test="${user.status eq 0 }">
	 						<span class="emp">停用</span>
	 						<a href="admin/user/updateStatus/${user.id}" class="list_op">启用</a>
	 					</c:if>
	 					
	 					<c:if test="${user.status eq 1 }">
	 						<span class="emp">启用</span>
	 						<a href="admin/user/updateStatus/${user.id}" class="list_op">停用</a>
	 					</c:if>
	 					&nbsp;
	 				</td>
	 				<td>
	 					<a href="mailto:$(user.email)" class="list_link">${user.email}</a>
	 					&nbsp;
	 				</td>
	 				<td>
	 					<a href="admin/user/delete/${user.id}" title="${user.id}" class="list_op delete">删除</a>
	 					<a href="admin/user/update/${user.id}" class="list_op">更新</a>
	 					<a href="<%=request.getContextPath()%>/admin/user/listChannels/${user.id}" class="list_op">用户管理栏目</a>
	 					&nbsp;
	 				</td>
	 				
	 			</tr>
	 		
	 		</c:forEach>
	 	</tbody>
	 	
	 	<tfoot>
	 	<tr><td colspan="6" style="text-align:right;margin-right:10px;">
	 		<jsp:include page="/jsp/pagerlj.jsp">
	 			<jsp:param value="admin/user" name="url"/>
	 			<jsp:param value="${datas.total}" name="items"/>
	 		</jsp:include>
	 	
	 	</td></tr>
	 	
	 	</tfoot>
	 	
	 	</table>
	 	
	 	
	 	
	 </div>
  </body>
</html>
