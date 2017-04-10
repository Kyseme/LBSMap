package gis.damin;

public class Gis {
	private Integer gid;
	private String gname;
	private String gtel;
	private String point;
	private String des;

	public Integer getGid() {
		return gid;
	}
	public void setGid(Integer gid) {
		this.gid = gid;
	}
	
	public String getGname() {
		return gname;
	}
	public void setGname(String gname) {
		this.gname = gname;
	}
	public String getGtel() {
		return gtel;
	}
	public void setGtel(String gtel) {
		this.gtel = gtel;
	}
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}
	public String getDes() {
		return des;
	}
	public void setDes(String des) {
		this.des = des;
	}
	@Override
	public String toString() {
		return "Gis [des=" + des + ", gid=" + gid + ", gname=" + gname
				+ ", gtel=" + gtel + ", point=" + point + "]";
	}
	
	
	
	

}
