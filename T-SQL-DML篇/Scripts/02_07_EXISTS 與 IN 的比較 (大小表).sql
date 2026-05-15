/*======================================================================
課程範例:
EXISTS 與 IN 的比較 (大小表)
------------------------------------
這個範例說明了在二張資料量有相當差異的條件下,
進行 (NOT) EXISTS 與 (NOT) IN 的效能比較

注意: 
    由於範例資料會利用隨機產生的方式建立, 
    可能看到的結果會與課程中不一致
======================================================================*/

use ColinDemo;
go

/*----------------------------------------
建立測試資料表
* dbo.Table_Big   => 大表
* dbo.Table_Small => 小表
----------------------------------------*/
drop table if exists dbo.Table_Big;
create table dbo.Table_Big
(
    id int identity (1,1) primary key,
    TB_Data1 char(4),
    TB_Data2 char(100)
);
go

drop table if exists dbo.Table_Small;
create table dbo.Table_Small
(
    id int identity (1,1) primary key,
    CheckData char(4),
    TestDate datetime default getdate()
);
go


/*----------------------------------------
寫入測試資料
* dbo.Table_Big   => 250000筆
* dbo.Table_Small => 取樣大表中的25%
這裡可以使用其他的取樣百分比或是ROW數,
可以看到影響最後執行的執行計劃
----------------------------------------*/
insert into dbo.Table_Big (TB_Data1)
select top 250000
      char(65 + FLOOR(RAND(a.column_id * 5645 + b.object_id) * 10)) 
    + char(65 + FLOOR(RAND(b.column_id * 3784 + b.object_id) * 12)) 
    + char(65 + FLOOR(RAND(b.column_id * 6841 + a.object_id) * 12)) 
    + char(65 + FLOOR(RAND(a.column_id * 7544 + b.object_id) * 8))
from master.sys.columns a cross join master.sys.columns b;
go

insert into dbo.Table_Small (CheckData)
select distinct TB_Data1
from dbo.Table_Big TABLESAMPLE (25 PERCENT);
go


/*----------------------------------------
更新部份資料的範例程式碼
----------------------------------------*/
update Table_Small
set CheckData = '****'
where id in
(select top 100 id from Table_Small);
go


/*----------------------------------------
建立 index 範例程式碼
----------------------------------------*/
create index IX_TB_Data1
on dbo.Table_Big (TB_Data1);

create index IX_CheckData
on dbo.Table_Small (CheckData);
go


/*----------------------------------------
大表在外的範例程式碼
----------------------------------------*/
/* IN */
select
    id, TB_Data1
from 
    dbo.Table_Big
where 
    TB_Data1 IN
    (
        select CheckData
        from dbo.Table_Small
    );

/* EXISTS */
select
    id, TB_Data1
from 
    dbo.Table_Big as tb
where 
    EXISTS
    (
        select CheckData
        from dbo.Table_Small as ts
        where ts.CheckData = tb.TB_Data1
    );


/*----------------------------------------
小表在外的範例程式碼
----------------------------------------*/
/* IN */
select
    id, CheckData
from 
    dbo.Table_Small
where 
    CheckData IN
    (
        select TB_Data1
        from dbo.Table_Big
    );

/* EXISTS */
select
    id, CheckData
from 
    dbo.Table_Small as ts
where 
    EXISTS
    (
        select TB_Data1
        from dbo.Table_Big as tb
        where ts.CheckData = tb.TB_Data1
    );


/*----------------------------------------
請依照課程中的說明, 複製程式碼進行改寫與測試

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/



/*----------------------------------------
移除測試資料
use ColinDemo;
go

drop table if exists dbo.Table_Big;
drop table if exists dbo.Table_Small;
----------------------------------------*/

/*-----END-----*/

