<%@ Page Title="" Language="C#" MasterPageFile="~/NguoiDung/NguoiDung.Master" AutoEventWireup="true" CodeBehind="ThanhToan.aspx.cs" Inherits="Web_PetHouse.NguoiDung.ThanhToan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>
    window.openPaymentModal = function () {
        const selected = document.querySelector("input[name='payment']:checked");
        console.log("Radio selected:", selected ? selected.id : "None");

        if (selected) {
            if (selected.id === "credit-card-option") {
                console.log("Mở modal CreditCard");
                $("#creditCardModal").modal("show");
            } else if (selected.id === "vnpay-option") {
                console.log("Mở modal VNPay");
                $("#vnpayModal").modal("show");
            } else if (selected.id === "cod-option") {
                console.log("Mở modal COD");
                $("#codModal").modal("show");
            }
        } else {
            console.log("Chưa chọn phương thức");
            window.showErrorAlert("Vui lòng chọn phương thức thanh toán.");
        }
    };

    // Hàm hiển thị alert thành công
    window.showSuccessAlert = function (message, redirectUrl) {
        $("#creditCardModal, #codModal, #vnpayModal").modal("hide");

        if (typeof Swal !== 'undefined') {
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
        } else {
            alert('Thành công: ' + message + '\nChuyển hướng đến: ' + redirectUrl);
            window.location.href = redirectUrl;
        }
    };

    // Hàm hiển thị alert lỗi
    window.showErrorAlert = function (message) {
        $("#creditCardModal, #codModal, #vnpayModal").modal("hide");

        if (typeof Swal !== 'undefined') {
            Swal.fire({
                title: 'Lỗi!',
                text: message,
                icon: 'error',
                confirmButtonText: 'OK'
            });
        } else {
            alert('Lỗi: ' + message);
        }
    };
