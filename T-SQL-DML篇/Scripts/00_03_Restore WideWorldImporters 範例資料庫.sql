/*======================================================================
Restore WideWorldImporters 範例資料庫
------------------------------------
1. 下載 WideWorldImporters 資料庫備份檔案
   https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak
2. 將下載的檔案放到 VM 環境中的 C:\Temp\ 目錄下
   (也可以放在其他位置, 若使用其他位置, 請自行修改程式碼以符合對應的檔案位置)
3. 在 VM 環境中建立資料庫檔案存放路徑 F:\SQLServer\Datafiles\ 目錄
   (也可以放在其他位置, 若使用其他位置, 請自行修改程式碼以符合對應的檔案位置)
4. 執行下列程式碼, 將 WideWorldImporters 範例資料庫還原

PS. 必須使用在 SQL Server 2016 或之後的版本
======================================================================*/
use master;
go

/* 檢查資料庫是否存在, 不存在的話才會建立, 已存在的話會回傳資料庫已存在 */
if db_id('WideWorldImporters') is null
begin
    restore database WideWorldImporters
    from disk = 'C:\Temp\WideWorldImporters-Full.bak'
    with
    move 'WWI_Primary'         to 'F:\SQLServer\Datafiles\WideWorldImporters.mdf',
    move 'WWI_UserData'        to 'F:\SQLServer\Datafiles\WideWorldImporters_UserData.ndf',
    move 'WWI_Log'             to 'F:\SQLServer\Datafiles\WideWorldImporters.ldf',
    move 'WWI_InMemory_Data_1' to 'F:\SQLServer\Datafiles\WideWorldImporters_InMemory_Data_1',
    recovery, replace, stats = 10;
end
else
begin
    print N'資料庫 WideWorldImporters 已存在!';
end
go
