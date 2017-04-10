package gis.dao;

import gis.damin.User;

import java.sql.Connection;
import java.sql.SQLException;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;

import cn.itcast.jdbc.JdbcUtils;
import cn.itcast.jdbc.TxQueryRunner;

public class UserDao {
	private QueryRunner qr=new TxQueryRunner(); 
	//按用户名查询
	public User findByUsername(String username){
		try{
			String sql="select * from user where username=?";
			Connection con = ConnectionUtil.getConnection();
			return qr.query(con,sql, new BeanHandler<User>(User.class), username);
		}catch(SQLException e){
			throw new RuntimeException(e);
		}
	}
	
	public User findByEmail(String email){
		try{
			String sql="select * from user where email=?";
			Connection con = ConnectionUtil.getConnection();
			return qr.query(con,sql, new BeanHandler<User>(User.class), email);
		}catch(SQLException e){
			throw new RuntimeException(e);
		}
	}
	//增加user
	public void add(User user){
		try{
			String sql="insert into user value(?,?,?,?,?,?)";
			Connection con = ConnectionUtil.getConnection();
			Object[ ] params={user.getUid(), user.getUsername(), user.getPassword(), user.getEmail(),user.getCode(),user.isState()};
			qr.update(con,sql, params);
		}catch(SQLException e){
			throw new RuntimeException(e);
		}
	}
	//按照激活码查询
	public User findByCode(String code){
		try{
			String sql="select * from user where code=?";
			Connection con = ConnectionUtil.getConnection();
			return qr.query(con,sql, new BeanHandler<User>(User.class), code);
		}catch(SQLException e){
			throw new RuntimeException(e);
		}
	}
	
	//修改指定用户的指定状态
	public void updateState(String uid,boolean state){
		try{
			String sql="update user set state=? where uid=?";
			Connection con = ConnectionUtil.getConnection();
			 qr.update(con,sql,state,uid);
		}catch(SQLException e){
			throw new RuntimeException(e);
		}
	}
}
