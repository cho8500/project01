package ezen.dto;

import java.util.ArrayList;

import ezen.dao.DbManager;
import ezen.vo.ReplyVO;

/**
 * 클래스명 : ReplyDTO
 * 작성자명 : Cho
 * 작성일자 : 2024.12.05
 * 기능설명 : reply 테이블의 정보를 관리하기 위한 클래스
 */
public class ReplyDTO extends DbManager
{
	public boolean Insert(ReplyVO vo)
	{
		this.driverLoad();
		this.dbConnect();
		
		String sql = "";
		sql += "insert into reply (no,rnote,userid) ";
		sql += "values ( ";
		sql += "'" + vo.getNo() + "', ";
		sql += "'" + vo.getRnote() + "', ";
		sql += "'" + vo.getUserid() + "' ";
		sql += ") ";
		this.execute(sql);
		
		this.dbDisconnect();
		
		return true;
	}
	
	public boolean Delete(String rno)
	{
		this.driverLoad();
		this.dbConnect();
		
		String sql = "";
		sql = "delete from reply where reply_no = " + rno;
		this.execute(sql);
		
		this.dbDisconnect();		
		return true;
	}
	
	public ArrayList<ReplyVO> GetList(String no)
	{
		ArrayList<ReplyVO> list = new ArrayList<ReplyVO>();
		
		this.driverLoad();
		this.dbConnect();
		
		String sql = "";
		sql  = "select reply_no as rno, rnote, date(rdate) as rwdate, userid, ";
		sql += "(select name from user where userid = reply.userid) as name ";
		sql += "from reply ";
		sql += "where no = " + no + " ";
		sql += "order by rno desc ";
		
		this.executeQuery(sql);
		
		while(this.next())
		{
			ReplyVO vo = new ReplyVO();
			
			vo.setRno   (this.getString("rno"));
			vo.setRnote (this.getString("rnote"));
			vo.setRwdate(this.getString("rwdate"));
			vo.setRname (this.getString("name"));
			vo.setUserid(this.getString("userid"));
			
			list.add(vo);
		}
		this.dbDisconnect();
		
		return list;
	}
}
