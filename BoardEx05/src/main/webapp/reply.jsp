<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.dao.*" %>
<%@ page import="ezen.dto.*" %>
<%@ page import="ezen.vo.*" %>
<%@ page import="java.util.*" %>
<%
UserVO login = (UserVO)session.getAttribute("login");
String no    = request.getParameter("no");

ReplyDTO dto = new ReplyDTO();
ArrayList<ReplyVO> list = dto.GetList(no);
%>
<table border="1" style="width:100%">
	<%
	if(login != null)
	{
		%>
		<tr>
			<td width="110px"><%= login.getName() %></td>
			<td><input type="text" id="rnote" name="rnote" style="width:95%"></td>
			<td width="110px" align="center">
				<input type="button" id="btnReply" value="작성완료">
			</td> 
		</tr>
		<%
	}
	for(ReplyVO vo : list)
	{
		%>
		<tr>
			<td width="110px"><%= vo.getRname() %></td>
			<td><%= vo.getRnote() %>
			<%
			if(login != null && login.getUserid().equals(vo.getUserid()))
			{
				%>
				[ <a href="javascript:delReply('<%= vo.getRno() %>')">삭제</a> ]
				<%
			}
			%>
			</td>
			<td width="110px" align="center"><%= vo.getRwdate() %></td>
		</tr>
		<%
	}
	%>
</table>