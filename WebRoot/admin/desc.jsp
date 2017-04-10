<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath }"></c:set>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>操作加油站信息</title>

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
	<form action="${ctx }/AdminGisServlet?method=addOrEdit" method="post">
		<table border='1' align="Center" cellspacing="0">
		<tr><th colspan="4">加油站信息操作</th></tr>
			<tr>
				<td>名称</td>
				<td><input type='text' name="gname" value="${gis.gname }"/>
				</td>
				<td>电话</td>
				<td><input type='text' name="gtel" value="${gis.gtel }" />
				</td>
			</tr>
			<tr>
				<td>坐标</td>
				<td><input type='text' name="point" value="${gis.point }" />
				</td>
				<td>描述</td>
				<td><input type='text' name="des" value="${gis.des }" />
				</td>
				</tr>
				<tr><th colspan="4"><input type="submit" value="提交" /></th></tr>
		</table>
		<input type="hidden" name="gid" value="${gis.gid }"/>
		
		
	</form>
	</div>
</body>
</html>
