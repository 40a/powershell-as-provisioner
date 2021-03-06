/*****	create database cm7management	*****/
CREATE DATABASE [cm7management] ON  PRIMARY 
( NAME = N'cm7management', FILENAME = N'E:\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Data\cm7management.mdf' , SIZE = 3072KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'cm7management_log', FILENAME = N'E:\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Data\cm7management_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%)
GO
ALTER DATABASE [cm7management] SET COMPATIBILITY_LEVEL = 100
GO
ALTER DATABASE [cm7management] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [cm7management] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [cm7management] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [cm7management] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [cm7management] SET ARITHABORT OFF 
GO
ALTER DATABASE [cm7management] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [cm7management] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [cm7management] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [cm7management] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [cm7management] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [cm7management] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [cm7management] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [cm7management] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [cm7management] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [cm7management] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [cm7management] SET  DISABLE_BROKER 
GO
ALTER DATABASE [cm7management] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [cm7management] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [cm7management] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [cm7management] SET  READ_WRITE 
GO
ALTER DATABASE [cm7management] SET RECOVERY FULL 
GO
ALTER DATABASE [cm7management] SET  MULTI_USER 
GO
ALTER DATABASE [cm7management] SET PAGE_VERIFY CHECKSUM  
GO
USE [cm7management]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [cm7management] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

/*****	create login and user cm7management	*****/
USE [master]
GO
CREATE LOGIN [cm7management] WITH PASSWORD=N'cm7management', DEFAULT_DATABASE=[cm7management], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [cm7management]
GO
CREATE USER [cm7management] FOR LOGIN [cm7management]
GO
USE [cm7management]
GO
ALTER USER [cm7management] WITH DEFAULT_SCHEMA=[cm7management]
GO
USE [cm7management]
GO
EXEC sp_addrolemember N'db_datareader', N'cm7management'
GO
USE [cm7management]
GO
EXEC sp_addrolemember N'db_datawriter', N'cm7management'
GO
USE [cm7management]
GO
EXEC sp_addrolemember N'db_ddladmin', N'cm7management'
GO

/***** create schema cm7management	*****/
USE [cm7management]
GO
CREATE SCHEMA [cm7management] AUTHORIZATION [cm7management]
GO
USE [cm7management]
GO
ALTER USER [cm7management] WITH DEFAULT_SCHEMA=[cm7management]
GO