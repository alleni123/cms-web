<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<span>

<!-- openWin方法定义在/resources/admin/inc.js  只要在包含此页面的jsp页面中引入该js文件即可 -->
<a style="color:#fff" href="javascript:openWin('<%=request.getContextPath()%>/admin/pic/addIndexPics','addIndexPics')" class="admin_link">添加宣传图片</a>

<a style="color:#fff" href="<%=request.getContextPath()%>/admin/pic/indexPics" class="admin_link">首页宣传图片</a>



<a style="color:#fff" href="<%=request.getContextPath() %>/admin/pic/newsPics" class="admin_link">首页新闻图片</a>
</span>