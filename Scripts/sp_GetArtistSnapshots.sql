USE [C:\PROJECTS\MY\RVL\ARTISTSWEBBILLING\ARTISTSWEBBILLING\APP_DATA\RVLDB.MDF]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetArtistCommission]    Script Date: 06.05.2018 1:23:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetArtistSnapshots] (@ArtistID int, @PeriodStart datetime, @PeriodEnd datetime)
AS
BEGIN 
	SELECT t.Name as Track, ac.*
		FROM [dbo].AccumulatedCommission ac			
		JOIN [dbo].[Track] t on ac.TrackID = t.[ID]	
	WHERE ac.ArtistID = @ArtistID AND ac.SnapshotTime BETWEEN @PeriodStart AND DATEADD(second,24*60*60-1,@PeriodEnd)
	ORDER BY SnapshotTime, Track
END
