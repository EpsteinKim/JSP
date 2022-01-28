<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.time.LocalDate"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="boardDTO" class="com.koreait.board.BoardDTO" />
<jsp:useBean id="boardDAO" class="com.koreait.board.BoardDAO" />

<c:set var="total" value="${boardDAO.listTotal() }" />

<%-- <c:set var="cur_page" value='${pageContext.request.getParameter("cur_page") }' /> --%>
<!-- request.getParameter를 사용하려면 pageContext로 request 객체를 불러와야 된다. -->

<c:set var="cur_page" value='${param.cur_page }'/>
<!-- JSTL에서 param이라는 객체는 request.getParameter들의 값이 모여있는 곳 -->

<c:if test='${empty cur_page || cur_page < 1}'>
<c:set var="cur_page" value="1"/>
</c:if>
<!-- 도메인을 임의로 수정하는 경우 cur_page값 고정 -->

<c:set var="boardList" value="${boardDAO.selectBoard(cur_page)}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>커뮤니티 - 리스트</title>
</head>
<body>
	<h2>커뮤니티 - 리스트</h2>
	<p>게시글 : ${total }</p>

	<table border="1" width="800">
		<tr>
			<th width="50">번호</th>
			<th width="300">제목</th>
			<th width="100">글쓴이</th>
			<th width="75">조회수</th>
			<th width="200">날짜</th>
			<th width="75">좋아요</th>
		</tr>

		<c:set var='now' value="${LocalDate.now() }" />
		<c:forEach var="item" items="${boardList}" varStatus="status">
			<c:set var="replyNum" value="${boardDAO.reply_total(item.idx) }" />
			<c:choose>
				<c:when test='${replyNum eq 0 }'>
					<c:remove var="replyNum" />
				</c:when>
				<c:otherwise>
					<c:set var="replyNum" value="[${replyNum }]" />
				</c:otherwise>
			</c:choose>
			<tr align=center>
				<td>${item.idx}</td>
				<td><a href='./view.jsp?idx=${item.idx}'>${item.title }</a>${replyNum }
					<c:if test='${now eq item.regdate.split(" ")[0] }'>
						<img style="width: 15px;"
							src="https://img.icons8.com/ios-glyphs/344/new.png">
					</c:if></td>
				<td>${item.userid }</td>
				<td>${item.hit }</td>
				<td>${item.regdate.split(" ")[0] }</td>
				<td>${item.like}</td>
			</tr>
		</c:forEach>
		<tr>
			<td colspan=7 style="text-align: center;">
			<c:forEach var="pageNum" items='${boardDAO.pagination(total) }'>
			<span> <a href="./list.jsp?cur_page=${pageNum}">${pageNum}</a> </span>
			</c:forEach>
			</td>
		</tr>

	</table>

	<p>
		<input type="button" value="글쓰기" onclick="location.href='./write.jsp'">
		<input type="button" value="메인" onclick="location.href='../login.jsp'">
	</p>
</body>
</html>