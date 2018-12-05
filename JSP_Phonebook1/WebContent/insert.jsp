<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Insert</title>
<link rel="stylesheet" type="text/css" href="CSS/phonebook.css"/>
<script src="ckeditor/ckeditor.js"/>
</head>
<script>
function chkSubmit(){
	frm = document.forms["frm"];
	
	var name = frm["name"].value.trim();

    if (name == "") {
        alert("이름은 반드시 입력해야 합니다.");
        return false;
    }
    return true;
}

</script>
<body>
<h2>신규등록</h2>
<br>
<form name="frm" action="insertOk.jsp" onsubmit="return chkSubmit()">
이름:
<input type="text" name="name"/><br>
전화번호:
<input type="text" name="phonenum"/><br>
이메일:
<input type="text" name="email"/><br>
메모:<br>
<textarea name="memo" id="editor1"></textarea>
<script>
	CKEDITOR.replace('editor1', {
		allowedContent: true, // html 태그 자동삭제 방지 설정
		//width: 640,
		//height: 600
		filebrowserUploadUrl : '${pageContext.request.contextPath}/fileUpload.jsp'
		
		
	});
</script>
<br><br>
<input type="submit" value="등록"/>
</form>
<br>
<button onclick="location.href='list.jsp'">목록으로</button>
</body>
</html>