<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.*"%>
<%

	String idx = request.getParameter("idx");
	String r_idx = request.getParameter("r_idx");

	Connection conn = Dbconn.getConnection();
	String sql = "delete from tb_reply where r_board_idx = ? and r_idx = ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,idx);
	pstmt.setString(2,r_idx);
	if(pstmt.executeUpdate() > 0){
		%>
		<script>
		alert('삭제되었습니다');
		location.href='./view.jsp?idx=<%=idx%>';
		</script>
		<%
	}
%>