</script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Tiêu đề trang -->
    <div class="d-flex flex-column align-items-center justify-content-center text-center bg-secondary" style="min-height: 300px">
        <h1 class="font-weight-bold text-uppercase mb-3 title-effect">THANH TOÁN</h1>
        <div class="d-inline-flex align-items-center breadcrumb-custom">
            <h2 class="m-0"><a href="TrangChu.aspx" class="text-decoration-none">TRANG CHỦ</a></h2>
            <span class="mx-2">|</span>
            <h2 class="m-0 text-muted">THANH TOÁN</h2>
        </div>
    </div>

    <!-- Nội dung thanh toán -->
    <div class="container-fluid pt-5">
        <div class="row px-xl-5">
            <div class="col-lg-8">
                <div class="mb-4">
                    <h4 class="font-weight-semi-bold mb-4">Thông Tin Thanh Toán</h4>
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label>Họ</label>
                            <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control" placeholder="Nguyễn"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="txtFirstName" ErrorMessage="Vui lòng nhập họ" ForeColor="Red" Display="Dynamic" ValidationGroup="MainForm" />
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Tên</label>
                            <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control" placeholder="Văn A"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="txtLastName" ErrorMessage="Vui lòng nhập tên" ForeColor="Red" Display="Dynamic" ValidationGroup="MainForm" />
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="bug@email.com"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Vui lòng nhập email" ForeColor="Red" Display="Dynamic" ValidationGroup="MainForm" />
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email không hợp lệ" ForeColor="Red" Display="Dynamic" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" ValidationGroup="MainForm" />
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Số Điện Thoại</label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="+84 123 456 789"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Vui lòng nhập số điện thoại" ForeColor="Red" Display="Dynamic" ValidationGroup="MainForm" />
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Địa Chỉ</label>
                            <asp:TextBox ID="txtAddress1" runat="server" CssClass="form-control" placeholder="Địa chỉ"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvAddress1" runat="server" ControlToValidate="txtAddress1" ErrorMessage="Vui lòng nhập địa chỉ" ForeColor="Red" Display="Dynamic" ValidationGroup="MainForm" />
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Quận/Huyện</label>
                            <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="Đầm Dơi"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity" ErrorMessage="Vui lòng nhập thành phố" ForeColor="Red" Display="Dynamic" ValidationGroup="MainForm" />
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Tỉnh/Thành Phố</label>
                            <asp:TextBox ID="txtState" runat="server" CssClass="form-control" placeholder="Cà Mau"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvState" runat="server" ControlToValidate="txtState" ErrorMessage="Vui lòng nhập tỉnh/thành" ForeColor="Red" Display="Dynamic" ValidationGroup="MainForm" />
                        </div>
                        <div class="col-md-6 form-group">
                            <label>Mã Bưu Điện</label>
                            <asp:TextBox ID="txtZipCode" runat="server" CssClass="form-control" placeholder="100000"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="card border-secondary mb-5">
                    <div class="card-header bg-secondary border-0">
                        <h4 class="font-weight-semi-bold m-0">Tổng Đơn Hàng</h4>
                    </div>
                    <asp:Repeater ID="rptCartSummary" runat="server">
                        <ItemTemplate>
                            <div class="card-body">
                                <div class="d-flex justify-content-between mb-3 pt-1">
                                    <h6 class="font-weight-medium">Tạm tính</h6>
                                    <h6 class="font-weight-medium"><%# Eval("TongTien", "{0:N0}") %>đ</h6>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <div class="card-body">
                        <div class="d-flex justify-content-between">
                            <h6 class="font-weight-medium">Phí vận chuyển</h6>
                            <h6 class="font-weight-medium">50.000đ</h6>
                        </div>
                    </div>
                    <div class="card-footer border-secondary bg-transparent">
                        <div class="d-flex justify-content-between mt-2">
                            <h5 class="font-weight-bold">Tổng cộng</h5>
                            <h5 class="font-weight-bold text-danger">
                                <asp:Label ID="lblTongTien" runat="server"></asp:Label>
                            </h5>
                        </div>
                    </div>
                </div>
                <div class="card border-secondary mb-5">
                    <div class="card-header bg-secondary border-0">
                        <h4 class="font-weight-semi-bold m-0">Phương Thức Thanh Toán</h4>
                    </div>
                    <div class="card-body">
                        <div class="form-group">
                            <div class="custom-control custom-radio">
                                <input type="radio" class="custom-control-input" name="payment" id="credit-card-option" value="credit-card-option">
                                <label class="custom-control-label" for="credit-card-option">Thẻ tín dụng / Ghi nợ</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="custom-control custom-radio">
                                <input type="radio" class="custom-control-input" name="payment" id="vnpay-option" value="vnpay-option">
                                <label class="custom-control-label" for="vnpay-option">Thanh toán VNPay</label>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="custom-control custom-radio">
                                <input type="radio" class="custom-control-input" name="payment" id="cod-option" value="cod-option">
                                <label class="custom-control-label" for="cod-option">Thanh toán khi nhận hàng (COD)</label>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer border-secondary bg-transparent">
