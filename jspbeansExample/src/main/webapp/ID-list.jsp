<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="beans.Detail"%>
    
<%
	request.setCharacterEncoding("utf-8");
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
td:nth-child(2){
	width:80%;
}
</style>

</head>
<body>
<!-- 머리글 영역 -->
<header>
	<!-- 홈 -->
	<img src="./images/home.png" alt="홈으로" usemap="#tohome">
	<map name="tohome">	
		<area shape="rect" coords="0, 0, 57, 52" alt="홈으로" href="./index.html">
	</map>
	<!-- 카테고리 관리 -->
	<div id="manage">
		<a href="./AdConfig.html">카테고리 관리</a>
	</div>
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
	<form action="#" method="post" name="login">
		<fieldset>
			<legend>Login</legend>
			ID<br>
			<input type="text"name="id"><br>
			Password<br>
			<input type="password" name="pwd"><br>
			<input type="submit" name="loginconfirm" value = "확인">
		</fieldset>
	</form>
	<!-- 메뉴 -->
	<ul>
		<li><a href="./index.html">전체 보기</a></li>
		<li><a>액션</a></li>
		<li><a>로맨스</a></li>
		<li><a>SF</a></li>
		<li><a>코믹</a></li>
	</ul>
</nav>
<!-- 글 영역 -->
<article>
	<jsp:useBean id="det" class="beans.Detail"/>
	<jsp:setProperty property="*" name="det"/>
	<!-- 등록 버튼 -->
	<div id="insert" style="background-color:white; border-radius:5px;"><a href="./Input1.html" target="_blank">등록하기</a></div>
	<table border="1">
		<tr>
			<th colspan="2" style="background-color:#e6faff;">요약 정보</th>
		</tr>
		<tr>
			<td style="background-color:#e6faff;">타이틀</td>
			<td><jsp:getProperty property="posttitle" name="det"/></td>
		</tr>
		<tr>
			<td style="background-color:#e6faff;">장르</td>
			<td><jsp:getProperty property="postgenre" name="det"/></td>
		</tr>
		<tr>
			<td style="background-color:#e6faff;">작가 명</td>
			<td><jsp:getProperty property="author" name="det"/></td>
		</tr>
		<tr>
			<td style="background-color:#e6faff;">작가의 말</td>
			<td><jsp:getProperty property="authorsay" name="det"/></td>
		</tr>
		<tr style = "height:300px;">
			<td style = "background-color:#e6faff;">줄거리</td>
			<td><pre><jsp:getProperty property="postsummary" name="det"/></pre></td>
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