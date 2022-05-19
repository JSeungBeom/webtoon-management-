<%@ page contentType="text/html; charset=UTF-8" import="java.sql.*"%>
<%
request.setCharacterEncoding("utf-8");

String idx = request.getParameter("idx");

try{
	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL ="jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
	Connection con = DriverManager.getConnection(DB_URL, "admin", "1234");
	String sql = "DELETE FROM mainwebtoon WHERE idx=?";
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	pstmt.setInt(1, Integer.parseInt(idx));
	pstmt.executeUpdate();
	
	pstmt.close();
	con.close();
} catch(ClassNotFoundException e){
	out.print(e);
	return;
} catch(SQLException e){
	out.print(e);
	return;
}

response.sendRedirect("index.jsp");
%>