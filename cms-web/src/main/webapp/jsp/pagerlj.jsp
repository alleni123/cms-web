<%@page import="com.lj.basic.model.SystemContext" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<style>

a{
text-decoration:none;}

a.pager_link:link,a.pager_link:visited{
	padding:3px 5px;
	border:1px solid #699;
}
</style>

<!-- 注意要想获得jsp:include  param name= "n" value="p",必须写${param.n},没有param是得不到值的 -->
<!-- param.items是数据的数量，也就是${datas.total} -->
curpage=${curPage}
<%
	int items = Integer.parseInt(request.getParameter("items"));
	//out.println(request.getParameter("curPage"));

	Integer curPage = (Integer) (request.getAttribute("curPage")==null?1:request.getAttribute("curPage"));
	out.println("attr_curPage=" + curPage);
	System.out.println("attr_curPage=" + curPage);
	out.println("items= " + items);
	System.out.println("items= " + items);

	
	//Integer apageSize = (Integer) request.getAttribute("pageSize");
	Integer pageSize =SystemContext.getPageSize()!=null?SystemContext.getPageSize():5;
	 
	
	 System.out.println("pageSize= "+pageSize);
	 out.println("pageSize= "+pageSize);
	// pageSize=Integer.valueOf(request.getParameter("pageSize"));
	int end = items / pageSize;

	request.setAttribute("end", end);
	request.setAttribute("pageSize", pageSize);
	request.setAttribute("contextPath", request.getContextPath());
	request.setAttribute("curPage", curPage);
	int pageCount;
	pageCount = items / pageSize;

	if (items % pageSize > 0)
	{
		pageCount++;
	}
	request.setAttribute("pageCount", pageCount);

	int endPage = pageCount > curPage + 5 ? curPage + 5 : pageCount;
	request.setAttribute("endPage", endPage);

	//out.println("pageCount= "+pageCount);

	//String s_curPage=request.getParameter("curPage");
	//out.println("s_curpage= "+s_curPage);
	//int curPage=1;
	//request.setAttribute("curPage", curPage);
	//if(s_curPage!=null){
	//	out.println("cur");
	//	 curPage=Integer.parseInt(s_curPage);
	//	 request.setAttribute("curPage", curPage);
	//}
	//out.println("curpage="+curPage);
%>

<c:choose>
<c:when test="${pageCount>0}">
共${param.items}条记录,共${pageCount}页, pageSize=${pageSize} 当前第${curPage}页



<a class="pager_link" href="${contextPath}/${param.url}/listByPage/0/1${param.custom}">首页</a>
<c:if test="${curPage gt 1}">
	<a class="pager_link"
		href="${contextPath}/${param.url}/listByPage/${(curPage-2)*pageSize}/${curPage-1}${param.custom}">上一页</a>
</c:if>



<c:if test="${curPage<=7}">
	<c:forEach var="i" begin="1" end="${endPage}">
		<c:choose>
			<c:when test="${i ne curPage}">
				<a class="pager_link" href="${contextPath}/${param.url}/listByPage/${(i-1)*pageSize}/${i}${param.custom}">${i}</a>
			</c:when>

			<c:otherwise>
				<a class="pager_link_curPage" href="${contextPath}/${param.url}/listByPage/${(i-1)*pageSize}/${i}${param.custom}">${i}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>
</c:if>


<c:if test="${curPage>7&&pageCount>14}">
	<c:forEach var="i" begin="${(curPage-6)}" end="${endPage}">

		<c:choose>
			<c:when test="${i ne curPage}">
				<a class="pager_link" href="${contextPath}/${param.url}/listByPage/${(i-1)*pageSize}/${i}${param.custom}">${i}</a>
			</c:when>
			<c:otherwise>
				<a class="pager_link_curPage" href="${contextPath}/${param.url}/listByPage/${(i-1)*pageSize}/${i}${param.custom}">${i}</a>
			</c:otherwise>
		</c:choose>

	</c:forEach>
</c:if>



<c:if test="${curPage ne pageCount }">
	<a class="pager_link"
		href="${contextPath}/${param.url}/listByPage/${(curPage)*pageSize}/${curPage+1}${param.custom}">下一页</a>
</c:if>



<a class="pager_link"
	href="${contextPath}/${param.url}/listByPage/${(pageCount-1)*pageSize}/${pageCount}${param.custom}">尾页</a>




</c:when>

<c:otherwise>
 没有找到任何记录..
</c:otherwise>
</c:choose>















