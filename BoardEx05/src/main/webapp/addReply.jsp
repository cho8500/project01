<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.dao.*" %>
<%@ page import="ezen.dto.*" %>
<%@ page import="ezen.vo.*" %>
<%
UserVO login = (UserVO)session.getAttribute("login");

request.setCharacterEncoding("utf-8");

String no    = request.getParameter("no");
String rnote = request.getParameter("rnote");

if(login == null || no == null || rnote == null)
{
	response.sendRedirect("index.jsp");
	return;
}

ReplyVO vo = new ReplyVO();
vo.setNo(no);
vo.setRnote(rnote);
vo.setUserid(login.getUserid());

ReplyDTO dto = new ReplyDTO();
dto.Insert(vo);
%>
댓글 등록이 완료되었습니다.