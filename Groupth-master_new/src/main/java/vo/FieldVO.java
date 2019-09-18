package vo;

public class FieldVO {
	private int fid;
	private String type;
	public int getFid() {
		return fid;
	}
	@Override
	public String toString() {
		return "FieldVO [fid=" + fid + ", type=" + type + "]";
	}
	public void setFid(int fid) {
		this.fid = fid;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
}
