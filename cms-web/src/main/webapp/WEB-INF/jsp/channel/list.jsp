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
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/ztree/zTreeStyle.css"/> 
	
	 <script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/jquery-1.9.0.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/core/jquery.cms.core.js"></script>
	
	<script type="text/javascript"
	src="<%=request.getContextPath()%>/resources/js/tree/jquery.ztree.core-3.5.js"></script>

 
	 
	 <script type="text/javascript">
		
			 
		var mt;
	      $(function(){
	       mt=$("#tree").mytree({_custom:{srcElement:"#table_frame",listChild:1}});
	       console.log(mt);
	      });
	      
	      function refreshTree(){
	      mt.reAsyncChildNodes(null,"refresh");
	      }
	 
	 
	
	     
	 </script>
	 
  </head>
  
  <body>
	 	 <div id="content">
	 	 	<h3 class="admin_link_bar">
	 	 		<span>正在使用栏目管理工具</span>
	 	 	</h3>
	 	 	
	 	 	<table border="0" align="left" height="600px">
	 	 		<tr>
	 	 			<td width="150px" align="left" valign="top" style="border-right:#999999 1px dashed">
	 	 				<ul id="tree" class="ztree" style="width:150px; overflow:auto"></ul>
	 	 			</td>
	 	 			
	 	 			<!-- 这个iframe用来显示栏目的详细信息的列表。 返回页面为list_child.jsp。 请求路径为admin/channel/channels/pid -->
	 	 			<td width="650px" align=left valign=top>
	 	 				<iframe id="table_frame" name="testIframe" frameborder="0" scrolling="auto" width="100%" height="600px">
	 	 				</iframe>
	 	 			</td>
	 	 		</tr>
	 	 	</table>
	 	 	
	 	 </div>
	 	
  </body>
</html>
