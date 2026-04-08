/*======================================================================
建立課程中會使用的範例資料庫
------------------------------------
下列語法可以建立一個名稱為 ColinDemo 的空資料庫
* 會先檢查是否有相同的資料庫存在
  若不存在才會進行建立, 並且將 Recovery mode 設定為 simple
  已存在則不建立, 回傳資料庫已存在
* 可以變更該資料庫的名稱與對應的檔案名稱
  有修改的話, 後續使用範例時也要一併調整
* 在 VM 環境中建立資料庫檔案存放路徑 F:\SQLServer\Datafiles\ 目錄
  (也可以放在其他位置, 若使用其他位置, 請自行修改程式碼以符合對應的檔案位置)
======================================================================*/
use master;
go

/* 檢查資料庫是否存在, 不存在的話才會建立, 已存在的話會回傳資料庫已存在 */
if db_id('ColinDemo') is null
begin
    create database ColinDemo
    on primary
    (
        name = 'ColinDemo_mst', 
        filename = 'F:\SQLServer\Datafiles\ColinDemo_mst.mdf'
    )
    log on
    (
        name = 'ColinDemo_log', 
        filename = 'F:\SQLServer\Datafiles\ColinDemo_log.ldf'
    );

    alter database ColinDemo set recovery simple;
end
else
begin
    print N'資料庫 ColinDemo 已存在!';
end
go
