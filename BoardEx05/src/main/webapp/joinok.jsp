<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/head.jsp" %>
<%
//한글 인코딩 처리
request.setCharacterEncoding("utf-8");

String userid = request.getParameter("userid");
String userpw = request.getParameter("userpw");
String name   = request.getParameter("name");
String gender = request.getParameter("gender");
String hobby  = request.getParameter("hobby");
String fav[]  = request.getParameterValues("fav");

if(userid == null || userpw == null)
{
	response.sendRedirect("join.jsp");
	return;
}

UserVO vo = new UserVO();
vo.setUserid(userid);
vo.setUserpw(userpw);
vo.setName(name);
vo.setGender(gender);
vo.setHobby(hobby);
vo.setFav(fav);

UserDTO dto = new UserDTO();
if( dto.Join(vo) == true )
{
	//가입 성공시
	response.sendRedirect("login.jsp");
}else
{
	//가입 실패시
	response.sendRedirect("join.jsp");
}
%>
<%@ include file="./include/tail.jsp" %> 