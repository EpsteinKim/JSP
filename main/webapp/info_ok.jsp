<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*" %>
<%@page import="com.koreait.*" %>
<!DOCTYPE html>
<%
	Connection conn = Dbconn.getConnection();
	PreparedStatement pstmt = null;
	request.setCharacterEncoding("UTF-8");
	
	String userpw = request.getParameter("userpw");
	String name = request.getParameter("name");
	String hp = request.getParameter("hp");
	String email = request.getParameter("email");
	String[] hobbyHTML = request.getParameterValues("hobby");
	String hobby = "";
	for(String ho : hobbyHTML){
		hobby += ho+" ";
	}
	String zipcode = request.getParameter("zipcode");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String address3 = request.getParameter("address3");

	String sql = "update tb_member set mem_name = ?, mem_hp = ?, mem_email =? , mem_hobby = ?, mem_zipcode =?, mem_address1 =?, mem_address2 =?, mem_address3 =? where mem_idx = ? && mem_userpw = ?";
	
	if(session.getAttribute("idx") == null){
		%>
		<script>
		alert('로그인 후 이용하세요');
		location.href =	'./login.jsp';
		</script>
		<%
	}else{
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(9, (String)session.getAttribute("idx"));
			pstmt.setString(10, userpw);
			pstmt.setString(1, name);
			pstmt.setString(2, hp);
			pstmt.setString(3, email);
			pstmt.setString(4, hobby);
			pstmt.setString(5, zipcode);
			pstmt.setString(6, address1);
			pstmt.setString(7, address2);
			pstmt.setString(8, address3);
			
			if(pstmt.executeUpdate() > 0){
				%>
				<script>
				alert('정보가 수정되었습니다');
				location.href = 'info.jsp';
				</script>
				
				<%
			}else{
				%>
				<script>
				alert('비밀번호 혹은 로그인 정보가 일치하지 않습니다.');
				history.back();
				</script>
				<%
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}

//info.jsp로 이동
%>
