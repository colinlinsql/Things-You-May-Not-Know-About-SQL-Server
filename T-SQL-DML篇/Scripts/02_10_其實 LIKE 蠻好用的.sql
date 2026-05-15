/*======================================================================
課程範例:
其實 LIKE 蠻好用的
------------------------------------
這個範例主要分享在使用 LIKE 的小技巧, 例如判斷是否為包含 email 格式的應用
======================================================================*/

use ColinDemo;
go

/*----------------------------------------
建立測試資料 dbo.ForLIKETest
----------------------------------------*/
drop table if exists dbo.ForLIKETest;
create table dbo.ForLIKETest
(
	Id int identity(1,1),
	Name varchar(100),
	Phone varchar(20),
	Birthday date,
	Amount varchar(100),
	Comments varchar(1000)
);


/*----------------------------------------
寫入測試資料 22 筆
----------------------------------------*/
insert into dbo.ForLIKETest
(Name, Phone, Birthday,Amount, Comments)
values
('Alexander Albon'	, 'No Record'		, '20220920', '64534'        , 'Contact email: AlexAlbon@ColinDemoDomain.com'),
('Gabriel Bortoleto', '8412345695'		, '20230314', '24723.37'     , 'Job email: Brotoleto.Gabriel@idonotknow.com'),
('Isack Hadjar'		, '333-555-9487'	, '19970520', '.93454'       , 'The driver of Red Bull Racing'),
('Charles Leclerc'	, '222-333-2468'	, NULL      , '17453.'       , 'My favorite driver'),
('W''xy Max W''xyz'	, 'N/A'				, NULL      , '-73445'       , 'Just a strange string'),
('Sergio Perez'		, '(886) 223-5432'	, NULL      , '-9.3422'      , 'Change team to another'),
('Lance Stroll'		, '321-534-6364'	, '20250607', '-1234-56'     , NULL),
('Fernando Alonso'	, '452-333-8245'	, '20250109', '345.543.11'   , NULL),
('Valtteri Bottas'	, '645-745-9245'	, '20250307', '86543-'       , NULL),
('Lewis Hamilton'	, '654-134-4536'	, '20250307', 'Tow Million'  , 'I don'' like him'),
('Oscar Piastri'	, '712-244-7834'	, '20240802', '37E5432'      , 'Sadness driver'),
('Max Verstappen'	, '912-233-6437'	, '20230203', '$'            , ''),
('Kimi Antonelli'	, '107-784-8234'	, NULL      , 'xx'           , 'Rookie dark horse'),
('Franco Colapioto'	, '437-345-7434'	, '20180913', 'FFFFFF'       , 'franccoos@b#%^xyy56.gue'),
('Noco Hulkenberg'	, '924-942-8932'	, NULL      , '23452'        , 'NULL'),
('Lando Norris'		, '268-452-6534'	, NULL      , '-38421'       , '50%-50%'),
('George Ressell'	, '645-257-1762'	, NULL      , '1.2.3.4.5'    , 'Maybe the NO.1 driver in this year'),
('Oliver Bearman'	, '962-234-4783'	, '20211127', '2302.002-'    , 'Great rookie'),
('Pierre Gasly'		, '234-257-4378'	, '20221213', '33210'        , 'Why cannot join Red Bull Racing?'),
('Liam Lawson'		, '753-743-1937'	, NULL      , '86424'        , NULL),
('Esteban Ocon'		, '821-924-1948'	, NULL      , '43563'        , NULL),
('Carlos Sains'		, '645-257-2945'	, '20240102', '60345'        , 'In Ferrari team before');
go


/*----------------------------------------
請依照課程中的說明進行各項測試

範例語法不複雜, 請依課程內容自行編寫 (課堂練習作業)
----------------------------------------*/



/*----------------------------------------
移除測試資料
use ColinDemo;
go

drop table if exists dbo.ForLIKETest;
----------------------------------------*/

/*-----END-----*/