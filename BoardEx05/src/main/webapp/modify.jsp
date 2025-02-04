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

BoardDTO dto = new BoardDTO();
BoardVO  vo  = dto.Read(no, false);

if(!login.getUserid().equals(vo.getUserid()))
{
	response.sendRedirect("index.jsp");
	return;
}
%>
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<script>
	window.onload = function()
	{
		$("#title").focus()
		
		$("#sbmBtn").click(function(){
			doSubmit();
		});
		
		$("#cclBtn").click(function(){
			if(confirm("수정을 취소하시겠습니까?"))
			{
				document.location = "view.jsp?no=<%= no %>"
				return;
			}
		});
	}

	function Trim(obj)
	{
		let value = $(obj).val();
			value = value.trim();
		$(obj).val(value);
		return value;
	}

	function ValidCheck(tagID, msg)
	{
		if(Trim($("#" + tagID)) == "")
		{
			alert(msg + "을 입력하세요");
			$("#" + tagID).focus();
			return true;
		}
		else
			return false;
	}

	function doSubmit()
	{
		if(ValidCheck("title", "제목")) return;
		if(ValidCheck("note",  "내용")) return;
		
		if(confirm("완료하시겠습니까?"))
			$("#modify").submit();
		else
			return;
	}
</script>
<table border="0" style="width:100%;">
	<tr>
		<td style="height:40px">
			<span style="font-weight:bold; color:red;">※ 글수정</span>
		</td>
	</tr>
</table>
<form name="modify" id="modify" method="post" action="modifyok.jsp" enctype="multipart/form-data">
	<input type="hidden" name="no" value="<%= no %>">
	<table border="0" style="width: 100%; margin: 0px 0px 0px 0px; padding: 0px 0px 0px 0px; border: 1px;">
		<tr>
			<td
				style="width: 120px; text-align: center; background-color: #f4f4f4">제목</td>
			<td><input type="text" name="title" id="title" value="<%=vo.getTitle() %>" style="width: 95%"></td>
		</tr>
		<tr>
			<td
				style="width: 120px; text-align: center; background-color: #f4f4f4">구분</td>
			<td><input type="radio" id="kind" name="kind" <%= vo.getKind().equals("J") ? "checked" : "" %>>자바 학습 게시판
				<input type="radio" id="kind" name="kind" <%= vo.getKind().equals("H") ? "checked" : "" %>>HTML 학습 게시판</td>
		</tr>
		<tr>
			<td
				style="width: 120px; text-align: center; background-color: #f4f4f4">내용</td>
			<td><textarea name="note" id="note" style="width: 95%; height: 200px;"><%= vo.getNote() %></textarea></td>
		</tr>
		<tr>
			<td style="width:120px; text-align:center; background-color:#f4f4f4;" rowspan='2'>첨부파일</td>
			<td><input name="attach" type="file" style="width:95%"></td>
		</tr>
		<tr>
			<td>
				<%
				if(vo.getFname() == null)
				{
					%> 등록된 첨부파일이 없습니다. <%
				} else 
				{
					%> <a href='down.jsp?no=<%= no %>'><%= vo.getFname() %></a><%
				}
				%>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="height: 1px; background-color: #cccccc"></td>
		</tr>
		<tr>
			<td style="text-align: center;" colspan="2">
				<input type="button" id="sbmBtn" value="글수정 완료">
				<input type="button" id="cclBtn" value="글수정 취소">
			</td>
		</tr>
	</table>
</form>
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<%@ include file="./include/tail.jsp" %>