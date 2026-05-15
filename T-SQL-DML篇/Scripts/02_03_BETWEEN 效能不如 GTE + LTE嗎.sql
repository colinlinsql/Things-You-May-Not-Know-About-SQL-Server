/*======================================================================
課程範例:
BETWEEN 效能不如 GTE + LTE嗎?
------------------------------------
這個範例說明了 BETWEEN 與 GTE (>=) + LTE (<=) 的效能比較

注意: 
    由於範例資料會利用隨機產生的方式建立, 
    可能看到的結果會與課程中不一致
======================================================================*/
use ColinDemo;
go

/*----------------------------------------
建立範例資料表
    ColinDemo.dbo.Demo_Between_vs_GTE_and_LTE
----------------------------------------*/
drop table if exists dbo.Demo_Between_vs_GTE_and_LTE;
create table dbo.Demo_Between_vs_GTE_and_LTE
(
    id int identity(1,1) not null,
    date_time datetime null,
    constraint PK_Demo_Between_vs_GTE_and_LTE primary key clustered
    (
        id asc
    )
);
go


/*----------------------------------------
透過迴圈寫入 1000000 資料
資料內容是 1900-01-01 ~ 1999-12-31 區間內的亂數資料
因此後續呈現的結果不會每次都相同
----------------------------------------*/
set nocount on;
declare @i int = 1;
declare @date_from datetime = '1900-01-01';
declare @date_to   datetime = '1999-12-31';

begin tran
    while @i < 1000000
    begin
        insert into dbo.Demo_Between_vs_GTE_and_LTE (date_time)
        select
        (
            @date_from + abs(cast(cast(newid() as binary(8))as int)) % cast((@date_to - @date_from) as int)
        )

        set @i = @i + 1;
    end
commit tran
go


/*--------------------------------------------------------------------*/

/*----------------------------------------
比較 BETWEEN 與 GTE + LTE
請依照課程中的說明進行各項測試比較

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/
set statistics time on;
select *
from Demo_Between_vs_GTE_and_LTE
where date_time between '1945-01-08' and '1965-01-01';
set statistics time off;

set statistics time on;
select * 
from Demo_Between_vs_GTE_and_LTE
where date_time >= '1945-01-08' and date_time <= '1965-01-01';
set statistics time off;
go



/*----------------------------------------
移除測試資料
use ColinDemo;
go

drop table if exists dbo.Demo_Between_vs_GTE_and_LTE;
----------------------------------------*/

/*-----END-----*/