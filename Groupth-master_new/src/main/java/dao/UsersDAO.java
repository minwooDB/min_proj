package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.UsersVO;

@Repository
public class UsersDAO {
	@Autowired
	SqlSession session =null;
	
	public boolean insert(UsersVO vo) {
		boolean result = true;
		String statement ="UsersMapper.insertUser";
		if(session.insert(statement,vo)!=1)
			result=false;
		return result;
	}
	public UsersVO loginUser(String idVal, String pwdVal) {
		UsersVO user=null;
		String statement="UsersMapper.searchLoginId";
		user=session.selectOne(statement,idVal);
		if(user==null) 
			return null;
		if(!user.getPassword().equals(pwdVal))
			return null;
		return user;
	}
	public int idDuplChk(String users_id)throws Exception{
		String statement="UsersMapper.idCheck";
		System.out.println(session.selectOne(statement,users_id));
		return session.selectOne(statement,users_id);
	}
	public UsersVO showUser(String idVal) {
		UsersVO user= null;
		String statement="UsersMapper.showUser";
		user=session.selectOne(statement,idVal);
		return user;
	}
	
	public boolean addInfo(UsersVO vo) {
		boolean result = true;
		System.out.println(vo);
		if(vo.getImg().equals("smile.png")) {
			session.update("UsersMapper.addInfoException",vo);
		}
		else if(session.update("UsersMapper.addInfo",vo)!=1)
			result=false;
		return result;
	}
	public boolean change(UsersVO vo) {
		boolean result = true;
		if(session.update("UsersMapper.changeUser",vo)!=1)
			result=false;
		return result;
	}
	public UsersVO matchInfo(String idVal) {
		UsersVO vo =null;
		vo= session.selectOne("UsersMapper.matchInfo", idVal);
		return vo;
	}
	public List<UsersVO> allUsersLocation(int range,int field,String lat,String lng){
		List<UsersVO> list= null;
		Map<String,String> parameters = new HashMap<String,String>();
		parameters.put("range", String.valueOf(range));
		parameters.put("field", String.valueOf(field));
		parameters.put("lat", lat);
		parameters.put("lng", lng);
		list= session.selectList("UsersMapper.allUsersLocation", parameters);
		return list;
	}
}
