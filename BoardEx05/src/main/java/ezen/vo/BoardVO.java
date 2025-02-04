package ezen.vo;
//클래스명 : UserVO
//작성자명 : 홍길동
//작성일자 : 2024.12.05
//기능설명 : 테이블 board 정보를 관리하기 위한 클래스
public class BoardVO 
{
	private String no;     //게시물 번호
	private String userid; //아이디
	private String title;  //제목
	private String kind;   //구분
	private String note;   //내용
	private String pname;  //물리파일명
	private String fname;  //논리파일명
	private String wdate;  //작성일
	private String hit;    //조회수
	
	//추가항목
	private String rcount;  //댓글갯수
	private String uname;   //작성자명
	
	public String getNo()     { return no;	    }
	public String getUserid() { return userid;	}
	public String getTitle()  { return title;	}
	public String getKind()   { return kind;	}
	public String getNote()   { return note;	}
	public String getPname()  { return pname;	}
	public String getFname()  { return fname;	}
	public String getWdate()  { return wdate;	}
	public String getHit()    { return hit;	    }
	public String getRcount() { return rcount;	}
	public String getUname()  { return uname;	}
	
	public void setNo(String no)         { this.no = no;	     }
	public void setUserid(String userid) { this.userid = userid; }
	public void setTitle(String title)   { this.title = title;	 }
	public void setKind(String kind)     { this.kind = kind;	 }
	public void setNote(String note)     { this.note = note;	 }
	public void setPname(String pname)   { this.pname = pname;	 }
	public void setFname(String fname)   { this.fname = fname;	 }
	public void setWdate(String wdate)   { this.wdate = wdate;	 }
	public void setHit(String hit)       { this.hit = hit;	     }
	public void setRcount(String rcount) { this.rcount = rcount; }
	public void setUname(String uname)   { this.uname = uname;	 }
		
	
}
