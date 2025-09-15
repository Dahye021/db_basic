package callableStatementEx;

import jdbc_boards.util.DBUtil;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class MemberInsert {
    static Connection conn = DBUtil.getConnection();
    public static void main(String[] args) {
        String m_userid = "jenny";
        String m_pwd = "jenny1234";
        String m_email = "jenny@blackping.com";
        String m_hp = "010-1234-1234";
        String resultString = null;

        String sql = "{CALL SP_MEMBER_INSERT(?,?,?,?,?)}";

        try(CallableStatement call = conn.prepareCall(sql)){
            call.setString(1,m_userid);
            call.setString(2,m_pwd);
            call.setString(3,m_email);
            call.setString(4,m_hp);

            call.registerOutParameter(5,java.sql.Types.INTEGER);

            call.execute();
            int rtn = call.getInt(5);

            if(rtn == 100) {
               // conn.rollback();
                System.out.println("이미 가입된 사용자 입니다.");
            } else {
               // conn.commit();
                System.out.println("회원 가입이 되었습니다. 감사합니다.");
            }
        }catch (SQLException e) {
//            try{conn.rollback();} catch (SQLException ex) {
//                ex.printStackTrace();
//            }
        }

    }
}
