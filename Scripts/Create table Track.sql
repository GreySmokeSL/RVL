USE [C:\PROJECTS\MY\RVL\ARTISTSWEBBILLING\ARTISTSWEBBILLING\APP_DATA\RVLDB.MDF]
GO

/****** Object:  Table [dbo].[Track]    Script Date: 06.05.2018 14:35:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Track](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](1024) NOT NULL,
	[Length] [int] NOT NULL,
	[ArtistID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Track]  WITH NOCHECK ADD  CONSTRAINT [FK_Track_Artist] FOREIGN KEY([ArtistID])
REFERENCES [dbo].[Artist] ([ID])
GO

ALTER TABLE [dbo].[Track] CHECK CONSTRAINT [FK_Track_Artist]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The id for the track' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Track', @level2type=N'COLUMN',@level2name=N'ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The id for the track' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Track', @level2type=N'COLUMN',@level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The length of the track in seconds' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Track', @level2type=N'COLUMN',@level2name=N'Length'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The id of the artist that has composed this track' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Track', @level2type=N'COLUMN',@level2name=N'ArtistID'
GO


