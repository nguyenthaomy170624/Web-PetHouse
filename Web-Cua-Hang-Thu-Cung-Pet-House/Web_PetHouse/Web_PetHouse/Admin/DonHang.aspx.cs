using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web_PetHouse.Admin
{
	public partial class DonHang : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            Session["breadCrumbTitle"] = "Quản lý đơn hàng";
            Session["breadCrumbPage"] = "Đơn hàng";
        }
    }
}