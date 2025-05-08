<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VNPayReturn.aspx.cs" Inherits="Web_PetHouse.NguoiDung.VNPayReturn" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Kết Quả Thanh Toán VNPay</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <script>
        function showSuccessAlert(message, redirectUrl) {
            Swal.fire({
                title: 'Thành công!',
                text: message,
                icon: 'success',
                confirmButtonText: 'OK'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = redirectUrl;
                }
            });
        }

        function showErrorAlert(message) {
            Swal.fire({
                title: 'Lỗi!',
                text: message,
                icon: 'error',
                confirmButtonText: 'OK'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'ThanhToan.aspx';
                }
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h3>Kết Quả Thanh Toán VNPay</h3>
                </div>
                <div class="card-body">
                    <asp:Label ID="lblResult" runat="server" CssClass="text-info"></asp:Label>
                </div>
                <div class="card-footer">
                    <asp:Button ID="btnBack" runat="server" CssClass="btn btn-secondary" Text="Quay lại" OnClick="btnBack_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>