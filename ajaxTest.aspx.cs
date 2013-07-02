using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ajaxTest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static string GetDate()
    {
        return DateTime.Now.ToString();
    }



    [WebMethod]
    public static List<person> GetPeople()
    {        
        List<person> list = new List<person>()
        {
            new person {fname="Sam", lname ="Smith", id="1"},
            new person {fname="Greg", lname ="Lewis", id="2"},
            new person {fname="Kait", lname ="Sampson", id="3"},
            new person {fname="Paul", lname ="Lilian", id="4"}
        };

       return list;
            
        
    }


    [WebMethod]
    public static tmMember GetPerson(int id)
    {
        var get = getTeamMembers()[id];

        return get;
    }

    public class person
    {
        
        public string fname { get; set; }
        public string lname { get; set; }
        public string id { get; set; }

    }

    public class tmMember
    {
        public string tmMemberID { get; set; }
        public string fName { get; set; }
        public string lName { get; set; }
        public string grade { get; set; }
        public string teamID { get; set; }
        public string userID { get; set; }
    }


    [WebMethod]
    public static List<tmMember> getTeamMembers()
    {

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "SELECT tmMemberID, fName, lName, grade, teamID, userID FROM tmMembers WHERE teamID = 1";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            SqlDataReader reader = command.ExecuteReader();

            List<tmMember> _members = new List<tmMember>();
            while (reader.Read())
            {
                _members.Add(new tmMember()
                {
                    tmMemberID = reader["tmMemberID"].ToString(),
                    fName = reader["fName"].ToString(),
                    lName = reader["lName"].ToString(),
                    grade = reader["grade"].ToString(),
                    teamID = reader["teamID"].ToString(),
                    userID = reader["userID"].ToString()
                });
            }

            //Close connections
            reader.Close();
            connection.Close();

            return _members;
        }
    }

    [WebMethod]
    public static void newTeamMembers(string fName, string lName, int grade, int teamID)
    {
        tmMember newMember = new tmMember();

        string connectionString = ConfigurationManager.ConnectionStrings["statbookConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string sql = "Insert INTO tmMembers (fName, lName, grade, teamID) VALUES (@fName, @lName, @grade, @teamID);";

            connection.Open();

            SqlCommand command = new SqlCommand(sql, connection);
            command.Parameters.AddWithValue("@fName", fName);
            command.Parameters.AddWithValue("@lName", lName);
            command.Parameters.AddWithValue("@grade", grade);
            command.Parameters.AddWithValue("@teamID", teamID);
         
            command.ExecuteNonQuery();
        }
    }
}