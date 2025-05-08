<%@ Page Title="" Language="C#" MasterPageFile="~/NguoiDung/NguoiDung.Master" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="Web_PetHouse.NguoiDung.TrangChu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <!-- Featured Start -->
  <div class="container-fluid pt-5">
    <div class="row px-xl-5 pb-3 justify-content-center">
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1 d-flex justify-content-center">
            <div class="d-flex align-items-center border mb-4 text-center" style="padding: 30px;">
                <h1 class="fa fa-check text-primary m-0 mr-3"></h1>
                <h5 class="font-weight-semi-bold m-0" style="font-family: 'Times New Roman', Times, serif">Chất lượng sản phẩm</h5>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1 d-flex justify-content-center">
            <div class="d-flex align-items-center border mb-4 text-center" style="padding: 30px;">
                <h1 class="fa fa-shipping-fast text-primary m-0 mr-2"></h1>
                <h5 class="font-weight-semi-bold m-0" style="font-family: 'Times New Roman', Times, serif">Miễn phí giao hàng</h5>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1 d-flex justify-content-center">
            <div class="d-flex align-items-center border mb-4 text-center" style="padding: 30px;">
                <h1 class="fas fa-exchange-alt text-primary m-0 mr-3"></h1>
                <h5 class="font-weight-semi-bold m-0" style="font-family: 'Times New Roman', Times, serif">14 ngày hoàn trả</h5>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 pb-1 d-flex justify-content-center">
            <div class="d-flex align-items-center border mb-4 text-center" style="padding: 30px;">
                <h1 class="fa fa-phone-volume text-primary m-0 mr-3"></h1>
                <h5 class="font-weight-semi-bold m-0" style="font-family: 'Times New Roman', Times, serif">Hỗ trợ 24/7</h5>
            </div>
        </div>
    </div>
