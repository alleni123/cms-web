<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<span>
<!-- openWin方法定义在/resources/admin/inc.js  只要在包含此页面的jsp页面中引入该js文件即可 -->
<a style="color:#fff" href="javascript:openWin('<%=request.getContextPath() %>/admin/topic/add','addTopic')" class="admin_link">添加文章</a>
<a style="color:#fff" href="<%=request.getContextPath() %>/admin/topic/listByPage/0/1?published=1" class="admin_link published_topic">已发布文章列表</a>
<a style="color:#fff" href="<%=request.getContextPath() %>/admin/topic/listByPage/0/1?published=0" class="admin_link unpublished_topic">未发布文章列表</a>
<a style="color:#fff" href="<%=request.getContextPath() %>/admin/topic/listByPage/0/1?published=2" class="admin_link all_topic">所有文章列表</a>
</span>