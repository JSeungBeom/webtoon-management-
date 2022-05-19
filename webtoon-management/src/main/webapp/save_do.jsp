<%@ page contentType="text/html; charset=UTF-8" import="java.sql.*, 
java.util.Calendar, java.text.SimpleDateFormat"%>
<%
request.setCharacterEncoding("utf-8");

String title = request.getParameter("posttitle");
String genre = request.getParameter("postgenre");
String author = request.getParameter("author");
String authorsay = request.getParameter("authorsay");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Calendar c1 = Calendar.getInstance();
String strToday = sdf.format(c1.getTime());
String pwd = request.getParameter("postpwd");
String summary = request.getParameter("postsummary");

try {
	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL ="jdbc:mariadb://localhost:3306/webtoon?useSSL=false";

	Connection con = DriverManager.getConnection(DB_URL, "admin", "1234");   
	
	String sql = "INSERT INTO mainwebtoon(title, genre, author, authorsay, summary, date, password)VALUES(?, ?, ?, ?, ?, ?, ?)";
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	pstmt.setString(1, title);
	pstmt.setString(2, genre);
	pstmt.setString(3, author);
	pstmt.setString(4, authorsay);
	pstmt.setString(5, summary);
	pstmt.setString(6, strToday);
	pstmt.setString(7, pwd);

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

response.sendRedirect("index.jsp");
%>