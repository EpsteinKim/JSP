package com.koreait.board;
import com.koreait.*;
import java.sql.*;
import java.util.*;

public class BoardDAO {
	Connection conn = Dbconn.getConnection();
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = null;
	
	public boolean write(BoardDTO board) throws SQLException {
		sql = "insert into tb_board(b_userid, b_title, b_content, b_file) values(?,?,?,?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, board.getUserid());
		pstmt.setString(2, board.getTitle());
		pstmt.setString(3, board.getContent());
		pstmt.setString(4, board.getFile());
		
		if(pstmt.executeUpdate()>0) 	return true;
		else							return false;
	}
	
	public List<BoardDTO> selectBoard(int cur_page) throws SQLException{
		List<BoardDTO> boardList = new ArrayList<>();
		sql = "select b_idx, b_userid, b_title, b_regdate, b_hit, b_like, b_file from tb_board order by b_idx desc limit ?, 10";
		pstmt = conn.prepareStatement(sql);
		int boardStartIndex = (cur_page - 1) * 10;
		pstmt.setInt(1, boardStartIndex);
		rs = pstmt.executeQuery();
		while(rs.next()) {
			BoardDTO board = new BoardDTO();
			board.setIdx(rs.getInt("b_idx"));
			board.setUserid(rs.getString("b_userid"));
			board.setTitle(rs.getString("b_title"));
			board.setRegdate(rs.getString("b_regdate"));
			board.setHit(rs.getInt("b_hit"));
			board.setLike(rs.getInt("b_like"));
			board.setFile(rs.getString("b_file"));
			boardList.add(board);
		}
		return boardList;
	}
	public int listTotal() throws SQLException{
		sql = "select count(b_idx) as total from tb_board";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			return rs.getInt("total");
		}
		return 0;
	}
	
	public int reply_total(int b_idx) throws SQLException{
		sql = "select count(r_idx) as total from tb_reply where r_board_idx = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, b_idx);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			return rs.getInt("total");
		}
		return 0;
	}
	
	public List<Integer> pagination(int total) throws SQLException{
		int pageAll = total / 10 + 1;
		int pageLeft = total % 10;
		if(pageLeft == 0) pageAll--;
		List<Integer> temp = new ArrayList<>();
		for(int i = 1; i<=pageAll; i++) temp.add(i);
		return temp;
	}
}





