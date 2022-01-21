<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.member.*" %>
<%	request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="anonymous" class="com.koreait.member.MemberDTO"/>
<jsp:useBean id="memberDAO" class="com.koreait.member.MemberDAO"/>
<jsp:setProperty property="*" name="anonymous"/>

<%
	MemberDTO member = memberDAO.login(anonymous);
	if(member == null){
		%>
		<script>
		alert('등록된 회원정보가 없습니다');
		history.back();
		</script>
		<%
		return;
	}
	session.setAttribute("userid", member.getUserid());
	session.setAttribute("name", member.getUsername());
	session.setAttribute("idx",member.getIdx());
%>
	<script>
	alert('<%=member.getUsername()%>님이 로그인하였습니다. 환영합니다.');
	location.href='./login.jsp';
	</script>