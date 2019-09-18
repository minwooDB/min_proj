package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.GroupVO;
import vo.Group_InfoVO;

@Repository
public class GroupDAO {
	@Autowired
	SqlSession session=null;
	
	public List<Group_InfoVO> popularGroup(){
		List<Group_InfoVO> list;
		
		list = session.selectList("GroupMapper.popularGroup");
		return list;
	}
	
	public boolean create(GroupVO vo) {
		boolean result =true;
		if(session.insert("GroupMapper.insertGroup",vo)!=1) {
			System.out.println("group table 삽입 에러");
			result=false;
		}
		int gid = vo.getGid();
		System.out.println(vo.getGid());
		 Map<String, String> parameters = new HashMap<String, String>();
		 parameters.put("gid", String.valueOf(vo.getGid()));
		 parameters.put("leader", vo.getLeader());
		if(session.insert("GroupMapper.insertUserGroupLeader",parameters)!=1) {
			System.out.println("user_group table 삽입 에러");
			result=false;
		}
		return result;
	}
	
	public List<Group_InfoVO> ListAllGroup(){
		List<Group_InfoVO> list =null;
		String statement = "GroupMapper.ListAllGroup"; 
		list=session.selectList(statement);
		return list;
	}
	public List<Group_InfoVO> search(String key, String field){
		List<Group_InfoVO> list;
		if(key==null) {
			list=session.selectList("GroupMapper.searchField", field);
		}
		else {
			if(field==null) {
				list=session.selectList("GroupMapper.searchNonField", key);
			}
			else {
				Map<String, String> parameters = new HashMap<String, String>();
				parameters.put("key", key);
				parameters.put("field", field);
				list = session.selectList("GroupMapper.searchInfo", parameters);
			}
		}
		return list;
	} 
	
	public Group_InfoVO showContent(int gid) {
		Group_InfoVO vo= null;
		String statement="GroupMapper.showContent";
		vo=session.selectOne(statement,gid);
		session.update("GroupMapper.showContentUpdateCount",gid);
		return vo;
	}
	
	public boolean deleteGroup(int gid) {
		boolean result=true;
		if(session.delete("GroupMapper.deleteGroup",gid)!=1) {
			result=false;
		}
		return result;
	}
	
	public int storeLocation(int gid, String lat,String lng,String location) {
		Map<String, String> parameters = new HashMap<String, String>();
		 parameters.put("gid", String.valueOf(gid));
		 parameters.put("lat", lat);
		 parameters.put("lng", lng);
		 parameters.put("location", location);
		return session.update("GroupMapper.storeLocation",parameters);
	}
	
	public GroupVO findLoc(int gid) {
		GroupVO vo = null;
		vo= session.selectOne("GroupMapper.findLoc",gid);
		return vo;
	}
}
