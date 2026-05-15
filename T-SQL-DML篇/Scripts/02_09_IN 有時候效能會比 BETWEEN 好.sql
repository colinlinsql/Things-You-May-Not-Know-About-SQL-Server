/*======================================================================
課程範例:
IN 有時候效能會比 BETWEEN 好
------------------------------------
這個範例利用 IN 與 BETWEEN 在不同的資料結構上做比較
來說明 Colin 老師一直在提及的 "任何效能的考量都要不斷的測試才能找到最適合的"
這個實例就是在不同的資料結構 (INDEX) 下, 來看 IN 與 BETWEEN 取相同資料的效能評比

注意: 
    由於範例資料會利用隨機產生的方式建立, 
    可能看到的結果會與課程中不一致
======================================================================*/

use ColinDemo;
go

/*----------------------------------------
建立測試資料 1000000 筆亂數產生
由於每筆資料都會需要運算出亂數值的結果集,
執行以 Colin 老師的機器, 差不多是 90 秒
----------------------------------------*/
drop table if exists dbo.SalesDetail_1000000;
create table dbo.SalesDetail_1000000
(
	ID int identity(1,1),
	ProductID int,
	Quantity int,
	Price numeric(6,2),
	SaleDate datetime,
	SaleComments varchar(100),
	constraint PK_SalesDetail_1000000 primary key clustered(ID ASC)
);
go

/* 大量寫入 1000000 筆資料 */
set nocount on;
declare @v_StringSample varchar(1000);
set @v_StringSample = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()~_+<>';
declare @v_StringOutput varchar(100);

declare @i int = 1;

declare @v_string_loop int;
declare @v_string_loop_max int;

begin tran
while @i <= 1000000
begin
	set @v_StringOutput = '';
	set @v_string_loop = 1;
	set @v_string_loop_max = convert(int, rand() * 90) + 11
	while @v_string_loop <= @v_string_loop_max
	begin
		set @v_StringOutput = @v_StringOutput + substring(@v_StringSample, convert(int, rand() * len(@v_StringSample)), 1)
		set @v_string_loop = @v_string_loop + 1;
	end

	insert into dbo.SalesDetail_1000000
	(ProductID, Quantity, Price, SaleDate, SaleComments)
	select
		convert(int, rand() * 100) + 1,
		convert(int, rand() * 1000) + 1,
		convert(numeric(6, 2), rand() * 100 - 0.01) + 1,
		dateadd(ss, convert(int, rand() * 31535999), '2022-01-01 00:00:00.000'),
		@v_StringOutput
	
	set @i = @i + 1;
end
commit tran
print 'SalesDetail_1000000 DONE';
go


/*----------------------------------------
建立 index 範例程式碼
----------------------------------------*/
create nonclustered index IX_SalesDetail_1000000_ProductID_Quantity
on dbo.SalesDetail_1000000 (ProductID, Quantity);
go

drop index IX_SalesDetail_1000000_ProductID_Quantity on dbo.SalesDetail_1000000;
go

create nonclustered index IX_SalesDetail_1000000_ProductID_Quantity
on dbo.SalesDetail_1000000 (ProductID, Quantity) include (Price, SaleDate, SaleComments);
go


/*----------------------------------------
測試用的範例程式碼
----------------------------------------*/
/* BETWEEN */
select * from dbo.SalesDetail_1000000
where ProductID between 1 and 3
and Quantity = 998;

/* IN */
select * from dbo.SalesDetail_1000000
where ProductID in (1, 2, 3)
and Quantity = 998;


/*----------------------------------------
請依照課程中的說明, 複製程式碼進行改寫與測試

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/



/*----------------------------------------
移除測試資料
use ColinDemo;
go

drop table if exists dbo.SalesDetail_1000000;
----------------------------------------*/

/*-----END-----*/