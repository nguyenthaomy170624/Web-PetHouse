<%@ Page Title="" Language="C#" MasterPageFile="~/NguoiDung/NguoiDung.Master" AutoEventWireup="true" CodeBehind="LienHe.aspx.cs" Inherits="Web_PetHouse.NguoiDung.LienHe" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <!-- Page Header Start -->
   <div class="d-flex flex-column align-items-center justify-content-center text-center bg-secondary" style="min-height: 300px">
    <!-- Tiêu đề chính -->
    <h1 class="font-weight-bold text-uppercase mb-3 title-effect">LIÊN HỆ</h1>
    
    <!-- Thanh điều hướng nhỏ -->
    <div class="d-inline-flex align-items-center breadcrumb-custom">
        <h2 class="m-0"><a href="TrangChu.aspx" class="text-decoration-none">TRANG CHỦ</a></h2>
        <span class="mx-2">|</span>
        <h2 class="m-0 text-muted">LIÊN HỆ</h2>
    </div>
</div>

    <!-- Page Header End -->


    <!-- Contact Start -->
    <div class="container-fluid pt-5">
    <div class="text-center mb-4">
        <h2 class="section-title px-5"><span class="px-2">LIÊN HỆ PET HOUSE</span></h2>
    </div>
    <div class="row px-xl-5">
        <div class="col-lg-7 mb-5">
            <div class="contact-form">
                <div id="success"></div>
                <form name="sentMessage" id="contactForm" novalidate="novalidate">
                    <div class="control-group">
                        <input type="text" class="form-control" id="name" placeholder="Họ và tên"
                            required="required" data-validation-required-message="Vui lòng nhập tên của bạn" />
                        <p class="help-block text-danger"></p>
                    </div>
                    <div class="control-group">
                        <input type="email" class="form-control" id="email" placeholder="Email"
                            required="required" data-validation-required-message="Vui lòng nhập email của bạn" />
                        <p class="help-block text-danger"></p>
                    </div>
                    <div class="control-group">
                        <input type="text" class="form-control" id="subject" placeholder="Chủ đề"
                            required="required" data-validation-required-message="Vui lòng nhập chủ đề" />
                        <p class="help-block text-danger"></p>
                    </div>
                    <div class="control-group">
                        <textarea class="form-control" rows="6" id="message" placeholder="Nội dung tin nhắn"
                            required="required"
                            data-validation-required-message="Vui lòng nhập nội dung tin nhắn"></textarea>
                        <p class="help-block text-danger"></p>
                    </div>
                    <div>
                        <button class="btn btn-primary py-2 px-4" type="submit" id="sendMessageButton">Gửi tin nhắn</button>
                    </div>
                </form>
            </div>
        </div>
  <div class="col-lg-5 mb-5">
    <!-- Cửa hàng miền Nam -->
    <div class="d-flex flex-column mb-3">
        <h5 class="font-weight-semi-bold mb-3" style="text-align: left">Cửa Hàng Miền Nam</h5>
        <p class="mb-2"><i class="fa fa-map-marker-alt text-primary mr-3"></i>1045 Kha Vạn Cân, Linh Trung, Thủ Đức, Tp.HCM</p>
    </div>

    <!-- Trại nhân giống miền Nam -->
    <div class="d-flex flex-column mb-3">
        <h5 class="font-weight-semi-bold mb-3" style="text-align: left">Trại Nhân Giống Miền Nam</h5>
        <p class="mb-2"><i class="fa fa-map-marker-alt text-primary mr-3"></i>Huỳnh Văn Lũy, Thủ Dầu Một, Bình Dương</p>
    </div>
    <!-- Cửa hàng miền Bắc -->
    <div class="d-flex flex-column mb-3">
        <h5 class="font-weight-semi-bold mb-3" style="text-align: left">Cửa Hàng Miền Bắc</h5>
        <p class="mb-2"><i class="fa fa-map-marker-alt text-primary mr-3"></i>293 Minh Khai, Hai Bà Trưng, Hà Nội</p>
    </div>

    <!-- Trại nhân giống miền Bắc -->
    <div class="d-flex flex-column">
        <h5 class="font-weight-semi-bold mb-3" style="text-align: left">Trại Nhân Giống Miền Bắc</h5>
        <p class="mb-2"><i class="fa fa-map-marker-alt text-primary mr-3"></i>Thôn Đức Hậu, Xã Đức Hòa, Sóc Sơn, Hà Nội</p>
    </div>
     <a href="tel:0379889868" target="_blank" 
       style="width:300px;background-color: red; color: white; text-decoration: none; padding: 10px 15px; 
              display: inline-block; border-radius: 5px; font-weight: bold; text-align: center;">
        <i class="fa fa-phone-alt" style="margin-right: 5px;"></i> 0379.889.868
    </a>

</div>

    </div>
</div>

    <!-- Contact End -->
</asp:Content>
