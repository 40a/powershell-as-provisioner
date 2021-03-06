/****** drop Schema [cm7caefeeder]    ******/
USE [cm7caefeeder]
GO
DROP SCHEMA [cm7caefeeder]
GO

/****** drop  User [cm7caefeeder]    ******/
USE [cm7caefeeder]
GO
DROP USER [cm7caefeeder]
GO

/****** drop  Login [cm7caefeeder]    ******/
USE [master]
GO
DROP LOGIN [cm7caefeeder]
GO

/******	drop database [cm7caefeeder]	******/
EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = N'cm7caefeeder'
GO
USE [master]
GO
ALTER DATABASE [cm7caefeeder] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [master]
GO
DROP DATABASE [cm7caefeeder]
GO
