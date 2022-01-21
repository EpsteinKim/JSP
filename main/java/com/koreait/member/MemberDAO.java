package com.koreait.member;

import com.koreait.*;
import java.sql.*;


public class MemberDAO {
	Connection conn = Dbconn.getConnection();

	PreparedStatement pstmt;
	ResultSet rs;
	public int insertDB(MemberDTO member) throws SQLException {
		String hobby = "";
		for (String ho : member.getHobby()) {
			hobby += ho + " ";
		}
		if (isNull(conn)) return 0;
		String sql = "insert into tb_member(mem_userid, mem_userpw, mem_name, mem_hp, mem_email, mem_hobby, mem_ssn1, mem_ssn2, mem_zipcode, mem_address1, mem_address2, mem_address3) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, member.getUserid());
		pstmt.setString(2, member.getUserpw());
		pstmt.setString(3, member.getUsername());
		pstmt.setString(4, member.getHp());
		pstmt.setString(5, member.getEmail());

		pstmt.setString(6, hobby);
		pstmt.setString(7, member.getSsn1());
		pstmt.setString(8, member.getSsn2());
		pstmt.setString(9, member.getZipcode());
		pstmt.setString(10, member.getAddress1());
		pstmt.setString(11, member.getAddress2());
		pstmt.setString(12, member.getAddress3());
		if(pstmt.executeUpdate() > 0) return 1;
		return 0;
	}
	
	public MemberDTO login(MemberDTO anonymous) throws SQLException {
		if(isNull(this.conn)) return null;
		
		MemberDTO member_logined = new MemberDTO();
		String sql = "select mem_idx, mem_name from tb_member where mem_userid = ? and mem_userpw = ?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, anonymous.getUserid());
		pstmt.setString(2, anonymous.getUserpw());
		rs = pstmt.executeQuery();
		if(rs.next()) {
			member_logined.setUserid(anonymous.getUserid());
			member_logined.setIdx(rs.getInt("mem_idx"));
			member_logined.setUsername(rs.getString("mem_name"));
		}else member_logined = null;
		
		return member_logined;
	}
	
	public MemberDTO info(MemberDTO target) throws SQLException {
		MemberDTO member_logined = new MemberDTO();
		String sql = "select * from tb_member where mem_idx = ?";
		if(isNull(this.conn)) return null;
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, target.getIdx());
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			member_logined.setIdx(target.getIdx());
			member_logined.setUserid(rs.getString("mem_userid"));
			member_logined.setUsername(rs.getString("mem_name"));
			member_logined.setHp(rs.getString("mem_hp"));
			member_logined.setEmail(rs.getString("mem_email"));
			member_logined.setHobby(rs.getString("mem_hobby").split(" "));
			member_logined.setZipcode(rs.getString("mem_zipcode"));
			member_logined.setAddress1(rs.getString("mem_address1"));
			member_logined.setAddress2(rs.getString("mem_address2"));
			member_logined.setAddress3(rs.getString("mem_address3"));

		}
		
		return member_logined;
	}
	
	public int edit(MemberDTO member) throws SQLException {
		String sql = "update tb_member set mem_name = ?, mem_hp = ?, mem_email =? , mem_hobby = ?, mem_zipcode =?, mem_address1 =?, mem_address2 =?, mem_address3 =? where mem_idx = ? && mem_userpw = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(9, member.getIdx());
		pstmt.setString(10, member.getUserpw());
		pstmt.setString(1, member.getUsername());
		pstmt.setString(2, member.getHp());
		pstmt.setString(3, member.getEmail());
		String hobby ="";
		for(String ho : member.getHobby()) hobby += ho + " ";
		pstmt.setString(4, hobby);
		pstmt.setString(5, member.getZipcode());
		pstmt.setString(6, member.getAddress1());
		pstmt.setString(7, member.getAddress2());
		pstmt.setString(8, member.getAddress3());
		

		return pstmt.executeUpdate();
	}
	private boolean isNull(Connection conn) {
		return conn == null;
	}

}
