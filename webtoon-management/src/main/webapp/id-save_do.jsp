<%@ page contentType="text/html; charset=UTF-8" import="java.util.*, java.sql.*, beans.*, java.util.Calendar, java.text.SimpleDateFormat"%>
<%
	request.setCharacterEncoding("utf-8");
	int idx = Integer.parseInt(request.getParameter("idx"));
	String title = request.getParameter("posttitle");
	String pwd = request.getParameter("postpwd");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Calendar c1 = Calendar.getInstance();
	String strToday = sdf.format(c1.getTime());
	
	ServletContext context = getServletContext();
	String realFolder = context.getRealPath("images");
	
	Collection<Part> parts = request.getParts();
	MyMultiPart multiPart = new MyMultiPart(parts, realFolder);
	
	
	Class.forName("org.mariadb.jdbc.Driver");
	
	String DB_URL = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
	
	Connection con = DriverManager.getConnection(DB_URL, "admin", "1234");
	
	// 회차 정보 레코드에 등록하기
	String sql = "INSERT INTO subwebtoon(idx, title, date, coverimg, mainimg) VALUES(?,?,?,?,?)";
	
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, idx);
	pstmt.setString(2, title);
	pstmt.setString(3, strToday);
	pstmt.setString(4, multiPart.getSavedFileName("coverimg"));
	pstmt.setString(5, multiPart.getSavedFileName("mainimg"));
	pstmt.executeUpdate();
	
	pstmt.close();
	con.close();
	
%>

<script>
	location.href="ID-list.jsp?idx=<%=idx%>"
</script>