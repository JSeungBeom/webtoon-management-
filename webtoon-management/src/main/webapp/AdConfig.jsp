
<%@ page contentType="text/html; charset=UTF-8" import="java.sql.*"%>
<%
	request.setCharacterEncoding("utf-8");
	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
	
	try{
	Connection con = DriverManager.getConnection(DB_URL, "admin", "1234");
	Statement stmt = con.createStatement();
	
	String sql = "SELECT idx, id, name, birth FROM genre";
	
	ResultSet rs = stmt.executeQuery(sql);

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
	left:20px;
	display:table-cell;
	width:80%;
	height:800px;
	border:1px solid black;
	border-radius:5px;
	background-color:#e6faff;
}
table{
	background-color:white;
	position:relative;
	margin:50px;
	border-collapse:collapse;
	width:75%;
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
	width:155px;
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
	<div id="manage">
		<a href="./AdConfig.jsp">카테고리 관리</a>
	</div>
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
<%if(session.getAttribute("id") == null) {%>
	<!-- 로그인 --> 
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
	<ul>
		<li><a href="./index.jsp">전체 보기</a></li>
	</ul>
</nav>
<article>
<!-- 등록 버튼 -->
<div id="insert" style="background-color:white; border-radius:5px;"><a href="./AdInput.jsp" target="_blank">등록하기</a></div>
<!--  카테고리 -->
<table border="1" style="border-collapse:collapse;">
	<tr>
		<th>No</th>
		<th>ID</th>
		<th>이름</th>
		<th>생성일자</th>
		<th></th>
		<th></th>
	</tr>
<%while(rs.next()){ %>
	<tr>
		<td><%=rs.getInt("idx")%></td>
		<td><%=rs.getString("id")%></td>
		<td><%=rs.getString("name")%></td>
		<td><%=rs.getDate("birth")%></td>
		<td><input type="button" value="수정" onclick="location.href='AdModify.jsp?idx=<%=rs.getInt("idx")%>'"></td>
		<td><input type="button" value="삭제" onclick="location.href='cate_delete_do.jsp?idx=<%=rs.getInt("idx")%>'"></td>
	</tr>
<%} %>
</table>
</article>
<%
	rs.close();
	stmt.close();
	con.close();
	}
	catch(SQLException e){
		out.print(e);
	}
%>