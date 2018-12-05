package com.lec.jsp;

public interface D {
	// DB driver 클래스
	public static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	// DB 서버 URL
	public static final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	
	// DB 사용자 계정 정보
	public static final String USER = "scott";
	public static final String PASSWD = "tiger";
	
	// 사용 테이블, 컬럼 정보
	public static final String TBL_NAME = "phonebook";
	
	public static final String COL_LABEL_ID = "id";
	public static final String COL_LABEL_NAME = "name";
	public static final String COL_LABEL_PHONENUM = "phonenum";
	public static final String COL_LABEL_EMAIL = "email";
	public static final String COL_LABEL_REGDATE = "regdate";
	public static final String COL_LABEL_MEMO = "memo";

	//--------------------------------------------------------------------
	// 쿼리 문자열 상수들
	
	// 쿼리 문자열
	public static final String SQL_COUNT_ALL = "SELECT COUNT(*) cnt FROM " + TBL_NAME;
	public static final String SQL_MAX_ID = "SELECT MAX(id) maxid FROM " + TBL_NAME;

	// 전체 SELECT
	public static final String SQL_SELECT_ALL = "SELECT * FROM " + TBL_NAME + " ORDER BY " + COL_LABEL_ID + " DESC";
	
	// 특정 id 의 목록 SELECT
	public static final String SQL_SELECT_BY_ID = "SELECT * FROM " + TBL_NAME + " WHERE " + COL_LABEL_ID + " = ?";

	// fromRow 부터 pageRows 만큼 SELECT
	public static final String SQL_SELECT_FROM_ROW = "SELECT * FROM " + 
			"(SELECT ROWNUM AS RNUM, T.* FROM (SELECT * FROM " + TBL_NAME + " ORDER BY " + COL_LABEL_ID + " DESC) T)" + 
			"WHERE RNUM >= ? AND RNUM < ?";
	
	// 신규 항목 INSERT
	public static final String SQL_INSERT = "INSERT INTO " + TBL_NAME + 
	"(" + COL_LABEL_ID + "," + COL_LABEL_NAME + "," 
			+ COL_LABEL_PHONENUM + "," + COL_LABEL_EMAIL + "," 
			+ COL_LABEL_REGDATE + "," + COL_LABEL_MEMO 
			+ ") VALUES(phonebook_seq.nextval, ?, ?, ?, SYSDATE, ?)";

	// 특정 id 항목 수정 UPDATE
	public static final String SQL_UPDATE = "UPDATE " + TBL_NAME 
			+ " SET " + COL_LABEL_NAME + " = ?, " 
			+ COL_LABEL_PHONENUM + " = ?, " 
			+ COL_LABEL_EMAIL + " = ?, "
			+ COL_LABEL_MEMO + " = ? "
			+ "WHERE " + COL_LABEL_ID + " = ?";	
	// 특정 id 항목 삭제 DELETE
	public static final String SQL_DELETE = "DELETE FROM " + TBL_NAME + " WHERE " + COL_LABEL_ID + " = ?";
	
	public static final String SQL_FINDID = "SELECT count(*) cnt FROM " + TBL_NAME + " WHERE " + COL_LABEL_ID + " = ?";

}
