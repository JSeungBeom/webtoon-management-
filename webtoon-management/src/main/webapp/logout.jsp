<%@ page contentType="text/html; charset=UTF-8"%>
<%
// 세션 해제 (로그아웃)
session.invalidate();
response.sendRedirect("index.jsp");
%>