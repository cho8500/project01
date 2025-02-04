<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="./include/head.jsp" %>
<%
String kind = request.getParameter("kind");
if(kind == null || (!kind.equals("J") && !kind.equals("H"))) { kind = "J"; }

// 확장성을 고려한 코드; 게시판을 추가하기 용이함
String subject = "";
switch(kind)
{
	case "J" : subject = "자바";  break;
	case "H" : subject = "HTML"; break;
}

BoardDTO dto = new BoardDTO();

int pageno = 1;

try 
{
	// index.jsp?page= 
	String curPage = request.getParameter("page");
	pageno = Integer.parseInt(curPage);
} catch(Exception e) {}

int total = dto.GetTotal(kind);
ArrayList<BoardVO> list = dto.GetList(pageno, kind);
%>
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<table border="0" style="width:100%;">
	<tr>
		<td style="height:40px">
			<span style="font-weight:bold; color:red;">※ <%= subject %> 학습 게시판</span>
		</td>
	</tr>
	<tr>
		<td style="height:25px; text-align:right;">
			<%
			if(login != null)
			{
				%>
				<a href="write.jsp?kind=<%= kind %>">글쓰기</a>
				<%
			}
			%>
		</td>
	</tr>
	<tr>
		<td>
			<table border="0" style="width:100%;">
				<tr>
					<td style="text-align:center; background-color:#f2f2f2; width: 60px;">번호</td>
					<td style="text-align:center; background-color:#f2f2f2;">제목</td>
					<td style="text-align:center; background-color:#f2f2f2;width: 100px;">작성일</td>
					<td style="text-align:center; background-color:#f2f2f2;width: 80px;">작성자</td>
					<td style="text-align:center; background-color:#f2f2f2;width: 70px;">조회수</td>
				</tr>
				<%
				int seqNo = total - (pageno - 1) * 20;
				for(BoardVO vo : list)
				{
					%>
					<tr>
						<td style="text-align:center;"><%= seqNo-- %></td>
						<td><a href="view.jsp?no=<%= vo.getNo() %>&page=<%= pageno %>"><%=vo.getTitle() %></a>
							<%
							if(!vo.getRcount().equals("0"))
							{
								%>
								<span style="color:#ff6600">(<%= vo.getRcount() %>)</span>
								<%
							}
							%>
						</td>
						<td style="text-align:center;"><%= vo.getWdate() %></td>
						<td style="text-align:center;"><%= vo.getUname() %></td>
						<td style="text-align:center;"><%= vo.getHit() %></td>
					</tr>
					<%
				}
				%>
			</table>							
		</td>
	</tr>
	<tr>
		<td style="text-align:center;">
		<%
			int maxPage = total / 20;
			if(total % 20 != 0) maxPage++;
			int startBlock = (pageno - 1) / 10 * 10 + 1;		// (pageNo-1) - ((pageNo-1) % 10) + 1;
			int endBlock   = (pageno - 1) / 10 * 10 + 10;		// (startBlock + 10) - 1;
			if(endBlock > maxPage) endBlock = maxPage;
			
			if(pageno > 1)
			{%>
				<a href='index.jsp?page=<%= 1 %>&kind=<%= kind %>'>처음으로</a> 
				<a href='index.jsp?page=<%= pageno - 1 %>&kind=<%= kind %>'>◀</a>
			<%}
			for(int i=startBlock; i <= endBlock; i++)
			{
				if(i == pageno)
				{%>
				 	<a href='index.jsp?page=<%= i %>&kind=<%= kind %>'><span style='color:red;'><b><%= i %></b></span></a> 
				<%} else {%>
				 	<a href='index.jsp?page=<%= i %>&kind=<%= kind %>'><%= i %></a> 
				<%}
			}
			if(pageno < maxPage) {%>
				<a href='index.jsp?page=<%= pageno + 1 %>&kind=<%= kind %>'>▶</a> 
				<a href='index.jsp?page=<%= maxPage %>&kind=<%= kind %>'>끝으로</a>
			<%}
			%>
		</td>
	</tr>												
</table>
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<%@ include file="./include/tail.jsp" %>
