/*======================================================================
Restore AdventureWorks2025 範例資料庫
------------------------------------
1. 下載 AdventureWorks2025 資料庫備份檔案
   https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorks2025.bak
2. 將下載的檔案放到 VM 環境中的 C:\Temp\ 目錄下
   (也可以放在其他位置, 若使用其他位置, 請自行修改程式碼以符合對應的檔案位置)
3. 在 VM 環境中建立資料庫檔案存放路徑 F:\SQLServer\Datafiles\ 目錄
   (也可以放在其他位置, 若使用其他位置, 請自行修改程式碼以符合對應的檔案位置)
4. 執行下列程式碼, 將 AdventureWorks2025 範例資料庫還原

PS. 若是您使用的 SQL Server 版本不是 SQL Server 2025 的話, 
    請在下列頁面中找到對應的 AdventureWorks 範例資料庫版本,
    並調整相關的程式碼再執行還原資料庫的操作.
    https://learn.microsoft.com/zh-tw/sql/samples/adventureworks-install-configure?view=sql-server-ver17&tabs=ssms
======================================================================*/
use master;
go

/* 檢查資料庫是否存在, 不存在的話才會建立, 已存在的話會回傳資料庫已存在 */
if db_id('AdventureWorks2025') is null
begin
    restore database AdventureWorks2025
    from disk = 'C:\Temp\AdventureWorks2025.bak'
    with
    move 'AdventureWorks'     to 'F:\SQLServer\Datafiles\AdventureWorks2025.mdf',
    move 'AdventureWorks_log' to 'F:\SQLServer\Datafiles\\AdventureWorks2025_log.ldf',
    recovery, replace, stats = 10;
end
else
begin
    print N'資料庫 AdventureWorks2025 已存在!';
end
go
