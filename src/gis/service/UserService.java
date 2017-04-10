package gis.service;

import gis.damin.User;
import gis.dao.UserDao;

import java.sql.SQLException;

public class UserService {
	private UserDao userDao=new UserDao();
	
	public void regist(User form) throws UserException{
		User user=userDao.findByUsername(form.getUsername());
		if(user!=null) throw new UserException("用户名已被注册过！");
		
		user=userDao.findByEmail(form.getEmail());
		if(user!=null) throw new UserException("Email已被注册过！");
		
		//插入用户到数据库
		userDao.add(form);
	}
	//激活功能
	public void active(String code) throws UserException{
		/*
		 * 1,使用code查询数据库，得到user
		 */
		User user=userDao.findByCode(code);
		/*
		 * 2.如果user不存在，说明激活码错误
		 */
		if(user==null) throw new UserException("激活码无效");
		/*
		 * 校验用户的状态，是否为未激活状态，如果已激活则抛异常，
		 */
		if(user.isState()) throw new UserException("你已经激活，无需再激活");
		/*
		 * 修改用户的状态
		 */
		userDao.updateState(user.getUid(), true);
	}
	
	//登陆功能
	/*
	 * 1.使用username查询，得到User
	 * 2.如果user为null，抛出异常（用户名不存在）
	 * 3.比较form和user的密码，若不同，抛出异常（密码错误）
	 * 4.查看用户的状态，若为false，抛出异常（尚未激活）
	 * 5.返回user
	 */
	public User login(User form) throws UserException{
		User user=userDao.findByUsername(form.getUsername());
		if(user==null) throw new UserException("用户名或密码错误");
		if(!user.getPassword().equals(form.getPassword()))
			throw new UserException("用户名或密码错误");
		if(!user.isState()) throw new UserException("账号尚未激活");
		
		return user;
	}
	
}
