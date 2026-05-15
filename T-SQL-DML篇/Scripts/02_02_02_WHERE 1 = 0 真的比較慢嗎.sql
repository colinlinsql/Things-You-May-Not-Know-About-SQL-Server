/*======================================================================
課程範例:
WHERE 1 = 0 真的比較慢嗎?
------------------------------------
當使用 WHERE 1 = 0 的方式可以透過 SELECT 出來的欄位, 
寫入到新的資料表, 這時會依取出來的欄位建立對應的 data type

這個方式與使用 CREATE TABLE 的方式來比較時, 哪一個快呢?
======================================================================*/

use AdventureWorks2025;
go

/*----------------------------------------
利用下列二張暫存資料表來說明
* #tmp_TestTable_1eq0
* #tmp_TestTable_Create
若這二張資料表已存在的話就做刪除的動作
----------------------------------------*/
drop table if exists #tmp_TestTable_1eq0;
drop table if exists #tmp_TestTable_Create;
go


/*----------------------------------------
使用 SELECT ... INTO ... WHERE 1 = 0
的方式來建立 #tmp_TestTable_1eq0
----------------------------------------*/
select
	soh.SalesOrderID,
	sod.SalesOrderDetailID,
	soh.SalesOrderNumber
into
	#tmp_TestTable_1eq0
from
	Sales.SalesOrderHeader as soh
join
	Sales.SalesOrderDetail as sod
	on sod.SalesOrderID = soh.SalesOrderID
where
	1 = 0;
go


/*----------------------------------------
使用 CREATE TABLE
的方式來建立 #tmp_TestTable_Create
----------------------------------------*/
create table #tmp_TestTable_Create
(
	SalesOrderID int,
	SalesOrderDetail int,
	SalesOrderNumber nvarchar(25)
);
go



/*----------------------------------------
測試的語法如上述, 而測試的方式與效能比較
請依照課程中的方式來進行

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/



/*----------------------------------------
移除測試資料
use AdventureWorks2025;
go

drop table if exists #tmp_TestTable_1eq0;
drop table if exists #tmp_TestTable_Create;
----------------------------------------*/

/*-----END-----*/
