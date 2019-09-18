package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.CommentVO;

@Repository
public class CommentDAO {
	@Autowired
	SqlSession session=null;
	
	public boolean insertReply(CommentVO vo){
		boolean result = true;
		if(session.insert("CommentMapper.insertReply", vo)!=1) {
			result = false;
		}
		return result;
	}
	public List<CommentVO> listComments(String bid){
		List<CommentVO> list = null;
		list = session.selectList("CommentMapper.listComments",bid);
		return list;
	}
}
