<%@ page contentType="text/html; charset=UTF-8" import="java.sql.*, java.util.*, java.io.*"
import="java.text.SimpleDateFormat, beans.*"%>
<%
	request.setCharacterEncoding("utf-8");
	int idx = Integer.parseInt(request.getParameter("idx"));
	int subidx = Integer.parseInt(request.getParameter("subidx"));
	String title = request.getParameter("posttitle");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Calendar c1 = Calendar.getInstance();
	String strToday = sdf.format(c1.getTime());
	String pwd = request.getParameter("postpwd");

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
	
	// 대표 이미지와 본문 이미지 모두 변경 시
	if(multiPart.getMyPart("coverimg") != null && multiPart.getMyPart("mainimg") != null) { 

		sql = "SELECT coverimg, mainimg FROM subwebtoon WHERE subidx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, subidx);
		rs = pstmt.executeQuery();
		rs.next();
		String oldFileName = rs.getString("coverimg");
		File oldFile = new File(realFolder + File.separator + oldFileName);
		oldFile.delete();
		
		oldFileName = rs.getString("mainimg");
		oldFile = new File(realFolder + File.separator + oldFileName);
		oldFile.delete();
		
		sql = "UPDATE subwebtoon SET title=?, date=?, coverimg=?, mainimg=? WHERE subidx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, strToday);
		pstmt.setString(3, multiPart.getSavedFileName("coverimg"));
		pstmt.setString(4, multiPart.getSavedFileName("mainimg"));
		pstmt.setInt(5, subidx);
		
	} else if(multiPart.getMyPart("coverimg") != null){  // 대표 이미지만 변경 시
		sql = "SELECT coverimg FROM subwebtoon WHERE subidx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, subidx);
		rs = pstmt.executeQuery();
		rs.next();
		String oldFileName = rs.getString("coverimg");
		File oldFile = new File(realFolder + File.separator + oldFileName);
		oldFile.delete();
		
		sql = "UPDATE subwebtoon SET title=?, date=?, coverimg=? WHERE subidx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, strToday);
		pstmt.setString(3, multiPart.getSavedFileName("coverimg"));
		pstmt.setInt(4, subidx);
	} else if(multiPart.getMyPart("mainimg") != null){ // 본문 이미지만 변경 시
		
		sql = "SELECT mainimg FROM subwebtoon WHERE subidx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, subidx);
		rs = pstmt.executeQuery();
		rs.next();
		String oldFileName = rs.getString("mainimg");
		File oldFile = new File(realFolder + File.separator + oldFileName);
		oldFile.delete();
		
		sql = "UPDATE subwebtoon SET title=?, date=?, mainimg=? WHERE subidx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, strToday);
		pstmt.setString(3, multiPart.getSavedFileName("mainimg"));
		pstmt.setInt(4, subidx);
	}
	else{ // 이미지 변경 없을 시
		sql = "UPDATE subwebtoon SET title=?, date=? WHERE subidx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, title);
		pstmt.setString(2, strToday);
		pstmt.setInt(3, subidx);
	}

	pstmt.executeUpdate();
	
	pstmt.close();
	con.close();
} catch(SQLException e){
	out.print(e);
	return;
}
%>
<script>
	location.href="ID-list.jsp?idx=<%=idx%>"
</script>