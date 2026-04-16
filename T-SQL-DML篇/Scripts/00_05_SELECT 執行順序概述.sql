/*======================================================================
課程範例:
SELECT 執行順序概述
------------------------------------
下列語法會在 ColinDemo 資料庫中, 建立二張範例資料表
* dbo.Customers
* dbo.Orders
並且寫入測試資料
======================================================================*/
use ColinDemo;
go

/*----------------------------------------
建立測試資料表
----------------------------------------*/
drop table if exists dbo.Orders;
drop table if exists dbo.Customers;

create table dbo.Customers
(
    customerid  char(10)    not null primary key,
    city        varchar(10) not null
);

create table dbo.Orders
(
    orderid     int         not null primary key,
    customerid  char(10)    null references Customers(customerid)
);
go


/*----------------------------------------
寫入測試資料
----------------------------------------*/
insert into dbo.Customers (customerid, city)
values ('Colin' , 'Taipei'),
       ('Vivi'  , 'Taipei'),
       ('Eva'   , 'Taipei'),
       ('Parker', 'Kaohsiung');

insert into dbo.Orders (orderid, customerid)
values (1, 'Vivi'),
       (2, 'Vivi'),
       (3, 'Eva'),
       (4, 'Eva'),
       (5, 'Eva'),
       (6, 'Parker'),
       (7, null);

/* 檢查資料 與輸出用 */
select * from dbo.Customers;
select * from dbo.Orders;


/*----------------------------------------
取出在Taipei交易的資料, 只取小於3筆訂單的記錄
以訂單數量倒序排序 (大到小)

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/




/*----------------------------------------
移除測試資料
use ColinDemo;
go

drop table if exists dbo.Orders;
drop table if exists dbo.Customers;
----------------------------------------*/

/*-----END-----*/