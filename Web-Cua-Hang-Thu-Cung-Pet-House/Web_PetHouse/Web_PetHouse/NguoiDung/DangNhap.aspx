<%@ Page Title="" Language="C#" MasterPageFile="~/NguoiDung/NguoiDung.Master" AutoEventWireup="true" CodeBehind="DangNhap.aspx.cs" Inherits="Web_PetHouse.NguoiDung.DangNhap" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
     <style>
        .login-wrapper {
            width: 100%;
             min-height: 70px;
             display: flex;
             justify-content: center;
             align-items: flex-start;
             background: #edf1ff;
             padding-top: 50px;
        }

        .login-container {
             width: 100%;
              max-width: 400px;
              padding: 35px;
              background: #fff;
              border-radius: 12px;
              box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.15);
              animation: fadeIn 0.5s ease-in-out;
        }

        .login-title {
            font-size: 24px;
            font-weight: bold;
            color: #007bff;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            font-size: 18px;
            font-weight: bold;
            background: #007bff;
            color: #fff;
            border: none;
            border-radius: 8px;
            transition: 0.3s;
            box-shadow: 0px 4px 8px rgba(0, 123, 255, 0.3);
            margin-top: 15px;
        }

        .btn-login:hover {
            background: #0056b3;
        }
    </style>
      <script>
      window.onload = function () {
          var seconds = 5;
          setTimeout(function () {
              document.getElementById('<%= lblMsg.ClientID %>').style.display = "none";
              }, seconds * 1000);
      };
      </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="login-wrapper">
        <div class="login-container">
            <div class="login-title">Đăng nhập</div>

            <div class="form-group">
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Nhập tên đăng nhập"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ErrorMessage="Vui lòng nhập tên đăng nhập" ControlToValidate="txtUsername" CssClass="text-danger"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Nhập mật khẩu" TextMode="Password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Vui lòng nhập mật khẩu" ControlToValidate="txtPassword" CssClass="text-danger"></asp:RequiredFieldValidator>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Đăng nhập" CssClass="btn-login" OnClick="btnLogin_Click1" />
                        <asp:Label ID="lblAlreadyUser" CssClass="label-center"  runat="server" Text="Chưa có tài khoản? <a href='DangKy.aspx'>Đăng ký tại đây</a>"></asp:Label>
            <asp:Label ID="lblMsg" runat="server" CssClass="text-danger" Visible="false"></asp:Label>
        </div>
    </div>
</asp:Content>