<asp:Button ID="btnPlaceOrder" runat="server" OnClientClick="openPaymentModal(); return false;" CssClass="btn btn-lg btn-block btn-primary font-weight-bold my-3 py-3" Text="Đặt Hàng" />
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Thanh toán bằng thẻ tín dụng -->
    <div class="modal fade" id="creditCardModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thanh toán bằng Thẻ tín dụng</h5>
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>
                <div class="modal-body">
                    <label>Họ và tên</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Nhập tên chủ thẻ"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Vui lòng nhập tên chủ thẻ" ForeColor="Red" Display="Dynamic" ValidationGroup="CardPayment" />
                    
                    <label>Số thẻ</label>
                    <asp:TextBox ID="txtCardNo" runat="server" CssClass="form-control" placeholder="Nhập số thẻ 16 số"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCardNo" runat="server" ControlToValidate="txtCardNo" ErrorMessage="Vui lòng nhập số thẻ" ForeColor="Red" Display="Dynamic" ValidationGroup="CardPayment" />
                    <asp:RegularExpressionValidator ID="revCardNo" runat="server" ControlToValidate="txtCardNo" ErrorMessage="Số thẻ phải là 16 chữ số" ForeColor="Red" Display="Dynamic" ValidationExpression="^\d{16}$" ValidationGroup="CardPayment" />

                    <label>Ngày hết hạn</label>
                    <div class="row">
                        <div class="col">
                            <asp:TextBox ID="txtExpMonth" runat="server" CssClass="form-control" placeholder="MM"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvExpMonth" runat="server" ControlToValidate="txtExpMonth" ErrorMessage="Vui lòng nhập tháng" ForeColor="Red" Display="Dynamic" ValidationGroup="CardPayment" />
                            <asp:RegularExpressionValidator ID="revExpMonth" runat="server" ControlToValidate="txtExpMonth" ErrorMessage="Tháng phải từ 01-12" ForeColor="Red" Display="Dynamic" ValidationExpression="^(0[1-9]|1[0-2])$" ValidationGroup="CardPayment" />
                        </div>
                        <div class="col">
                            <asp:TextBox ID="txtExpYear" runat="server" CssClass="form-control" placeholder="YYYY"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvExpYear" runat="server" ControlToValidate="txtExpYear" ErrorMessage="Vui lòng nhập năm" ForeColor="Red" Display="Dynamic" ValidationGroup="CardPayment" />
                            <asp:RegularExpressionValidator ID="revExpYear" runat="server" ControlToValidate="txtExpYear" ErrorMessage="Năm phải là 4 chữ số" ForeColor="Red" Display="Dynamic" ValidationExpression="^\d{4}$" ValidationGroup="CardPayment" />
                        </div>
                    </div>

                    <label>CVV</label>
                    <asp:TextBox ID="txtCvv" runat="server" CssClass="form-control" placeholder="Nhập mã CVV"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCvv" runat="server" ControlToValidate="txtCvv" ErrorMessage="Vui lòng nhập CVV" ForeColor="Red" Display="Dynamic" ValidationGroup="CardPayment" />
                    <asp:RegularExpressionValidator ID="revCvv" runat="server" ControlToValidate="txtCvv" ErrorMessage="CVV phải là 3 chữ số" ForeColor="Red" Display="Dynamic" ValidationExpression="^\d{3}$" ValidationGroup="CardPayment" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                    <asp:LinkButton ID="lbCard" runat="server" CssClass="btn btn-primary" OnClick="lbCard_Click" CausesValidation ="true" ValidationGroup="CardPayment">Xác nhận thanh toán</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Thanh toán VNPay -->
    <div class="modal fade" id="vnpayModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Thanh toán VNPay</h5>
                    <button type="button" class="close" data-dismiss="modal">×</button>
                </div>
                <div class="modal-body text-center">
                    <p>Bạn sẽ được chuyển đến VNPay để hoàn tất thanh toán.</p>
                    <asp:LinkButton ID="lbVnPaySubmit" runat="server" CssClass="btn btn-success" OnClick="lbVnPaySubmit_Click" CausesValidation="true" ValidationGroup="VNPayPayment">
                        <i class="fa fa-credit-card mr-2"></i> Thanh toán qua VNPay
                    </asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Thanh toán COD -->
    <div class="modal fade" id="codModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Thanh toán khi nhận hàng (COD)</h5>
                <button type="button" class="close" data-dismiss="modal">×</button>
            </div>
            <div class="modal-body">
                <label>Địa chỉ nhận hàng</label>
                <asp:TextBox ID="txtCODAddress" runat="server" CssClass="form-control" placeholder="Nhập địa chỉ"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCODAddress" runat="server" ControlToValidate="txtCODAddress" ErrorMessage="Vui lòng nhập địa chỉ nhận hàng" ForeColor="Red" Display="Dynamic" ValidationGroup="CODPayment" />
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                <asp:LinkButton ID="lbCod" runat="server" CssClass="btn btn-primary" OnClick="lbCod_Click" CausesValidation="true" ValidationGroup="CODPayment">Xác nhận thanh toán</asp:LinkButton>
            </div>
        </div>
        </div>
    </div>
</asp:Content>

