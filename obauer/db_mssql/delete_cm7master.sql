/****** drop Schema [cm7master]    ******/
USE [cm7master]
GO
DROP SCHEMA [cm7master]
GO

/****** drop  User [cm7master]    ******/
USE [cm7master]
GO
DROP USER [cm7master]
GO

/****** drop  Login [cm7master]    ******/
USE [master]
GO
DROP LOGIN [cm7master]
GO

/******	drop database [cm7master]	******/
EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'cm7master'
GO
USE [master]
GO
ALTER DATABASE [cm7master] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [master]
GO
DROP DATABASE [cm7master]
GO
