<%@ page contentType="text/html; charset=UTF-8" import="java.sql.*, 
java.util.Calendar, java.text.SimpleDateFormat"%>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("cateid");
String name = request.getParameter("catename");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Calendar c1 = Calendar.getInstance();
String birth = sdf.format(c1.getTime());

try {
	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL ="jdbc:mariadb://localhost:3306/webtoon?useSSL=false";

	Connection con = DriverManager.getConnection(DB_URL, "admin", "1234");   
	
	// 장르 카테고리에 추가하기
	String sql = "INSERT INTO genre(id, name, birth)VALUES(?, ?, ?)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	pstmt.setString(1, id);
	pstmt.setString(2, name);
	pstmt.setString(3, birth);
	pstmt.executeUpdate();
	
	pstmt.close();
	con.close();
}catch(ClassNotFoundException e) {
	out.print(e);
	return;
}catch(SQLException e) {
	out.print(e);
	return;
}

response.sendRedirect("AdConfig.jsp");
%>