<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbcommon.jsp" %>

<%  // parameter 받아오기
	String name = request.getParameter("name");
	String phonenum = request.getParameter("phonenum");
	String email = request.getParameter("email");
	String memo = request.getParameter("memo");
	
	// parameter 검증 필요
	// TODO ? 실패하면 더이상 진행 안되게 리턴..
%>


<%    
	int cnt = 0;
	
    try{
		Class.forName(driver); //oracle.jdbc.driver.OracleDriver
		conn = DriverManager.getConnection(url, uid, upw);
		pstmt = conn.prepareStatement(D.SQL_INSERT);
		
		pstmt.setString(1, name);
		pstmt.setString(2, phonenum);
		pstmt.setString(3, email);
		pstmt.setString(4, memo);
		
		cnt = pstmt.executeUpdate();

    }catch(Exception e){
    	e.printStackTrace();
    } finally {
    	try{
    		if(rs != null) rs.close();
    		if(stmt != null) stmt.close();
    		if(pstmt != null) pstmt.close();
    		if(conn != null) conn.close();
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    }
%>

<% if(cnt == 0){ %>
<script>
	alert("항목 추가 실패");
	hisotry.back();
</script>
<% } else { %>
<script>
	alert("항목 추가 성공");
	location.href = "list.jsp";
</script>
<% } %>
    