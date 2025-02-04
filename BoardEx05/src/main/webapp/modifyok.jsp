<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="ezen.dto.BoardDTO"%>
<%@ page import="ezen.vo.BoardVO"%>
<%@ page import="ezen.vo.UserVO"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<%@ include file="./config/config.jsp" %>
<%
// 로그인 정보 받기
UserVO login = (UserVO)session.getAttribute("login");

/* 업로드 처리 */
// 업로드 파일 사이즈 지정
int size = 10 * 1024 * 1024;

// 파라미터로 받을 수 있도록 객체 생성
MultipartRequest multi = null;

try
{
	multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
} catch(Exception e) {
	response.sendRedirect("index.jsp");
	return;
}

String no    = multi.getParameter("no");
String title = multi.getParameter("title");
String kind  = multi.getParameter("kind");
String note  = multi.getParameter("note");

if(login == null || no == null)
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

vo.setNo(no);
vo.setTitle(title);
vo.setKind(kind);
vo.setNote(note);

// 업로드 된 첨부파일 불러오기
String filename = (String)multi.getFilesystemName("attach");
String phyname  = null;

// 저장된 파일명을 암호화
if(filename != null)
{
	phyname = UUID.randomUUID().toString();
	String srcName    = uploadPath + "/" + filename;
	String targetName = uploadPath + "/" + phyname;
	
	File srcFile      = new File(srcName);
	File targetFile   = new File(targetName);
	srcFile.renameTo(targetFile);
}

dto.Update(vo);
%>
<script>
	alert('게시글 수정이 완료되었습니다.')
	document.location = 'view.jsp?no=<%= no %>';
</script>