package vo;

public class GroupVO {
	private int gid;
	private String g_name;
	private int fid;
	private String leader; 
	private String g_content;
	private int limit_mem;
	private String img;
	private int count_mem;
	private String lat;
	private String lng;
	private String location;
	
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
	public int getCount_mem() {
		return count_mem;
	}
	public void setCount_mem(int count_mem) {
		this.count_mem = count_mem;
	}
	
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	@Override
	public String toString() {
		return "GroupVO [gid=" + gid + ", g_name=" + g_name + ", fid=" + fid + ", leader=" + leader + ", g_content="
				+ g_content + ", limit_mem=" + limit_mem + ", img=" + img + ", count_mem=" + count_mem + ", lat=" + lat
				+ ", lng=" + lng + ", location=" + location + "]";
	}
	
	
	
	
}
