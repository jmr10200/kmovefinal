<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>   <%-- JDBC 관련 클래스 import --%>
<%@ page import="com.lec.jsp.D"%>   <%-- JDBC, SQL 상수 인터페이스 import --%>
<%!
	// JDBC 관련 기본 객체 변수들 선언
	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	// Connection 에 필요한 값 세팅
    String driver = D.DRIVER;
    String url = D.URL;
    String uid = D.USER;
    String upw = D.PASSWD;    
%>