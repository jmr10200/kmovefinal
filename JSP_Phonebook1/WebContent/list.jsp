<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "java.util.Date" %>
<%@ include file="dbcommon.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>list</title>
<link rel="stylesheet" type="text/css" href="CSS/phonebook.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<%    
	int cnt = 0;
	int i;
    
	int writePages = 10;    // 한 ‘페이징’에 몇개의 페이지를 표현할 것인가?
	int pageRows = 7;   // 한 페이지에 몇개의 글을 리스트업할것인가? 
	int totalPage = 0; //총 몇 페이지 분량인가?
	int curPage = 1;  // 현재 페이지 
	
    try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, uid, upw);
		stmt = conn.createStatement();
		
		// 전체 항목 개수
		rs = stmt.executeQuery(D.SQL_COUNT_ALL);  // 전체항목수 추출 쿼리
		if(rs.next()) cnt = rs.getInt(1);
		rs.close();	 // 다시 쿼리 할 것이라 일단, 기존 result set 은 close
		i = cnt;
		
		// 전화번호부 항목 가져오기.
		//rs = stmt.executeQuery(D.SQL_SELECT_ALL);  // 전체 항목을 최신등록순 추출 쿼리
%>

<%
	totalPage = (int)Math.ceil(cnt / (double)pageRows); //총 몇 페이지 분량인가?
	
	// 현재 몇 페이지?
	String this_Page = request.getParameter("page");
	if(this_Page == null || this_Page.trim().equals("")){
		curPage = 1;  // page 파라미터가 없으면 디폴트로 첫페이지로
	}else{
		curPage = Integer.parseInt(this_Page);
	}
	
	int fromRow = (curPage - 1) * pageRows + 1;	// 몇번째 row 부터?
	pstmt = conn.prepareStatement(D.SQL_SELECT_FROM_ROW);
	pstmt.setInt(1, fromRow);    // 몇번째 row 부터
	pstmt.setInt(2, fromRow + pageRows);  // 몇번째 row 전까지?
	rs = pstmt.executeQuery();
%>




		<h2>리스트</h2>
		<br>
		<%= cnt %> 개의 항목이 있습니다.
		<table>
		<tr>
			<th>ROW</th>
			<th>번호</th>
			<th>이름</th>
		</tr>
		<%
		while(rs.next()){
			out.println("<tr>");
			int id = rs.getInt("id");
			String name = rs.getString("name");
			
			int rnum = rs.getInt("rnum");
			
			out.println("<td>" + rnum + "</td>");
			out.println("<td>" + id + "</td>");
			out.println("<td><a href='view.jsp?id=" + id + "'>" + name + "</a></td>");
			out.println("</tr>");
			i--;
		} // end while
		 %>
		</table>
		<br>
		<button onclick="location.href = 'insert.jsp'">신규등록</button>
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
<%--페이징 --%>
<jsp:include page="pagination.jsp">
	<jsp:param value="<%= writePages %>" name="writePages"/>
	<jsp:param value="<%= totalPage %>" name="totalPage"/>
	<jsp:param value="<%= curPage %>" name="curPage"/>
</jsp:include>

</body>
</html>