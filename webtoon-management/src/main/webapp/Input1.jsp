<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웹툰 등록 / 수정 페이지</title>
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
	position:absolute;
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
	height:150px;
	border:1px solid black;
}
.myclass2{
	display:inline-block;
	text-align:center;
	border:1px solid black;
}
option{
	font-family:"굴림";
	font-weight:bold;
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
		<area shape="rect" coords="0, 0, 57, 52" alt="홈으로" href="./index.html">
	</map>
	<!-- 카테고리 관리 버튼 -->
	<div id="manage">
		<a href="./AdConfig.html">카테고리 관리</a>
	</div>
	<!-- 제목 -->
	<div id="title">
		Webtoon World
	</div>
	<!-- 검색 -->
	<input type="text" name="search">
	<img src="./images/search.png" alt="검색">
</header>
<!-- 메뉴 -->
<nav>
	<!-- 로그인 & 메뉴 -->
	<form action="#" method="post" name="login">
		<fieldset>
			<legend>Login</legend>
			ID<br>
			<input type="text"name="id"><br>
			Password<br>
			<input type="password" name="pwd"><br>
			<input type="submit" name="idpwd" value = "확인">
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
<!-- 글 쓰기 -->
<form action="ID-list.jsp" method="post" name="postfrm" id = "postfrm">
	<table border="1">
		<tr>
			<th colspan="2" style="background-color:#e6faff;">글 쓰기</th>
		</tr>
		<tr>
			<td style="background-color:#e6faff;">타이틀</td>
			<td><input type="text" name="posttitle" id="posttitle"></td>
		</tr>
		<tr>
			<td style="background-color:#e6faff;">장르</td>
			<td>
				<select name="postgenre" id = "postgenre" style="width:100%">
					<optgroup label="장르">
						<option value="0">액션</option>
						<option value="1">로맨스</option>
						<option value="2">SF</option>
						<option value="3">코믹</option>
					</optgroup>
				</select>
			</td>
		</tr>
		<tr>
			<td style="background-color:#e6faff;">작가 명</td>
			<td><input type="text" id="author" name="author"></td>
		</tr>
		<tr>
			<td style="background-color:#e6faff;">작가의 말</td>
			<td><input type="text" id="authorsay" name="authorsay"></td>
		</tr>
	</table>
<!-- 이미지 업로드 -->
<div class="myclass1">
		<input style = "position:absolute; bottom:0px;" 
		type="file" accept="image/jpg, image/gif" id = "postimg" name="postimg" value="업로드/변경">
</div>
	<div class="myclass2">
		줄거리
	</div>
	<!-- 비밀번호 입력 -->
	<div class="myclass2" style="position:absolute; right:19%">
		비밀번호 <input type="password" name="postpwd" id = "postpwd">
	</div>
	<!-- 만화 영역 -->
	<div id="container1">
		<textarea rows="20" style="width:100%; font-family:굴림체, serif" name = "postsummary" id = "postsummary"></textarea>
	</div>
	<!-- 등록 & 취소 -->
		<input type="submit" name="postconfirm" value="등록" style="margin-top:5px;">
		<input type="reset" name="postcancel" value="취소" style="margin-top:5px;">
</form>
</article>
</body>
</html>