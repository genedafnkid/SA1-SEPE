﻿/*
Deployment script for ItemDB

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "ItemDB"
:setvar DefaultFilePrefix "ItemDB"
:setvar DefaultDataPath "C:\Users\sepeg\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\sepeg\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
The column [dbo].[Item].[Name] is being dropped, data loss could occur.

The column [dbo].[Item].[productName] on table [dbo].[Item] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [dbo].[Item])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Starting rebuilding table [dbo].[Item]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Item] (
    [Id]          INT             IDENTITY (1, 1) NOT NULL,
    [productName] NVARCHAR (50)   NOT NULL,
    [Code]        NVARCHAR (10)   NOT NULL,
    [Brand]       NVARCHAR (50)   NOT NULL,
    [UnitPrice]   DECIMAL (10, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Item])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Item] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Item] ([Id], [Code], [Brand], [UnitPrice])
        SELECT   [Id],
                 [Code],
                 [Brand],
                 [UnitPrice]
        FROM     [dbo].[Item]
        ORDER BY [Id] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Item] OFF;
    END

DROP TABLE [dbo].[Item];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Item]', N'Item';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Altering Procedure [dbo].[Item_Add]...';


GO
ALTER PROCEDURE [dbo].[Item_Add]
	@Name NVARCHAR(50),
    @Code NVARCHAR(10),
    @Brand NVARCHAR(50),
    @UnitPrice DECIMAL(10, 2)
AS
begin
    set nocount on;

    INSERT INTO dbo.Item (productName, Code, Brand, UnitPrice) VALUES (@Name, @Code, @Brand, @UnitPrice)
end
GO
PRINT N'Update complete.';


GO
