<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
<link rel="stylesheet" type="text/css" href="<%=path%>/resources/css/admin/main.css"/>
<link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css"/>
<script type="text/javascript" src="<%=path%>/resources/js/jquery-1.9.0.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/core/jquery.cms.core.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/admin/inc.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/ui/jquery.ui.core.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/ui/jquery.ui.widget.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/ui/jquery.ui.core.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/ui/jquery.ui.button.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/ui/jquery.ui.spinner.js"></script>
<script type="text/javascript" src="<%=path%>/resources/js/admin/main.js"></script>
<script type="text/javascript" src="<%=path%>/dwr/engine.js"></script>
<script type="text/javascript" src="<%=path%>/dwr/interface/dwrService.js"></script>


<script type="text/javascript" charset="utf-8">
	$(function() {
 	
	 $(".setPos").click(setPos);
	 
	 
	 /**
	 * 这里为了不让多个排序输入被弄出来，就封装了方法并使用off和on来设置。
	 */
	 function setPos(){
	 	event.preventDefault();
	 	var id=$(this).attr("picid");
	 	var pos=$(this).attr("pos");
		$(this).after("<span>&nbsp;<input type='text' value='"+pos+"' class='posInput' size='3'/><a href='#' class='list_opg confirmPos'>确定</a>&nbsp;<a href='#' class='list_opg cancelPos'>取消</a></span>")	;
	 	// $(".posInput").spinner();
	 	$(this).next("span").children("input").spinner({
	 		min:$("#minPos").val(),
	 		max:$("#maxPos").val(),
	 		step:1,
	 		spin:function(event,ui){
	 			
	 		}
	 	});
	 	$(this).off("click");
	 	
	 	//自己写的， 目的是让‘排序’被点击后不至于跳转到a指向的页面
	 	$(this).on("click",function(e){
	 		e.preventDefault();
	 	});
	 }
	 
	 $(".posCon").on("click",".cancelPos",function(event){
	 	event.preventDefault();
	    $(this).parent("span").prev("a").on("click",setPos);//必须放在remove()前面
	 	$(this).parent("span").remove();
	 	
	 	
	 });
	
	 $(".posCon").on("click",".confirmPos",function(event){
	 	event.preventDefault();
	 	var id=$(this).parent("span").prev("a").attr("picid"); //图片id
	 	var op=$(this).parent("span").prev("a").attr("pos"); //原始值
	 	var np=$(this).prev("span").children("input").val();//输入值
	 	
	 	//如果输入值和原始值不相等，则通过dwr更新排序。
	 	if(op!=np){
	 		//通过dwr更新
			dwrService.updatePicPos(id,op,np,function(data){
				alert((data+1)+" rows have been updated");
				window.location.reload();
			});	
	 	}
	 	$(this).parent("span").prev("a").on("click",setPos);//必须放在remove()前面
	 	$(this).parent("span").remove();
	 
	 });
	 
	 

	});
</script>


</head>

<body>
	<div id="content">
		<input type="hidden" id="maxPos" value="${max}"/><input type="hidden" id="minPos" value="${min}"/>
		<h3 class="admin_link_bar">
			<jsp:include page="inc.jsp"></jsp:include>

		</h3>

		<table width="800" border="1" cellspacing="0" cellPadding="0" id="listTable">
			<thead>
				<tr>
					<td>缩略图</td>
					<td width="250">图片标题</td>
					<td>状态</td>
					<td>链接类型</td>
					<td>位置</td>
					<td>用户操作</td>
				</tr>
			</thead>

			<tbody>
				<c:forEach items="${datas.datas}" var="pic">
					<tr>
						<!-- 缩略图 -->
						<td><img src="<%=path%>/resources/indexPic/thumbnail/${pic.newName}" />
						</td>

						<!-- 图片标题 -->
						<td><a href="<%=path%>/admin/pic/indexPic/${pic.id}" class="list_link">${pic.title}</a>
						</td>

						<!-- 图片状态 -->
						<td><c:if test="${pic.status eq 0}">未启用&nbsp;<a href="admin/pic/updateIndexPicStatus/${pic.id}">启用</a>
							</c:if> <c:if test="${pic.status eq 1}">启用&nbsp;<a href="admin/pic/updateIndexPicStatus/${pic.id}">停用</a>
							</c:if></td>

						<!-- 链接类型 -->
						<td><c:if test="${pic.linkType eq 0}">站内链接</c:if> <c:if test="${pic.linkType eq 1}">
								<a href="${pic.linkUrl}" class="list_link">站外链接</a>
							</c:if></td>
                        
                        <td class="posCon">
                        	${pic.pos}&nbsp;<a href="#" class="list_opg setPos" pos="${pic.pos}" picId="${pic.id}">排序</a>
                        </td>

						<!-- 用户操作 -->
						<td><a href="admin/pic/deleteIndexPic/${pic.id}" class="list_op delete">删除</a>&nbsp; <a
							href="admin/pic/updateIndexPic/${pic.id}" id="upd" class="list_op">更新</a>&nbsp;</td>

					</tr>

				</c:forEach>
			</tbody>

 

		</table>



	</div>
</body>
</html>
