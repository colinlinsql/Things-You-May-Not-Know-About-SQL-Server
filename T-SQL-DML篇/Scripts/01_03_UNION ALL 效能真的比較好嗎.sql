/*======================================================================
課程範例:
UNION ALL 效能真的比較好嗎
------------------------------------
這個範例主要說明 UNION ALL 與 UNION 在效能上的比較
======================================================================*/

use ColinDemo;
go

/*----------------------------------------
建立二張
* DemoUnion_1000_A
* DemoUnion_1000_B
並且寫入 1000 資料至上述二張表
----------------------------------------*/
drop table if exists DemoUnion_1000_A;
drop table if exists DemoUnion_1000_B;

create table DemoUnion_1000_A
(ID int, MyDateTime datetime);

create table DemoUnion_1000_B
(ID int, MyDateTime datetime);

set nocount on;
declare @i int = 1;
begin tran
while @i <= 1000
begin
    insert into DemoUnion_1000_A values (@i, getdate());
    insert into DemoUnion_1000_B values (@i, getdate());
    set @i = @i + 1;
end
commit tran
go

/*----------------------------------------
在 DemoUnion_1000_A 資料表裡再寫一筆資料
做為差異資料區分
----------------------------------------*/
insert into DemoUnion_1000_A values (999999, getdate());
go


/*----------------------------------------
利用相同的模式, 再建立二張
* DemoUnion_10000_A
* DemoUnion_10000_B
並且寫入 10000 資料至上述二張表
----------------------------------------*/
drop table if exists DemoUnion_10000_A;
drop table if exists DemoUnion_10000_B;

create table DemoUnion_10000_A
(ID int, MyDateTime datetime);

create table DemoUnion_10000_B
(ID int, MyDateTime datetime);

set nocount on;
declare @i int = 1;
begin tran
while @i <= 10000
begin
    insert into DemoUnion_10000_A values (@i, getdate());
    insert into DemoUnion_10000_B values (@i, getdate());
    set @i = @i + 1;
end
commit tran
go

/*----------------------------------------
在 DemoUnion_10000_A 資料表裡再寫一筆資料
做為差異資料區分
----------------------------------------*/
insert into DemoUnion_10000_A values (999999, getdate());
go


/*----------------------------------------
利用相同的模式, 再建立二張
* DemoUnion_100000_A
* DemoUnion_100000_B
並且寫入 100000 資料至上述二張表
----------------------------------------*/
drop table if exists DemoUnion_100000_A;
drop table if exists DemoUnion_100000_B;

create table DemoUnion_100000_A
(ID int, MyDateTime datetime);

create table DemoUnion_100000_B
(ID int, MyDateTime datetime);

set nocount on;
declare @i int = 1;
begin tran
while @i <= 100000
begin
    insert into DemoUnion_100000_A values (@i, getdate());
    insert into DemoUnion_100000_B values (@i, getdate());
    set @i = @i + 1;
end
commit tran
go

/*----------------------------------------
在 DemoUnion_100000_A 資料表裡再寫一筆資料
做為差異資料區分
----------------------------------------*/
insert into DemoUnion_100000_A values (999999, getdate());
go



/*----------------------------------------
UNION 與 UNION ALL 語法應用

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/




/*----------------------------------------
移除測試資料
use ColinDemo;
go

drop table if exists DemoUnion_1000_A;
drop table if exists DemoUnion_1000_B;
drop table if exists DemoUnion_10000_A;
drop table if exists DemoUnion_10000_B;
drop table if exists DemoUnion_100000_A;
drop table if exists DemoUnion_100000_B;
----------------------------------------*/

/*-----END-----*/
