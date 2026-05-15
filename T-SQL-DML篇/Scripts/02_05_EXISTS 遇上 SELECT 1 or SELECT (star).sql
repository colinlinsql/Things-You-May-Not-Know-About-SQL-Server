/*======================================================================
課程範例:
EXISTS 遇上 SELECT 1 & SELECT *
------------------------------------
這個範例說明在使用 EXISTS (SELECT 1 or STAR) 的效能比較
以實例來檢視 EXISTS 與
    * SELECT *
    * SELECT 1
    * SELECT TOP 1 *
    * SELECT TOP 1 1
效能的差異 
======================================================================*/

use ColinDemo;
go

/*----------------------------------------
建立測試資料表 dbo.Product
----------------------------------------*/
drop table if exists dbo.Product;
create table dbo.Product
(
    ProductID   int identity(1,1) not null,
    ProductName varchar(100),
    constraint PK_Product primary key clustered (ProductID)
);
go


/*----------------------------------------
建立測試資料表 dbo.ProductOrder
----------------------------------------*/
drop table if exists dbo.ProductOrder;
create table dbo.ProductOrder
(
    ProductOrderID int identity(1,1) not null,
    ProductID int not null,
    constraint PK_ProductOrder primary key clustered (ProductOrderID)
);
go

create nonclustered index IX_ProductOrder_ProductID 
    on dbo.ProductOrder (ProductID);
go


/*----------------------------------------
寫入測試資料 dbo.Product
----------------------------------------*/

insert into dbo.Product (ProductName)
select top 1000000 'Product_' + cast(row_number() over (order by o1.object_id) as varchar(10)) as ProductName
from sys.objects as o1
cross join sys.objects as o2
cross join sys.objects as o3
cross join sys.objects as o4
option (maxdop 1);
go


/*----------------------------------------
寫入測試資料 dbo.ProductOrder
取一半的 Product.ProductID資料 (%2)
----------------------------------------*/
insert into dbo.ProductOrder (ProductID)
select ProductID
from dbo.Product
where ProductID % 2 = 0;
go


/*--------------------------------------------------------------------*/

/*----------------------------------------
請依照課程中的說明, 複製程式碼進行改寫與測試

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/
select p.ProductID
from dbo.Product as p
where EXISTS
    (
        SELECT *
        from dbo.ProductOrder as po
        where po.ProductID = p.ProductID
    );
go



/*----------------------------------------
移除測試資料
use ColinDemo;
go

drop table if exists dbo.Product;
drop table if exists dbo.ProductOrder;
----------------------------------------*/

/*-----END-----*/