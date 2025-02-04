<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ezen.vo.*" %>
<%@ page import="ezen.dto.*" %>   
<%@ page import="java.io.*" %>
<%@ include file="./config/config.jsp" %>    
<%
//down.jsp?no=1
String no = request.getParameter("no");
if( no == null)
{
	response.sendRedirect("index.jsp");
	return;
}

BoardDTO dto = new BoardDTO();
BoardVO  vo = dto.Read(no, false);

String fullname = uploadPath + "\\" + vo.getPname();

System.out.print(fullname);


String enname = java.net.URLEncoder.encode(vo.getFname(), "UTF-8");
response.setContentType("application/octet-stream");   
response.setHeader("Content-Disposition","attachment; filename=" + enname + "");   

File file = new File(fullname);
FileInputStream fileIn = new FileInputStream(file);
ServletOutputStream ostream = response.getOutputStream();

byte[] outputByte = new byte[4096];
//copy binary contect to output stream
while(fileIn.read(outputByte, 0, 4096) != -1)
{
	ostream.write(outputByte, 0, 4096);
}
fileIn.close();
ostream.flush();
ostream.close();
%>