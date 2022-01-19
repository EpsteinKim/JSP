<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.*"%>

<%
	String userid = (String)session.getAttribute("userid");
	if(userid == null){
%>
	<script>
	alert('로그인 후 이용하세요');
	location.href='../login.jsp';
	</script>
	<%
	return;
	}
	%>
	<script>
	if(!confirm('이 글을 삭제하시겠습니까?')){
		history.back();
	}
	</script>
	<%
	
	String idx = (String)request.getParameter("idx");
	String DB_userid = "";
	
	Connection conn = Dbconn.getConnection();
	String sql = "delete from tb_board where b_idx = ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,idx);
	int result = pstmt.executeUpdate();
	
	if(result > 0 ){
		%>
		<script>
		alert('삭제되었습니다.');
		location.href='./list.jsp';
		</script>
	<%
	}

		
%>

