using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Configuration;
namespace Web_PetHouse
{
  
    public class KetNoi
	{
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        SqlDataReader sdr;
        DataTable dt;
        public static string getConnection()
        {
            return ConfigurationManager.ConnectionStrings["cs"].ConnectionString;
        }
        public static bool IsValidExtension(string fileName)
        {
            bool isValid = false;
            string[] fileExtension = { ".jpg", ".png", ".jpeg" };
            foreach (string file in fileExtension)
            {
                if (fileName.Contains(file))
                {
                    isValid = true;
                    break;
                }
            }
            return isValid;
        }
        public static string getUniqueId()
        {
            Guid guid = Guid.NewGuid();
            return guid.ToString();
        }
        public static string getImageUrl(object imageUrl)
        {
            string img = Convert.ToString(imageUrl);
            return string.IsNullOrEmpty(img) ? "/HinhAnh/No_image.png" : "" + img;
        }
        public static string getImageUrl1(object imageUrl)
        {
            string img = Convert.ToString(imageUrl);
            return string.IsNullOrEmpty(img) ? "/HinhAnh/No_image.png" : "/NguoiDungTemplate/HinhAnh/" + img;
        }

        public bool updateCartQuantity(int quantity, int productId, int userId)
        {
            bool isUpdated = false;
            con = new SqlConnection(KN.GetConnectionString());
            cmd = new SqlCommand("Cart_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "UPDATE");
            cmd.Parameters.AddWithValue("@ProductId", productId);
            cmd.Parameters.AddWithValue("@Quantity", quantity);
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                isUpdated = true;
            }
            catch (Exception ex)
            {
                isUpdated = false;
                System.Web.HttpContext.Current.Response.Write("<script>alert('Error - " + ex.Message + "');</script>");
            }
            finally
            {
                con.Close();
            }
            return isUpdated;
        }

        public int cartCount(int userId)
        {
            con = new SqlConnection(KN.GetConnectionString());
            cmd = new SqlCommand("Cart_Crud", con);

            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.Parameters.AddWithValue("@UserId", userId);

            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();
            sda.Fill(dt);

            return dt.Rows.Count;
        }
        public static string GetUniqueId()
        {
            Guid guid = Guid.NewGuid();
            String uniqueId = guid.ToString();
            return uniqueId;
        }
    }
}