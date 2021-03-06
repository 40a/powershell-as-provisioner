/****** drop Schema [cm7management]    ******/
USE [cm7management]
GO
DROP SCHEMA [cm7management]
GO

/****** drop  User [cm7management]    ******/
USE [cm7management]
GO
DROP USER [cm7management]
GO

/****** drop  Login [cm7management]    ******/
USE [master]
GO
DROP LOGIN [cm7management]
GO

/******	drop database [cm7management]	******/
EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'cm7management'
GO
USE [master]
GO
ALTER DATABASE [cm7management] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [master]
GO
DROP DATABASE [cm7management]
GO
