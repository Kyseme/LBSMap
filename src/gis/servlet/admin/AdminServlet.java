package gis.servlet.admin;



import gis.damin.User;
import gis.service.UserException;
import gis.service.UserService;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;

public class AdminServlet extends BaseServlet {
	private UserService userService=new UserService();
	
	public String login(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User form=CommonUtils.toBean(request.getParameterMap(),User.class);
		User user;
		try {
			user = userService.login(form);
			request.getSession().setAttribute("session_user", user);
			return "f:admin/list.jsp";
		} catch (UserException e) {
			//request.setAttribute("msg", e.getMessage());
			request.setAttribute("form", form);
			return "f:admin/login.jsp";
		}
	}

}
