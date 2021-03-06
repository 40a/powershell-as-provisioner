/*****	create database cm7replication	*****/
CREATE DATABASE [cm7replication] ON  PRIMARY 
( NAME = N'cm7replication', FILENAME = N'G:\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Data\cm7replication.mdf' , SIZE = 3072KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'cm7replication_log', FILENAME = N'O:\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\Data\cm7replication_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%)
GO
ALTER DATABASE [cm7replication] SET COMPATIBILITY_LEVEL = 100
GO
ALTER DATABASE [cm7replication] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [cm7replication] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [cm7replication] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [cm7replication] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [cm7replication] SET ARITHABORT OFF 
GO
ALTER DATABASE [cm7replication] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [cm7replication] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [cm7replication] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [cm7replication] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [cm7replication] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [cm7replication] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [cm7replication] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [cm7replication] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [cm7replication] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [cm7replication] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [cm7replication] SET  DISABLE_BROKER 
GO
ALTER DATABASE [cm7replication] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [cm7replication] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [cm7replication] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [cm7replication] SET  READ_WRITE 
GO
ALTER DATABASE [cm7replication] SET RECOVERY FULL 
GO
ALTER DATABASE [cm7replication] SET  MULTI_USER 
GO
ALTER DATABASE [cm7replication] SET PAGE_VERIFY CHECKSUM  
GO
USE [cm7replication]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [cm7replication] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

/*****	create login and user cm7replication	*****/
USE [master]
GO
CREATE LOGIN [cm7replication] WITH PASSWORD=N'cm7replication', DEFAULT_DATABASE=[cm7replication], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [cm7replication]
GO
CREATE USER [cm7replication] FOR LOGIN [cm7replication]
GO
USE [cm7replication]
GO
ALTER USER [cm7replication] WITH DEFAULT_SCHEMA=[cm7replication]
GO
USE [cm7replication]
GO
EXEC sp_addrolemember N'db_datareader', N'cm7replication'
GO
USE [cm7replication]
GO
EXEC sp_addrolemember N'db_datawriter', N'cm7replication'
GO
USE [cm7replication]
GO
EXEC sp_addrolemember N'db_ddladmin', N'cm7replication'
GO

/***** create schema cm7replication	*****/
USE [cm7replication]
GO
CREATE SCHEMA [cm7replication] AUTHORIZATION [cm7replication]
GO
USE [cm7replication]
GO
ALTER USER [cm7replication] WITH DEFAULT_SCHEMA=[cm7replication]
GO