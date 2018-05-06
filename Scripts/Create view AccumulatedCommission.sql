USE [C:\PROJECTS\MY\RVL\ARTISTSWEBBILLING\ARTISTSWEBBILLING\APP_DATA\RVLDB.MDF]
GO

/****** Object:  View [dbo].[AccumulatedCommission]    Script Date: 06.05.2018 14:35:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[AccumulatedCommission]
AS
SELECT        p.TrackID, t.ArtistID, COUNT(p.ID) AS PlaybackCount, SUM(CASE WHEN CAST(p.ListenedLength AS float) / t .Length > 0.5 THEN 1 ELSE 0 END) AS CommissionalPlaybackCount, 
                         SUM(CASE WHEN CAST(p.ListenedLength AS float) / t .Length > 0.5 THEN 1 ELSE 0 END * c.CommissionValue) AS Commission, DATEADD(hour, DATEDIFF(hour, 0, p.StartTime), 0) AS SnapshotTime
FROM            dbo.Playback AS p INNER JOIN
                         dbo.Track AS t ON p.TrackID = t.ID INNER JOIN
                         dbo.Commission AS c ON t.ArtistID = c.ArtistID
GROUP BY p.TrackID, t.ArtistID, DATEADD(hour, DATEDIFF(hour, 0, p.StartTime), 0)
GO

