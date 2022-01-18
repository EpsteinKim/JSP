<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.koreait.*"%>
<%@ page import="java.sql.*"%>

<%
	String idx = request.getParameter("idx");
	
	Connection conn = Dbconn.getConnection();
	String sql = "update tb_board set b_hit = b_hit + 1 where b_idx = ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, idx);
	pstmt.executeUpdate();
%>
	<script>
		location.href='./view.jsp?idx=<%=idx%>';
	</script>