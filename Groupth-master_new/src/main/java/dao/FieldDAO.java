package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.FieldVO;

@Repository
public class FieldDAO {
	@Autowired
	SqlSession session=null;
	
	public List<FieldVO> ListAllType() {
		
		List<FieldVO> list= null;
		String statement = "FieldMapper.listAllType";
		list=session.selectList(statement);
		return list;
	}
}
