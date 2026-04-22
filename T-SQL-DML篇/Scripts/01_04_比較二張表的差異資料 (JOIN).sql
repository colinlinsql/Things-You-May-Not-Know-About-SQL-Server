/*======================================================================
課程範例:
比較二張表的差異資料 (JOIN)
------------------------------------
這個範例主要說明使用 JOIN 的方式來比較二張資料表的內容是否一致或是取出差異
======================================================================*/
use ColinDemo;
go

/*----------------------------------------
建立二張 temp table
* ExceptLeftTable
* ExceptRightTable
----------------------------------------*/
drop table if exists ExceptLeftTable;
create table ExceptLeftTable
(
    ID int,
    Column_01 nvarchar(10),
    Column_02 nvarchar(10),
    Column_03 nvarchar(10)
);

drop table if exists ExceptRightTable;
create table ExceptRightTable
(
    ID int,
    Column_01 nvarchar(10),
    Column_02 nvarchar(10),
    Column_03 nvarchar(10)
);
go


/*----------------------------------------
寫入測試資料, 其中包含
* 第 1 ~ 3 筆與第 7 筆的資料相同
* ExceptLeftTable  多了第 5 筆
* ExceptRightTable 多了第 4 筆
* 二張表的第 6 筆刻意的做差異資料
----------------------------------------*/
insert into ExceptLeftTable
(ID, Column_01, Column_02, Column_03)
values
(1, N'測試資料01_01', N'測試資料02_01', N'測試資料03_01'),
(2, N'測試資料01_02', N'測試資料02_02', N'測試資料03_02'),
(3, N'測試資料01_03', N'測試資料02_03', N'測試資料03_03'),
(5, N'測試資料01_05', N'測試資料02_05', N'測試資料03_05'),
(6, N'測試資料01_06', N'測試資料02_06', N'故意不同03_06'),
(7, N'測試資料01_07', N'測試資料02_07', NULL);

insert into ExceptRightTable
(ID, Column_01, Column_02, Column_03)
values
(1, N'測試資料01_01', N'測試資料02_01', N'測試資料03_01'),
(2, N'測試資料01_02', N'測試資料02_02', N'測試資料03_02'),
(3, N'測試資料01_03', N'測試資料02_03', N'測試資料03_03'),
(4, N'測試資料01_04', N'測試資料02_04', N'測試資料03_04'),
(6, N'測試資料01_06', N'測試資料02_06', N'測試資料03_06'),
(7, N'測試資料01_07', N'測試資料02_07', NULL);
go


/*----------------------------------------
JOIN 語法應用

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/



/*----------------------------------------
移除測試資料
use ColinDemo;
go

drop table if exists ExceptLeftTable;
drop table if exists ExceptRightTable; 
----------------------------------------*/

/*-----END-----*/
