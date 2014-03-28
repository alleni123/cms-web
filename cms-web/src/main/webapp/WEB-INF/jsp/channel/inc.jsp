<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<span>
当前栏目:${parentChannel.name} [${parentChannel.id}] &nbsp;
<a style="color:#fff" href="<%=request.getContextPath() %>/admin/channel/add/${pid}" class="admin_link">添加子栏目</a>
<a style="color:#fff" href="<%=request.getContextPath() %>/admin/channel/channels" class="admin_link">子栏目列表</a>
</span>