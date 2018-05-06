USE [C:\PROJECTS\MY\RVL\ARTISTSWEBBILLING\ARTISTSWEBBILLING\APP_DATA\RVLDB.MDF]
GO

/****** Object:  Table [dbo].[Playback]    Script Date: 06.05.2018 14:35:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Playback](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[ListenedLength] [int] NOT NULL,
	[TrackID] [int] NOT NULL,
 CONSTRAINT [PK__Play__3214EC2733AA958D] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Playback] ADD  CONSTRAINT [DF_Playback_StartTime]  DEFAULT (getdate()) FOR [StartTime]
GO

ALTER TABLE [dbo].[Playback]  WITH NOCHECK ADD  CONSTRAINT [FK_Playback_Track] FOREIGN KEY([TrackID])
REFERENCES [dbo].[Track] ([ID])
GO

ALTER TABLE [dbo].[Playback] CHECK CONSTRAINT [FK_Playback_Track]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The id of the playback record' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Playback', @level2type=N'COLUMN',@level2name=N'ID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The timestamp when the playback began' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Playback', @level2type=N'COLUMN',@level2name=N'StartTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The length of the playback in seconds' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Playback', @level2type=N'COLUMN',@level2name=N'ListenedLength'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The id of the particular track that was listened to' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Playback', @level2type=N'COLUMN',@level2name=N'TrackID'
GO


