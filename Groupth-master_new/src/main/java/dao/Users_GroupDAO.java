package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.GroupVO;
import vo.UsersVO;

@Repository
public class Users_GroupDAO {
	@Autowired
	SqlSession session = null;

	public boolean applyGroup(String uid, int gid) {
		boolean result = true;
		int num = 0;
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("users_id", uid);
		parameters.put("gid", String.valueOf(gid));
		num = session.selectOne("TempMemMapper.checkUser", parameters);
		if (num == 0) {
			if (session.insert("TempMemMapper.applyUser", parameters) != 1) {
				result = false;
			}
		} else {
			result = false;
		}
		return result;
	}

	public List<UsersVO> tempMember(int gid) {
		List<UsersVO> list;
		list = session.selectList("TempMemMapper.listTempMember", gid);
		return list;
	}

	public List<UsersVO> currentMember(int gid) {
		List<UsersVO> list;
		list = session.selectList("TempMemMapper.listCurrentMember", gid);
		return list;
	}

	public boolean statusJoin(String users_id, int gid) {
		boolean result = false;
		int num = 0;
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("users_id", users_id);
		parameters.put("gid", String.valueOf(gid));
		num = session.selectOne("TempMemMapper.statusJoin", parameters);
		if (num != 0)
			result = true;
		return result;
	}

	public boolean acceptMember(int gid, String users_id) {
		boolean result = true;
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("users_id", users_id);
		parameters.put("gid", String.valueOf(gid));
		if (session.update("TempMemMapper.acceptMember", parameters) != 1) {
			result = false;
		}
		if (session.update("GroupMapper.countAddMember", gid) != 1) {
			result = false;
		}
		return result;
	}

	public boolean rejectMember(int gid, String users_id) {
		boolean result = true;
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("users_id", users_id);
		parameters.put("gid", String.valueOf(gid));
		if (session.delete("TempMemMapper.rejectMember", parameters) != 1) {
			result = false;
		}
		return result;
	}
	public boolean dropMember(int gid, String users_id) {
		boolean result = true;
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("users_id", users_id);
		parameters.put("gid", String.valueOf(gid));
		if (session.delete("TempMemMapper.rejectMember", parameters) != 1) {
			result = false;
		}
		if (session.update("GroupMapper.countRemoveMember", gid) != 1) {
			result = false;
		}
		return result;
	}
	public List<GroupVO> myGroup(String idVal){
		List<GroupVO> glist=null;
		Map<String, String> parameters = new HashMap<String, String>();
		parameters.put("idVal", idVal);
		parameters.put("leader", "leader");
		parameters.put("accept", "accept");
		glist = session.selectList("UsersMapper.myGroup", parameters);
		return glist;
	}
}
