<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="BangDieuKhien.aspx.cs" Inherits="Web_PetHouse.Admin.BangDieuKhien" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
       .dashboard-card {
    padding: 20px;
    background-color: #007bff; 
    border-radius: 12px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    text-align: center;
    margin-bottom: 20px;
    color: white;  
}

.dashboard-card h3 {
    margin: 10px 0;
}

    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        <div class="col-md-3">
            <div class="dashboard-card">
                <h4>Danh mục</h4>
                <h3>
                    <asp:Label ID="lblTongDanhMuc" runat="server" Text="0" /></h3>
            </div>
        </div>
        <div class="col-md-3">
            <div class="dashboard-card">
                <h4>Sản phẩm</h4>
                <h3>
                    <asp:Label ID="lblTongSanPham" runat="server" Text="0" /></h3>
            </div>
        </div>
        <div class="col-md-3">
            <div class="dashboard-card">
                <h4>Người dùng</h4>
                <h3>
                    <asp:Label ID="lblTongNguoiDung" runat="server" Text="0" /></h3>
            </div>
        </div>
        <div class="col-md-3">
            <div class="dashboard-card">
                <h4>Đơn hàng</h4>
                <h3>
                    <asp:Label ID="lblTongDonHang" runat="server" Text="0" /></h3>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-10">
            <canvas id="chartDoanhThu" width="400" height="200"></canvas> 
        </div>
    </div>

    <asp:HiddenField ID="hdnLabels" runat="server" />
    <asp:HiddenField ID="hdnValues" runat="server" />

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var ctx = document.getElementById('chartDoanhThu').getContext('2d');

            var labels = document.getElementById('<%= hdnLabels.ClientID %>').value.split(',');
            var values = document.getElementById('<%= hdnValues.ClientID %>').value.split(',').map(Number);

            new Chart(ctx, {
                type: 'bar',  
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Doanh thu theo hình thức thanh toán',
                        data: values,
                        backgroundColor: '#36A2EB',  
                        borderColor: '#36A2EB', 
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        x: {
                            ticks: {
                                maxRotation: 45,  
                                minRotation: 45
                            }
                        },
                        y: {
                            beginAtZero: true  
                        }
                    }
                }
            });
        });
    </script>
</asp:Content>
