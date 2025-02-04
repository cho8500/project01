package ezen.dto;

import java.util.ArrayList;

import ezen.dao.DbManager;
import ezen.vo.BoardVO;

/**
 * 클래스명 : BoardDTO
 * 작성자명 : Cho
 * 작성일자 : 2024.12.05
 * 기능설명 : reply 테이블의 정보를 관리하기 위한 클래스
 */
public class BoardDTO extends DbManager
{
	//게시물을 등록한다.
	//리턴값 : true - 등록성공, false - 등록실패	
	public boolean Insert(BoardVO vo)
	{
		this.driverLoad();
		this.dbConnect();
		
		String sql = ""; 
		sql += "insert into board ";
		sql += "(userid, title, kind, note, pname, fname) ";
		sql += "values ";
		sql += "('" + vo.getUserid() + "'";
		sql += ",'" + this._R(vo.getTitle())  + "'";
		sql += ",'" + vo.getKind()   + "'";
		sql += ",'" + this._R(vo.getNote())   + "'";
		if(vo.getFname() != null)
		{
			sql += ",'" + vo.getPname()          + "'";
			sql += ",'" + this._R(vo.getFname()) + "'";
		} else {
			sql += ",null";
			sql += ",null";
		}
			sql += ");";
		
		this.execute(sql);
		
		sql = "select last_insert_id() as no;";
		this.executeQuery(sql);
		this.next();
		vo.setNo(this.getString("no"));
		
		this.dbDisconnect();
		
		return true;
	}
	
	//게시물을 삭제한다.
	//리턴값 : true - 삭제성공, false - 삭제실패	
	public boolean Delete(String no)
	{
		this.driverLoad();
		this.dbConnect();
		
		String sql = "";
		sql = "delete from reply where no=" + no + ";";
		this.execute(sql);

		sql = "delete from board where no=" + no + ";";
		this.execute(sql);

		this.dbDisconnect();
		
		return true;
	}
	
	//게시물 정보를 변경한다.
	//리턴값 : true - 변경성공, false - 변경실패	
	public boolean Update(BoardVO vo)
	{
		this.driverLoad();
		this.dbConnect();

		String sql = "";
		sql += "update board set ";
		sql += "title = '" + this._R(vo.getTitle()) + "', ";
		sql += "kind  = '" + vo.getKind()         + "', ";
		sql += "note  = '" + this._R(vo.getNote())  + "', ";
		if(vo.getFname() != null)
		{
			sql += "pname = '" + vo.getPname() + "', ";
			sql += "fname = '" + vo.getFname() + "' ";
		} else {
			sql += "pname = null, ";
			sql += "fname = null ";
		}
		sql += "where no=" + vo.getNo() + ";";

		this.execute(sql);
		this.dbDisconnect();
		
		return true;
	}
	
	//게시물 정보를 조회한다.
	//ishit : true - 조회수를 증가, false - 조회수 증가 안함.
	public BoardVO Read(String no, boolean ishit)
	{
		BoardVO vo = new BoardVO();
		
		this.driverLoad();
		this.dbConnect();
		
		String sql = "";
		
		if(ishit)
		{
			sql = "update board set hit = hit + 1 where no=" + no + ";";
			this.execute(sql);
		}
		
		sql  = "select title, userid, date(wdate) as date, hit, kind, note, fname, ";
		sql += "(select name from user where userid = board.userid) as name ";
		sql += "from board ";
		sql += "where no='" + no + "';";

		this.executeQuery(sql);
		this.next();

		vo.setTitle (this.getString("title"));
		vo.setUname (this.getString("name"));
		vo.setUserid(this.getString("userid"));
		vo.setWdate (this.getString("date"));
		vo.setHit   (this.getString("hit"));
		vo.setKind  (this.getString("kind"));
		vo.setNote  (this.getString("note"));
		vo.setFname (this.getString("fname"));
		
		this.dbDisconnect();
		
		return vo;
	}
	
	//전체 게시물 갯수를 얻는다.
	//kind: 구분(J 또는 H)
	//리턴값 : 게시물의 갯수
	public int GetTotal(String kind)
	{
		this.driverLoad();
		this.dbConnect();
		
		String sql = "";
		sql += "select count(*) as total ";
		sql += "from board ";
		sql += "where kind='" + kind + "';";
		this.executeQuery(sql);
		this.next();
		
		int total = this.getInt("total");
		
		this.dbDisconnect();
		
		return total;
	}
	
	//게시물의 목록을 얻는다.
	//pageno : 페이지 번호
	//kind: 구분(J 또는 H)
	public ArrayList<BoardVO> GetList(int pageno,String kind)
	{
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
		
		int startNo = pageno - 1;
		
		this.driverLoad();
		this.dbConnect();
		
		String sql = "";
		
		sql += "select no, title, date(wdate) as wdate, hit, ";
		sql += "(select name from user where userid = board.userid) as name, ";
		sql += "(select count(*) from reply where no = board.no) as count ";
		sql += "from board ";
		sql += "where kind='" + kind + "' ";
		sql += "order by no desc ";
		sql += "limit " + startNo * 20  + ", 20;";

		this.executeQuery(sql);
		
		while(this.next())
		{
			BoardVO vo = new BoardVO();
			
			vo.setNo(this.getString("no"));
			vo.setTitle(this.getString("title"));
			vo.setWdate(this.getString("wdate"));
			vo.setHit(this.getString("hit"));
			vo.setUname(this.getString("name"));
			vo.setRcount(this.getString("count"));
			
			list.add(vo);
		}
		this.dbDisconnect();
		
		return list;
	}
	
}
