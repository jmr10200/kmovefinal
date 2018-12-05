<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbcommon.jsp" %>

<% // parameter 받아오기
	int id = Integer.parseInt(request.getParameter("id"));
	String name = request.getParameter("name");
	String phonenum = request.getParameter("phonenum");
	String email = request.getParameter("email");
	String memo = request.getParameter("memo");
	//parameter 검증 필요
%>
  
<%    
	int cnt = 0;
	
    try{
		Class.forName(driver); //oracle.jdbc.driver.OracleDriver
		conn = DriverManager.getConnection(url, uid, upw);
		pstmt = conn.prepareStatement(D.SQL_UPDATE);
		
		pstmt.setString(1, name);
		pstmt.setString(2, phonenum);
		pstmt.setString(3, email);
		pstmt.setString(4, memo);
		pstmt.setInt(5, id);
	
		cnt = pstmt.executeUpdate();

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

<% if(cnt == 0){ %>
<script>
	alert("수정 실패");
	hisotry.back();
</script>
<% } else { %>
<script>
	alert("수정 성공");
	location.href = "view.jsp?id=<%= id %>"; <%-- 수정 성공하면 view 로 이동하여 제대로 수정되었는지 보여주는게 좋다--%>
</script>
<% } %>  