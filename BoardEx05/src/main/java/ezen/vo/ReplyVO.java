package ezen.vo;
//클래스명 : UserVO
//작성자명 : 홍길동
//작성일자 : 2024.12.05
//기능설명 : 테이블 reply 정보를 관리하기 위한 클래스
public class ReplyVO 
{
	private String rno;     //댓글번호
	private String no;      //게시물번호
	private String rnote;   //댓글내용
	private String rwdate;  //댓글작성일
	private String userid;  //댓글작성자아이디
	
	//추가항목
	private String rname;   //댓글작성자 이름

	public String getRno()    { return rno;	   }
	public String getNo()     { return no;	   }
	public String getRnote()  { return rnote;  }
	public String getRwdate() { return rwdate; }
	public String getUserid() { return userid; }
	public String getRname()  { return rname;  }

	public void setRno(String rno)       { this.rno = rno;	      }
	public void setNo(String no)         { this.no = no;	      }
	public void setRnote(String rnote)   { this.rnote = rnote;	  }
	public void setRwdate(String rwdate) { this.rwdate = rwdate;  }
	public void setUserid(String userid) { this.userid = userid;  }
	public void setRname(String rname)   { this.rname = rname;    }
	
}
