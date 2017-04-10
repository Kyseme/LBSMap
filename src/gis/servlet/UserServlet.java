package gis.servlet;



import java.io.IOException;
import java.text.MessageFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gis.damin.User;
import gis.service.UserException;
import gis.service.UserService;
import cn.itcast.commons.CommonUtils;
import cn.itcast.mail.Mail;
import cn.itcast.mail.MailUtils;
import cn.itcast.servlet.BaseServlet;

public class UserServlet extends BaseServlet {
private UserService userService=new UserService();
	
	public String quit(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		request.getSession().invalidate();
		return "r:/index.jsp";
	}
	
	public String active(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		/*
		 * 1.获取参数激活码
	 * >保存异常信息到request域，转发到msg.jsp
		 * 3.保存成功信息到request域，转发到msg.jsp	
		 */
		String code=request.getParameter("code");
		try {
			userService.active(code);
			request.setAttribute("msg", "恭喜你已成功激活，请马上登陆吧！");
		} catch (UserException e) {
			request.setAttribute("msg", e.getMessage());
		}
		
		return "f:/msg.jsp";
	}
	

	public String regist(HttpServletRequest request, HttpServletResponse response) throws IOException
		{
	//封装表单数据
		User form=CommonUtils.toBean(request.getParameterMap(), User.class);
		//补全
		form.setUid(CommonUtils.uuid());
		form.setCode(CommonUtils.uuid()+CommonUtils.uuid());
		
		//创建一个map，用来封装错误信息，其中key为表单字段名称，值为错误信息
		Map<String,String>errors=new HashMap<String,String>();
		//后期username,password,email进行校验
		String username=form.getUsername();
		if(username==null || username.trim().isEmpty()){
			errors.put("username", "用户名不能为空！");
		}
		else if(username.length()<3 || username.length()>10)
		{
			errors.put("username", "用户名长度必须在3~10之间");
		}
		
		String password=form.getPassword();
		if(password==null || password.trim().isEmpty()){
			errors.put("password", "密码不能为空！");
		}
		else if(password.length()<5 || password.length()>15)
		{
			errors.put("password", "密码长度必须在5~15之间");
		}
		
		String email=form.getEmail();
		if(email==null || email.trim().isEmpty()){
			errors.put("email", "Email不能为空！");
		}
		else if(!email.matches("\\w+@\\w+\\.\\w+"))
		{
			errors.put("email", "Email格式不正确");
		}
		
		if(errors.size()>0){
			request.setAttribute("errors",errors);
			request.setAttribute("form",form);
			return "f:/user/regist.jsp";
		}
		
		try {
			userService.regist(form);
		
		} catch (UserException e) {
			request.setAttribute("form",form);
			return "f:/user/regist.jsp";
		}
		//发邮件
		Properties props=new Properties();
		props.load(this.getClass().getClassLoader().getResourceAsStream("email_template.properties"));
		String host=props.getProperty("host");
		String uname=props.getProperty("uname");
		String pwd=props.getProperty("pwd");
		String from=props.getProperty("from");
		String to =form.getEmail();//获取收件人
		String subject=props.getProperty("subject");
		String content=props.getProperty("content");
		content=MessageFormat.format(content, form.getCode());//替换占位符
		
		Session session=MailUtils.createSession(host, uname, pwd);
		Mail mail=new Mail(from, to, subject, content);
		try {
			MailUtils.send(session, mail);
		} catch (MessagingException e) {
		
		}
		request.setAttribute("msg","恭喜注册成功，马上去邮箱激活吧！");

		return "f:/user/login.jsp";

		
	}
	
	//登陆
	/*
	 * 1.封装表单数据到form中
	 * 2.输入校验（不写了）
	 * 3.调用service完成激活
	 * >保存错误信息、form到request，转发到login.jsp
	 * 4.保存用户信息到session中，然后重定向index.jsp
	 */
	
	public String login(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		User form=CommonUtils.toBean(request.getParameterMap(),User.class);
		User user;
		try {
			user = userService.login(form);
			request.getSession().setAttribute("session_user", user);
			return "r:/user/Test.jsp";
		} catch (UserException e) {
			request.setAttribute("msg", e.getMessage());
			request.setAttribute("form", form);
			return "f:/user/login.jsp";
		}
		
	
	}

}
