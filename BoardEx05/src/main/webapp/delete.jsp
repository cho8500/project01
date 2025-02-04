<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="ezen.dto.BoardDTO"%>
<%@page import="ezen.vo.BoardVO"%>
<%@page import="ezen.vo.UserVO"%>
<%
UserVO login = (UserVO)session.getAttribute("login");

String no = request.getParameter("no");
if(login == null || no == null)
{
	response.sendRedirect("index.jsp");
	return;
}

BoardVO  vo  = new BoardVO();
BoardDTO dto = new BoardDTO();

vo = dto.Read(no, false);

if(!vo.getUserid().equals(login.getUserid()))
{
	response.sendRedirect("index.jsp");
	return;
}

dto.Delete(no);

response.sendRedirect("index.jsp");
%>