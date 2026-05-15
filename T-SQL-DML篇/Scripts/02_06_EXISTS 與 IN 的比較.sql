/*======================================================================
課程範例:
EXISTS 與 IN 的比較
------------------------------------
這個範例說明在 EXISTS 與 IN 的比較.
* 二者的行為不同
* 某些情況下或性能差異的比較
======================================================================*/
use AdventureWorksDW2025;
go


/*----------------------------------------
主要使用的 IN 範例語法
----------------------------------------*/
select 
	ProductSubcategoryKey,
	EnglishProductSubcategoryName,
	ProductCategoryKey
from 
	dbo.DimProductSubcategory
where
	ProductCategoryKey IN 
    ( 
        << 這裡加入 IN 的條件>> 
    );
go

/*----------------------------------------
主要使用的 EXISTS 範例語法
----------------------------------------*/
select 
	ProductSubcategoryKey,
	EnglishProductSubcategoryName,
	ProductCategoryKey
from 
	dbo.DimProductSubcategory
where
	EXISTS 
	(
		<< 這裡加入 EXISTS 的條件>>
	);
go


/*----------------------------------------
請依照課程中的說明, 複製程式碼進行改寫與測試

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/

/*--------------------------------------------------------------------*/

/*----------------------------------------
EXISTS 通常被運用在 "相關子查詢", 也就是在外層的查詢
與內部查詢 (子查詢) 做一個檢查, 判斷資料值是否存在.
----------------------------------------*/
select
	EmployeeKey,
	FirstName,
	LastName,
	Title
from
	dbo.DimEmployee as e
where
	EXISTS
	(
		select 1
		from dbo.FactResellerSales as f
		where e.EmployeeKey = f.EmployeeKey
	);
go


/*----------------------------------------
當然, 上述例子也可以使用 IN 的方式來表示.
----------------------------------------*/
select
	EmployeeKey,
	FirstName,
	LastName,
	Title
from
	dbo.DimEmployee as e
where
	EmployeeKey IN
	(
		select EmployeeKey
		from dbo.FactResellerSales as f
	);
go


/*----------------------------------------
用上述的例子, 我們進行 EXISTS 與 IN 的一個比較

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/

/*--------------------------------------------------------------------*/

/*----------------------------------------
要篩選多個欄位時, 那就只能使用 EXISTS, IN 只能檢查一個欄位 
----------------------------------------*/

select
	f.EmployeeKey,
	f.SalesTerritoryKey,
	sum(SalesAmount)
from 
	dbo.FactResellerSales as f
where
	EXISTS
	(
		select 1
		from dbo.DimEmployee as e
		where f.EmployeeKey = e.EmployeeKey
		and f.SalesTerritoryKey = e.SalesTerritoryKey
		and e.SalesTerritoryKey <> 11
	)
group by 
	f.EmployeeKey,
	f.SalesTerritoryKey;
go


/*----------------------------------------
用上述的例子, 改寫為 JOIN 的語法

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/

/*--------------------------------------------------------------------*/


/*----------------------------------------
使用 IN / NOT IN 
與 EXISTS / NOT EXISTS
遇到 NULL 值時會產生的現象
----------------------------------------*/

/*----------------------------------------
主要使用的 IN 範例語法
----------------------------------------*/
select 
	ProductSubcategoryKey,
	EnglishProductSubcategoryName,
	ProductCategoryKey
from 
	dbo.DimProductSubcategory
where
	ProductCategoryKey /* NOT */ IN 
    ( 
        << 這裡加入 IN 的條件>> 
    );
go

/*----------------------------------------
主要使用的 EXISTS 範例語法
----------------------------------------*/
select 
	ProductSubcategoryKey,
	EnglishProductSubcategoryName,
	ProductCategoryKey
from 
	dbo.DimProductSubcategory
where
	/* NOT */ EXISTS 
	(
		<< 這裡加入 EXISTS 的條件>>
	);
go

/*----------------------------------------
請依照課程中的說明, 複製程式碼進行改寫與測試

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/



/*----------------------------------------
移除測試資料

----------------------------------------*/

/*-----END-----*/