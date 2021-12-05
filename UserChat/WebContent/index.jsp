<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name ="viewport" content="width=device-width, initial-scale=1"> <!-- bootstarp 적용 -->
	<link rel="stylesheet" href="css/bootstrap.css"> <!-- bootstarp 내의 css 적용 -->
	<link rel="stylesheet" href="css/custom.css"> <!-- 자제체작  css 적용 -->
	<title> 취약점 진단 게시판 </title>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> <!-- ajex를 위해서 공식쿼리 링크 -->
	<script src="js/booststrap.min.js"></script>
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script> <!-- 드롭다운 위해 추가 -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> <!-- 드롭다운 위해 추가 -->
	
	
</head>
<body>
	<%
		String userID = null; 
		if (session.getAttribute("userId") != null){
			userID = (String) session.getAttribute("userID"); // 접속유무 세션확인
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <!-- 메뉴 오른쪽 아이콘 바 -->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">취약점 진단 게시판</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a>
				<li><a href="bbs.jsp">게시판</a>
			</ul>
			<%
				if(userID == null){ //로그인이 되어있지 않은 사람에게만 노출
			%>	
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else { //로그인이 된 사람만 노출
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="updateuser.jsp">회원 정보수정</a></li>
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	
	</nav>
</body>
</html>