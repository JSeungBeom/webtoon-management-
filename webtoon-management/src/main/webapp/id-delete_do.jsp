<%@ page contentType="text/html; charset=UTF-8" import="java.sql.*, java.util.*, beans.*, java.io.*"%>
<%
request.setCharacterEncoding("utf-8");

String subidx = request.getParameter("subidx");
int idx = Integer.parseInt(request.getParameter("idx"));
try{
	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL ="jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
	Connection con = DriverManager.getConnection(DB_URL, "admin", "1234");
	String sql = "";
	// 회차의 대표 이미지와, 본문 이미지 삭제
	sql = "SELECT idx, coverimg, mainimg FROM subwebtoon WHERE subidx=?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	pstmt.setInt(1, Integer.parseInt(subidx));
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	
	String filename = rs.getString("coverimg");
	
	ServletContext context = getServletContext();
	String realFolder = context.getRealPath("images");
	File file = new File(realFolder + File.separator + filename);
	file.delete();
	
	filename = rs.getString("mainimg");
		file = new File(realFolder + File.separator + filename);
	file.delete();
	
	// 회차 정보 DB에서 삭제
	sql = "DELETE FROM subwebtoon WHERE subidx=?";
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, Integer.parseInt(subidx));
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
%>
<script>
	location.href = "ID-list.jsp?idx=<%=idx%>"
</script>