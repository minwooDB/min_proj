package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.BoardVO;


@Repository
public class BoardDAO {
	@Autowired
	SqlSession session= null;
	
	public boolean insert(BoardVO vo) {
		boolean result =true;
		String statement = "BoardMapper.insertBoard";
		if(session.insert(statement,vo)!=1)
			result=false;
		return result;
	}
	
	public boolean update(BoardVO vo) {
		boolean result =true;
		String statement  ="BoardMapper.updateBoard";
		if(session.update(statement,vo)!=1)
			result=false;
		return result;
	}
	
	public boolean delete(int id) {
		boolean result =true;
		String statement ="BoardMapper.deleteBoard";
		if(session.delete(statement,id)!=1)
			result =false;
		return result;
	}
	
	public List<BoardVO> listAll(){
		List<BoardVO> list=null;
		String statement="BoardMapper.listAllBoard";
		list=session.selectList(statement);
		return list;
	}
	
	public BoardVO listOne(int id) {
		BoardVO vo= null;
		String statement="BoardMapper.listOneBoard";
		String c_statement="BoardMapper.updateCount";
		session.update(c_statement,id);
		vo=session.selectOne(statement,id);
		return vo;
	}
	
	public List<BoardVO> listWriter(String writer){
		List<BoardVO> list;
		String statement = "BoardMapper.listWriterBoard";
		list = session.selectList(statement, writer);
		return list;
	}
	
	public List<BoardVO> search(String key, String searchType){
		List<BoardVO> list;
		String statement = "BoardMapper.searchInfo";
		 Map<String, String> parameters = new HashMap<String, String>();
		 parameters.put("key", key);
		 parameters.put("searchType", searchType);
		list = session.selectList(statement, parameters);
		return list;

	}

	
	
}
