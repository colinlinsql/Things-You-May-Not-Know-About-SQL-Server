/*======================================================================
課程範例:
GROUP BY 裡的 CASE WHEN
------------------------------------
有時為了開發應用的方便性, 在 GROUP BY 裡進行 CASE WHEN 的操作

這個範例主要說明, 在GROUP BY中使用CASE WHEN的條件時, 
有機會吃不到Index的狀況. 而不是在說明效能優化的實例.

範例中會使用WideWorldImporters資料庫
======================================================================*/
use WideWorldImporters;
go

/*----------------------------------------
建立測試Procedure dbo.ColinGroup
    * 將Sales.Invoices與Sales.InvioceLines
      進行Join, 並依輸入參數利用CASE WHEN進
      行GROUP BY的動作 
----------------------------------------*/
create or alter procedure dbo.ColinGroup
(
	@p_input_int int
)
as
	select
		sum(il.UnitPrice),
		count(i.ContactPersonID),
		count(i.AccountsPersonID),
		count(i.SalespersonPersonID)
	from
		Sales.Invoices as i
	join
		Sales.InvoiceLines as il
		on il.InvoiceID = i.InvoiceID
	GROUP BY
		CASE
			WHEN @p_input_int =  7 THEN i.ContactPersonID
			WHEN @p_input_int = 15 THEN i.AccountsPersonID
			ELSE i.SalespersonPersonID
		END;
go

/* 測試語法 */
exec dbo.ColinGroup @p_input_int =  1;
go

/*----------------------------------------
請依照課程中的說明進行各項測試
* 代入參數分別為 1, 7, 15, 20

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/


/*----------------------------------------
有人提到這個看似 Sniffing
那就做一個避 Sniffing 的測試
----------------------------------------*/

/*----------------------------------------
請依照課程中的說明進行語法的修改
* 建立新的物件為 dbo.ColinGroup_WithoutSniffing
* 加入 local variable
    declare @v_replace_int int;
    set @v_replace_int = @p_input_int;
* 對應的 CASE WHEN 調整使用的參數為上述的 local variable

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/
create or alter procedure dbo.ColinGroup_WithoutSniffing
(
	@p_input_int int
)
as
    /* 範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業) */
    
go


/* 測試語法 */
exec dbo.ColinGroup_WithoutSniffing @p_input_int =  1;
go

/*----------------------------------------
請依照課程中的說明進行各項測試
* 代入參數分別為 1, 7, 15, 20

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/



/*====================================================================*/

/*----------------------------------------
實際上, 上述的 Procedure, 拆分後也就是下列三個
的組合
    * ColinGroup_SalespersonPersonID
    * ColinGroup_ContactPersonID
    * ColinGroup_AccountsPersonID
----------------------------------------*/
create or alter procedure ColinGroup_SalespersonPersonID
as
    select
        sum(il.UnitPrice),
        count(i.ContactPersonID),
        count(i.AccountsPersonID),
        count(i.SalespersonPersonID)
    from
        Sales.Invoices as i
    join
        Sales.InvoiceLines as il
        on il.InvoiceID = i.InvoiceID
    GROUP BY
        i.SalespersonPersonID;
go

create or alter procedure ColinGroup_ContactPersonID
as
    select
        sum(il.UnitPrice),
        count(i.ContactPersonID),
        count(i.AccountsPersonID),
        count(i.SalespersonPersonID)
    from
        Sales.Invoices as i
    join
        Sales.InvoiceLines as il
        on il.InvoiceID = i.InvoiceID
    GROUP BY
        i.ContactPersonID;
go

create or alter procedure ColinGroup_AccountsPersonID
as
    select
        sum(il.UnitPrice),
        count(i.ContactPersonID),
        count(i.AccountsPersonID),
        count(i.SalespersonPersonID)
    from
        Sales.Invoices as i
    join
        Sales.InvoiceLines as il
        on il.InvoiceID = i.InvoiceID
    GROUP BY
        i.AccountsPersonID;
go

/* 測試語法 */
exec dbo.ColinGroup_SalespersonPersonID;
exec dbo.ColinGroup_ContactPersonID;
exec dbo.ColinGroup_AccountsPersonID;
go


/*----------------------------------------
建立測試 Index 在 Sales.Invoices (SalespersonPersonID)
----------------------------------------*/

create index IX_ColinGroup_SalespersonPersonID
on Sales.Invoices (SalespersonPersonID);

/* 測試語法 */
exec dbo.ColinGroup_SalespersonPersonID;


/*----------------------------------------
再回頭測試原來的dbo.ColinGroup
這時使用 7 和 15 以外的, 應要走到 NonClustered 
----------------------------------------*/
exec dbo.ColinGroup @p_input_int =  1;
exec dbo.ColinGroup @p_input_int = 20;
go



/*----------------------------------------
移除測試資料

use ColinDemo;
go
drop index IX_ColinGroup_SalespersonPersonID on Sales.Invoices;
drop procedure dbo.ColinGroup_AccountsPersonID;
drop procedure dbo.ColinGroup_ContactPersonID;
drop procedure dbo.ColinGroup_SalespersonPersonID;
drop procedure dbo.ColinGroup_WithoutSniffing;
drop procedure dbo.ColinGroup;
----------------------------------------*/

/*-----END-----*/




