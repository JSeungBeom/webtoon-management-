<%@ page contentType="text/html; charset=UTF-8" import="java.sql.*, java.util.*, beans.*, java.io.*"%>
<%
request.setCharacterEncoding("utf-8");

String idx = request.getParameter("idx");

try{
	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL ="jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
	Connection con = DriverManager.getConnection(DB_URL, "admin", "1234");
	String sql = "";
	// 웹툰의 대표 이미지 삭제하기
	sql = "SELECT coverimg FROM mainwebtoon WHERE idx=?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	pstmt.setInt(1, Integer.parseInt(idx));
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	String filename = rs.getString("coverimg");
	
	ServletContext context = getServletContext();
	String realFolder = context.getRealPath("images");
	File file = new File(realFolder + File.separator + filename);
	file.delete();
	
	// 모든 회차의 이미지 삭제하기
	sql = "SELECT coverimg, mainimg FROM subwebtoon WHERE idx=?";
	pstmt = con.prepareStatement(sql);
	
	pstmt.setInt(1, Integer.parseInt(idx));
	rs = pstmt.executeQuery();
	while(rs.next()){
		filename = rs.getString("coverimg");
		file = new File(realFolder + File.separator + filename);
		file.delete();
		filename = rs.getString("mainimg");
		file = new File(realFolder + File.separator + filename);
		file.delete();
	}
	
	// 웹툰 DB에서 삭제하기
	sql = "DELETE FROM mainwebtoon WHERE idx=?";
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(idx));
	pstmt.executeUpdate();
	
	// 회차 DB에서 삭제하기
	sql = "DELETE FROM subwebtoon WHERE idx=?";
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(idx));
	pstmt.executeUpdate();
	
	pstmt.close();
	con.close();
	rs.close();
} catch(ClassNotFoundException e){
	out.print(e);
	return;
} catch(SQLException e){
	out.print(e);
	return;
} catch(Exception e){
	e.getMessage();
	return;
}

response.sendRedirect("index.jsp");
%>