<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath }"></c:set>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>列表</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	 <style type="text/css">
	body{font-size:14px;font-family:"微软雅黑"}
	div{margin:50px auto;}
	</style>

  </head>
 
  <body>

	<div>
	<table border='1' align="Center" cellspacing="0">
	<tr><th colspan="6">加油站信息列表</th></tr>
	<tr><td colspan="6"><a href="${ctx}/admin/desc.jsp">添加数据</a></td></tr>
		<tr>
			<td>序号</td>
			<td>名称</td>
			<td>电话</td>
			<td>坐标</td>
			<td>描述</td>
			<td>操作</td>
		</tr>
		<c:forEach var="list" items="${gisList }">
			<tr>
				<td>${list.gid }</td>
				<td>${list.gname }</td>
				<td>${list.gtel }</td>
				<td>${list.point }</td>
				<td>${list.des }</td>	
				<td> <a href="${ctx}/AdminGisServlet?method=load&id=${list.gid }">编辑</a>
				<a href="${ctx }/AdminGisServlet?method=delete&id=${list.gid }">删除</a>
				</td>			
			</tr>
		</c:forEach>
	</table>
</div>

  </body>
</html>
