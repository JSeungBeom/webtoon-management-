<%@ page contentType="text/html; charset=utf-8" import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
	
	String DB_USER = "admin";
	String DB_PASSWORD= "1234";
	
	Connection con= null;
	Statement stmt = null;
	ResultSet rs   = null;
	
	try {
	    con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD); 

	    stmt = con.createStatement();

	    
	    String query = "SELECT idx, title, genre, author, authorsay, date, summary FROM mainwebtoon"; 
		String ctquery = "SELECT name FROM genre";
	    rs = stmt.executeQuery(query);
		ResultSet ctrs = stmt.executeQuery(ctquery);
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
	left:50px;
	display:table-cell;
	width:80%;
	height:800px;
	border:1px solid black;
	border-radius:5px;
	background-color:#e6faff;
}

#insert{
	background-color:lightgray;
	position:absolute;
	top:5px;
	right:5px;
	border:3px solid black;
	width:5%;
	text-align:center;
}
input{
	font-family:"굴림", serif;
}
fieldset{
	display:table-cell;
	width:155px;
}
tr td{
	width:200px;
}
</style>
</head>
<body>
<!-- 머리글 영역 -->
<header>
	<!-- 홈 -->
	<img src="./images/home.png" alt="홈으로" usemap="#tohome">
	<map name="tohome">
		<area shape="rect" coords="0, 0, 57, 52" alt="홈으로" href="./index.jsp">
	</map>
	<!-- 카테고리 관리 -->
	<%if(session.getAttribute("id") == null) {%>
	<div id="manage" style="visibility:hidden;">
		<a href="./AdConfig.jsp">카테고리 관리</a>
	</div>
	<%} else{ %>
	<div id="manage">
		<a href="./AdConfig.jsp">카테고리 관리</a>
	</div>
	<%} %>
	<div id="title">
		Webtoon World
	</div>
	<!-- 검색 -->
	<input type="text" name="search">
	<img src="./images/search.png" alt="검색">
</header>

<!-- 로그인 & 메뉴 -->
<nav style="padding:0px;">
	<!-- 로그인 --> 
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
	<!-- 메뉴 -->
	<ul>
		<li><a href="./index.jsp">전체 보기</a></li>
		<%while(ctrs.next()){ %>
		<li><a><%=ctrs.getString("name") %></a></li>
		<%} %>
	</ul>
</nav>
<!-- 글 영역 -->
<article>
	<!-- 등록 버튼 -->
	<div id="insert" style="background-color:white; border-radius:5px;"><a href="./Input1.jsp" target="_blank">등록하기</a></div>
	<!-- 웹툰 목록 출력 -->
	<%
		while(rs.next()){
			String dtitle = rs.getString("title");
			String dgenre = rs.getString("genre");
			String dauthor = rs.getString("author");
			String dauthorsay = rs.getString("authorsay");
			String dsummary = rs.getString("summary");
	%>
	<div style = "margin:50px; display:inline;">
		<table border="1" style="border-collapse:collapse; background-color:white;">
			<tr>
				<td colspan="2" style="height:200px;" onclick="location.href='ID-list.jsp?title=<%=dtitle%>&genre=<%=dgenre%>&author=<%=dauthor%>&authorsay=<%=dauthorsay%>&summary=<%=dsummary%>'">
				</td>
			</tr>
			<tr>
				<th>타이틀</th>
				<td><%=dtitle%></td>
			</tr>
			<tr>
				<th>장르</th>
				<td><%=dgenre%></td>
			</tr>
			<tr>
				<th>작가명</th>
				<td><%=dauthor%></td>
			</tr>
			<tr>
				<th>게시일</th>
				<td><%=rs.getDate("date")%></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:right;">
				<input type="button" value="수정" onclick="location.href = 'modify.jsp?idx=<%=rs.getInt("idx")%>'">
				<input type="button" value="삭제" onclick="location.href = 'delete_do.jsp?idx=<%=rs.getInt("idx")%>'">
				</td>
			</tr>
		</table>
	</div>
	<%
		rs.close();
		stmt.close();
		con.close();
	}
	} catch(SQLException e){
		out.println("err:"+e.toString());
		return;
	}
	%>
</article>
</body>
</html>