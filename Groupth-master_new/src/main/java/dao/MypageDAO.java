package dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MypageDAO {
	@Autowired
	SqlSession session=null;
	
	public boolean deleteGroup(String gid,String idVal) {
		boolean result= true;
		Map<String,String> parameters = new HashMap<String ,String>();
		parameters.put("id", idVal);
		parameters.put("gid", gid);
		if(session.delete("GroupMapper.myInfoGroup",parameters)!=1)
			result =false;
		return result;
	}
	
}
