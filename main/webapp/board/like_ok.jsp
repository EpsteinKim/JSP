<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="com.koreait.*"%>

<%

if(session.getAttribute("userid") == null){
%>
<script>
alert('로그인 후 이용하세요');
location.href='../login.jsp';
</script>
<%
return;
}
	String idx = request.getParameter("idx");
	Connection conn = Dbconn.getConnection();
	ResultSet rs = null;
	int cur_like = 0;
	
	String sql = "update tb_board set b_like = b_like + 1 where b_idx = ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,idx);
	pstmt.executeUpdate();
	
	sql = "select b_like from tb_board where b_idx = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,idx);
	rs = pstmt.executeQuery();
	if(rs.next())
		cur_like = rs.getInt("b_like");
	
	out.print(cur_like);
%>
