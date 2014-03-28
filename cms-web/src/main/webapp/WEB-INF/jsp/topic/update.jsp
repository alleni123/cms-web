<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String cssPath = request.getContextPath() + "/resources/css";
%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix='fmt' uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/validate/main.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/resources/css/admin/main.css" />
<link rel="stylesheet" type="text/css"
	href="<%=cssPath%>/ztree/zTreeStyle.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/resources/xeditor/demos/common.css" />


<link rel="stylesheet" type="text/css"
	href="<%=path%>/resources/js/base/jquery.ui.all.css" />
<link rel="stylesheet" type="text/css"
	href="<%=path%>/resources/uploadify/uploadify.css" />


<!-- jquery 1.9和xheditor不兼容， 要换成这个1.7.2才行 -->
<!--src="<%=path%>/resources/js/jquery-1.7.2.min.js">-->
<script type="text/javascript"
	src="<%=path%>/resources/js/jquery-1.7.2.min.js">
	
</script>
<script type="text/javascript"
	src="<%=path%>/resources/js/ui/jquery-ui.custom.js">
	
</script>

<script type="text/javascript"
	src="<%=path%>/resources/js/ui/jquery.ui.core.js">
	
</script>

<script type="text/javascript"
	src="<%=path%>/resources/js/i18n/jquery-ui-i18n.js">
	
</script>

<script type="text/javascript"
	src="<%=path%>/resources/js/tree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript"
	src="<%=path%>/resources/js/core/jquery.cms.core.js"></script>

<script type="text/javascript"
	src="<%=path%>/resources/xeditor/xheditor-1.1.14-zh-cn.min.js">
	
</script>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/js/core/jquery.cms.keywordinput.css" />


<script type="text/javascript"
	src="<%=path%>/resources/js/core/jquery.cms.core.js">
	</script>
<script type="text/javascript"
	src="<%=path%>/resources/js/core/jquery.cms.keyword.js">
	
</script>

<script type="text/javascript"
	src="<%=path%>/resources/js/admin/main.js">
</script>

<script type="text/javascript"
	src="<%=path%>/resources/uploadify/jquery.uploadify.js"></script>

<script type="text/javascript"
	src="<%=path%>/resources/js/admin/topicAdd.js"></script>
	
	
	<script type="text/javascript"
	src="<%=request.getContextPath()%>/dwr/engine.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/dwr/interface/dwrService.js"></script>
	


<script type="text/javascript">
	/*文章添加下拉功能：60文章管理 35分钟*/
	/*js文件路径-> resources/js/admin/topicAdd.js*/
	var mt;
	$(function(){
		 
		
		$("#keyword").keydown(function(event){
			var code=event.keyCode;
			if(code==13){
			return ;
			}
		});
	});

	 var writeContent=function(){
		  alert($(".editMode").html());
		 };
		 
	
</script>


</head>