</div>

    <!-- Featured End -->


    <!-- Categories Start -->
    <div class="container-fluid pt-5">
        <div class="row px-xl-5 pb-3">
            <div class="col-lg-4 col-md-6 pb-1">
                <div class="cat-item d-flex flex-column border mb-4" style="padding: 30px;">
                    <p class="text-left">15 Sản phẩm</p>
                    <a href="" class="cat-img position-relative overflow-hidden mb-3">
                        <img class="img-fluid" src="../NguoiDungTemplate/HinhAnh/anh-cho-chow-chow-100239-1247x1496.jpg" alt="" width="300" height="300">
                    </a>
                    <h5 class="font-weight-semi-bold m-0">Chó Cảnh</h5>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 pb-1">
                <div class="cat-item d-flex flex-column border mb-4" style="padding: 30px;">
                    <p class="text-left">13 Sản Phẩm</p>
                    <a href="" class="cat-img position-relative overflow-hidden mb-3">
                        <img class="img-fluid" src="../NguoiDungTemplate/HinhAnh/anh-meo-Maine-Coon-4-1247x1496.jpg" alt="" width="300" height="300">
                    </a>
                    <h5 class="font-weight-semi-bold m-0">Mèo Cảnh</h5>
                </div>
            </div>
            <div class="col-lg-4 col-md-6 pb-1">
                <div class="cat-item d-flex flex-column border mb-4" style="padding: 30px;">
                    <p class="text-left">6 Sản phẩm</p>
                    <a href="" class="cat-img position-relative overflow-hidden mb-3">
                        <img class="img-fluid" src="../NguoiDungTemplate/HinhAnh/phu-kien-pet-–-Da-sua-280x280.png" alt=""width="300" height="300">
                    </a>
                    <h5 class="font-weight-semi-bold m-0">Phụ Kiện</h5>
                </div>
            </div>
        </div>
    </div>
    <!-- Categories End -->


    <!-- Products Start -->
    <div class="container-fluid pt-5">
        <div class="text-center mb-4">
            <h2 class="section-title px-5"><span class="px-2""style="font-family: 'times New Roman', Times, serif">Sản phẩm bán nhiều</span></h2>
        </div>
        <div class="row px-xl-5 pb-3">
            <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                <div class="card product-item border-0 mb-4">
                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                        <img class="img-fluid w-100" src="../NguoiDungTemplate/HinhAnh/anh-cho-Hmong-coc.jpg" alt="">
                    </div>
                    <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                        <h6 class="text-truncate mb-3">Chó H’mông cộc đen mã HC001</h6>
                        <div class="d-flex justify-content-center">
                            <h6>8.000.000 đ</h6><h6 class="text-muted ml-2"><del>$8.500.000 đ</del></h6>
                        </div>
                    </div>
                    <div class="card-footer d-flex justify-content-between bg-light border">
                        <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>Xem chi tiết</a>
                        <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Thêm vào giỏ hàng</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                <div class="card product-item border-0 mb-4">
                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                        <img class="img-fluid w-100" src="../NguoiDungTemplate/HinhAnh/anh-cho-Corgi.jpg" alt="">
                    </div>
                    <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                        <h6 class="text-truncate mb-3">Chó Corgi vàng trắng mã CG1118</h6>
                        <div class="d-flex justify-content-center">
                            <h6>10.200.000 đ</h6><h6 class="text-muted ml-2"><del>12.000.000 đ</del></h6>
                        </div>
                    </div>
                    <div class="card-footer d-flex justify-content-between bg-light border">
                        <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>Xem chi tiết</a>
                        <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Thêm vào giỏ hàng</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                <div class="card product-item border-0 mb-4">
                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                        <img class="img-fluid w-100" src="../NguoiDungTemplate/HinhAnh/anh-cho-phoc-soc-2002-1247x1496.jpg" alt="">
                    </div>
                    <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                        <h6 class="text-truncate mb-3">Chó Phốc Sóc Mini trắng mã PS143</h6>
                        <div class="d-flex justify-content-center">
                            <h6>8.600.000 đ</h6><h6 class="text-muted ml-2"><del>9.000.000 đ</del></h6>
                        </div>
                    </div>
                    <div class="card-footer d-flex justify-content-between bg-light border">
                        <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>Xem chi tiết</a>
                        <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Thêm vào giỏ hàng</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                <div class="card product-item border-0 mb-4">
                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                        <img class="img-fluid w-100" src="../NguoiDungTemplate/HinhAnh/anh-cho-Phu-Quoc.jpg" alt="">
                    </div>
                    <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                        <h6 class="text-truncate mb-3">Chó Phú Quốc vện mã PQ797</h6>
                        <div class="d-flex justify-content-center">
                            <h6>10.500.000 đ</h6><h6 class="text-muted ml-2"><del>12.000.000 đ</del></h6>
                        </div>
                    </div>
                    <div class="card-footer d-flex justify-content-between bg-light border">
                        <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>Xem chi tiết</a>
                        <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Thêm vào giỏ hàng</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                <div class="card product-item border-0 mb-4">
                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                        <img class="img-fluid w-100" src="../NguoiDungTemplate/HinhAnh/anh-meo-Anh-long-ngan-4.jpg" alt="">
                    </div>
                    <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                        <h6 class="text-truncate mb-3">Mèo Anh lông ngắn màu Bicolor mã ALN1760</h6>
                        <div class="d-flex justify-content-center">
                            <h6>5.900.000 đ</h6><h6 class="text-muted ml-2"><del>7.000.000 đ</del></h6>
                        </div>
                    </div>
                    <div class="card-footer d-flex justify-content-between bg-light border">
                        <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>Xem chi tiết</a>
                        <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Thêm vào giỏ hàng</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                <div class="card product-item border-0 mb-4">
                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                        <img class="img-fluid w-100" src="../NguoiDungTemplate/HinhAnh/anh-cho-poodle-8959595900989-1247x1496.jpg" alt="">
                    </div>
                    <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                        <h6 class="text-truncate mb-3">Chó Poodle Tiny vàng mơ mã PD2979</h6>
                        <div class="d-flex justify-content-center">
                            <h6>6.500.000 đ</h6><h6 class="text-muted ml-2"><del>7.000.000 đ</del></h6>
                        </div>
                    </div>
                    <div class="card-footer d-flex justify-content-between bg-light border">
                        <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>Xem chi tiết</a>
                        <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Thêm vào giỏ</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                <div class="card product-item border-0 mb-4">
                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                        <img class="img-fluid w-100" src="../NguoiDungTemplate/HinhAnh/anh-cho-phoc-soc-2045-1247x1496.jpg" alt="">
                    </div>
                    <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                        <h6 class="text-truncate mb-3">Chó Phốc Sóc Teacup trắng mã PS361</h6>
                        <div class="d-flex justify-content-center">
                            <h6>15.000.000 đ</h6><h6 class="text-muted ml-2"><del>18.000.000 đ</del></h6>
                        </div>
                    </div>
                    <div class="card-footer d-flex justify-content-between bg-light border">
                        <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>Xem chi tiết</a>
                        <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Thêm vào giỏ hàng</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-12 pb-1">
                <div class="card product-item border-0 mb-4">
                    <div class="card-header product-img position-relative overflow-hidden bg-transparent border p-0">
                        <img class="img-fluid w-100" src="../NguoiDungTemplate/HinhAnh/meo-anh-long-ngan-mau-xam-xanh-ma-ALN2073-1247x1496.jpg" alt="">
                    </div>
                    <div class="card-body border-left border-right text-center p-0 pt-4 pb-3">
                        <h6 class="text-truncate mb-3">Mèo Anh lông ngắn màu xám xanh mã ALN2973</h6>
                        <div class="d-flex justify-content-center">
                            <h6>3.700.000 đ</h6><h6 class="text-muted ml-2"><del>4.000.000 đ</del></h6>
                        </div>
                    </div>
                    <div class="card-footer d-flex justify-content-between bg-light border">
                        <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-eye text-primary mr-1"></i>Xem chi tiết</a>
                        <a href="" class="btn btn-sm text-dark p-0"><i class="fas fa-shopping-cart text-primary mr-1"></i>Thêm vào giỏ hàng</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Products End -->
    <!-- Vendor Start -->
    <div class="container section-title-container" style="display: flex; justify-content: center; align-items: center; text-align: center;">
    <h3 class="section-title section-title-bold-center">
        <b></b>
        <span class="section-title-main" style="font-size:91%;color:rgb(0, 20, 255); font-family: 'Times New Roman', Times, serif;">
            <i class="icon-star"></i> KHÁCH HÀNG CHECKIN TẠI PET HOUSE
        </span>
        <b></b>
    </h3>
