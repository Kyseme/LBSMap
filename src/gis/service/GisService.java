package gis.service;

import java.util.List;


import gis.damin.Gis;
import gis.dao.GisDao;

public class GisService {
	private GisDao gisDao=new GisDao();
	
	public List<Gis>findAll(){
		return gisDao.findAll();
	}

	public void add(Gis gis) {
		gisDao.add(gis);
		
	}

	public Gis load(String gid) {
		return gisDao.findByGid(gid);
	}

	public void delete(String gid) {
		gisDao.delete(gid);
		
	}
	
	


	public void edit(Gis gis) {
		gisDao.edit(gis);
	}

	
}
