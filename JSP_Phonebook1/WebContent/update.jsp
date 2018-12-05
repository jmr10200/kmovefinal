<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	Update 의 경우가 의외로 처리 할 것들이 많다.
	
	일단, 기존의 데이터를 불러 들어 와야 한다. SELECT
	그리고, 편집가능한 영역과 그렇지 않은 영역을 분리해서 사용자에게 form 을 제공해야 한다.
	표시내용은 view.jsp 에서 비슷하세 시작가능
	
	나중에 updateOk.jsp 로 넘겨서 실제 UPDATE 쿼리를 실행하기 위해선 id 값도 넘어가야 한다.
	그래서 넘겨 받은 id 값을 hidden 으로 담아 두었다가 넘겨준다.
	
 --%>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.Date" %>
<%@ include file="dbcommon.jsp" %>

<%  // parameter 받아오기
  	int id = Integer.parseInt(request.getParameter("id"));
	//parameter 검증 필요
%>

<%!
  	String name;
  	String phonenum;
  	String email;
  	String regDate;
  	String memo;
%>

<%
    try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, uid, upw);
		pstmt = conn.prepareStatement(D.SQL_SELECT_BY_ID); // 특정 id 항목 추출 쿼리
		pstmt.setInt(1, id);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			id = rs.getInt("id");
			name = rs.getString("name");
			phonenum = rs.getString("phonenum");
			email = rs.getString("email");
			memo = rs.getString("memo");
			regDate = new SimpleDateFormat("yyyy-MM-dd").format(rs.getDate("regdate"));
		}else{
		%>
			<script>
				alert("정보가 없습니다");
				history.back();
			</script>	
		<%
			return;  // JSP 프로세싱 종료
		}
%>


<%	
    }catch(Exception e){
    	e.printStackTrace();
    } finally {
    	try{
    		if(rs != null) rs.close();
    		if(pstmt != null) pstmt.close();
    		if(stmt != null) stmt.close();
    		if(conn != null) conn.close();
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>Update</title>
<link rel="stylesheet" type="text/css" href="CSS/phonebook.css"/>
<script src="ckeditor/ckeditor.js"></script>
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
<h2>수정하기</h2>
<br>
<form name="frm" action="updateOk.jsp" method="get" onsubmit="return chkSubmit();">
<%-- ★나중에 updateOk 에 넘길 id 값을 담아둘 form element 가 필요하다 이를 hidden 으로 세팅한다★ --%>
<input type="hidden" name="id" value="<%= id %>"/>  
id : <%= id %><br>
이름 : <input type="text" name="name" value="<%= name %>"/><br>
전화번호: <input type="text" name="phonenum" value="<%= phonenum %>"/><br>
이메일: <input type="text" name="email" value="<%= email %>"/><br>
등록일: <%= regDate %><br>
<hr>
<textarea name="memo" id="editor1"><%= memo %></textarea>
<script>
	CKEDITOR.replace('editor1');
</script>
<hr>
<br>
<input type="submit" value="수정"/>
</form>
<br>
<button onclick="history.back();">이전으로</button>
<button onclick="location.href='list.jsp'">목록보기</button>

</body>
</html>