</div>
    <div class="container-fluid py-5">
        <div class="row px-xl-5">
            <div class="col">
                <div class="owl-carousel vendor-carousel">
                    <div class="vendor-item border p-4">
                        <img src="../NguoiDungTemplate/HinhAnh/khach-hang-checkin-tai-Pet-House-2-280x280.jpg" alt="">
                    </div>
                    <div class="vendor-item border p-4">
                        <img src="../NguoiDungTemplate/HinhAnh/khach-hang-checkin-tai-Pet-House-3.jpg" alt="">
                    </div>
                    <div class="vendor-item border p-4">
                        <img src="../NguoiDungTemplate/HinhAnh/khach-hang-checkin-tai-Pet-House-4.jpg" alt="">
                    </div>
                    <div class="vendor-item border p-4">
                        <img src="../NguoiDungTemplate/HinhAnh/khach-hang-checkin-tai-Pet-House-5.jpg" alt="">
                    </div>
                    <div class="vendor-item border p-4">
                        <img src="../NguoiDungTemplate/HinhAnh/khach-hang-checkin-tai-Pet-House-6.jpg" alt="">
                    </div>
                    <div class="vendor-item border p-4">
                        <img src="../NguoiDungTemplate/HinhAnh/khach-hang-checkin-tai-Pet-House-7.jpg" alt="">
                    </div>
                    <div class="vendor-item border p-4">
                        <img src="../NguoiDungTemplate/HinhAnh/Khach-hang-checkin-tai-Pet-House-Sai-Gon-3.jpg" alt="">
                    </div>
                    <div class="vendor-item border p-4">
                        <img src="../NguoiDungTemplate/HinhAnh/Khach-hang-checkin-tai-Pet-House-Sai-Gon-8.jpg" alt="">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Vendor End -->
</asp:Content>
