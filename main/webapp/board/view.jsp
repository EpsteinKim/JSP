<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ page import="com.koreait.*"%>
<%

String idx = request.getParameter("idx");

Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql = null;

String userid = "";
String title = "";
String content = "";
String regdate = "";
String date = "";
int like = 0;
int hit = 0;

conn = Dbconn.getConnection();
if (conn != null) {
	sql = "select * from tb_board where b_idx = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, idx);
	rs = pstmt.executeQuery();

	if (rs.next()) {
		userid = rs.getString("b_userid");
		title = rs.getString("b_title");
		content = rs.getString("b_content");
		regdate = rs.getString("b_regdate");
		date = regdate.split(" ")[0];

		like = rs.getInt("b_like");
		hit = rs.getInt("b_hit");
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 - 글보기</title>
<script>
	window.onload = function() {
		const likebtn = document.querySelectorAll('[value="좋아요"]');
		const likeHTML = document.getElementById('like');
		likebtn[0].addEventListener('click', function(){
	  	  const xhr = new XMLHttpRequest();
	 	   xhr.open('GET', './like_ok.jsp?idx=<%=idx%>', true);
			xhr.send();

			xhr.onreadystatechange = function() {
				if (xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200) {
					likeHTML.innerHTML = xhr.responseText;
				}
			};
		})
	};
</script>
</head>
<body>
	<h2>커뮤니티 - 글보기</h2>
	<table width="800" border="1">
		<tr>
			<td>제목</td>
			<td><%=title%></td>
		</tr>
		<tr>
			<td>날짜</td>
			<td><%=date%></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><%=userid%></td>
		</tr>
		<tr>
			<td>조회수</td>
			<td><%=hit%></td>
		</tr>
		<tr>
			<td>좋아요</td>
			<td id='like'><%=like%></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><%=content%></td>
		</tr>
		<tr>
			<td colspan="2">
			<%
			if(userid.equals((String)session.getAttribute("userid"))){
				%>
		<input type="button" value="수정" onclick="location.href='./edit.jsp?idx=<%=idx%>'"> 
		<input type="button" value="삭제" onclick="location.href='./delete.jsp?idx=<%=idx%>'"> 
				<%			
			}
			
			
			%>
				
				<input type="button" value="좋아요">
				<input type="button" value="리스트"
				onclick="location.href='./list.jsp?idx=<%=idx%>'"></td>
		</tr>
	</table>
	
<hr/>
	<form method="post" action="reply_ok.jsp">
		<input type="hidden" name="idx" value="<%=idx%>">
		<p><%=session.getAttribute("userid")%> :
		<input type="text" size="40" name="r_content">
		<input type="submit" value="확인"></p>
	</form>
	<hr/>
	<%
		sql = "select * from tb_reply where r_board_idx = ? order by r_idx desc";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,idx);
		rs = pstmt.executeQuery();
		
		String r_userid ="";
		String r_content = "";
		String r_regdate ="";
		while(rs.next()){
			int r_idx = rs.getInt("r_idx");
			r_userid = rs.getString("r_userid");
			r_content = rs.getString("r_content");
			r_regdate = rs.getString("r_regdate");
			%>
			<p><%=r_userid %> : <%=r_content %> (<%=r_regdate %>)
			<%
				if(r_userid.equals((String)session.getAttribute("userid"))){
					%>
					<input type="button" value="삭제" onclick="replyDel(<%=r_idx%>)">
					<%
				}
			%>
			</p>
			<%
		}
	%>
	
<script>
	function replyDel(r_idx){
		if(confirm('게시물을 삭제하시겠습니까?')){
			location.href='./reply_delete.jsp?r_idx='+ r_idx + '&' + 'idx=<%=idx%>';
		}

	}
</script>

</body>
</html>












