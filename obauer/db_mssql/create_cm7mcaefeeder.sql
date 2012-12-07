/*****	create database cm7mcaefeeder	*****/
CREATE DATABASE [cm7mcaefeeder] ON  PRIMARY 
( NAME = N'cm7mcaefeeder', FILENAME = N'E:\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Data\cm7mcaefeeder.mdf' , SIZE = 3072KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'cm7mcaefeeder_log', FILENAME = N'E:\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Data\cm7mcaefeeder_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%)
GO
ALTER DATABASE [cm7mcaefeeder] SET COMPATIBILITY_LEVEL = 100
GO
ALTER DATABASE [cm7mcaefeeder] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [cm7mcaefeeder] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [cm7mcaefeeder] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [cm7mcaefeeder] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [cm7mcaefeeder] SET ARITHABORT OFF 
GO
ALTER DATABASE [cm7mcaefeeder] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [cm7mcaefeeder] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [cm7mcaefeeder] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [cm7mcaefeeder] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [cm7mcaefeeder] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [cm7mcaefeeder] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [cm7mcaefeeder] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [cm7mcaefeeder] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [cm7mcaefeeder] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [cm7mcaefeeder] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [cm7mcaefeeder] SET  DISABLE_BROKER 
GO
ALTER DATABASE [cm7mcaefeeder] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [cm7mcaefeeder] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [cm7mcaefeeder] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [cm7mcaefeeder] SET  READ_WRITE 
GO
ALTER DATABASE [cm7mcaefeeder] SET RECOVERY FULL 
GO
ALTER DATABASE [cm7mcaefeeder] SET  MULTI_USER 
GO
ALTER DATABASE [cm7mcaefeeder] SET PAGE_VERIFY CHECKSUM  
GO
USE [cm7mcaefeeder]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [cm7mcaefeeder] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

/*****	create login and user cm7mcaefeeder	*****/
USE [master]
GO
CREATE LOGIN [cm7mcaefeeder] WITH PASSWORD=N'cm7mcaefeeder', DEFAULT_DATABASE=[cm7mcaefeeder], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [cm7mcaefeeder]
GO
CREATE USER [cm7mcaefeeder] FOR LOGIN [cm7mcaefeeder]
GO
USE [cm7mcaefeeder]
GO
ALTER USER [cm7mcaefeeder] WITH DEFAULT_SCHEMA=[cm7mcaefeeder]
GO
USE [cm7mcaefeeder]
GO
EXEC sp_addrolemember N'db_datareader', N'cm7mcaefeeder'
GO
USE [cm7mcaefeeder]
GO
EXEC sp_addrolemember N'db_datawriter', N'cm7mcaefeeder'
GO
USE [cm7mcaefeeder]
GO
EXEC sp_addrolemember N'db_ddladmin', N'cm7mcaefeeder'
GO

/***** create schema cm7mcaefeeder	*****/
USE [cm7mcaefeeder]
GO
CREATE SCHEMA [cm7mcaefeeder] AUTHORIZATION [cm7mcaefeeder]
GO
USE [cm7mcaefeeder]
GO
ALTER USER [cm7mcaefeeder] WITH DEFAULT_SCHEMA=[cm7mcaefeeder]
GO