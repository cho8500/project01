<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./include/head.jsp" %>
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<script>

//아이디 중복 여부 확인용
isDuplicate = false;

window.onload = function()
{
	$("#userid").focus();
	
	$("#userid").keyup(function(){
		CheckUserID();		
	});
	
	$("#btnCancel").click(function(){
		if(confirm("회원 가입을 취소하시겠습니까?") == true)
		{
			document.location = "index.jsp";
		}
	});
	
	$("#btnOK").click(function(){
		DoSubmit();
	});
}


function CheckUserID()
{
	userid = $("#userid").val();
	//띄어쓰기 제거
	userid = userid.replace(" ","");		
	$("#userid").val(userid);
	if(userid == "")
	{
		$("#msg").html("아이디를 입력하세요.");
		return;	
	}
	isDuplicate = false;
		
	//아이디 중복 여부를 ajax로 검사한다.
	$.ajax({
		url  : 'idcheck.jsp',
		type : 'post',
		data : { id : userid },
		success : function(result){
			//앞뒤 공백 제거 
			result = result.trim();
			if(result == "DUPLICATE")
			{
				$("#msg").html("중복된 아이디 입니다.");
				$("#msg").css("color","red");
				isDuplicate = true;
			}else
			{
				$("#msg").html("사용가능한 아이디 입니다.");
				$("#msg").css("color","blue");
				isDuplicate = false;
			}
		}
	});	
}


function DoSubmit()
{
	if(isDuplicate == true)
	{
		alert("중복된 회원아이디입니다. 다른 아이디를 입력하세요.");
		$("#userid").focus();
		return;		
	}
	if( $("#userid").val() == "" )
	{
		alert("아이디를 입력하세요.");
		$("#userid").focus();
		return;
	}
	if( $("#userpw").val() == "" )
	{
		alert("비밀번호를 입력하세요.");
		$("#userpw").focus();
		return;
	}
	if( $("#userpw").val() != $("#pwcheck").val() )
	{
		alert("비밀번호가 일치하지 않습니다.");
		$("#userpw").focus();
		return;
	}
	if( $("#name").val() == "" )
	{
		alert("이름을 입력하세요.");
		$("#name").focus();
		return;
	}
	if( $("#sign").val() == "" )
	{
		alert("자동가입 방지코드를 입력하세요.");
		$("#sign").focus();
		return;
	}	
	
	//자동가입 방지 코드일치 여부를 ajax로 검사한다.
	$.ajax({
		url : 'answer.jsp',
		type : 'get',
		success : function(result){
			//앞뒤 공백 제거 
			result = result.trim();
			if($("#sign").val() != result)
			{
				alert("자동가입 방지 코드가 일치하지 않습니다.");
				$("#sign").focus();
			}else
			{
				if(confirm("회원가입을 진행하시겠습니까?") == true)
				{
					//document.join.submit();
					$("#join").submit();
				}
			}
		}
	});		
}

</script>
<form id="join" name="join" method="post" action="joinok.jsp">
	<table border="0" style="width:100%;">
		<tr>
			<td style="height:40px">
				<span style="font-weight:bold; color:red;">※ 회원가입</span>
			</td>
		</tr>																		
	</table>
	<table border="1" style="width:100%;">
		<tr>
			<td style="width:130px;">아이디 (*)</td>
			<td><input type="text" id="userid" name="userid" placeholder="아이디는 영문자로만 입력하세요." style="width:95%">
				<span id="msg">아이디를 입력하세요.</span></td>
		</tr>
		<tr>
			<td>비밀번호 (*)</td>
			<td><input type="password" id="userpw" name="userpw"  style="width:95%"></td>
		</tr>
		<tr>
			<td>비밀번호 확인 (*)</td>
			<td><input type="password" id="pwcheck" name="pwcheck" style="width:95%"></td>
		</tr>			
		<tr>
			<td>이름 (*)</td>
			<td><input type="text" id="name" name="name"  style="width:95%"></td>
		</tr>		
		<tr>
			<td>성별 (*)</td>
			<td>
				<input type="radio" id="gender" name="gender" value="M" checked>남자
				<input type="radio" id="gender" name="gender" value="F" >여자
			</td>
		</tr>		
		<tr>
			<td>취미 (*)</td>
			<td>
				<select id="hobby" name="hobby" >
					<option value="1">낚시</option>
					<option value="2">여행</option>
					<option value="3" selected>게임</option>
				</select>
			</td>
		</tr>		
		<tr>
			<td>관심분야</td>
			<td>
				<input type="checkbox" value="1" id="fav" name="fav"  checked>책
				<input type="checkbox" value="2" id="fav" name="fav">영화					
			</td>
		</tr>
		<tr>
			<td>자동가입방지</td>
			<td>
				<img src="img.jsp">
				<input type="text" id="sign" name="sign" size="6">						
			</td>
		</tr>		
		<tr>
			<td colspan="2" style="text-align:center;">
				<input id="btnOK" type="button" value="가입완료">
				<input id="btnCancel" type="button" value="취소">
			</td>							
		</tr>																															
	</table>
</form>
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<%@ include file="./include/tail.jsp" %>  