<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.dao.*" %>
<%@ page import="ezen.dto.*" %>
<%@ page import="ezen.vo.*" %>    
<%
String userid = request.getParameter("userid");
String userpw = request.getParameter("userpw");

//로그인 처리
UserDTO dto = new UserDTO();
UserVO  vo  = dto.Login(userid, userpw);
if( vo == null )
{
	//아이디/비번 틀림
	out.println("ERROR");
}else
{
	session.setAttribute("login", vo);
	out.println("OK");
}
%>
