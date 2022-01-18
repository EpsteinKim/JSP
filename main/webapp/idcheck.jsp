<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userid = request.getParameter("userid");

	Connection conn = null;
	PreparedStatement pstmt = null;
	String sql_id = "root";
	String sql_url = "jdbc:mysql://localhost:3306/aiclass";
	String sql_pw = "1234";
	ResultSet rs = null;
	
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(sql_url, sql_id, sql_pw);
		if(conn != null){
			String sql = "select mem_idx from tb_member where mem_userid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			if(rs.next()){
				out.print("중복된 아이디입니다.");
			}else{
				out.print("생성 가능한 아이디입니다.");
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		rs.close();
		pstmt.close();
		conn.close();
		rs = null;
		pstmt = null;
		conn = null;
	}


%>