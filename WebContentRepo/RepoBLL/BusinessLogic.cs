using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using RepoDAL;

namespace RepoBLL
{
    public class BusinessLogic
    {
        DataAccess objDA;
        public BusinessLogic()
        {
            objDA = new DataAccess();
        }

        public DataTable GetSearchResults(string Keyword, int MaxNoOfResults, string userID)
        {
            DataTable dtOutput;
            try
            {
                string strQuery = "select top " + MaxNoOfResults.ToString() + " kwd.KeywordName, kwd.KeywordDesc, kwd.Abbreviation, repo.Filename, repo.Filepath, repo.FileType, repo.Extension, repo.AddedOn, repo.Status from tblKeywordsMaster kwd inner join tblKeyWordtoRepo kwdtorepo on kwd.ID=kwdtorepo.KeywordID inner join  tblRepomaster repo on kwdtorepo.FileID=repo.ID where kwd.KeywordName like '%" + Keyword + "%' or kwd.KeywordDesc like '%" + Keyword + "%' order by repo.ID";
                dtOutput = objDA.SqlQueryToDataTable(strQuery, userID);
            }
            catch (Exception ex)
            {
                Logger.LogException(ex, userID);
                dtOutput = null;
            }
            return dtOutput;
        }
    }
}
