<%@page import="org.apache.catalina.filters.AddDefaultCharsetFilter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 - 글쓰기</title>
</head>
<body>

<!--  
	form action : write.ok.jsp
	작성자 : session.getAttribute("userid")
	제목 : b_title
	내용 : b_content
	
	write_ok.jsp - > list.jsp
	db insert
-->
	<h2>커뮤니티 - 글쓰기</h2>
	<form method="post" action="write_ok.jsp">
		<p>작성자 : <%=session.getAttribute("userid")%></p>
		<p>제목 : <input type="text" name="title"></p>
		<p>내용</p>
		<p><textarea rows="5" cols="40" name="content" maxlength=2000></textarea></p>
		<p><input type="submit" value="등록"> <input type="reset" value="다시작성"> <input type="button" value="리스트" onclick="location.href=list.jsp"></p>
	</form>

</body>
</html>