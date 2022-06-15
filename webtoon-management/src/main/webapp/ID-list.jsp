<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import = "java.sql.*, java.util.*, beans.*"%>
<%
	request.setCharacterEncoding("utf-8");
	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL ="jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
	Connection con = DriverManager.getConnection(DB_URL, "admin", "1234");
	int idx = Integer.parseInt(request.getParameter("idx"));
	
	// idx와 일치하는 웹툰 레코드 가져오기
	String sql = "SELECT * FROM mainwebtoon WHERE idx=?";
	PreparedStatement pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, idx);
	ResultSet rs = pstmt.executeQuery();
	rs.next();
	
	String pgenre = rs.getString("genre");
	String ptitle = rs.getString("title");
	String pauthor = rs.getString("author");
	String pauthorsay = rs.getString("authorsay");
	String psummary = rs.getString("summary");
	String coverimg = rs.getString("coverimg");
	
	// idx와 일치하는 회차 레코드 가져오기
	sql = "SELECT * FROM subwebtoon WHERE idx=?";
	pstmt = con.prepareStatement(sql);
	pstmt.setInt(1, idx);
	rs = pstmt.executeQuery();
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
.myclass1{
	background-color:white;
	display:table-cell;
	position:absolute;
	top:30px;
	right:30px;
	width:15%;
	height:250px;
	border:1px solid black;
}
input{
	font-family:"굴림", serif;
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
td input[type="text"]{
	width:90%;
}
table{
	background-color:white;
	top:0px;
	border-collapse:collapse;
	width:75%;
}
fieldset{
	width:155px;
}
</style>
<script>
window.onload = function(){
	document.getElementById("postgenre").selectedIndex = <%=pgenre%>;
}
</script>
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
</nav>
<!-- 글 영역 -->
<article>
	<!-- 등록 버튼 -->
	<div id="insert" style="background-color:white; border-radius:5px; display:table-cell;"><a href="./Input2.jsp?idx=<%=idx%>" target="_blank">등록하기</a></div>
	<table border="1">
		<tr>
			<th colspan="2" style="background-color:#e6faff;">요약 정보</th>
		</tr>
		<tr>
			<td style="background-color:#e6faff;">타이틀</td>
			<td><input type="text" name="posttitle" id="posttitle" readonly value= <%=ptitle%>></td>
		</tr>
		<tr>
			<td style="background-color:#e6faff;">장르</td>
			<td>
				<select name="postgenre" id = "postgenre" style="width:100%" disabled>
					<optgroup label="장르">
						<option value="액션">액션</option>
						<option value="로맨스">로맨스</option>
						<option value="SF">SF</option>
						<option value="코믹">코믹</option>
					</optgroup>
				</select>
			</td>
		</tr>
		<tr>
			<td style="background-color:#e6faff;">작가 명</td>
			<td><input type="text" id="author" name="author" readonly value = <%=pauthor%>></td>
		</tr>
		<tr>
			<td style="background-color:#e6faff;">작가의 말</td>
			<td><input type="text" id="authorsay" name="authorsay" readonly value = <%=pauthorsay%>></td>
		</tr>
		<tr>
			<td style = "background-color:#e6faff;">줄거리</td>
			<td><textarea rows="10" style="width:99%; font-family:굴림체, serif" name = "postsummary" id = "postsummary" disabled><%=psummary%></textarea></td>
		</tr>
	</table>
	<!-- 이미지 업로드 -->
<div class="myclass1">
		<img src="./images/<%=coverimg%>" height="200px" width="200px"><br>
		<input style = "position:absolute; bottom:0px;" 
		type="file" accept="image/jpg, image/gif" id = "postimg" name="postimg" value="업로드/변경" disabled>
</div>
	<%
		int count = 0;
		while(rs.next()){
		count++;
	%>
	<div style = "margin:50px; display:inline-block; position:relative;">
		<table border="1" style="border-collapse:collapse; background-color:white; position:static;">
			<tr>
				<td colspan="2">
				<img src="./images/<%=rs.getString("coverimg")%>">
				</td>
			</tr>
			<tr>
				<th>타이틀</th>
				<td><%=rs.getString("title")%></td>
			</tr>
			<tr>
				<th>게시일</th>
				<td><%=rs.getDate("date")%></td>
			</tr>
			<tr>
				<th colspan="2"><%=count%>화</th>
			</tr>
			<tr>
				<td colspan="2" style="text-align:right;">
				<input type="button" value="수정" onclick="location.href = 'id-modify.jsp?subidx=<%=rs.getInt("subidx")%>&idx=<%=idx%>'">
				<input type="button" value="삭제" onclick="location.href = 'id-delete_do.jsp?subidx=<%=rs.getInt("subidx")%>&idx=<%=idx%>'">
				</td>
			</tr>
		</table>
	</div>
<%
		}
%>
</article>
</body>
</html>