<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
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
		<li><a>액션</a></li>
		<li><a>로맨스</a></li>
		<li><a>SF</a></li>
		<li><a>코믹</a></li>
	</ul>
</nav>
<!-- 글 영역 -->
<article>
	<!-- 등록 버튼 -->
	<div id="insert" style="background-color:white; border-radius:5px;"><a href="./Input1.jsp" target="_blank">등록하기</a></div>
	<!-- 웹툰 목록 출력 -->
	<div style = "margin:50px; display:inline;">
		<jsp:useBean id="det" class="beans.Detail"/>
		<jsp:setProperty property="*" name="det"/>
		<table border="1" style="border-collapse:collapse; background-color:white;">
			<tr>
				<td colspan="2" style="height:200px;"></td>
			</tr>
			<tr>
				<th>타이틀</th>
				<td><jsp:getProperty property="posttitle" name="det"/></td>
			</tr>
			<tr>
				<th>장르</th>
				<td><jsp:getProperty property="postgenre" name="det"/></td>
			</tr>
			<tr>
				<th>작가명</th>
				<td><jsp:getProperty property="author" name="det"/></td>
			</tr>
			<tr>
				<th>게시일</th>
				<td></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:right;">
				<input type="button" value="수정">
				<input type="button" value="삭제">
				</td>
			</tr>
		</table>
	</div>
</article>
</body>
</html>