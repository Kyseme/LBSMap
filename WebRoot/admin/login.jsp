<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>管理员登录页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
  </head>
  	<style type="text/css">
	body{font-size:14px;font-family:"微软雅黑";background-image:url("../img/adminbg.jpg");
	background-repeat:no-repeat;background-position:center;}
	div{margin:250px auto;}
	.inp{text-indent:0.7em;}
	</style>
   <body>
 <div  style="height:180px;width:350px;">
<h1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;管理员登录页面</h1>
<hr/>
<form action="<c:url value='/AdminGisServlet?method=findAll'/>" method="post">
	&nbsp;&nbsp;&nbsp;&nbsp;管理员账户：<input class="inp" type="text" name="adminname" value="" placeholder="请输入用户名"/><br/>
	&nbsp;&nbsp;&nbsp;&nbsp;密　　　码：<input class="inp" type="password" name="password" placeholder="请输入密码"/><br/><br/>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="submit" value="进入后台"/>
</form>
</div>
  </body>
</html>
