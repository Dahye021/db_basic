use bookmarketdb;

create table orderTbl(
    orderNo INT AUTO_INCREMENT PRIMARY KEY,
    userID varchar(5),
    prodName varchar(5),
    orderamount INT
);

create table prodTbl(
    prodName VARCHAR(5),
    account INT
);

create table deliverTbl(
    deliverNo int AUTO_INCREMENT primary key,
    prodName varchar(5),
    account int unique
);

insert into prodTbl values('사과', 100);
insert into prodTbl values('배', 100);
insert into prodTbl values('귤', 100);

drop trigger if exists orderTrg;
delimiter //
create trigger orderTrg
       after insert
    on orderTbl
    FOR EACH ROW
begin
    update  prodTbl set account = account - NEW.orderamount
    where prodName = NEW.prodName;
end //
DELIMITER ;

drop trigger if exists prodTrg;
delimiter //
create trigger prodTrg
    after update
    on prodTbl
    for each ROW
begin
    declare orderAmount int;
    set orderAmount = OLD.account - new.account;
    insert into deliverTbl(prodName, account)
        values (new.prodName, orderAmount);
end //
delimiter ;

insert into orderTbl values (null,'john','배',5);

select * from orderTbl;
select *from prodTbl;
select * from deliverTbl;

alter table deliverTBL change prodName productName varchar(5);

insert into orderTbl values (null, 'dang', '사과', 9);

select * from orderTbl;
select *from prodTbl;
select * from deliverTbl;