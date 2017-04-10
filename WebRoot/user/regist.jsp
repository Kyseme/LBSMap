<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>注册</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
	body{font-size:14px;font-family:"微软雅黑";background-image:url("/sun_gis/img/bg.jpg");}
	div{margin:250px auto;}
	.inp{text-indent:0.7em;}
	</style>

  </head>
  
   <body>
   <div style="height:180px;width:450px;">
  <h1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注册</h1>
<p style="color: red; font-weight: 900">${msg }</p>
<form action="<c:url value='/UserServlet'/>" method="post">
	<input type="hidden" name="method" value="regist"/>
	用户名：<input class="inp" autofocus="autofocus" type="text" name="username" value="${form.username}" placeholder="请输入用户名"/>
		<span style="color: red; font-weight: 900">${errors.username}</span>
	<br/>

	密　码：<input class="inp" type="password" name="password" value="${form.password}" placeholder="请输入密码"/>
			<span style="color: red; font-weight: 900">${errors.password}</span>
	<br/>
	邮　箱：<input class="inp" type="text" name="email" value="${form.email}" placeholder="请输入邮箱"/>
			<span style="color: red; font-weight: 900">${errors.email }</span>
	<br/>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="注册"/>
</form>
</div>
  </body>
</html>
