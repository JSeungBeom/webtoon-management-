
<%@ page contentType="text/html; charset=UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Webtoon World</title>
 <link rel="stylesheet" type="text/css" href="./basic.css">
<style>
input{
	font-family:"굴림", serif;
}
td input[type="text"]{
	width:90%;
}
article{
	position:relative;
	display:table-cell;
	width:80%;
	border-radius:5px;
	padding-left:50px;
}
table{
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
	<!-- 메뉴 -->
	<ul>
		<li><a href="./index.jsp">전체 보기</a></li>
	</ul>
</nav>
<article>
<!--  카테고리 -->
<form action="cate_save_do.jsp" method="post" name="cateframe" id="cateframe">
	<table border="1" style="border-collapse:collapse;">
		<tr>
			<th>카테고리 ID</th>
			<td><input type="text" name="cateid" id="cateid"></td>
		</tr>
		<tr>
			<th>카테고리 제목</th>
			<td><input type="text" name="catename" id="catename"></td>
		</tr>
		<tr>
		<td colspan="2" style="text-align:right;">
				<input type="submit" value="등록">
				<input type="reset" value="취소">
		</tr>
	</table>
</form>
</article>