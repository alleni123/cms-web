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

 	<script type="text/javascript"></script>
	 
	 <script type="text/javascript">
	 var datas=[{id:"0", name:"根目录", pid:"-1",test:"abc" },
	 	         {id:"1",  name:"用户管理", pid:"0",test:"a1"   },
	 	         {id:"2",  name:"用户管理1", pid:"1" ,test:"a11"  },
	 	         {id:"3",  name:"用户管理2", pid:"1" ,test:"a12"  },
	 	         {id:"4",  name:"文章管理", pid:"0" ,test:"a2"  },
	 	         {id:"5",  name:"文章管理1", pid:"4" ,test:"a21"  },
	 	         {id:"6",  name:"文章管理2", pid:"4" ,test:"a22"  },
	 	         {id:"7",  name:"文章管理3", pid:"4" ,test:"a23"  },
	 	         {id:"8",  name:"系统管理", pid:"0" ,test:"a3"  },
	 	         {id:"9",  name:"系统管理1", pid:"8",test:"a31"   },
	 	           ];
	 	           
	 	           
	 $(function(){
		var setting={
			data:{
				simpleData:{
					enable:true,
					idKey:"id",
					pIdKey:"pid",
					rootPid:0		
				}
			},
			
			view:{
				dblClickExpand:true,
				selectedMulti:false
			},
			callback:{
				onClick:function(event,treeId,treeNode){
						console.log(treeId);
						console.log(treeNode);
					}
			}
		};
		
	//	 $.fn.zTree.init($("#tree"),setting,datas);
		 
		  var n={id:"7",name:"系统管理2",pid:"8"};
	 
	 var t=$.fn.zTree.init($("#tree"),setting, datas);
	 
	// t.addNodes(null,n);
	 t.addNodes(t.getNodeByParam("id",8,null),n);
		 	
	 });	       
	 
	 
	
	     
	 </script>
	 
  </head>
  
  <body>
	 	<div id="content" class="ztree">
	 		<div id="tree"></div>
	 	</div>
	 	
  </body>
</html>
