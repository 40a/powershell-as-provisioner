/*****	create database cm7caefeeder	*****/
CREATE DATABASE [cm7caefeeder] ON  PRIMARY 
( NAME = N'cm7caefeeder', FILENAME = N'G:\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Data\cm7caefeeder.mdf' , SIZE = 3072KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'cm7caefeeder_log', FILENAME = N'O:\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Data\cm7caefeeder_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%)
GO
ALTER DATABASE [cm7caefeeder] SET COMPATIBILITY_LEVEL = 100
GO
ALTER DATABASE [cm7caefeeder] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [cm7caefeeder] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [cm7caefeeder] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [cm7caefeeder] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [cm7caefeeder] SET ARITHABORT OFF 
GO
ALTER DATABASE [cm7caefeeder] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [cm7caefeeder] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [cm7caefeeder] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [cm7caefeeder] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [cm7caefeeder] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [cm7caefeeder] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [cm7caefeeder] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [cm7caefeeder] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [cm7caefeeder] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [cm7caefeeder] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [cm7caefeeder] SET  DISABLE_BROKER 
GO
ALTER DATABASE [cm7caefeeder] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [cm7caefeeder] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [cm7caefeeder] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [cm7caefeeder] SET  READ_WRITE 
GO
ALTER DATABASE [cm7caefeeder] SET RECOVERY FULL 
GO
ALTER DATABASE [cm7caefeeder] SET  MULTI_USER 
GO
ALTER DATABASE [cm7caefeeder] SET PAGE_VERIFY CHECKSUM  
GO
USE [cm7caefeeder]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [cm7caefeeder] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

/*****	create login and user cm7caefeeder	*****/
USE [master]
GO
CREATE LOGIN [cm7caefeeder] WITH PASSWORD=N'cm7caefeeder', DEFAULT_DATABASE=[cm7caefeeder], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [cm7caefeeder]
GO
CREATE USER [cm7caefeeder] FOR LOGIN [cm7caefeeder]
GO
USE [cm7caefeeder]
GO
ALTER USER [cm7caefeeder] WITH DEFAULT_SCHEMA=[cm7caefeeder]
GO
USE [cm7caefeeder]
GO
EXEC sp_addrolemember N'db_datareader', N'cm7caefeeder'
GO
USE [cm7caefeeder]
GO
EXEC sp_addrolemember N'db_datawriter', N'cm7caefeeder'
GO
USE [cm7caefeeder]
GO
EXEC sp_addrolemember N'db_ddladmin', N'cm7caefeeder'
GO

/***** create schema cm7caefeeder	*****/
USE [cm7caefeeder]
GO
CREATE SCHEMA [cm7caefeeder] AUTHORIZATION [cm7caefeeder]
GO
USE [cm7caefeeder]
GO
ALTER USER [cm7caefeeder] WITH DEFAULT_SCHEMA=[cm7caefeeder]
GO