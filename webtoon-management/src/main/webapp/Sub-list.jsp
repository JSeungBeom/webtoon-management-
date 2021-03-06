<%@ page contentType="text/html; charset=UTF-8" import="java.util.*, java.sql.*, beans.*"%>
<%
	request.setCharacterEncoding("utf-8");
	int subidx = Integer.parseInt(request.getParameter("subidx"));
	int idx = Integer.parseInt(request.getParameter("idx"));
	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
	
	Connection con = DriverManager.getConnection(DB_URL, "admin", "1234");
	
	// subidx와 일치하는 회차 레코드 가져오기
	String sql = "SELECT * FROM subwebtoon WHERE subidx=?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, subidx);
	
	ResultSet rs = pstmt.executeQuery();
	rs.next();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Webtoon World</title>
<link rel="stylesheet" type="text/css" href="./basic.css">
<style>
article{
	position:relative;
	display:table-cell;
	width:80%;
	border-radius:5px;
	padding-left:50px;
}
table{
	top:0px;
	border-collapse:collapse;
	width:75%;
}
input{
	font-family:"굴림", serif;
}
td input[type="text"]{
	width:90%;
}
#container1{
	text-align:center;
	width:80%;
	border:1px solid black;
}
.myclass1{
	text-align:center;
	position:absolute;
	top:0px;
	right:30px;
	width:15%;
	height:250px;
	border:1px solid black;
}
.myclass2{
	margin-top:10px;
	display:inline-block;
	text-align:center;
	border:1px solid black;
}
option{
	font-family:"굴림";
	font-weight:bold;
}
fieldset{
	width:155px;
}
</style>
</head>
<body>
<!-- 머리글 영역 -->	
<header>
	<!-- 홈 버튼 -->
	<img src="./images/home.png" alt="홈으로" usemap="#tohome">
	<map name="tohome">
		<area shape="rect" coords="0, 0, 57, 52" alt="홈으로" href="./index.jsp">
	</map>
	<!-- 카테고리 관리 버튼 -->
	<%if(session.getAttribute("id") == null) {%>
	<div id="manage" style="visibility:hidden;">
		<a href="./AdConfig.jsp">카테고리 관리</a>
	</div>
	<%} else{ %>
	<div id="manage">
		<a href="./AdConfig.jsp">카테고리 관리</a>
	</div>
	<%} %>
	<!-- 제목 -->
	<div id="title">
		Webtoon World
	</div>
	<!-- 검색 -->
	<form action="search.jsp" method="get" style="display:inline;">
		<select name="type" id = "type" style="width:5%;">
			<option value="작가명">작가명</option>
			<option value="제목">제목</option>
		</select>
		<input type="text" name="search" style="margin-left:0px;">
		<input type="image" src="./images/search.png" alt="검색">
	</form>	
</header>
<!-- 로그인 & 메뉴 -->
<nav>
	<!-- 로그인-->
	<%if(session.getAttribute("id") == null) {%>
	<form action="member_ok.jsp" method="post" name="login">
		<fieldset>
			<legend>Login</legend>
			ID<br>
			<input type="text"name="id"><br>
			Password<br>
			<input type="password" name="pwd"><br>
			<input type="submit" name="loginconfirm" value = "확인">
		</fieldset>
	</form>
	<%} else { %>
		<fieldset style="text-align:center; height:120px;">
			<a href="logout.jsp" style="color:red;"><br><br><br>
			Admin Logout</a>
		</fieldset>
	<% } %>
</nav>
<!-- 글 영역 -->
<article>
<!-- 글 쓰기 -->
<input type="text" name="idx" id="idx" value=<%=idx %> style="visibility:hidden;">
	<table border="1">
		<tr>
			<th colspan="2" style="background-color:#e6faff;">회차 정보</th>
		</tr>
		<tr>
			<td style="background-color:#e6faff;">타이틀</td>
			<td><input type="text" name="posttitle" id="posttitle" value="<%=rs.getString("title")%>" disabled></td>
		</tr>
	</table>
	<div class="myclass2">
	</div>
	<!-- 만화 영역 -->
	<div id="container1">
		<img src="./images/<%=rs.getString("mainimg")%>">
	</div>
	<!-- 이미지 업로드 -->
<div class="myclass1">
		<img src="./images/<%=rs.getString("coverimg")%>" height="200px"><br>
</div>
</article>
</body>
</html>