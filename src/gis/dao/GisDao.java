package gis.dao;

import gis.damin.Gis;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;

import cn.itcast.jdbc.TxQueryRunner;



public class GisDao {
	private QueryRunner qr=new TxQueryRunner();
	
	public List<Gis> findAll(){
		try{
			String sql="select * from gis";
			Connection con = ConnectionUtil.getConnection();
			return qr.query(con,sql, new BeanListHandler<Gis>(Gis.class));
		}catch(SQLException e){
			throw new RuntimeException(e);
		}
	}

	public void add(Gis gis) {
		try {
			String sql = "insert into gis values(null,?,?,?,?)";
			Connection con = ConnectionUtil.getConnection();
			Object[] params = {gis.getGname(),gis.getGtel(),gis.getPoint(),gis.getDes()};
			qr.update(con,sql, params);
		} catch(SQLException e) {
			throw new RuntimeException(e);
		}
		
	}

	public Gis findByGid(String gid) {
		try{
			String sql="select * from gis where gid=?";
			Connection con = ConnectionUtil.getConnection();
			return qr.query(con,sql, new BeanHandler<Gis>(Gis.class),gid);
			
		}catch(SQLException e){
			throw new RuntimeException(e);
		}
	}

	public void delete(String gid) {
		try {
			Connection con = ConnectionUtil.getConnection();
			String sql = "delete from gis where gid=?";
			qr.update(con,sql, gid);
		} catch(SQLException e) {
			throw new RuntimeException(e);
		}
		
	}

	public void edit(Gis gis) {
		try {
			Connection con = ConnectionUtil.getConnection();
			String sql = "update gis set gname=?, gtel=?,point=?, des=? where gid=?";
			Object[] params = {gis.getGname(),gis.getGtel(),gis.getPoint(),gis.getDes(),gis.getGid()};
			qr.update(con,sql, params);
		} catch(SQLException e) {
			throw new RuntimeException(e);
		}
		
	}


}
