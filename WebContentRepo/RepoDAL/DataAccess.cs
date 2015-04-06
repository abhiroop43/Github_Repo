using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace RepoDAL
{
    public class DataAccess
    {
        string ConnString;
        SqlConnection conn;
        public DataAccess()
        {
            ConnString = ConfigurationSettings.AppSettings["ConnString"].ToString();
            conn = new SqlConnection(ConnString);
        }

        private void OpenConnection()
        {
            try
            {
                if (conn != null && conn.State != ConnectionState.Open)
                {
                    conn.Open();
                }
            }
            catch (Exception ex)
            {                
                throw ex;
            }
        }

        private void CloseConnection()
        {
            try
            {
                if (conn.State == ConnectionState.Open)
                {
                    conn.Close();
                    conn.Dispose();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public DataTable SqlQueryToDataTable(string Query, string userID)
        {
            DataTable dtOutput = new DataTable();
            try
            {
                OpenConnection();
                SqlCommand cmd = new SqlCommand(Query, conn);
                cmd.CommandType = CommandType.Text;
                SqlDataAdapter sqlDA = new SqlDataAdapter(cmd);
                sqlDA.Fill(dtOutput);
            }
            catch (Exception ex)
            {                
                throw ex;
            }
            finally
            {
                CloseConnection();
            }
            return dtOutput;
        }
    }
}
