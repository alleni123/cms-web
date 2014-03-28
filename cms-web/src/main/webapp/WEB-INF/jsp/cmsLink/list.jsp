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
	 	var id=$(this).attr("objId");
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
	 	var id=$(this).parent("span").prev("a").attr("objId"); //链接id
	 	var op=$(this).parent("span").prev("a").attr("pos"); //原始值
	 	var np=$(this).prev("span").children("input").val();//输入值
	 	
	 	//如果输入值和原始值不相等，则通过dwr更新排序。
	 	if(op!=np){
	 		//通过dwr更新
			dwrService.updateLinkPos(id,op,np,function(data){
				alert((data+1)+" rows have been updated");
				window.location.reload();
			});	
	 	}
	 	$(this).parent("span").prev("a").on("click",setPos);//必须放在remove()前面
	 	$(this).parent("span").remove();
	 
	 });
	 
	 
	 
	 $("#selectType").change(function(){
	 	var v = $(this).val();
	 	if(v=="-1"){
	 		window.location.href="admin/cmsLink/links";
	 	}else{
	 	window.location.href="admin/cmsLink/links?type="+v;}
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
				<!-- 选择类别的部分 -->
				<tr>
					<td colspan="6">选择类别:
						<select id="selectType">
							<option value="-1">请选择类别筛选</option>
							<c:forEach items="${types}" var="t">
								<option value="${t}" <c:if test="${param.type eq t}">selected="selected"</c:if>>${t}</option>
							</c:forEach>
						</select>
					
					
					</td>
				</tr>
			
				<tr>
					<td>标题</td>
					<td width="250">超链接</td>
					<td>类型</td>
					<td>打开方式</td>
					<td>位置</td>
					<td>用户操作</td>
				</tr>
			</thead>

			<tbody>
				<c:forEach items="${datas.datas}" var="cl">
					<tr>
						<!-- 标题 -->
						<td><a href="admin/cmsLink/show/${cl.id}">${cl.title}</a>
						</td>

						<!-- 超链接 -->
						<td><a href="${cl.url}" class="list_link">${cl.url}</a>
						</td>

						<!-- 类型 -->
						<td>${cl.type}</td>

						<!-- 链接类型 -->
						<td><c:if test="${cl.newWin eq 0}">本窗口</c:if>
						    <c:if test="${cl.newWin eq 1}">新窗口</c:if>
						   </td>
                        
                        <td class="posCon">
                        	${cl.pos}&nbsp;<a href="#" class="list_opg setPos" pos="${cl.pos}" objId="${cl.id}">排序</a>
                        </td>

						<!-- 用户操作 -->
						<td><a href="admin/cmsLink/delete/${cl.id}" class="list_op delete">删除</a>&nbsp; <a
							href="admin/cmsLink/update/${cl.id}" id="upd" class="list_op">更新</a>&nbsp;</td>

					</tr>

				</c:forEach>
			</tbody>

			<tfoot>
				<tr>
					<td colspan="6" style="text-align:right;margin-right:10px;"><jsp:include
							page="/jsp/pagerlj.jsp">
							<jsp:param value="admin/cmsLink" name="url" />
							<jsp:param value="${datas.total}" name="items" />
						</jsp:include></td>
				</tr>

			</tfoot>

		</table>



	</div>
</body>
</html>
