USE [C:\PROJECTS\MY\RVL\ARTISTSWEBBILLING\ARTISTSWEBBILLING\APP_DATA\RVLDB.MDF]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetArtistCommission]    Script Date: 06.05.2018 13:27:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_GetArtistCommission] (@ArtistID int, @PeriodStart datetime, @PeriodEnd datetime)
AS
BEGIN 
	SELECT t.Name AS Track, tb.TrackID, tb.PlaybackCount, tb.CommissionalPlaybackCount, tb.Commission, tb.AmountBonusKoef, tb.Commission * tb.AmountBonusKoef AS Total
	FROM (SELECT TrackID, SUM(PlaybackCount) AS PlaybackCount, SUM(CommissionalPlaybackCount) AS CommissionalPlaybackCount, SUM(Commission) AS Commission, 
                 CASE WHEN SUM(ac.CommissionalPlaybackCount) > 1000 THEN 2.0 WHEN SUM(ac.CommissionalPlaybackCount) > 500 THEN 1.5 
				 WHEN SUM(ac.CommissionalPlaybackCount) > 100 THEN 1.1 ELSE 1 END AS AmountBonusKoef
                          FROM AccumulatedCommission AS ac
                          WHERE (ArtistID = @ArtistID) AND (SnapshotTime BETWEEN @PeriodStart AND DATEADD(second, 24 * 60 * 60 - 1, @PeriodEnd))
                          GROUP BY TrackID) AS tb INNER JOIN
                         Track AS t ON tb.TrackID = t.ID
ORDER BY tb.Commission DESC, Track
END
