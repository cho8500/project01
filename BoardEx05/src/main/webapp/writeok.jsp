<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="ezen.dao.*" %>
<%@ page import="ezen.dto.*" %>
<%@ page import="ezen.vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>

<%@ include file="./include/head.jsp" %>
<%@ include file="./config/config.jsp" %>
<%
/* 업로드 처리 */
	// 업로드 파일 사이즈 지정
	int size = 10 * 1024 * 1024;
	
	// 파라미터로 받을 수 있도록 객체 생성
	MultipartRequest multi = null;
	
	try
	{
		multi = new MultipartRequest(request, uploadPath, size, "UTF-8", new DefaultFileRenamePolicy());
	} catch(Exception e) {
		response.sendRedirect("write.jsp");
		return;
	}
	
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

// 글쓰기에서 작성한 데이터 받기; title, kind, note
// 폼 데이터 형식에 따라 기존에 쓰던 request에서 multi로 바뀌었음에 유의***
String title = multi.getParameter("title");
String kind  = multi.getParameter("kind");
String note  = multi.getParameter("note");

BoardVO vo = new BoardVO();
		vo.setUserid(login.getUserid());
		vo.setTitle(title);
		vo.setKind(kind);
		vo.setNote(note);
		vo.setFname(filename);
		vo.setPname(phyname);

BoardDTO dto = new BoardDTO();
		 dto.Insert(vo);

response.sendRedirect("view.jsp?no=" + vo.getNo());
%>