<body>

	  
	<input type="hidden" id="sid" value="<%=session.getId()%>"/>
	<input type="hidden" id="contextPath" value="<%=path%>"/>
	<!--???-->

	<!-- ztree显示下拉隐藏菜单的地方 -->
	<div id="menuContent" class="menuContent"
		style="display:none;position:absolute;background:#eee;z-index:999;border:1px solid #999">
		<ul id="mytree" class="ztree" style="margin-top:0;width:160px;"></ul>
	</div>


	<div id="container">
		<jsp:include page="/jsp/admin/top_inc.jsp"></jsp:include>
		<div id="contents">
			<input type="hidden" id="ctx" value="<%=path%>" />
			<h3 class="admin_link_bar" style="text-align:center">
				<span>更新文章功能</span>
			</h3>

			<sf:form method="post" modelAttribute="topicDto" id="addForm">
				<table width="980" cellspacing="0" cellpadding="0" id="addTable">
					<tr>
						<td class="rightTd" width="120px">文章标题:</td>
						<td class="leftTd"><sf:input path="title" size="80" /> <sf:errors
								cssClass="errorContainer" path="title" /></td>
					</tr>


					<tr>
						<td class="rightTd">文章栏目:</td>
						<td class="leftTd"><input type="text" readonly="readonly"
							name="channel_name" id="channel_name" value="${channel_name}" /> <input type="text"
							readonly="readonly" name="channel_id" id="channel_id" value="${topicDto.channel_id}">
							<sf:errors cssClass="errorContainer" path="channel_id" /></td>
					</tr>


					<c:choose>
						<c:when test="${isAdmin||isAudit}">
							<tr>
								<td class="rightTd">文章状态:</td>
								<td class="leftTd"><sf:radiobutton path="status" value="0" />未发布
									<sf:radiobutton path="status" value="1" />已发布</td>
							</tr>
						</c:when>
						<c:otherwise>
							<sf:hidden path="status" />
						</c:otherwise>

					</c:choose>



					<tr>
						<td class="rightTd">是否推荐该文章</td>
						<td class="leftTd"><sf:radiobutton path="recommend" value="0" />不推荐
							<sf:radiobutton path="recommend" value="1" />推荐</td>
					</tr>

					<tr>
						<td class="rightTd">发布时间:</td>
						<td class="leftTd"><sf:input path="publishDate" />
						</td>
					</tr>

					<tr>
						<td class="rightTd">文章关键字:</td>
						<td class="leftTd">
						<!-- 这里要加入已经存在关键字 -->
						<div id="existKeyword">
						 	
							<c:forEach items="${keywords}" var="keyword">
								<span>${keyword}</span>
							</c:forEach>
							
						</div>
						<sf:input path="keyword"/></td>
					</tr>

					<tr>
						<td class="rightTd">文章附件</td>
						<td class="leftTd">
							<div id="attachs"></div> <input type="file" id="attach"
							name="attach" /> <input type="button" id="uploadFile"
							value="上传文件" /></td>
					</tr>

					<tr>
						<td colspan="2">已传文件</td>
					</tr>

					<tr>
						<td colspan="2">
							<!-- 文件信息开始， 这里用一个table来显示所有文件信息 -->
							<table id="ok_attach" width="890px" cellspacing="0"
								cellpadding="0" border="1px solid blue">
								<thead>
									<tr>
										<td>文件名缩略图</td>
										<td width="180px">文件名</td>
										<td>文件大小</td>
										<td>主页图片</td>
										<td>栏目图片</td>
										<td>附件信息</td>
										<td width="160px">操作</td>
									</tr>
								</thead>
									<!-- tbody里面会被加入文件信息。使用$("tbody").find()来获取具体文件信息 -->
								<tbody>
									<c:forEach items="${atts}" var="att">
										<tr>
											<td>
												<c:if test="${att.isImg eq 1 }">
													<img src="<%=path%>/resources/upload/thumbnail/${att.newName}"/>
												</c:if>
												<c:if test="${att.isImg ne 1 }">
													普通类型附件
												</c:if>
											</td>
											<td>
												${att.originalName}
											</td>
											<td>
												 
												<fmt:formatNumber type="number" value="${att.fileSize/1024}" maxIntegerDigits="1"></fmt:formatNumber>
												K
											</td>
											<c:if test="${att.isImg eq 1 }">
												<td>
													<input type='checkbox' value='${att.id}' name='indexPic' class='indexPic' <c:if test="${att.isIndexPic eq 1}">
													checked='checked'</c:if> />
												</td>
												<td>
													<input type='radio' value='${att.id}' name="channelPicId" <c:if test="${att.id eq topicDto.channelPicId}">
													checked="checked"</c:if> />
												</td>
											</c:if>
											<c:if test="${att.isImg ne 1 }">
												<td>&nbsp;</td>
												<td>&nbsp;</td>
											</c:if>
											
											<td>
												<input type="checkbox" value="${att.id}" name="isAttach" class="isAttach" <c:if test="${att.isAttach eq 1}">checked="checked"</c:if>/>
											</td>
											<td>
												<a href="javascript:void(0)" class="list_op insertAttach" title="${att.id}" isImg="${att.isImg}" 
												name="${att.newName}" oldName="${att.originalName}">插入附件</a>&nbsp;
												<a href="#" title="${att.id}" class="list_op deleteAttach delete">删除附件</a>
											</td>
											
										</tr>
									</c:forEach>
								</tbody>

							</table></td>
					</tr>

					<tr>
						<td colspan="2">文章内容</td>
					</tr>

					<tr>
						<td colspan="2"><sf:textarea path="content" rows="25"
								cols="110" /></td>
					</tr>
						
					<tr>
						<td colspan="2">文章摘要</td>
					</tr>
						
					<tr>
						<td colspan="2"><sf:textarea path="summary" rows="5"
								colspan="110" /></td>
					</tr>

					<tr>
						<td colspan="2" class="centerTd"><input type="submit"
							id="addBtn" value="更新文章" /> <input
							type="reset" /> <!-- 这里设置为button,并且捆绑事件 onclick='this.form.submit()',这样防止keyword添加时按了回车而提交form -->
						</td>
					</tr>


				</table>


			</sf:form>

		</div>
	</div>

</body>
</html>
