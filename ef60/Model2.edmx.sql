
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 10/05/2018 14:13:23
-- Generated from EDMX file: C:\Users\Widness\source\repos\ef60\ef60\Model1.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [Database1];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_localiteHotel]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Hotels] DROP CONSTRAINT [FK_localiteHotel];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Hotels]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Hotels];
GO
IF OBJECT_ID(N'[dbo].[localites]', 'U') IS NOT NULL
    DROP TABLE [dbo].[localites];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Hotels'
CREATE TABLE [dbo].[Hotels] (
    [idHotel] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Description] nvarchar(max)  NOT NULL,
    [Category] int  NOT NULL,
    [HasWifi] bit  NOT NULL,
    [Phone] nvarchar(20)  NOT NULL,
    [Email] nvarchar(max)  NOT NULL,
    [Website] nvarchar(max)  NOT NULL,
    [HasParking] bit  NOT NULL,
    [localite_IdLocalite] int  NOT NULL
);
GO

-- Creating table 'localites'
CREATE TABLE [dbo].[localites] (
    [IdLocalite] int IDENTITY(1,1) NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [NPA] nvarchar(max)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [idHotel] in table 'Hotels'
ALTER TABLE [dbo].[Hotels]
ADD CONSTRAINT [PK_Hotels]
    PRIMARY KEY CLUSTERED ([idHotel] ASC);
GO

-- Creating primary key on [IdLocalite] in table 'localites'
ALTER TABLE [dbo].[localites]
ADD CONSTRAINT [PK_localites]
    PRIMARY KEY CLUSTERED ([IdLocalite] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [localite_IdLocalite] in table 'Hotels'
ALTER TABLE [dbo].[Hotels]
ADD CONSTRAINT [FK_localiteHotel]
    FOREIGN KEY ([localite_IdLocalite])
    REFERENCES [dbo].[localites]
        ([IdLocalite])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_localiteHotel'
CREATE INDEX [IX_FK_localiteHotel]
ON [dbo].[Hotels]
    ([localite_IdLocalite]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------