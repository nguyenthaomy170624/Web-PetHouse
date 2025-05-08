using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_PetHouse.NguoiDung
{
	public partial class NguoiDung : System.Web.UI.MasterPage
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            if (Request.Url.AbsoluteUri.ToString().Contains("TrangChu.aspx"))
            {
                Control slidederNguoiDungControl = LoadControl("SliderNguoiDungControl.ascx");
                pmlSliderUC.Controls.Add(slidederNguoiDungControl);
            }

            if (!IsPostBack)
            {
                if (Session["TenDangNhap"] != null && !string.IsNullOrEmpty(Session["TenDangNhap"].ToString()))
                {
                    lblUserName.Text = "    Chào, " + Session["TenDangNhap"].ToString();
                }
                else
                {
                    lblUserName.Text = ""; 
                }
                if (Session["MaNguoiDung"] != null || Session["admin"] != null)
                {
                    pnlChuaDangNhap.Visible = false;
                    pnlDaDangNhap.Visible = true;
                }
                else
                {
                    pnlChuaDangNhap.Visible = true;
                    pnlDaDangNhap.Visible = false;
                }

            }
        }

        protected void lbRegisterOrProfile_Click(object sender, EventArgs e)
        {

        }

        protected void btnTK_Click(object sender, EventArgs e)
        {

            if (Session["MaNguoiDung"] != null)
            {
                btnTK.ToolTip = "Hồ sơ cá nhân";
                Response.Redirect("ThongTin.aspx");
            }
            else
            {
                btnTK.ToolTip = "Đăng ký tài khoản";
                Response.Redirect("DangKy.aspx");
            }
        }
        protected void btnDangXuat_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("/NguoiDung/TrangChu.aspx"); 
        }
    }
}