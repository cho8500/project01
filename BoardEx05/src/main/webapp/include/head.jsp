<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.dao.*" %>
<%@ page import="ezen.dto.*" %>
<%@ page import="ezen.vo.*" %>    
<%@ page import="ezen.util.*" %>
<%
UserVO login = (UserVO)session.getAttribute("login");
%>
<!DOCTYPE html>
<html>
	<head>	
		<meta charset="utf-8">
		<title>자바 학습 커뮤니티</title>
		<link rel="stylesheet" href="./style/board.css"/>
		<script src="./js/jquery-3.7.1.js"></script>
	</head>
	<body>
		<table border="1" width="900px" align="center">
			<tr>
				<td colspan="3" style="height:60px;">
					<table border="0" style="width:100%; height:60px;">
						<tr>
							<td>
								<a href="index.jsp">
								<span style="color:red; font-size:15pt; font-weight:bold;">
								자바학습 커뮤니티
								</span>
								</a>
							</td>
							<td style="text-align:right;">
							<%
							if(login == null)
							{
								%>
								<a href="join.jsp">회원가입</a>
								&nbsp;&nbsp;
								<a href="login.jsp">로그인</a>
								&nbsp;
								<%
							}else
							{
								%>
								[ <%= login.getName() %> ]님
								&nbsp;&nbsp;
								<a href="logout.jsp">로그아웃</a>
								&nbsp;
								<%
							}
							%>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td style="width:200px" valign="top">
					<div class="submenu"><a href="index.jsp?kind=J">자바 학습 게시판</a></div>
					<div style="height:2px; background-color:#ffffff;"></div>
					<div class="submenu"><a href="index.jsp?kind=H">HTML학습 게시판</a></div>
				</td>
				<td style="width:5px"></td>
				<td>