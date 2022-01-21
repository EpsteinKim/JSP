<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*" %>
<%@page import="com.koreait.*" %>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="member_modified" class="com.koreait.member.MemberDTO"/>
<jsp:setProperty property="*" name="member_modified"/>
<jsp:setProperty property="username" param="name" name="member_modified"/>
<jsp:useBean id="memberDAO" class="com.koreait.member.MemberDAO"/>

<%
	if(session.getAttribute("idx") == null){
		%>
		<script>
		alert('로그인 후 이용하세요');
		location.href =	'./login.jsp';
		</script>
		<%
		return;
	}

	member_modified.setIdx((int)session.getAttribute("idx"));
	if(memberDAO.edit(member_modified) > 0){
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
	
//info.jsp로 이동
%>
