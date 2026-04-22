/*======================================================================
課程範例:
小心使用 EXCEPT
------------------------------------
這個範例主要介紹 INTERSET 與 EXCEPT 的內容, 
並且提醒在透過 EXCEPT 進行資料比對時, 要留意的重點


這個範例會使用下列 View
    AdventureWorksDW2025.dbo.vTimeSeries
======================================================================*/

use AdventureWorksDW2025;
go

/*----------------------------------------
手動將 AdventureWorksDW2025.dbo.vTimeSeries
這個物件產生出 Script, 放置在這裡做說明
----------------------------------------*/



/*--------------------------------------------------------------------------------*/

/*----------------------------------------
先確認 APPLY 可以運用在不參照資料表物件的可能性
----------------------------------------*/

/*----------------------------------------
假設有一個資料表, 儲存了日期的資料
並且使用 year 函數取出年份資料
----------------------------------------*/
select
	MyDate,
	year(DateList.MyDate) as YearOfMyDate
from
	(values ('2020-03-04'),('2021-03-04'),('2022-03-04'),('2023-03-04'),('2024-03-04'),('2025-03-04')) DateList(MyDate);
go


/*----------------------------------------
若是要針對上述資料, 進行是否為閏年的話
一般常運用的方式是透過 case when
----------------------------------------*/
select
	MyDate,
	year(DateList.MyDate) as YearOfMyDate,
	case 
		when year(DateList.MyDate) % 4 = 0 and year(DateList.MyDate) % 400 <> 0
		then 'Leap Year'
		else 'Not Leap Year'
	end as LeapYear
from
	(values ('2020-03-04'),('2021-03-04'),('2022-03-04'),('2023-03-04'),('2024-03-04'),('2025-03-04')) DateList(MyDate);
go


/*----------------------------------------
利用 APPLY 簡化上述測試語法

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/


/*--------------------------------------------------------------------------------*/

use AdventureWorksDW2025;
go


/*----------------------------------------
利用 APPLY 簡化 AdventureWorksDW2025.dbo.vTimeSeries
* 自行手動做一次, 加強記憶
* 記得要修改物件名稱, 做一個新的物件出來, 
  例如 AdventureWorksDW2025.dbo.[vTimeSeries_ColinDemoApply]

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/



/*----------------------------------------
將原來的
AdventureWorksDW2025.dbo.vTimeSeries
與新建立的
AdventureWorksDW2025.dbo.vTimeSeries_ColinDemoApply
進行執行計劃的比對

開啟執行計劃 (Include Actual Execution Plan)
----------------------------------------*/
select * from dbo.vTimeSeries;
select * from dbo.vTimeSeries_ColinDemoApply;
go



/*----------------------------------------
移除測試資料
use AdventureWorksDW2025;
go

drop view dbo.vTimeSeries_ColinDemoApply;
----------------------------------------*/

/*-----END-----*/