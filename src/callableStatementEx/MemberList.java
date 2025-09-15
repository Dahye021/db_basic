package callableStatementEx;

import jdbc_boards.util.DBUtil;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberList {
    static Connection conn = DBUtil.getConnection();

    public static void main(String[] args) {
        String sql = "{call SP_MEMBER_LIST()}";

        try(CallableStatement cs = conn.prepareCall(sql); ResultSet rs = cs.executeQuery()) {
            conn.setAutoCommit(false);

            while(rs.next()){
                System.out.println("m_seq: "+rs.getInt(1));
                System.out.println("m_userid: "+rs.getString(2));
                System.out.println("m_pwd: "+rs.getString(3));
                System.out.println("m_email: "+rs.getString(4));
                System.out.println("m_hp: "+rs.getString(5));
                System.out.println("m_registdate: "+rs.getDate(6));
                System.out.println("m_point: "+rs.getInt(7));
                System.out.println("=============================================");
            }
        }catch(SQLException e){
            try{conn.rollback();}catch(SQLException e1){e.printStackTrace();}
        }
    }
}
