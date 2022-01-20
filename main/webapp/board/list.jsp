<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.koreait.*"%>
<%@page import="java.time.LocalDate" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<%
int total = 0;

Integer cur_page = request.getParameter("cur_page") == null? cur_page = 0 :Integer.parseInt(request.getParameter("cur_page"));


String sql = "";
PreparedStatement pstmt = null;
ResultSet rs = null;
Connection conn = Dbconn.getConnection();

Date from = new Date();
SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
String to = fm.format(from);

int page_rep = 0;
int page_rep_left = 0;
int page_user_rep = 10;



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

	if (rs.next()) total = rs.getInt("total");	
	out.print(total);
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
		
		sql = "select * from tb_board order by b_idx desc limit ?,?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,cur_page*10);
		pstmt.setInt(2,10);
		rs = pstmt.executeQuery();
		
		// 반복여부 추가
		page_rep = total / page_user_rep + 1;
		
		while (rs.next()) {
			String[] regdate = rs.getString("b_regdate").split(" ");
			String date = regdate[0];
			String time = regdate[1];
			
			String idx = rs.getString("b_idx");
			String title = rs.getString("b_title");
			String userid = rs.getString("b_userid");
			String hit = rs.getString("b_hit");
			String like = rs.getString("b_like");
			String reply_howmany = "";
			String isNewHTML = "";
			
			sql = "select count(r_board_idx) as reply_total from tb_reply where r_board_idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,idx);
			ResultSet re_rs = pstmt.executeQuery();
			
			// 댓글 갯수 확인
			if(re_rs.next()){
				int reply_total = re_rs.getInt("reply_total");
				if(reply_total > 0) reply_howmany = "<span>["+ reply_total+ "]</span>";
			}
			
			// 시간 확인
			LocalDate now = LocalDate.now();
			if(date.equals(now.toString())) isNewHTML = "<img src='./img/New.png' style='width:20px; vertical-align:middle;'>";
%>

		<tr align=center>
			<td><%=idx %></td>
			<td style="text-align:left;"><a href="./title_click.jsp?idx=<%=idx %>"><%=title %></a> <%=reply_howmany %> <%=isNewHTML %> </td>
			<td><%=userid %></td>
			<td><%=hit %></td>
			<td><%=date %></td>
			<td><%=like %></td>
		</tr>
<%
		}
%>
		
		<tr>
			<td colspan=5 style="text-align:center;">
<%
			for(int i = 1 ; i <= page_rep; i++){
				String tempHTML = "<a href=./list.jsp?cur_page=" + (i-1) + ">" +" "+i+" " + "</a>";
				out.print(tempHTML);
			}
%>
			<td>
		</tr>
		
	</table>

	<p>
		<input type="button" value="글쓰기" onclick="location.href='./write.jsp'">
		<input type="button" value="메인" onclick="location.href='../login.jsp'">
	</p>
</body>
</html>