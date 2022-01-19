<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.koreait.*"%>
<%
Connection conn = Dbconn.getConnection();
String sql = "select * from tb_board order by b_idx desc";
PreparedStatement pstmt;
ResultSet rs;
int count = 0;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 - 리스트</title>
</head>
<body>
	<h2>커뮤니티 - 리스트</h2>
	<p>
		게시글 :
		<%
	String sql_howmany = "select count(b_idx) as total from tb_board";
	pstmt = conn.prepareStatement(sql_howmany);
	rs = pstmt.executeQuery();

	if (rs.next())
		count = rs.getInt("total");
	out.print(count);
	%>개
	</p>

	<table border="1" width="800">
		<tr>
			<th width="50">번호</th>
			<th width="300">제목</th>
			<th width="100">글쓴이</th>
			<th width="75">조회수</th>
			<th width="200">날짜</th>
			<th width="75">좋아요</th>
		</tr>
		<%
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();

		while (rs.next()) {
			String[] regdate = rs.getString("b_regdate").split(" ");
			String date = regdate[0];
			String time = regdate[1];
			
			String idx = rs.getString("b_idx");
			String title = rs.getString("b_title");
			String userid = rs.getString("b_userid");
			String hit = rs.getString("b_hit");
			String like = rs.getString("b_like");
%>

		<tr align=center>
			<td><%=idx %></td>
			<td style="text-align:left;"><a href="./title_click.jsp?idx=<%=idx %>"><%=title %></a> 
<%
				sql = "select count(r_board_idx) as reply_total from tb_reply where r_board_idx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,idx);
				ResultSet re_rs = pstmt.executeQuery();

				if(re_rs.next()){
%>
					<span>[<%=re_rs.getString("reply_total") %>]</span>
<%
				}
%>
			
			</td>
			<td><%=userid %></td>
			<td><%=hit %></td>
			<td><%=date %></td>
			<td><%=like %></td>
		</tr>
<%
		}
%>
	</table>

	<p>
		<input type="button" value="글쓰기" onclick="location.href='./write.jsp'">
		<input type="button" value="메인" onclick="location.href='../login.jsp'">
	</p>
</body>
</html>