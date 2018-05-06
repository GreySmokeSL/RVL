USE [C:\PROJECTS\MY\RVL\ARTISTSWEBBILLING\ARTISTSWEBBILLING\APP_DATA\RVLDB.MDF]
GO

/****** Object:  Table [dbo].[Commission]    Script Date: 06.05.2018 14:34:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Commission](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ArtistID] [int] NOT NULL,
	[CommissionValue] [money] NOT NULL,
 CONSTRAINT [PK__Commissi__3214EC277E9C3543] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Commission]  WITH NOCHECK ADD  CONSTRAINT [FK_Commission_Artist] FOREIGN KEY([ArtistID])
REFERENCES [dbo].[Artist] ([ID])
GO

ALTER TABLE [dbo].[Commission] CHECK CONSTRAINT [FK_Commission_Artist]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The id of the commission record' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Commission', @level2type=N'COLUMN',@level2name=N'ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The id of the artist that this records is related to' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Commission', @level2type=N'COLUMN',@level2name=N'ArtistID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The commision per full playback of a song' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Commission', @level2type=N'COLUMN',@level2name=N'CommissionValue'
GO


