/****** drop Schema [cm7httpcache]    ******/
USE [cm7httpcache]
GO
DROP SCHEMA [cm7httpcache]
GO

/****** drop  User [cm7httpcache]    ******/
USE [cm7httpcache]
GO
DROP USER [cm7httpcache]
GO

/****** drop  Login [cm7httpcache]    ******/
USE [master]
GO
DROP LOGIN [cm7httpcache]
GO

/******	drop database [cm7httpcache]	******/
EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'cm7httpcache'
GO
USE [master]
GO
ALTER DATABASE [cm7httpcache] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [master]
GO
DROP DATABASE [cm7httpcache]
GO
