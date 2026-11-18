--restore database
RESTORE DATABASE TestDB
FROM DISK = 'D:\Programs\SQL Express\MSSQL17.SQLEXPRESS\MSSQL\Backup\TestDB.bak'
WITH RECOVERY;

--checking the default db file locations
SELECT
    SERVERPROPERTY('InstanceDefaultDataPath') AS DataPath,
    SERVERPROPERTY('InstanceDefaultLogPath') AS LogPath;

-- mdf file(data file) & ldf file(transaction log file)
RESTORE DATABASE TestDB
FROM DISK = 'D:\Programs\SQL Express\MSSQL17.SQLEXPRESS\MSSQL\Backup\TestDB.bak'
WITH
    MOVE 'TestDB'
    TO 'D:\Programs\SQL Express\MSSQL17.SQLEXPRESS\MSSQL\DATA\TestDB.mdf',

    MOVE 'TestDB_log'
    TO 'D:\Programs\SQL Express\MSSQL17.SQLEXPRESS\MSSQL\DATA\TestDB_log.ldf',

    RECOVERY;

--checking the db existence
SELECT name, state_desc
FROM sys.databases
WHERE name = 'TestDB';