package vo;

public class Group_InfoVO {
	private int gid;
	private String g_name;
	private int fid;
	private String leader; 
	private String g_content;
	private int limit_mem;
	private int count_mem;
	public int getCount_mem() {
		return count_mem;
	}
	public void setCount_mem(int count_mem) {
		this.count_mem = count_mem;
	}
	private String img;
	private String type;
	public int getGid() {
		return gid;
	}
	public void setGid(int gid) {
		this.gid = gid;
	}
	public String getG_name() {
		return g_name;
	}
	public void setG_name(String g_name) {
		this.g_name = g_name;
	}
	public int getFid() {
		return fid;
	}
	public void setFid(int fid) {
		this.fid = fid;
	}
	public String getLeader() {
		return leader;
	}
	public void setLeader(String leader) {
		this.leader = leader;
	}
	public String getG_content() {
		return g_content;
	}
	public void setG_content(String g_content) {
		this.g_content = g_content;
	}
	public int getLimit_mem() {
		return limit_mem;
	}
	public void setLimit_mem(int limit_mem) {
		this.limit_mem = limit_mem;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
}
