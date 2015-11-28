using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


    public class DbHelper : IDisposable
    {
        //private const string ConnString = "Data Source=EDARTIDBDEV;Initial Catalog=AdventureWorks2012_Data;User Id=report1;Password=report1";
        private readonly string _connString = ConfigurationManager.ConnectionStrings["AWConnString"].ConnectionString;
        public SqlConnection Conn;

        public void OpenConnection()
        {
            if (Conn == null)
            {
                Conn = new SqlConnection(_connString);
            }
            if (Conn.State != ConnectionState.Open)
            {
                Conn.Open();
            }
        }

        public void CloseConnection()
        {
            if (Conn.State == ConnectionState.Open)
            {
                Conn.Close();
                Conn.Dispose();
            }
        }

        public DataTable GetYearlyRevenue()
        {
            DataTable dtOutput = new DataTable();
            try
            {
                OpenConnection();
                string strQuery = "select SUM(detail.LineTotal) Rev, YEAR(header.OrderDate) Year from Sales.SalesOrderDetail detail inner join Sales.SalesOrderHeader header on detail.SalesOrderID=header.SalesOrderID group by YEAR(header.OrderDate) order by YEAR(header.OrderDate)";

                SqlDataAdapter sqlDa = new SqlDataAdapter(strQuery, Conn);

                sqlDa.Fill(dtOutput);
            }
            finally
            {
                CloseConnection();
            }
            return dtOutput;
        }

        public DataTable GetYearlyRevenue(int customerId)
        {
            DataTable dtOutput = new DataTable();
            try
            {
                OpenConnection();
                string strQuery = "select SUM(detail.LineTotal) Rev, YEAR(header.OrderDate) Year from Sales.SalesOrderDetail detail inner join Sales.SalesOrderHeader header on detail.SalesOrderID=header.SalesOrderID  where header.CustomerID = @CustomerID group by YEAR(header.OrderDate) order by YEAR(header.OrderDate)";

                SqlDataAdapter sqlDa = new SqlDataAdapter(strQuery, Conn);
                sqlDa.SelectCommand.Parameters.Add("@CustomerID", SqlDbType.Int);
                sqlDa.SelectCommand.Parameters["@CustomerID"].Value = customerId;
                sqlDa.Fill(dtOutput);
            }
            finally
            {
                CloseConnection();
            }
            return dtOutput;
        }

        public DataTable GetQuarterlyRevenue(int year)
        {
            DataTable dtOutput = new DataTable();
            try
            {
                OpenConnection();
                string strQuery = "with T as (select SUM(detail.LineTotal) Rev, CASE WHEN MONTH(header.OrderDate) IN (1,2,3) THEN 1 WHEN  MONTH(header.OrderDate) IN (4,5,6) THEN 2 WHEN  MONTH(header.OrderDate) IN (7,8,9) THEN 3 ELSE 4 END AS Quarter from Sales.SalesOrderDetail detail inner join Sales.SalesOrderHeader header on detail.SalesOrderID=header.SalesOrderID WHERE YEAR(header.OrderDate)=@Year group by header.OrderDate) select SUM(T.Rev) Rev, Quarter from T group by Quarter order by Quarter";

                SqlDataAdapter sqlDa = new SqlDataAdapter(strQuery, Conn);
                sqlDa.SelectCommand.Parameters.Add("@Year", SqlDbType.Int);
                sqlDa.SelectCommand.Parameters["@Year"].Value = year;

                sqlDa.Fill(dtOutput);
            }
            finally
            {
                CloseConnection();
            }
            return dtOutput;
        }

        public DataTable GetQuarterlyRevenue(int year, int customerId)
        {
            DataTable dtOutput = new DataTable();
            try
            {
                OpenConnection();
                string strQuery = "with T as (select SUM(detail.LineTotal) Rev, CASE WHEN MONTH(header.OrderDate) IN (1,2,3) THEN 1 WHEN  MONTH(header.OrderDate) IN (4,5,6) THEN 2 WHEN  MONTH(header.OrderDate) IN (7,8,9) THEN 3 ELSE 4 END AS Quarter from Sales.SalesOrderDetail detail inner join Sales.SalesOrderHeader header on detail.SalesOrderID=header.SalesOrderID WHERE YEAR(header.OrderDate)=@Year and header.CustomerID = @CustomerID group by header.OrderDate) select SUM(T.Rev) Rev, Quarter from T group by Quarter order by Quarter";

                SqlDataAdapter sqlDa = new SqlDataAdapter(strQuery, Conn);
                sqlDa.SelectCommand.Parameters.Add("@Year", SqlDbType.Int);
                sqlDa.SelectCommand.Parameters["@Year"].Value = year;
                sqlDa.SelectCommand.Parameters.Add("@CustomerID", SqlDbType.Int);
                sqlDa.SelectCommand.Parameters["@CustomerID"].Value = customerId;
                sqlDa.Fill(dtOutput);
            }
            finally
            {
                CloseConnection();
            }
            return dtOutput;
        }

        public DataTable GetMonthlyRevenue(int year, int quarter)
        {
            DataTable dtOutput = new DataTable();
            try
            {
                OpenConnection();
                string strQuery = "select SUM(detail.LineTotal) Rev, datename(month, header.OrderDate) Month from Sales.SalesOrderDetail detail inner join Sales.SalesOrderHeader header on detail.SalesOrderID=header.SalesOrderID WHERE YEAR(header.OrderDate)=@Year and @Quarter = CASE WHEN MONTH(header.OrderDate) IN (1,2,3) THEN 1 WHEN  MONTH(header.OrderDate) IN (4,5,6) THEN 2 WHEN  MONTH(header.OrderDate) IN (7,8,9) THEN 3 ELSE 4 END group by datename(month, header.OrderDate) order by MONTH(datename(month, header.OrderDate) + ' 1 2014') ";

                SqlDataAdapter sqlDa = new SqlDataAdapter(strQuery, Conn);
                sqlDa.SelectCommand.Parameters.Add("@Year", SqlDbType.Int);
                sqlDa.SelectCommand.Parameters["@Year"].Value = year;
                sqlDa.SelectCommand.Parameters.Add("@Quarter", SqlDbType.Int);
                sqlDa.SelectCommand.Parameters["@Quarter"].Value = quarter;
                sqlDa.Fill(dtOutput);
            }
            finally
            {
                CloseConnection();
            }
            return dtOutput;
        }

        public DataTable GetMonthlyRevenue(int year, int quarter, int customerId)
        {
            DataTable dtOutput = new DataTable();
            try
            {
                OpenConnection();
                string strQuery = "select SUM(detail.LineTotal) Rev, datename(month, header.OrderDate) Month from Sales.SalesOrderDetail detail inner join Sales.SalesOrderHeader header on detail.SalesOrderID=header.SalesOrderID WHERE header.CustomerID = @CustomerID and YEAR(header.OrderDate)=@Year and @Quarter = CASE WHEN MONTH(header.OrderDate) IN (1,2,3) THEN 1 WHEN  MONTH(header.OrderDate) IN (4,5,6) THEN 2 WHEN  MONTH(header.OrderDate) IN (7,8,9) THEN 3 ELSE 4 END group by datename(month, header.OrderDate) order by MONTH(datename(month, header.OrderDate) + ' 1 2014') ";

                SqlDataAdapter sqlDa = new SqlDataAdapter(strQuery, Conn);
                sqlDa.SelectCommand.Parameters.Add("@CustomerID", SqlDbType.Int);
                sqlDa.SelectCommand.Parameters["@CustomerID"].Value = customerId;
                sqlDa.SelectCommand.Parameters.Add("@Year", SqlDbType.Int);
                sqlDa.SelectCommand.Parameters["@Year"].Value = year;
                sqlDa.SelectCommand.Parameters.Add("@Quarter", SqlDbType.Int);
                sqlDa.SelectCommand.Parameters["@Quarter"].Value = quarter;
                sqlDa.Fill(dtOutput);
            }
            finally
            {
                CloseConnection();
            }
            return dtOutput;
        }

        public DataTable GetCustomerOrders()
        {
            DataTable dtOutput = new DataTable();
            try
            {
                OpenConnection();
                string strQuery = "select header.CustomerID, CONCAT(person.FirstName, ' ', person.MiddleName, ' ', person.LastName) CustomerName, SUM(detail.LineTotal) Revenue, YEAR(header.OrderDate) OrderYear from Sales.SalesOrderDetail detail inner join Sales.SalesOrderHeader header on detail.SalesOrderID=header.SalesOrderID inner join Sales.Customer cust on header.CustomerID=cust.CustomerID inner join Person.Person person on cust.CustomerID=person.BusinessEntityID group by header.CustomerID, CONCAT(person.FirstName, ' ', person.MiddleName, ' ', person.LastName), YEAR(header.OrderDate) order by YEAR(header.OrderDate), CustomerName";

                SqlDataAdapter sqlDa = new SqlDataAdapter(strQuery, Conn);

                sqlDa.Fill(dtOutput);
            }
            finally
            {
                CloseConnection();
            }
            return dtOutput;
        }

        //public DataTable GetCustomerOrdersByCid(int customerId)
        //{
        //    DataTable dtOutput = new DataTable();
        //    try
        //    {
        //        OpenConnection();
        //        string strQuery = "select header.CustomerID, CONCAT(person.FirstName, ' ', person.MiddleName, ' ', person.LastName) CustomerName, SUM(detail.LineTotal) Revenue, header.OrderDate OrderYear from Sales.SalesOrderDetail detail inner join Sales.SalesOrderHeader header on detail.SalesOrderID=header.SalesOrderID inner join Sales.Customer cust on header.CustomerID=cust.CustomerID inner join Person.Person person on cust.CustomerID=person.BusinessEntityID where header.CustomerID = @CustomerID group by header.CustomerID, CONCAT(person.FirstName, ' ', person.MiddleName, ' ', person.LastName), header.OrderDate order by header.OrderDate, CustomerName";

        //        SqlDataAdapter sqlDa = new SqlDataAdapter(strQuery, Conn);
        //        sqlDa.SelectCommand.Parameters.Add("@CustomerID", SqlDbType.Int);
        //        sqlDa.SelectCommand.Parameters["@CustomerID"].Value = customerId;
        //        sqlDa.Fill(dtOutput);
        //    }
        //    finally
        //    {
        //        CloseConnection();
        //    }
        //    return dtOutput;
        //}

        public void Dispose()
        {
            CloseConnection();
        }
    }