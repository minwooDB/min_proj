package vo;

public class NoticeVO {
	private int nid;
	private int gid;
	private String writer;
	private String title;
	private String content;
	private String writedate;
	private String files;
	
	@Override
	public String toString() {
		return "NoticeVO [nid=" + nid + ", gid=" + gid + ", writer=" + writer + ", title=" + title + ", content="
				+ content + ", writedate=" + writedate + ", files=" + files + "]";
	}
	public int getNid() {
		return nid;
	}
	public void setNid(int nid) {
		this.nid = nid;
	}
	public int getGid() {
		return gid;
	}
	public void setGid(int gid) {
		this.gid = gid;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getWritedate() {
		return writedate;
	}
	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}
	public String getFiles() {
		return files;
	}
	public void setFiles(String files) {
		this.files = files;
	}
	
}
