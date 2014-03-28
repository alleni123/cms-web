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
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/admin/main.css"/> 
	 <script type="text/javascript"
	src="<%=path%>/resources/js/jquery-1.9.0.js"></script>
<script type="text/javascript"
	src="<%=path%>/resources/js/core/jquery.cms.core.js"></script>
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
			<td width="270">组描述</td>
			<td>用户操作</td>
		</tr>
		</thead>
	 	
	 	<tbody>
	 		<c:forEach items="${datas.datas}" var="group">
	 			<tr>
	 				<td>${group.id}&nbsp;</td>
	 				<td><a href="admin/group/show/${group.id}" class="list_link">${group.name}</a></td>
	 				<td>${group.desc} &nbsp;</td>
	 				 
	 				<td>
	 					<a href="admin/group/delete/${group.id}" class="list_op delete">删除</a>&nbsp;
	 					<a href="admin/group/update/${group.id}" class="list_op">更新</a>&nbsp;
	 					<a href="admin/group/clearUsers/${group.id}" class="list_op clearUser">清空用户</a>&nbsp;
	 				 
	 					<a href="admin/group/listChannels/${group.id}" class="list_op">查询管理栏目</a>
	 					<a href="admin/group/setChannels/${group.id}" class="list_op">设置管理栏目</a>
	 					&nbsp;
	 				</td>
	 				
	 			</tr>
	 		
	 		</c:forEach>
	 	</tbody>
	 	
	 	<tfoot>
	 	<tr><td colspan="6" style="text-align:right;margin-right:10px;">
	 		<jsp:include page="/jsp/pagerlj.jsp">
	 			<jsp:param value="users" name="url"/>
	 			<jsp:param value="${datas.total}" name="items"/>
	 		 
	 		</jsp:include>
	 	
	 	</td></tr>
	 	
	 	</tfoot>
	 	
	 	</table>
	 	
	 	
	 	
	 </div>
  </body>
</html>
