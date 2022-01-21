<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.koreait.*" %>
<%@page import="com.koreait.member.*" %>
<%
   request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="member" class="com.koreait.member.MemberDTO" />
<jsp:setProperty property="*" name="member"/>
<jsp:setProperty property="username" param="name" name="member"/>

<%
  	MemberDAO memberDAO = new MemberDAO();
  	if(memberDAO.insertDB(member) > 0){
  		%>
  		<script>
  		alert('회원가입이 완료되었습니다');
  		location.href='./login.jsp';
  		</script>
  		<%
  	}else{
  		%>
  		<script>
  		alert('회원가입이 되지 않았습니다');
  		history.back();
  		</script>
  		<%
  	}
%>