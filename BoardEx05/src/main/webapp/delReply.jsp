<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.dao.*" %>
<%@ page import="ezen.dto.*" %>
<%@ page import="ezen.vo.*" %>
<%
String rno = request.getParameter("rno");

ReplyDTO dto = new ReplyDTO();
dto.Delete(rno);
%>
댓글이 삭제되었습니다.