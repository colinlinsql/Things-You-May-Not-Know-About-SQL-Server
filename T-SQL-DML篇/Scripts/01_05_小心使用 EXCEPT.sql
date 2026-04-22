/*======================================================================
課程範例:
小心使用 EXCEPT
------------------------------------
這個範例主要介紹 INTERSET 與 EXCEPT 的內容, 
並且提醒在透過 EXCEPT 進行資料比對時, 要留意的重點
======================================================================*/

/*----------------------------------------
這個範例使用的測試資料與前一個範例使用的測試資料相同
(01_04_比較二張表的差異資料 (JOIN).sql)
可以自行選擇是否重建做是延用前一個測試資料來做練習
----------------------------------------*/

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
EXCEPT 與 INTERSECT 語法

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/



/*----------------------------------------
額外補充:
Left Semi Join 相似在使用 EXISTS 的操作
----------------------------------------*/
select * from ExceptLeftTable as L
where id = 7 and exists (select r.Column_03 from ExceptRightTable as R where id = 7)
go



/*----------------------------------------
EXCEPT 與 INTERSECT 語法

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/



/*----------------------------------------
移除測試資料
use ColinDemo;
go

drop table if exists ExceptLeftTable;
drop table if exists ExceptRightTable; 
*/

/*-----END-----*/