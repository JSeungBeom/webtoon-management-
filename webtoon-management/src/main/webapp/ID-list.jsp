<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String pgenre = request.getParameter("postgenre");
	String ptitle = request.getParameter("posttitle");
	String pauthor = request.getParameter("author");
	String pauthorsay = request.getParameter("authorsay");
	String psummary = request.getParameter("postsummary");
%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID-list</title>
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
	position:absolute;
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
	<input type="text" name="search">
	<img src="./images/search.png" alt="검색">
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
	<div id="insert" style="background-color:white; border-radius:5px;"><a href="./Input1.html" target="_blank">등록하기</a></div>
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
		<input style = "position:absolute; bottom:0px;" 
		type="file" accept="image/jpg, image/gif" id = "postimg" name="postimg" value="업로드/변경" disabled>
</div>
</article>
</body>
</html>