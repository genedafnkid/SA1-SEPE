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
PRINT N'Creating Procedure [dbo].[Item_Add]...';


GO
CREATE PROCEDURE [dbo].[Item_Add]
	@Name NVARCHAR(50),
    @Code NVARCHAR(10),
    @Brand NVARCHAR(50),
    @UnitPrice DECIMAL(10, 2)
AS
begin
    set nocount on;

    INSERT INTOdbo.Item (Name, Code, Brand, UnitPrice) VALUES (@Name, @Code, @Brand, @UnitPrice)
end
GO
PRINT N'Update complete.';


GO
