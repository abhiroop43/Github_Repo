using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;



/// <summary>
/// Class provides the basic functionalities to manipulate data in database using Entity framework Model.
/// </summary>
public class CoreEntity : IDisposable
{
    /// <summary>
    /// Instance of DatabaseEntities class, used for basic database operations.
    /// </summary>
    public Entities Database { get; set; }
    /// <summary>
    /// Constructor of Core entity class
    /// </summary>
    public CoreEntity()
    {
        Database = new Entities();
    }
    /// <summary>
    /// Save changes function
    /// </summary>
    public void CommitChanges()
    {
        try
        {
            Database.SaveChanges();
        }
        catch (Exception)
        {

        }
    }
    /// <summary>
    /// Dispose DataBase Connection
    /// </summary>
    public void Dispose()
    {
        Database.Dispose();
    }
}

