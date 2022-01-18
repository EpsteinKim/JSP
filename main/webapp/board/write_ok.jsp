<%@page import="org.apache.catalina.filters.SetCharacterEncodingFilter"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="com.koreait.*" %>
    <%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    	if(session.getAttribute("userid") == null){
    		%>
    		<script>
    		alert('로그인후 이용하세요');
    		location.href='../login.jsp';
    		</script>
    		<%
    		return;
    	}
    
		String userid = (String)session.getAttribute("userid");
    	String title = request.getParameter("title");
    	String content = request.getParameter("content");

    	
    	Connection conn = Dbconn.getConnection();

    	String sql = "insert into tb_board(b_userid, b_title, b_content) values(?,?,?)";
    	PreparedStatement pstmt = conn.prepareStatement(sql);
    	pstmt.setString(1, userid);
    	pstmt.setString(2, title);
    	pstmt.setString(3, content);
    	
    	if(pstmt.executeUpdate() > 0){
    		%>
    		<script>
    		alert('작성이 완료되었습니다');
    		location.href = './list.jsp';
    		</script>
    		<%
    	}
    	else{
    		%>
    		<script>
    		alert('입력을 완료해주세요');
    		history.back();
    		</script>
    		<%
    	}
    	
    %>
    
    
    
    
    
    
    
    