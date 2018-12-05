<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		pstmt = conn.prepareStatement(D.SQL_SELECT_BY_ID);
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
<title>정보</title>
<link rel="stylesheet" type="text/css" href="CSS/phonebook.css"/>
</head>
<script>

function chkDelete(id){
	// 삭제 여부, 다시 확인 하고 진행하기
	var r = confirm("삭제하시겠습니까?");
	
	if(r){
		location.href = 'deleteOk.jsp?id=' + id;
	}
}

</script>
<body>
<h2>항목 보기</h2>
<br>

id : <%= id %><br>
이름 : <%= name %><br>
전화번호: <%= phonenum %><br>
이메일: <%= email %><br>
등록일: <%= regDate %><br>
<hr>
<%= memo %>
<hr>
<br>
<button onclick="location.href='update.jsp?id=<%= id %>'">수정하기</button>
<button onclick="location.href='list.jsp'">목록보기</button>
<button onclick="chkDelete(<%= id %>)">삭제하기</button>
<button onclick="location.href='insert.jsp'">신규등록</button>

</body>
</html>