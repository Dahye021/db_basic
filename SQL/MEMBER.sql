use bookmarketdb;

create table CODE1(
    CID int, cName VARCHAR(50)
);
desc code1;

insert into code1(cid, cname)
select ifnull (max(cid),0) +1 as cld2,'test' as cname2
from code1;

select * from code1;

truncate code1;

CREATE TABLE TB_MEMBER (
                           m_seq INT AUTO_INCREMENT PRIMARY KEY,  -- 자동 증가 시퀀스
                           m_userid VARCHAR(20) NOT NULL,
                           m_pwd VARCHAR(20) NOT NULL,
                           m_email VARCHAR(50) NULL,
                           m_hp VARCHAR(20) NULL,
                           m_registdate DATETIME DEFAULT NOW(),  -- 기본값: 현재 날짜와 시간
                           m_point INT DEFAULT 0
);

DELIMITER $$
CREATE PROCEDURE SP_MEMBER_INSERT(
    in V_USERID VARCHAR(20),
    IN V_PWD VARCHAR(20),
    IN V_EMAIL VARCHAR(50),
    IN V_HP VARCHAR(20),
    OUT RTN_CODE INT
)
BEGIN
    DECLARE EXIT HANDLER for sqlexception
        begin
            set rtn_code = -1;
            rollback;
        end;

        start transaction;

        if exists (select 1 from TB_MEMBER where m_userid = V_USERID) then
            set RTN_CODE = 100;
            rollback ;
        else
            insert into tb_member (m_userid, m_pwd, m_email, m_hp, m_registdate, m_point)
                value (V_USERID, V_PWD, V_EMAIL, V_HP, now(), 0);
                set RTN_CODE = 200;
                commit ;
        end if ;
END $$
DELIMITER ;

call SP_MEMBER_INSERT('apple','1111','apple@sample.com','010-1111-1111',@result);
select @result;

select * from TB_MEMBER;

DELIMITER $$
CREATE PROCEDURE SP_MEMBER_LIST()
    BEGIN
        select *
        from TB_MEMBER
        order by m_seq asc;
    END $$
DELIMITER ;

CALL SP_MEMBER_LIST();


delimiter $$
CREATE PROCEDURE SP_MEMBER_UPDATE(
    IN V_SEQ INT,
    IN V_PWD VARCHAR(20),
    IN V_EMAIL VARCHAR(50),
    IN V_HP VARCHAR(20),
    OUT RTN_CODE INT
)
BEGIN
    DECLARE CNT INT;

    SELECT COUNT(*) INTO CNT FROM TB_MEMBER WHERE m_seq = V_SEQ;

    IF CNT = 0 THEN
        set RTN_CODE = 100;
    else
        update TB_MEMBER
            set
                m_pwd = V_PWD,
                m_email = V_EMAIL,
                m_hp = V_HP
        where m_seq = V_SEQ;

        set rtn_code = 200;
    end if;
END $$
DELIMITER  ;