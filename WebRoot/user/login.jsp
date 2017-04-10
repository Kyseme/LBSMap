<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>登录</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
	body{font-size:14px;font-family:"微软雅黑"}
	div{margin:250px auto;}
	.inp{text-indent:0.7em;}
	</style>

  </head>
  
  <body background="img/bg.jpg">
 <div  style="height:180px;width:350px;">
 <h1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 登录</h1>
<p style="color: red; font-weight: 900">${msg}</p>
<form action="<c:url value='/UserServlet' />" method="post">
<input type="hidden" name="method" value="login"/>
	用户名：<input class="inp" autofocus="autofocus type="text" name="username" placeholder="请输入用户名" value="${form.username}"/><br/>
	密　码：<input class="inp" type="password" name="password" placeholder="请输入密码" value="${form.password}"/><br/><br/>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="submit" value="登录"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="/sun_gis/user/regist.jsp"><input type="button" value="注册" /></a>
</form>
</div>

  </body>
</html>

