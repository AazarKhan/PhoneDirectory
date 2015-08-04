using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Phone_Directory
{
    public partial class MainPage : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["PhoneDBLocal"].ConnectionString;

        public void Message(string error)
        {
            string message = error;

            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload=function(){");
            sb.Append("alert('");
            sb.Append(message);
            sb.Append("')};");
            sb.Append("</script>");

            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
        }

        public void LoadGridData(string query)
        {
            SqlConnection sqlConn = new SqlConnection(connString);

            try
            {
                sqlConn.Open();

                SqlDataAdapter sqlAdapt = new SqlDataAdapter(query, sqlConn);
                DataSet dataSet = new DataSet();
                sqlAdapt.Fill(dataSet);
                DataGrid.DataSource = dataSet;
                DataGrid.DataBind();

                if (DataGrid.Rows.Count < 1)
                    LabelGrid.Text = "No results found";

                else
                    LabelGrid.Text = "" + DataGrid.Rows.Count.ToString() + " result(s) found";
            }

            catch
            {
                Message("Unexpected Failure!");
            }

            finally
            {
                sqlConn.Close();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Add_Click(object sender, EventArgs e)
        {
            SqlConnection SqlCon = new SqlConnection(connString);

            try
            {
                if (TextBoxNumber.Text == "" || TextBoxName.Text == "" || TextBoxCity.Text == "")
                {
                    Message("Please fill all the fields!!");
                }

                else
                {
                    string query = "SELECT COUNT(*) FROM DirectoryTable WHERE Number ='" + TextBoxNumber.Text + "'";

                    SqlCommand SqlCom = new SqlCommand(query, SqlCon);
                    SqlCon.Open();
                    
                    int obj = Convert.ToInt32(SqlCom.ExecuteScalar());

                    if (obj > 0)
                    {
                        Message("The number is already being used!!");
                        SqlCon.Close();
                    }

                    else
                    {
                        query = "INSERT INTO DirectoryTable (Number, Name, City) Values (@Number, @Name, @City)";
                        SqlCom = new SqlCommand(query, SqlCon);

                        SqlCom.Parameters.AddWithValue("@Number", TextBoxNumber.Text);
                        SqlCom.Parameters.AddWithValue("@Name", TextBoxName.Text);
                        SqlCom.Parameters.AddWithValue("@City", TextBoxCity.Text);

                        SqlCom.ExecuteNonQuery();

                        SqlCon.Close();

                        TextBoxNumber.Text = "";
                        TextBoxName.Text = "";
                        TextBoxCity.Text = "";

                        Message("Account is successfully created!!");
                    }
                }
            }

            catch
            {
                Message("Unexpected error occured!!");
            }

            finally
            {
                SqlCon.Close();
            }
        }

        protected void ShowData_Click(object sender, EventArgs e)
        {
            string query = "SELECT Number AS 'Number', Name AS 'Name', City AS 'City' FROM DirectoryTable ORDER BY Name";
            LoadGridData(query);
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            string query = "SELECT Number AS 'Number', Name AS 'Name', City AS 'City' FROM DirectoryTable "
                             + "WHERE Number LIKE '%" + SearchBox.Text + "%' OR Name LIKE '%" + SearchBox.Text + "%' OR City LIKE '%" + SearchBox.Text + "%' "
                             + "ORDER BY Name";
            LoadGridData(query);
        }

        //protected void DataGrid_PageIndexChanging(object sender, GridViewPageEventArgs e)
        //{
        //    DataGrid.PageIndex = e.NewPageIndex;
        //    LoadGridData();
        //}
    }
}