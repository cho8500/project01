<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/head.jsp" %>
<%
String no = request.getParameter("no");

if(no == null)
{
	response.sendRedirect("index.jsp");
	return;
}

int pageno = 1;
try 
{
	// index.jsp?page= 
	String curPage = request.getParameter("page");
	pageno = Integer.parseInt(curPage);
} catch(Exception e) {}

BoardDTO dto = new BoardDTO();
BoardVO  vo  = dto.Read(no, true);
%>
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<script src="./js/jquery-3.7.1.js"></script>
<script>
	$(document).ready(function(){
		loadReply();
	});
	
	function loadReply()
	{
		$.ajax({
			url  : "reply.jsp?no=<%= no %>",
			type : "get",
			success : function(result)
			{
				$("#replyList").html(result);
				$("#btnReply").click(function(){
					addReply();
				});
			}
		});
	}
	
	function addReply()
	{
		if($("#rnote").val() == "")
		{
			alert("댓글을 입력하세요");
			$("#rnote").focus();
			return;
		}
		
		$.ajax({
			url  : "addReply.jsp",
			type : "post",
			data :
			{
				no    : "<%= no %>",
				rnote : $("#rnote").val()
			},
			success : function(result)
			{
				result = result.trim();
				alert(result);
				loadReply();
			}
		});
	}
	
	function delReply(rno)
	{
		if(confirm("댓글을 삭제하시겠습니까?"))
		{
			$.ajax({
				url  : "delReply.jsp?rno=" + rno,
				type : "get",
				success : function(result)
				{
					result = result.trim();
					alert(result);
					loadReply();
				}
			});
		} else return;
	}
</script>
<table border="0" style="width:100%;">
	<tr>
		<td style="height:40px">
			<span style="font-weight:bold; color:red;">※ 글보기</span>
		</td>
	</tr>
</table>
<table border="1" style="width:100%;">
	<tr>
		<td style="background-color:#f4f4f4; width:120px;">제목</td>
		<td><%= WebUtil.replace(vo.getTitle()) %></td>
	</tr>
	<tr>
		<td style="background-color:#f4f4f4; width:120px;">작성자</td>
		<td><%= vo.getUname() %></td>
	</tr>
	<tr>
		<td style="background-color:#f4f4f4; width:120px;">작성일</td>
		<td><%= vo.getWdate() %></td>
	</tr>
	<tr>
		<td style="background-color:#f4f4f4; width:120px;">조회수</td>
		<td><%= vo.getHit() %></td>
	</tr>
	<tr>
		<td colspan="2">
			<%= WebUtil.replace(vo.getNote()) %>
		</td>
	</tr>	
	<tr>
		<td style="background-color:#f4f4f4; width:120px;">첨부파일</td>
		<td>
		<%
		if(vo.getFname() == null)
			{%> 등록된 첨부파일이 없습니다. <%}
		else
			{%><%= vo.getFname() %><%}%>
		</td>
	</tr>	
	<tr>
		<td colspan="2" align="center" style="height:40px;">
		<a href="index.jsp?kind=<%= vo.getKind()%>&page=<%= pageno %>">글목록</a>
		<%
		if(login != null && login.getUserid().equals(vo.getUserid()))
		{
			%>
			&nbsp;|&nbsp;
			<a href="modify.jsp?no=<%= no %>">글수정</a>
			&nbsp;|&nbsp;
			<a href="delete.jsp?no=<%= no %>">글삭제</a>
			<%
		}
		%>
		</td>
	</tr>
</table>
<br>
<span id="replyList"> 댓글 목록 표시 영역 </span>
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<%@ include file="./include/tail.jsp" %>