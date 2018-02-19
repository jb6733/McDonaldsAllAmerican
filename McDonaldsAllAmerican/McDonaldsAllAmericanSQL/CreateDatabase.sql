USE [master]
GO

CREATE DATABASE [<McDonaldsAllAmericanDW3, , McDonaldsAllAmericanDW2>]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'<McDonaldsAllAmericanDW3, , McDonaldsAllAmericanDW2>', FILENAME = N'C:\DATA\<McDonaldsAllAmericanDW3, , McDonaldsAllAmericanDW2>.mdf' , SIZE = 65536KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [UserFG]  DEFAULT
( NAME = N'<McDonaldsAllAmericanDW3, , McDonaldsAllAmericanDW2>N1', FILENAME = N'C:\DATA\<McDonaldsAllAmericanDW3, , McDonaldsAllAmericanDW2>N1.ndf' , SIZE = 65536KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'<McDonaldsAllAmericanDW3, , McDonaldsAllAmericanDW2>_log', FILENAME = N'C:\LOG\<McDonaldsAllAmericanDW3, , McDonaldsAllAmericanDW2>_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO


USE [<McDonaldsAllAmericanDW3, , McDonaldsAllAmericanDW2>]
GO
CREATE SCHEMA [etl]
GO

CREATE TABLE [dbo].[DimBirthCity](
	[DimBirthCityID] [int] NOT NULL,
	[BirthCity] [varchar](64) NULL,
	[BirthStateCode] [varchar](64) NULL,
	[StateRegion] [varchar](16) NULL,
	[StateSubRegion] [varchar](64) NULL,
 CONSTRAINT [PK_DimBirthCity] PRIMARY KEY CLUSTERED 
(
	[DimBirthCityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [UserFG]
) ON [UserFG]
GO

CREATE TABLE [dbo].[DimCollege](
	[DimCollegeID] [int] NOT NULL,
	[College] [varchar](32) NULL,
	[CollegeCity] [varchar](32) NULL,
	[CollegeStateCode] [varchar](8) NULL,
	[CollegeStateRegion] [varchar](16) NULL,
	[CollegeStateSubRegion] [varchar](32) NULL,
 CONSTRAINT [PK_DimCollege] PRIMARY KEY CLUSTERED 
(
	[DimCollegeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [UserFG]
) ON [UserFG]
GO

CREATE TABLE [dbo].[DimHeight](
	[DimHeightID] [int] NOT NULL,
	[Inches] [int] NULL,
	[Feet] [varchar](6) NULL,
	[Category] [varchar](15) NULL,
 CONSTRAINT [PK_DimHeight] PRIMARY KEY CLUSTERED 
(
	[DimHeightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [UserFG]
) ON [UserFG]
GO

CREATE TABLE [dbo].[DimHighSchool](
	[DimHighSchoolID] [int] NOT NULL,
	[HighSchool] [varchar](64) NULL,
	[HighSchoolStateCode] [varchar](8) NULL,
	[HighSchoolStateRegion] [varchar](16) NULL,
	[HighSchoolStateSubRegion] [varchar](32) NULL,
 CONSTRAINT [PK_DimHighSchool] PRIMARY KEY CLUSTERED 
(
	[DimHighSchoolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [UserFG]
) ON [UserFG]
GO

CREATE TABLE [dbo].[DimPosition](
	[DimPositionID] [int] NOT NULL,
	[Position] [varchar](10) NULL,
	[NumericPosition] [tinyint] NULL,
	[FunctionalPosition] [varchar](2) NULL,
 CONSTRAINT [PK_DimPosition] PRIMARY KEY CLUSTERED 
(
	[DimPositionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [UserFG]
) ON [UserFG]
GO

CREATE TABLE [dbo].[DimWeight](
	[DimWeightID] [int] NOT NULL,
	[Pounds] [smallint] NULL,
	[Category] [varchar](8) NULL,
	[SubCategory] [varchar](8) NULL,
 CONSTRAINT [PK_DimWeight] PRIMARY KEY CLUSTERED 
(
	[DimWeightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [UserFG]
) ON [UserFG]
GO

CREATE TABLE [dbo].[DimYear](
	[DimYearID] [int] NOT NULL,
	[Year] [smallint] NULL,
	[YearPeriod] [varchar](16) NULL,
	[Decade] [smallint] NULL,
 CONSTRAINT [PK_DimYear] PRIMARY KEY CLUSTERED 
(
	[DimYearID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [UserFG]
) ON [UserFG]
GO

CREATE TABLE [dbo].[FactPlayer](
	[FactPlayerID] [int] NOT NULL IDENTITY,
	[DimPositionID] [int] NOT NULL,
	[DimHeightID] [int] NOT NULL,
	[DimWeightID] [int] NOT NULL,
	[DimBirthCityID] [int] NOT NULL,
	[DimHighSchoolID] [int] NOT NULL,
	[DimCollegeID] [int] NOT NULL,
	[DimYearID] [int] NOT NULL,
	[PlayerName] [varchar](32) NULL,
	[Nationality] [varchar](32) NULL,
 CONSTRAINT [PK_FactPlayer] PRIMARY KEY CLUSTERED 
(
	[FactPlayerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [UserFG]
) ON [UserFG]
GO


ALTER TABLE [dbo].[FactPlayer] ADD  CONSTRAINT [DF_FactPlayer_Nationality]  DEFAULT ('unknown') FOR [Nationality]
GO
ALTER TABLE [dbo].[FactPlayer]  WITH CHECK ADD  CONSTRAINT [FK_FactPlayer_DimBirthCity] FOREIGN KEY([DimBirthCityID])
REFERENCES [dbo].[DimBirthCity] ([DimBirthCityID])
GO
ALTER TABLE [dbo].[FactPlayer] CHECK CONSTRAINT [FK_FactPlayer_DimBirthCity]
GO
ALTER TABLE [dbo].[FactPlayer]  WITH CHECK ADD  CONSTRAINT [FK_FactPlayer_DimCollege] FOREIGN KEY([DimCollegeID])
REFERENCES [dbo].[DimCollege] ([DimCollegeID])
GO
ALTER TABLE [dbo].[FactPlayer] CHECK CONSTRAINT [FK_FactPlayer_DimCollege]
GO
ALTER TABLE [dbo].[FactPlayer]  WITH CHECK ADD  CONSTRAINT [FK_FactPlayer_DimHeight] FOREIGN KEY([DimHeightID])
REFERENCES [dbo].[DimHeight] ([DimHeightID])
GO
ALTER TABLE [dbo].[FactPlayer] CHECK CONSTRAINT [FK_FactPlayer_DimHeight]
GO
ALTER TABLE [dbo].[FactPlayer]  WITH CHECK ADD  CONSTRAINT [FK_FactPlayer_DimHighSchool] FOREIGN KEY([DimHighSchoolID])
REFERENCES [dbo].[DimHighSchool] ([DimHighSchoolID])
GO
ALTER TABLE [dbo].[FactPlayer] CHECK CONSTRAINT [FK_FactPlayer_DimHighSchool]
GO
ALTER TABLE [dbo].[FactPlayer]  WITH CHECK ADD  CONSTRAINT [FK_FactPlayer_DimPosition] FOREIGN KEY([DimPositionID])
REFERENCES [dbo].[DimPosition] ([DimPositionID])
GO
ALTER TABLE [dbo].[FactPlayer] CHECK CONSTRAINT [FK_FactPlayer_DimPosition]
GO
ALTER TABLE [dbo].[FactPlayer]  WITH CHECK ADD  CONSTRAINT [FK_FactPlayer_DimWeight] FOREIGN KEY([DimWeightID])
REFERENCES [dbo].[DimWeight] ([DimWeightID])
GO
ALTER TABLE [dbo].[FactPlayer] CHECK CONSTRAINT [FK_FactPlayer_DimWeight]
GO
ALTER TABLE [dbo].[FactPlayer]  WITH CHECK ADD  CONSTRAINT [FK_FactPlayer_DimYear] FOREIGN KEY([DimYearID])
REFERENCES [dbo].[DimYear] ([DimYearID])
GO
ALTER TABLE [dbo].[FactPlayer] CHECK CONSTRAINT [FK_FactPlayer_DimYear]
GO


CREATE TABLE [etl].[BirthCity](
	[DimBirthCityID] [int] NOT NULL,
	[BirthCity] [varchar](64) NULL,
	[BirthStateCode] [varchar](64) NULL,
	[StateRegion] [varchar](16) NULL,
	[StateSubRegion] [varchar](64) NULL) ON [UserFG]
GO

CREATE TABLE [etl].[College](
	[DimCollegeID] [int] NOT NULL,
	[College] [varchar](32) NULL,
	[CollegeCity] [varchar](32) NULL,
	[CollegeStateCode] [varchar](8) NULL,
	[CollegeStateRegion] [varchar](16) NULL,
	[CollegeStateSubRegion] [varchar](32) NULL) ON [UserFG]
GO

CREATE TABLE [etl].[Height](
	[DimHeightID] [int] NOT NULL,
	[Inches] [int] NULL,
	[Feet] [varchar](6) NULL,
	[Category] [varchar](15) NULL) ON [UserFG]
GO

CREATE TABLE [etl].[HighSchool](
	[DimHighSchoolID] [int] NOT NULL,
	[HighSchool] [varchar](64) NULL,
	[HighSchoolStateCode] [varchar](8) NULL,
	[HighSchoolStateRegion] [varchar](16) NULL,
	[HighSchoolStateSubRegion] [varchar](32) NULL) ON [UserFG]
GO

CREATE TABLE [etl].[Position](
	[DimPositionID] [int] NOT NULL,
	[Position] [nchar](10) NULL,
	[NumericPosition] [tinyint] NULL,
	[FunctionalPosition] [varchar](2) NULL) ON [UserFG]
GO

CREATE TABLE [etl].[Weight](
	[DimWeightID] [int] NOT NULL,
	[Pounds] [smallint] NULL,
	[Category] [varchar](8) NULL,
	[SubCategory] [varchar](8) NULL) ON [UserFG]
GO

CREATE TABLE [etl].[Year](
	[DimYearID] [int] NOT NULL,
	[Year] [smallint] NULL,
	[YearPeriod] [varchar](16) NULL,
	[Decade] [smallint] NULL) ON [UserFG]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [etl].[FactPlayer](
	[FactPlayerID] [int] NOT NULL,
	[DimPositionID] [int] NOT NULL,
	[DimHeightID] [int] NOT NULL,
	[DimWeightID] [int] NOT NULL,
	[DimBirthCityID] [int] NOT NULL,
	[DimHighSchoolID] [int] NOT NULL,
	[DimCollegeID] [int] NOT NULL,
	[DimYearID] [int] NOT NULL,
	[PlayerName] [varchar](32) NULL,
	[Nationality] [varchar](32) NULL) ON [UserFG]
GO

CREATE TABLE [etl].[Player](
	[BirthCity] [varchar](64) NULL,
	[BirthStateCode] [varchar](64) NULL,
	[College] [varchar](32) NULL,
	[HighSchool] [varchar](64) NULL,
	[HighSchoolStateCode] [varchar](8) NULL,
	[Feet] [varchar](6) NULL,
	[Pounds] [smallint] NULL,
	[Year] [smallint] NULL,
	[Position] [varchar](10) NULL,
	[PlayerName] [varchar](32) NULL,
	[Nationality] [varchar](32) NULL
) ON [UserFG]
GO

CREATE VIEW [dbo].[vPlayerMerge] AS

SELECT bc.BirthCity 
  , bc.BirthStateCode
  , c.College
  , hs.HighSchool
  , hs.HighSchoolStateCode
  , h.Feet
  , w.Pounds
  , y.[Year]
  , pos.Position
  , p.PlayerName
  , p.Nationality
FROM [dbo].[FactPlayer] p
INNER JOIN [dbo].[DimBirthCity] bc ON
  p.DimBirthCityID = bc.DimBirthCityID
INNER JOIN [dbo].[DimHeight] h ON
  p.DimHeightID = h.DimHeightID
INNER JOIN [dbo].[DimCollege] c ON
  p.DimCollegeID = c.DimCollegeID
INNER JOIN [dbo].[DimHighSchool] hs ON
  p.DimHighSchoolID = hs.DimHighSchoolID
INNER JOIN [dbo].[DimPosition] pos ON
  p.DimPositionID = pos.DimPositionID
INNER JOIN [dbo].[DimWeight] w ON
  p.DimWeightID = w.DimWeightID
INNER JOIN [dbo].[DimYear] y ON
  p.DimYearID = y.DimYearID

GO

CREATE VIEW [dbo].[vPlayerInsert] AS
SELECT 
  ISNULL(pos.[DimPositionID], 1) [DimPositionID]
  , ISNULL(h.[DimHeightID], 1) [DimHeightID]
  , ISNULL(w.[DimWeightID], 1) [DimWeightID]
  , ISNULL(bc.[DimBirthCityID], 1) [DimBirthCityID]
  , ISNULL(hs.[DimHighSchoolID], 1) [DimHighSchoolID]
  , ISNULL(c.[DimCollegeID], 1) [DimCollegeID]
  , ISNULL(y.[DimYearID], 1) [DimYearID]
  , p.PlayerName
  , p.Nationality
FROM [etl].[Player] p
LEFT OUTER JOIN [dbo].[DimBirthCity] bc ON
  p.BirthCity = bc.BirthCity
  AND  p.BirthStateCode = bc.BirthStateCode
LEFT OUTER JOIN [dbo].[DimHeight] h ON
  p.Feet = h.Feet
LEFT OUTER JOIN [dbo].[DimCollege] c ON
  p.College = c.College
LEFT OUTER JOIN [dbo].[DimHighSchool] hs ON
  p.HighSchool = hs.HighSchool
  AND p.HighSchoolStateCode = hs.HighSchoolStateCode
LEFT OUTER JOIN [dbo].[DimPosition] pos ON
  p.Position = pos.Position
LEFT OUTER JOIN [dbo].[DimWeight] w ON
  p.Pounds = w.Pounds
LEFT OUTER JOIN [dbo].[DimYear] y ON
  p.[Year] = y.[Year]
GO