<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbcommon.jsp" %>

<%  // parameter 받아오기
	int id = Integer.parseInt(request.getParameter("id"));
	// parameter 검증 필요
%>

<%    
    int cnt = 0;
	
    try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, uid, upw);
		pstmt = conn.prepareStatement(D.SQL_DELETE);
		
		pstmt.setInt(1, id);
		
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
	alert("회원 삭제 실패");
	hisotry.back();
</script>
<% } else { %>
<script>
	alert("회원 삭제 성공");
	location.href = "list.jsp";
</script>
<% } %>
    