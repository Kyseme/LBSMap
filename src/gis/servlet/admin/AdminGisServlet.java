package gis.servlet.admin;

import gis.damin.Gis;
import gis.service.GisService;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.itcast.commons.CommonUtils;
import cn.itcast.servlet.BaseServlet;

public class AdminGisServlet extends BaseServlet {
	private GisService gisService = new GisService();
	

	public String addOrEdit(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Gis gis = CommonUtils.toBean(request.getParameterMap(), Gis.class);
		System.out.println("gid:"+gis.getGid());
		if(gis.getGid() == null || gis.getGid().equals(0)){
			System.out.println("add");
			gisService.add(gis);
		}
		else{
			System.out.println("edit");
			gisService.edit(gis);
		}
		return findAll(request, response);
	}
	
	public String load(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String gid = request.getParameter("id");
		Gis gis = gisService.load(gid);
		request.setAttribute("gis", gis);
		return "f:/admin/desc.jsp";
	}
	
	/**
	 * 查看所有加油站
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String findAll(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setAttribute("gisList", gisService.findAll());
		return "f:/admin/list.jsp";
	}
	
	/**
	 * 删除加油站
	 * @param request
	 * @param response
	 * @return
	 * @throws ServletException
	 * @throws IOException
	 */
	public String delete(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String gid = request.getParameter("id");
		gisService.delete(gid);
		return findAll(request, response);
	}
	
}
