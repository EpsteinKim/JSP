<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.*" %>
    
    <%
    	String session_userid = (String)session.getAttribute("userid");
    
    	if(session_userid == null){
    		%>
    		<script>
    		alert('로그인 후 이용하세요');
    		location.href='../login.jsp';
    		</script>
    		<%
    		return;
    	}
    
    	String idx = request.getParameter("idx");
    	String userid = "";
    	String title = "";
    	String content = "";
    	
    	Connection conn = Dbconn.getConnection();
    	String sql = "select b_userid, b_title, b_content from tb_board where b_idx = ?";
    	PreparedStatement pstmt = conn.prepareStatement(sql);
    	pstmt.setString(1,idx);
    	ResultSet rs = pstmt.executeQuery();
    	if(rs.next()){
    		userid = rs.getString("b_userid");
    		title = rs.getString("b_title");
    		content = rs.getString("b_content");
    	}
    	
    	if(!session_userid.equals(userid)){
    		%>
    		<script>
    		alert('작성자 정보가 일치하지 않습니다');
    		history.back();
    		</script>
    		<%
    		return;
    	}
    	
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 - 글 수정</title>
</head>
<body>
	<h2>커뮤니티 - 글 수정</h2>
	<form action="./edit_ok.jsp" method="post">
	<input type='hidden' name='idx' value='<%=idx %>'>
		<p>작성자 : <%=session.getAttribute("userid")%></p>
		<p>제목 : <input type="text" name="title" value="<%=title%>"></p>
		<p>내용</p>
		<p><textarea rows="5" cols="40" name="content" maxlength=2000><%=content %></textarea></p>
		<p><input type="submit" value="수정"> <input type="reset" value="다시작성"></p>
</form>
</body>
</html>