<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
request.setCharacterEncoding("UTF-8");
String userid = request.getParameter("userid");
String userpw = request.getParameter("userpw");

Connection conn = null;
ResultSet rs = null;
PreparedStatement pstmt = null;
String url = "jdbc:mysql://localhost:3306/aiclass";
String user = "root";
String password = "1234";
String sql = "select mem_idx, mem_name from tb_member where mem_userid = ? && mem_userpw = ?";
try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection(url, user, password);
	if (conn != null) {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		pstmt.setString(2, userpw);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			session.setAttribute("userid", userid);
			session.setAttribute("idx", rs.getString("mem_idx"));
			session.setAttribute("name", rs.getString("mem_name"));
		}
%>
<script>
	alert('로그인 되었습니다');
	location.href = "login.jsp";
</script>
<%
} else {
%>
<script>
	alert('아이디와 비밀번호를 다시 확인해주세요');
	history.back();
</script>
<%
}
} catch (Exception e) {
e.printStackTrace();
}
%>