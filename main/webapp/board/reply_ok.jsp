<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.*"%>

<%
if(session.getAttribute("userid")==null){
	%>
	<script>
	alert('로그인 후 이용하세요');
	location.href="../login.jsp";
	</script>
	<%
	return;
}
	
	request.setCharacterEncoding("UTF-8");
	
	String idx = request.getParameter("idx");
	String text = request.getParameter("r_content");
	String userid = (String)session.getAttribute("userid");

	Connection conn = Dbconn.getConnection();
	String sql = "insert into tb_reply(r_board_idx, r_userid, r_content) values(?,?,?)";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, idx);
	pstmt.setString(2, userid);
	pstmt.setString(3, text);

	if(pstmt.executeUpdate() > 0){
		%>
		<script>
		alert('등록되었습니다');
		location.href='./view.jsp?idx=<%=idx%>';
		</script>
		<%
	}
%>