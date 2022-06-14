<%@ page contentType="text/html; charset=UTF-8" import="java.sql.*, java.util.*, java.io.*"
import="java.text.SimpleDateFormat, beans.*"%>
<%
	request.setCharacterEncoding("utf-8");
	String idx = request.getParameter("idx");
	String title = request.getParameter("posttitle");
	String genre = request.getParameter("postgenre");
	String author = request.getParameter("author");
	String authorsay = request.getParameter("authorsay");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Calendar c1 = Calendar.getInstance();
	String strToday = sdf.format(c1.getTime());
	String pwd = request.getParameter("postpwd");
	String summary = request.getParameter("postsummary");
	
	ServletContext context = getServletContext();
	String realFolder = context.getRealPath("images");
	
	Collection<Part>parts = request.getParts();
	MyMultiPart multiPart = new MyMultiPart(parts, realFolder);

try{
	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
	
	Connection con = DriverManager.getConnection(DB_URL, "admin", "1234");
	
	String sql = "";
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	if(multiPart.getMyPart("coverimg") != null) { 
		sql = "SELECT coverimg FROM mainwebtoon WHERE idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, Integer.parseInt(idx));
		rs = pstmt.executeQuery();
		rs.next();
		String oldFileName = rs.getString("coverimg");
		File oldFile = new File(realFolder + File.separator + oldFileName);
		oldFile.delete();
		
		sql = "UPDATE mainwebtoon SET title=?, genre=?, author=?, authorsay=?, summary=?, date=?, password=?, coverimg=? WHERE idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, genre);
		pstmt.setString(3, author);
		pstmt.setString(4, authorsay);
		pstmt.setString(5, summary);
		pstmt.setString(6, strToday);
		pstmt.setString(7, pwd);
		pstmt.setString(8, multiPart.getSavedFileName("coverimg"));
		pstmt.setInt(9, Integer.parseInt(idx));
		
	} else {
		sql = "UPDATE mainwebtoon SET title=?, genre=?, author=?, authorsay=?, summary=?, date=?, password=? WHERE idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, genre);
		pstmt.setString(3, author);
		pstmt.setString(4, authorsay);
		pstmt.setString(5, summary);
		pstmt.setString(6, strToday);
		pstmt.setString(7, pwd);
		pstmt.setInt(8, Integer.parseInt(idx));
	}

	pstmt.executeUpdate();
	
	pstmt.close();
	con.close();
} catch(SQLException e){
	out.print(e);
	return;
}

response.sendRedirect("index.jsp");
%>