package ezen.vo;

//클래스명 : UserVO
//작성자명 : 홍길동
//작성일자 : 2024.12.05
//기능설명 : 테이블 user 정보를 관리하기 위한 클래스
public class UserVO 
{
	private String userid;   // 아이디
	private String userpw;   // 비밀번호
	private String name;     // 이름
	private String gender;   // 성별
	private String hobby;    // 취미
	private String fav;      // 관심분야
	private String retire;   // 탈퇴여부
	private String joindate; // 가입일자
	
	public String getUserid()   { return userid;   }
	public String getUserpw()   { return userpw;   }
	public String getName()     { return name;	   }
	public String getGender()   { return gender;   }
	public String getHobby()    { return hobby;	   }
	public String getFav()      { return fav;	   }
	public String getRetire()   { return retire;   }
	public String getJoindate() { return joindate; }
	
	public void setUserid(String userid)     { this.userid = userid; }
	public void setUserpw(String userpw)     { this.userpw = userpw; }
	public void setName(String name)         { this.name = name;	 }
	public void setGender(String gender)     { this.gender = gender; }
	public void setHobby(String hobby)       { this.hobby = hobby;	 }
	public void setFav(String fav)           { this.fav = fav;	     }
	public void setRetire(String retire)     { this.retire = retire; }
	public void setJoindate(String joindate) { this.joindate = joindate; }
	public void setFav(String fav[])           
	{
		this.fav = "";
		for(String f : fav)
		{
			if(!this.fav.equals("")) this.fav  += ",";
			this.fav += f;
		}
		
	}
	
}
