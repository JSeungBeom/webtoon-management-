<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%
	ResultSet rs = null;

	request.setCharacterEncoding("utf-8");
	String idx = request.getParameter("idx");
	Class.forName("org.mariadb.jdbc.Driver");
	String DB_URL = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
	
	Connection con = DriverManager.getConnection(DB_URL, "admin", "1234");
	// idx와 일치하는 웹툰 레코드 가져오기
	String query = "SELECT * FROM mainwebtoon WHERE idx = ?";
	PreparedStatement pstmt = con.prepareStatement(query);
	pstmt.setInt(1, Integer.parseInt(idx));
	Statement stmt = con.createStatement();
	
	String sql = "SELECT name FROM genre";
	rs = stmt.executeQuery(sql);
	ResultSet mrs = pstmt.executeQuery();
	mrs.next();
	
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
	width:80%;
	height:300px;
}
.myclass1{
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
<script>
	window.onload = function(){
		document.getElementById("postfrm").onsubmit = function(){
			var str="";
			var obj = document.getElementById("posttitle");
			str += "타이틀 : " + obj.value +  "\n";
			
			obj = document.getElementById("postgenre");
			str += "장르 : " + obj.value + "\n";
			
			obj = document.getElementById("author");
			str += "작가 명 : " + obj.value + "\n";
			
			obj = document.getElementById("authorsay");
			str += "작가의 말 : " + obj.value + "\n";
			
			obj = document.getElementById("postimg");
			str += "이미지 명 : " + obj.value + "\n";
			
			obj = document.getElementById("postpwd");
			str += "비밀번호 : " + obj.value + "\n";
			
			obj = document.getElementById("postsummary");
			str += "줄거리 : " + obj.value + "\n";
			
			alert(str);
			return true;
		}
	}
</script>
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
<form action="modify_do.jsp?idx=<%=Integer.parseInt(idx)%>" method="post" name="postfrm" id = "postfrm" enctype="multipart/form-data">
	<table border="1">
		<tr>
			<th colspan="2" style="background-color:#e6faff;">글 쓰기</th>
		</tr>
		<tr>
			<td style="background-color:#e6faff;">타이틀</td>
			<td><input type="text" name="posttitle" id="posttitle" value="<%=mrs.getString("title")%>" required></td>
		</tr>
		<tr>
			<td style="background-color:#e6faff;">장르</td>
			<td>
				<select name="postgenre" id = "postgenre" style="width:100%">
					<optgroup label="장르">
					<%while(rs.next()){ %>
						<option value=<%=rs.getString("name")%>><%=rs.getString("name")%></option>
					<%} %>
					</optgroup>
				</select>
			</td>
		</tr>
		<tr>
			<td style="background-color:#e6faff;">작가 명</td>
			<td><input type="text" id="author" name="author" value="<%=mrs.getString("author") %>" required></td>
		</tr>
		<tr>
			<td style="background-color:#e6faff;">작가의 말</td>
			<td><input type="text" id="authorsay" name="authorsay"  value="<%=mrs.getString("authorsay")%>"required></td>
		</tr>
	</table>
	<div class="myclass2">
		줄거리
	</div>
		<!-- 비밀번호 입력 -->
	<div class="myclass2" style="position:absolute; right:19%">
		비밀번호 <input type="password" name="postpwd" id = "postpwd" required>
	</div>
	<!-- 만화 영역 -->
	<div id="container1">
		<textarea rows="20" style="width:100%; font-family:굴림체, serif" name = "postsummary" id = "postsummary" required><%=mrs.getString("summary") %></textarea>
	</div>
	<!-- 이미지 업로드 -->
<div class="myclass1">
		<img src="./images/<%=mrs.getString("coverimg")%>" height="200px" width="200px"><br>	
		<input style = "position:absolute; bottom:0px;" 
		type="file" id = "coverimg" name="coverimg" value="업로드/변경">
</div>
	<!-- 등록 & 취소 -->
		<input type="submit" name="postconfirm" value="등록" style="margin-top:5px;">
		<input type="reset" name="postcancel" value="취소" style="margin-top:5px;">
</form>
</article>
</body>
</html>