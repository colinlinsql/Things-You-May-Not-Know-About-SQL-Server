/*======================================================================
課程範例:
UNION 和你想的可能不一樣
------------------------------------
這個範例主要說明 UNION 在排除重複資料時的注意事項
======================================================================*/
use tempdb;
go

/*----------------------------------------
建立二張 temp table
* #tmp_1, 包含 4 筆資料
* #tmp_2, 包含 5 筆資料
----------------------------------------*/
drop table if exists #tmp_1;
create table #tmp_1 (MyString varchar(5), MyInt int);
insert into #tmp_1 values ('Space',1), ('Space', 2), ('Space', 3),('Space', 1);

drop table if exists #tmp_2;
create table #tmp_2 (MyString varchar(5), MyInt int);
insert into #tmp_2 values ('Enter',1), ('Enter', 2), ('Enter', 3),('Enter', 1),('Space', 1);
go


/*----------------------------------------
UNION 與 UNION ALL 語法應用

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/


/*--------------------------------------------------------------------*/

/*----------------------------------------
再建立一張 temp table
* #tmp_3, 包含 4 筆資料
----------------------------------------*/
drop table if exists #tmp_3;
create table #tmp_3 (MyString varchar(5), MyInt int);
insert into #tmp_3 values ('Shift',1), ('Shift', 2), ('Shift', 3),('Shift', 1);
go


/*----------------------------------------
UNION 與 UNION ALL 語法應用

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/




/*----------------------------------------
移除測試資料
use tempdb;
go

drop table if exists #tmp_1;
drop table if exists #tmp_2;
drop table if exists #tmp_3;
----------------------------------------*/

/*-----END-----*/