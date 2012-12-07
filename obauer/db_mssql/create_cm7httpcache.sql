/*****	create database cm7httpcache	*****/
CREATE DATABASE [cm7httpcache] ON  PRIMARY 
( NAME = N'cm7httpcache', FILENAME = N'E:\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Data\cm7httpcache.mdf' , SIZE = 3072KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'cm7httpcache_log', FILENAME = N'E:\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Data\cm7httpcache_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%)
GO
ALTER DATABASE [cm7httpcache] SET COMPATIBILITY_LEVEL = 100
GO
ALTER DATABASE [cm7httpcache] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [cm7httpcache] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [cm7httpcache] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [cm7httpcache] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [cm7httpcache] SET ARITHABORT OFF 
GO
ALTER DATABASE [cm7httpcache] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [cm7httpcache] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [cm7httpcache] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [cm7httpcache] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [cm7httpcache] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [cm7httpcache] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [cm7httpcache] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [cm7httpcache] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [cm7httpcache] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [cm7httpcache] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [cm7httpcache] SET  DISABLE_BROKER 
GO
ALTER DATABASE [cm7httpcache] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [cm7httpcache] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [cm7httpcache] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [cm7httpcache] SET  READ_WRITE 
GO
ALTER DATABASE [cm7httpcache] SET RECOVERY FULL 
GO
ALTER DATABASE [cm7httpcache] SET  MULTI_USER 
GO
ALTER DATABASE [cm7httpcache] SET PAGE_VERIFY CHECKSUM  
GO
USE [cm7httpcache]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [cm7httpcache] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

/*****	create login and user cm7httpcache	*****/
USE [master]
GO
CREATE LOGIN [cm7httpcache] WITH PASSWORD=N'cm7httpcache', DEFAULT_DATABASE=[cm7httpcache], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [cm7httpcache]
GO
CREATE USER [cm7httpcache] FOR LOGIN [cm7httpcache]
GO
USE [cm7httpcache]
GO
ALTER USER [cm7httpcache] WITH DEFAULT_SCHEMA=[cm7httpcache]
GO
USE [cm7httpcache]
GO
EXEC sp_addrolemember N'db_datareader', N'cm7httpcache'
GO
USE [cm7httpcache]
GO
EXEC sp_addrolemember N'db_datawriter', N'cm7httpcache'
GO
USE [cm7httpcache]
GO
EXEC sp_addrolemember N'db_ddladmin', N'cm7httpcache'
GO

/***** create schema cm7httpcache	*****/
USE [cm7httpcache]
GO
CREATE SCHEMA [cm7httpcache] AUTHORIZATION [cm7httpcache]
GO
USE [cm7httpcache]
GO
ALTER USER [cm7httpcache] WITH DEFAULT_SCHEMA=[cm7httpcache]
GO