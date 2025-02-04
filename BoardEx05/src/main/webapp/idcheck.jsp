<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.dao.*" %>
<%@ page import="ezen.dto.*" %>
<%@ page import="ezen.vo.*" %>     
<%
String userid = request.getParameter("id");

//UserDTO를 이용해서 중복 검사한다.
UserDTO dto = new UserDTO();
if( dto.CheckID(userid) == true )
{
	out.println("DUPLICATE");
}else
{
	out.println("NOT_DUPLICATE");
}
%>    
