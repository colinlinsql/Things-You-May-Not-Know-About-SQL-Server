/*======================================================================
課程範例:
當 CASE WHEN 遇上 NULL
------------------------------------
CASE WHEN 有二種模式, 在處理 NULL 時有不同的行為模式

* CASE <object> WHEN => 簡單
* CASE WHEN <object> => 搜尋
======================================================================*/

/*----------------------------------------
使用 CASE <object> WHEN 查詢資料庫的復原模式 (簡單)
----------------------------------------*/
use master;
go

select
    name,
    case recovery_model
        when 1 then 'FULL'
        when 2 then 'BULK_LOGGED'
        when 3 then 'SIMPLE'
        else 'UNKNOWN'
    end as user_acccess_desc
from sys.databases;

/*----------------------------------------
使用 CASE WHEN <object> 查詢資料庫的復原模式 (搜尋)
----------------------------------------*/
use master;
go

select
    name,
    case 
        when recovery_model = 1 then 'FULL'
        when recovery_model = 2 then 'BULK_LOGGED'
        when recovery_model = 3 then 'SIMPLE'
        else 'UNKNOWN'
    end as user_acccess_desc
from sys.databases;



/*========================================
若是使用 CASE 的判斷式, 進行 NULL 的比較
要小心二者的差異
========================================*/
use ColinDemo;
go

/*----------------------------------------
建立範例資料
----------------------------------------*/
drop table if exists Demo_Case_With_NULL;
create table Demo_Case_With_NULL
(
    id int, 
    MyData varchar(20)
);
go

insert into Demo_Case_With_NULL (id, MyData)
values (1, 'Test'), (2, null);
go


/*----------------------------------------
使用 CASE <object> WHEN 與 CASE WHEN <object> 判斷 MyData
    當 Test 時顯示 "符合Test"
    當 NULL 時顥示 "值為NULL"
----------------------------------------*/
select
    CASE MyData
        WHEN 'Test' THEN N'符合Test'
        WHEN NULL   THEN N'值為NULL'
        ELSE 'N/A'
    END as Demo_CASE_object_WHEN,
    CASE 
        WHEN MyData = 'Test' THEN N'符合Test'
        WHEN MyData is null  THEN N'值為NULL'
        ELSE 'N/A'
    END as Demo_CASE_WHEN_object
from Demo_Case_With_NULL;



/*----------------------------------------
移除測試資料

use ColinDemo;
go
drop table if exists Demo_Case_With_NULL;
----------------------------------------*/

/*-----END-----*/