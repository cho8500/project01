<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/head.jsp" %>
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<table border="0" style="width:100%;">
	<tr>
		<td style="height:40px">
			<span style="font-weight:bold; color:red;">※ 로그인</span>
		</td>
	</tr>
</table>		
<script>
	window.onload = function()
	{
		$("#userid").focus();
		
		$("#btnLogin").click(function(){
			DoLogin();
		});
	}
	
	function DoLogin()
	{
		if( $("#userid").val() == "" )
		{
			$("#msg").html("아이디를 입력하세요.");
			$("#msg").css("color","red");
			$("#userid").focus();
			return;
		}
		if( $("#userpw").val() == "" )
		{
			$("#msg").html("비밀번호를 입력하세요.");
			$("#msg").css("color","red");
			$("#userpw").focus();
			return;
		}	
		$.ajax({
			url  : 'loginok.jsp',
			type : 'post',
			data : 
			{ 
				userid : $("#userid").val(), 
				userpw : $("#userpw").val() 
			},
			success : function(result){
				//앞뒤 공백 제거
				result = result.trim();
				if( result == "ERROR" )
				{
					$("#msg").html("아이디 또는 비밀번호가 일치하지 않습니다.");
					$("#msg").css("color","red");
					$("#userid").focus();					
				}else
				{
					document.location = "index.jsp";
				}
			}
		});			
	}
</script>
<table border="1" style="width:100%;">
	<tr>
		<td style="text-align:center;width:120px;">아이디 (*) </td>
		<td><input type="text" id="userid" name="userid"></td>
	</tr>
	<tr>
		<td style="text-align:center;width:120px;">비밀번호 (*) </td>
		<td><input type="password" id="userpw"  name="userpw"></td>
	</tr>
	<tr>
		<td id="msg" colspan="2" align="center">로그인 아이디와 비밀번호를 입력하세요.</td>		
	</tr>
	<tr>
		<td colspan="2" style="text-align:center;">
			<input id="btnLogin" type="button" value="로그인하기">
		</td>
	</tr>					
</table>
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<%@ include file="./include/tail.jsp" %>
