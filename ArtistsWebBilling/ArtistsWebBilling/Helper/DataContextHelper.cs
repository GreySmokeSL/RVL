using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.Linq;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;

namespace ArtistsWebBilling.Helper
{
    public static class DataContextHelper
    {
        public static bool IsEmpty<T>(this IEnumerable<T> list)
        {
            return list == null || !list.Any();
        }

        public static bool IsNone(this string source)
        {
            return String.IsNullOrWhiteSpace(source);
        }

        public static bool IntoTable(this DataContext context, IDataReader dataReader, string tableName)
        {
            if (dataReader == null || String.IsNullOrEmpty(tableName))
                return false;

            var connection = context.Connection as SqlConnection;
            var duration = TimeSpan.Zero;

            return dataReader.InsertDataIntoSqlServerUsingSqlBulkCopy(connection, tableName, ref duration);
        }

        public static bool IntoTable<T>(this DataContext context, IEnumerable<T> tableSource, string tableName)
        {
            if (tableSource.IsEmpty() || String.IsNullOrEmpty(tableName))
                return false;
            var dataReader = tableSource.GetDataReader();

            return context.IntoTable(dataReader, tableName);
        }

        public static bool InsertDataIntoSqlServerUsingSqlBulkCopy(
           this IDataReader aDataReader,
           SqlConnection aConnection,
           String aTableName,
           ref TimeSpan aBulkDuration,
           bool aShowMessage = false,
           int aCommandTimeout = 1800)
        {
            if (aDataReader == null || aConnection == null || aTableName.IsNone())
                return false;

            try
            {
                if (!aConnection.CheckOpen())
                    return false;

                var bulkCopy = new SqlBulkCopy(aConnection);

                aDataReader.ForeachFields(c => bulkCopy.ColumnMappings.Add(c, c));

                bulkCopy.BulkCopyTimeout = aCommandTimeout;

                bulkCopy.DestinationTableName = aTableName;
                try
                {
                    bulkCopy.WriteToServer(aDataReader);
                }
                finally
                {
                    aDataReader.Close();
                    aDataReader.Dispose();
                }
            }
            catch (Exception ex)
            {
                return false;
            }
            return true;
        }

        public static bool CheckOpen(this DbConnection connection)
        {
            if (connection == null) return false;
            if (connection.State != ConnectionState.Open)
                try
                {
                    connection.Open();
                }
                catch (Exception ex)
                {
                    SqlConnection.ClearPool((SqlConnection)connection);
                    try
                    {
                        connection.Open();
                    }
                    catch (Exception exc)
                    {
                        SqlConnection.ClearAllPools();
                        connection.Open();
                    }
                }
            return connection.State == ConnectionState.Open;
        }


        public static IDataReader GetDataReader<T>(this IEnumerable<T> aCollection, params string[] fields)
        {
            if (fields.IsEmpty())
                fields = aCollection.GetColumnPropertyNames();
            return new EnumerableDataReader<T>(aCollection, fields);
        }

        public static void ForeachFields(this IDataReader source, Action<string> foreachAction)
        {
            if (source == null || foreachAction == null)
                return;

            for (int i = 0; i < source.FieldCount; i++)
                foreachAction(source.GetName(i));
        }

        public static string[] GetColumnPropertyNames<T>(this IEnumerable<T> aCollection)
        {
            return typeof(T).GetProperties()
                .Where(i => i.CanRead && i.GetCustomAttribute<System.Data.Linq.Mapping.ColumnAttribute>() != null)
                .Select(s => s.Name).ToArray();
        }

    }
}