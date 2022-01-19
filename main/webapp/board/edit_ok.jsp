<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.*"%>

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

	request.setCharacterEncoding("UTF-8");
	
	String idx = (String)request.getParameter("idx");
	String title = (String)request.getParameter("title");
	String content = (String)request.getParameter("content");
	
	Connection conn = Dbconn.getConnection();
	String sql = "update tb_board set b_title = ?, b_content = ? where b_idx = ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(3,idx);
	pstmt.setString(1,title);
	pstmt.setString(2,content);
	
	if(pstmt.executeUpdate() > 0){
		%>
		<script>
		alert('수정되었습니다');
		location.href='./view.jsp?idx=<%=idx%>';
		</script>
		<%
	}else{
		%>
		<script>
		alert('오류로 인해 수정이 진행되지 않았습니다');
		history.back();
		</script>
		<%
	}
%>