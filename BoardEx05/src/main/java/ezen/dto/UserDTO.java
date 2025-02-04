package ezen.dto;

import ezen.dao.DbManager;
import ezen.vo.UserVO;

/**
 * 클래스명 : UserDTO
 * 작성자명 : Cho
 * 작성일자 : 2024.12.05
 * 기능설명 : reply 테이블의 정보를 관리하기 위한 클래스
 */
public class UserDTO extends DbManager
{
	//아이디 중복 검사
	//리턴값 : true - 중복된 ID, false - 중복이 안된 ID
	public boolean CheckID(String userid)
	{
		boolean flag = true;
		
		this.driverLoad();
		this.dbConnect();
		
		String sql = "";
		sql += "select userid ";
		sql += "from user ";
		sql += "where userid = '" + userid + "' ";
		
		this.executeQuery(sql);
		
		if(this.next() == true)
		{
			//중복된 아이디임.
			flag = true;
		}else
		{
			//중복된 아이디가 없음
			flag = false;
		}
		
		this.dbDisconnect();
		return flag;
	}
	
	//회원 가입 처리
	//리턴값 : true - 가입성공, false - 가입실패	
	public boolean Join(UserVO vo)
	{
		if(CheckID(vo.getUserid()) == true)
		{
			return false;
		}
		
		this.driverLoad();
		this.dbConnect();
		
		String sql  = "";
		sql += "insert into user (userid,userpw,name,gender,hobby,fav) ";
		sql += "values(";
		sql += "'" + _R(vo.getUserid()) + "',";
		sql += "md5('" + _R(vo.getUserpw()) + "'),";
		sql += "'" + _R(vo.getName())   + "',";
		sql += "'" + _R(vo.getGender()) + "',";
		sql += "'" + _R(vo.getHobby())  + "',";
		sql += "'" + _R(vo.getFav())    + "'";
		sql += ")";
		this.execute(sql);
		
		this.dbDisconnect();
		return true;
	}
	
	//로그인 처리
	//리턴값 : null 이면 로그인 실패 아니면 회원정보를 담은 VO
	public UserVO Login(String userid,String userpw)
	{
		this.driverLoad();
		this.dbConnect();
		
		String sql = "";
		sql += "select * "; 
		sql += "from user "; 
		sql += "where userid = '" + userid + "' "; 
		sql += "and userpw = md5('" + userpw + "') ";
		sql += "and retire = 'N' ";
		this.executeQuery(sql);
		if(this.next() == false)
		{
			//로그인 정보가 없음
			this.dbDisconnect();
			return null;			
		}
		UserVO vo = new UserVO();
		vo.setUserid(this.getString("userid"));
		vo.setName(this.getString("name"));
		
		this.dbDisconnect();
		return vo;
	}
}
