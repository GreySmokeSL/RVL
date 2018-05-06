using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Bogus;
using ArtistsWebBilling.Model;
using MoreLinq;
using System.Data.SqlClient;
using System.Data;
using System.Data.Linq;
using System.Data.Common;
using System.Reflection;
using System.Data.Linq.Mapping;

namespace ArtistsWebBilling.Helper
{
    public static class FakeDataGenerator
    {
        static string RD = Environment.NewLine; 
        public static String GenerateData(int artistsCount = 100)
        {
            var result = "Total generated:";
            using (var dc = new RVLDBDataContext())
            {
                //db cleanup
                dc.ExecuteCommand(@"truncate table [dbo].[Playback];
                                truncate table [dbo].[Commission];
                                DELETE FROM [dbo].[Track];
                                DELETE FROM [dbo].[Artist]");

                var artists = new Faker<Artist>()
               .RuleFor(bp => bp.Name, f => f.Name.FullName())
               .Generate(artistsCount)
               .ToList();

                //to get real id
                dc.Artists.InsertAllOnSubmit(artists);
                dc.SubmitChanges();
                result += RD + "artists=" + artists.Count;

                var commissions = artists
                .Select(a => new Faker<Commission>()
                .RuleFor(bp => bp.ArtistID, f => a.ID)
                .RuleFor(bp => bp.CommissionValue, f => f.Random.Decimal(0.5m, 10m))
                .Generate())
                .ToList();

                dc.IntoTable(commissions, "[dbo].[Commission]");
                result += RD + "commissions=" + commissions.Count;
                commissions.Clear();               

                var tracks = artists
               .SelectMany(a => new Faker<Track>()
               .RuleFor(bp => bp.ArtistID, f => a.ID)
               .RuleFor(bp => bp.Name, f => f.Lorem.Sentence(3))
               .RuleFor(bp => bp.Length, f => f.Random.Int(30, 600))//seconds
               .Generate(new Faker().Random.Int(3, 100)).Select(x => x))
               .Distinct()
               .ToList();

                dc.IntoTable(tracks, "[dbo].[Track]");
                result += RD + "tracks=" + tracks.Count;
                tracks.Clear();

                var trackIDs = dc.Tracks.Select(x=>new { x.ID, x.Length }).ToList();
                var playbacks = new Faker().PickRandom(trackIDs, (int)(trackIDs.Count * 0.8))
                .SelectMany(t => new Faker<Playback>()
                .RuleFor(bp => bp.TrackID, f => t.ID)
                .RuleFor(bp => bp.StartTime, f => f.Date.Past())
                .RuleFor(bp => bp.ListenedLength, f => f.Random.Int(5, t.Length))//seconds
                .Generate(new Faker().Random.Int(1, 500)).Select(x => x))
                .Distinct()
                .ToList();

                dc.IntoTable(playbacks, "[dbo].[Playback]");
                result += RD + "playbacks=" + playbacks.Count;
                playbacks.Clear();
            }
            return result;
        }


       
    }
}


