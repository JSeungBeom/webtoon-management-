<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String pwd = request.getParameter("pwd");

if(id.equals("admin") && pwd.equals("1234")){
	session.setAttribute("id", id);
	response.sendRedirect("index.jsp");
} else {
	out.println("<script>alert('아이디와 비밀번호를 확인하세요.');history.back();</script>");
}
%>