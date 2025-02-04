<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/head.jsp" %>
<%
if(login == null)
{
	response.sendRedirect("index.jsp");
	return;
}

String kind = request.getParameter("kind");
if(kind == null || (!kind.equals("J") && !kind.equals("H"))) { kind = "J"; }
%>
<script>
$(document).ready(function(){
	$("#title").focus();
	
	$("#btnOK").click(function(){
		doSubmit();
	});
});

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
		$("#write").submit();
	else
		return;
}
</script>

<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<table border="0" style="width:100%;">
	<tr>
		<td style="height:40px">
			<span style="font-weight:bold; color:red;">※ 글쓰기</span>
		</td>
	</tr>
</table>
<form name="write" id="write" method="post" action="writeok.jsp" enctype="multipart/form-data">
<table border="0" style="width:100%; margin:0px 0px 0px 0px;padding:0px 0px 0px 0px ; border: 1px;">
	<tr>
		<td style="width:120px; text-align:center; background-color:#f4f4f4">제목</td>
		<td><input type="text" name="title" id="title" style="width:95%"></td>
	</tr>
	<tr>
		<td style="width:120px; text-align:center; background-color:#f4f4f4">구분</td>
		<td>
			<input type="radio" name="kind" id="kind" value="J" <%= kind.equals("J") ? "checked" : "" %>>자바 학습 게시판
			<input type="radio" name="kind" id="kind" value="H" <%= kind.equals("H") ? "checked" : "" %>>HTML 학습 게시판
		</td>
	</tr>
	<tr>
		<td style="width:120px; text-align:center; background-color:#f4f4f4">내용</td>
		<td><textarea name="note" id="note" style="width:95%; height:200px;"></textarea></td>
	</tr>
	<tr>
		<td style="width:120px; text-align:center; background-color:#f4f4f4">첨부파일</td>
		<td><input name="attach" id="attach" type="file" style="width:95%"></td>
	</tr>
	<tr>
		<td colspan="2" style="height:1px;background-color:#cccccc"></td>
	</tr>
	<tr>
		<td style="text-align:center;" colspan="2">
			<input type="button" id="btnOK" value="글쓰기 완료">
		</td>
	</tr>
</table>					
</form>			
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<%@ include file="./include/tail.jsp" %>  