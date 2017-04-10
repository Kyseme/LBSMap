package gis.servlet;



import gis.damin.Gis;
import gis.service.GisService;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import cn.itcast.servlet.BaseServlet;

public class GisServlet extends BaseServlet {
	private GisService gisService=new GisService();
	
	
	public String findAll(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setAttribute("gisList", gisService.findAll());
		return "f:/admin/list.jsp";
	}
	
	public String findAll2(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		List<Gis> gisList = gisService.findAll();
		String message = JSONArray.fromObject(gisList).toString();
		System.out.println(message);
		response.getWriter().write(message);
		return null;
	}

}
