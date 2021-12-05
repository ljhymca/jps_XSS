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
	<script type="text/javascript">
		function registerCheckFunction() { //중복 확인 
			var userID = $("#userID").val();
			$.ajax({
				type: 'POST',
				url: './UserRegisterCheckServlet', //해당 서블릿으로 POST방식으로 회원아이디 전송
				data: {userID: userID}, // 속성 : 값
				success: function(result){
					if(result == 1){
						$('#checkMessage').html('사용할 수 있는 아이디입니다.');
						$('#checkType').attr('class', 'modal-content panel-success'); //속성 
					} else {
						$('#checkMessage').html('사용할 수 없는 아이디입니다.');
						$('#checkType').attr('class', 'modal-content panel-warning'); //속성 
					}
					$('#checkModal').modal("show"); //modal이 눈에 보기게끔 설정
				}
			});
		}
		function passwordCheckFunction() {//비밀번호 입력값 확인
			var userPassword1 = $('#userPassword1').val();
			var userPassword2 = $('#userPassword2').val();
			if(userPassword != userPassword2){
				$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
			} else {
				$('#passwordCheckMessage').html('비밀번호가 일치 합니다.');
			}
		}
		</script>
	
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
	<div class="container">
		<form method="post" action="./userRegister">
			<table class = "table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan ="3"><h4>회원 등록 양식</h4></th>
					</tr>
				</thead>
				<tbody>
					 <tr>
					 	<td style="width: 110px;"><h5>아이디</h5></td>
					 	<td><input class="form-control" type="text" id="userID" name="userID" maxlength="20" placeholder="아이디"></td>
					 	<td style="width: 110px"><button class="btn btn-primary" onclick="registerCheckFunction();" type="button">중복체크</button></td>
					 </tr>
					 <tr>
					 	<td style="width: 110px;"><h5>비밀번호</h5></td>
					 	<td colspan="2"><input onkeyup="passwordCheckFunction();" class="form-control" id="userPassword1" type="password" name="userPassword1" maxlength="20" placeholder="비밀번호"></td>
					 	<!-- 입력할때 마다비밀번호 일치확인  -->
					 </tr>
					 <tr>
					 	<td style="width: 110px;"><h5>비밀번호 확인</h5></td>
					 	<td colspan="2"><input onkeyup="passwordCheckFunction();" class="form-control" id="userPassword2" type="password" name="userPassword2" maxlength="20" placeholder="비밀번호 확인"></td>
					 	<!-- 입력할때 마다비밀번호 일치확인  -->
					 </tr>
					 <tr>
					 	<td style="width: 110px;"><h5>이름</h5></td>
					 	<td colspan="2"><input class="form-control" id="userName" type="text" name="userName" maxlength="20" placeholder="이름"></td>
					 </tr>
					 <tr>
					 	<td style="width: 110px;"><h5>나이</h5></td>
					 	<td colspan="2"><input class="form-control" id="userAge" type="number" name="userAge" maxlength="20" placeholder="나이"></td>
					 </tr>
					 <tr>
					 	<td style="width: 110px;"><h5>성별</h5></td> <!-- 라디오버튼 -->
					 	<td colspan="2">
					 		<div class="form-group" style="text-align: center;">
								<div class="btn-group" data-toggle="buttons">
									<label class="btn btn-primary active">
										<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
									</label>
									<label class="btn btn-primary">
										<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
									</label>
								</div>
							</div>
						</td>
					 </tr>
					 <tr>
					 	<td style="width: 110px;"><h5>이메일</h5></td>
					 	<td colspan="2"><input class="form-control" id="userEmail" type="email" name="userEmail" maxlength="20" placeholder="이메일"></td>
					 </tr>
					 <tr>
					 	<td style="text-align: left;" colspan="3"><h5 style="color; red;" id="passwordCheckMessage"></h5>
					 </tr>
				</tbody>
			</table>
		</form>
	</div>
	<!-- 세션 검증 -->
	<%
		String messageContent = null;
		if (session.getAttribute("messageContent") != null) {
			messageContent = (String) session.getAttribute("messageContent");
		}
		String messageType = null;
		if (session.getAttribute("messageType") != null) {
			messageContent = (String) session.getAttribute("messageType");
		}
		if (messageContent !=null){ // 세션값이 존재 하는 경우
	%>
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<!-- 오류메시지 출력 -->
				<div class="modal-content <% if(messageType.equals("오류 메시지")) out.println("panel-warning"); else out.println("panel-success"); %>">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal"><!-- 닫기 버튼 -->
							<span aria-hidden="true">&times</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
							<%= messageType %>
						</h4>
					</div>
					<div class="modal-body">
						<%= messageContent %>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$('#messageModal').modal("show"); // 사용자에게 보이게 끔 설정
	</script>
	<% 		 
		session.removeAttribute("messageContent");
		session.removeAttribute("messageType"); // 세션 종료
		}
	%>
	<div class="modal fade=" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog vertical-align-center">
				<!-- 회원가입시 사용가능한 아이디 일때 확인메시지 출력 -->
				<div id="checkType" class="modal-content panel-info">
					<div class="modal-header panel-heading">
						<button type="button" class="close" data-dismiss="modal"><!-- 닫기 버튼 -->
							<span aria-hidden="true">&times</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="model-title">
							확인 메시지
						</h4>
					</div>
					<div id="checkMessage" class="modal-body">
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>