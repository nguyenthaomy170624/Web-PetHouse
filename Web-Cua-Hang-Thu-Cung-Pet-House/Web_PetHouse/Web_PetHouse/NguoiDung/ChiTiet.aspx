<%@ Page Title="" Language="C#" MasterPageFile="~/NguoiDung/NguoiDung.Master" AutoEventWireup="true" CodeBehind="ChiTiet.aspx.cs" Inherits="Web_PetHouse.NguoiDung.ChiTiet" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <!-- Page Header Start -->
   <div class="d-flex flex-column align-items-center justify-content-center text-center bg-secondary" style="min-height: 300px">
    <!-- Tiêu đề chính -->
    <h1 class="font-weight-bold text-uppercase mb-3 title-effect">CHI TIẾT</h1>
    
    <!-- Thanh điều hướng nhỏ -->
    <div class="d-inline-flex align-items-center breadcrumb-custom">
        <h2 class="m-0"><a href="TrangChu.aspx" class="text-decoration-none">TRANG CHỦ</a></h2>
        <span class="mx-2">|</span>
        <h2 class="m-0 text-muted">CHI TIẾT</h2>
    </div>
</div>

    <!-- Page Header End -->


    <!-- Shop Detail Start -->
    <div class="container-fluid py-5 ">
        <div class="row px-xl-5">
            <div class="col-lg-5 pb-5">
                <div id="product-carousel" class="carousel slide" data-ride="carousel">
                    <div class="carousel-inner border">
                        <div class="carousel-item active">
                            <img class="w-100 h-100" src="../NguoiDungTemplate/HinhAnh/anh-cho-corgi-9292929.jpg" alt="Image">
                        </div>
                    </div>
                    <a class="carousel-control-prev" href="#product-carousel" data-slide="prev">
                        <i class="fa fa-2x fa-angle-left text-dark"></i>
                    </a>
                    <a class="carousel-control-next" href="#product-carousel" data-slide="next">
                        <i class="fa fa-2x fa-angle-right text-dark"></i>
                    </a>
                </div>
            </div>

            <div class="col-lg-7 pb-5">
                <h3 class="font-weight-semi-bold">Chó Corgi trưởng thành vàng mã CG860</h3>
                <div class="d-flex mb-3">
                    <div class="text-primary mr-2">
                        <small class="fas fa-star"></small>
                        <small class="fas fa-star"></small>
                        <small class="fas fa-star"></small>
                        <small class="fas fa-star-half-alt"></small>
                        <small class="far fa-star"></small>
                    </div>
                    <small class="pt-1">(1 Đánh giá)</small>
                </div>
                    <div style="display: flex; align-items: center;">
                        <h3>6.000.000 đ</h3>
                        <h3 class="text-muted ml-2" style="margin-left: 10px;"><del>12.000.000 đ</del></h3>
                    </div>
                <p class="mb-4"><strong>Chó Corgi trưởng thành vàng mã CG860</strong> chân lùn cùng chiếc mông bự nổi bật làm cho cún cưng càng trở nên đáng yêu, cuốn hút trong mắt mọi người. Chó ăn uống, sức khỏe tốt đã sẵn sàng là thành viên mới trong gia đình bạn. </p>
                <div class="d-flex align-items-center mb-4 pt-2">
                    <div class="input-group quantity mr-3" style="width: 130px;">
                        <div class="input-group-btn">
                            <button class="btn btn-primary btn-minus" >
                            <i class="fa fa-minus"></i>
                            </button>
                        </div>
                        <input type="text" class="form-control bg-secondary text-center" value="1">
                        <div class="input-group-btn">
                            <button class="btn btn-primary btn-plus">
                                <i class="fa fa-plus"></i>
                            </button>
                        </div>
                    </div>
                    <button class="btn btn-primary px-3"><i class="fa fa-shopping-cart mr-1"></i> Thêm vào giỏ</button>
                </div>
                <div class="d-flex pt-2">
                    <p class="text-dark font-weight-medium mb-0 mr-2">Chia sẽ:</p>
                    <div class="d-inline-flex">
                        <a class="text-dark px-2" href="">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a class="text-dark px-2" href="">
                            <i class="fab fa-twitter"></i>
                        </a>
                        <a class="text-dark px-2" href="">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                        <a class="text-dark px-2" href="">
                            <i class="fab fa-pinterest"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="row px-xl-5">
            <div class="col">
                <div class="nav nav-tabs justify-content-center border-secondary mb-4 bg-secondary">
                    <a class="nav-item nav-link active" data-toggle="tab" href="#tab-pane-1">Mô tả</a>
                    <a class="nav-item nav-link" data-toggle="tab" href="#tab-pane-2">Thông tin</a>
                    <a class="nav-item nav-link" data-toggle="tab" href="#tab-pane-3">Đánh giá (1)</a>
                </div>
                <div class="tab-content">
                    <div class="tab-pane fade show active" id="tab-pane-1">
                        <h4 class="mb-3">Mô tả sản phẩm</h4>
                    <p><strong>Chó Corgi trưởng thành vàng mã CG860</strong> chân lùn cùng chiếc mông bự nổi bật làm cho cún cưng càng trở nên đáng yêu, cuốn hút trong mắt mọi người. Chó ăn uống, sức khỏe tốt đã sẵn sàng là thành viên mới trong gia đình bạn. </p>
                    <p><strong>Quyền lợi có được khi mua Chó Corgi trưởng thành vàng mã CG860 tại Pet House:</strong></p>
                    <p>1. Bảo hành <strong>thuần chủng trọn đời</strong>.</p>
                    <p>2. Bảo hành bệnh truyền nhiễm nguy hiểm ở chó như <strong>Care</strong> và <strong>Parvo</strong> trong <strong>7 ngày</strong> đầu về nhà mới. Ngoài ra, quý khách có thể mua thêm gói bảo hiểm sức khỏe <strong>1 năm</strong> nếu có nhu cầu.</p>
                    <p>3. <strong>Miễn phí vận chuyển</strong> toàn quốc (đối với tàu hỏa và xe khách) – hỗ trợ 50-80% chi phí vận chuyển máy bay.</p>
                    <p>4. <strong>Tặng kèm phụ kiện</strong> cho thú cưng gồm: Dây dắt cún, Vòng cổ, Bát ăn, Bình nước thông minh, Đồ chơi, Lược chải cho bé, Túi vận chuyển cho thú cưng.</p>
                    <p>5. <strong>Giấy tờ đi kèm:</strong> Sổ theo dõi sức khỏe (số tiêm phòng vacxin), hợp đồng mua bán, hướng dẫn chăm sóc, giấy chứng nhận nguồn gốc.</p>
                    <p>6. <strong>Giảm giá 10%</strong> cho các lần mua thú cưng tiếp theo.</p>
                    <p>7. <strong>Giảm 20%</strong> cho các dịch vụ Spa cắt tỉa trọn đời, <strong>giảm 10%</strong> dịch vụ trông giữ cún tại cửa hàng, <strong>giảm 5%</strong> mua phụ kiện trọn đời.</p>
                    <p>8. Hỗ trợ bảo hiểm sức khỏe <strong>1.000.000 VND</strong> (trong trường hợp bị ốm và trong thời gian bảo hành theo hợp đồng).</p>
                    <p>9. Tặng quà tặng trị giá <strong>500.000 VND</strong> khi giới thiệu bạn bè mua thú cưng tại Pet House (có thể quy đổi thành tiền mặt).</p>
                    <p>10. <strong>Nói không</strong> với chó tậu bệnh, chó thải loại.</p>
                    <p>11. Đồng hành cùng khách hàng chăm sóc cún <strong>trọn đời</strong>.</p>
                    <p>12. Hỗ trợ <strong>thu mua thú cưng</strong> khi sinh sản số lượng lớn với giá tốt nhất.</p>
                     </div>
                    <div class="tab-pane fade" id="tab-pane-2">
                        <h4 class="mb-3">Thông tin sản phẩm</h4>
                        <div class="row">
                            <div class="col-md-6">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item px-0">
                                        <strong>Tháng tuổi:</strong> 14 tháng tuổi &emsp;
                                    </li>
                                    <li class="list-group-item px-0">
                                         <strong>Màu:</strong> Vàng &emsp; 
                                    </li>
                                    <li class="list-group-item px-0">
                                         <strong>Tình trạng:</strong> Có sẵn &emsp; 

                                    </li>
                                    <li class="list-group-item px-0">
                                          <strong>Tẩy giun:</strong> 2 lần &emsp;
                                        </li>
                                    <li class="list-group-item px-0">
                                          <strong>Nguồn gốc:</strong> Thuần chủng, sinh sản tại Trại Pethouse
                                        </li>
                                  </ul> 
                            </div>
                            <div class="col-md-6">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item px-0">
                                      <strong>Bố:</strong> Buna 
                                    </li>
                                    <li class="list-group-item px-0">
                                        <strong>Sức khỏe:</strong> Nhanh nhẹn, ăn uống tốt
                                    </li>
                                   <li class="list-group-item px-0">
                                        <strong>Vận chuyển:</strong> Miễn phí 
                                   </li>
                                    <li class="list-group-item px-0">
                                           <strong>Tiêm phòng:</strong> 3 mũi vacxin 
                                        </li>
                                    <li class="list-group-item px-0">
                                           <strong>Đặc điểm:</strong> Lông ngắn
                                    </li>
                                  </ul> 
                                </div>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="tab-pane-3">
                        <div class="row">
                            <div class="col-md-6">
                                <h4 class="mb-4">1 Đánh giá về "Chó Corgi trưởng thành vàng mã CG860"</h4>
                                <div class="media mb-4">
                                    <img src="../NguoiDungTemplate/HinhAnh/guma.jpg" alt="Image" class="img-fluid mr-3 mt-1" style="width: 45px;">
                                    <div class="media-body">
                                        <h6>Gumayusi<small> - <i>Ngày 13 Tháng 3 2025</i></small></h6>
                                        <div class="text-primary mb-2">
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                            <i class="fas fa-star"></i>
                                        </div>
                                        <p>Gumayusi rất thích bạn nhỏ này, rất dễ thương lại ngoan ngoãn nữa chứ <3</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <h4 class="mb-4">Đánh giá sản phẩm</h4>
                                <small>Địa chỉ email của bạn sẽ không công khai. Hãy yên tâm đánh giá*</small>
                                <div class="d-flex my-3">
                                    <p class="mb-0 mr-2">Xếp hạng sản phẩm * :</p>
                                    <div class="text-primary">
                                        <i class="far fa-star"></i>
                                        <i class="far fa-star"></i>
                                        <i class="far fa-star"></i>
                                        <i class="far fa-star"></i>
                                        <i class="far fa-star"></i>
                                    </div>
                                </div>
                                <form>
                                    <div class="form-group">
                                        <label for="message">Đánh giá *</label>
                                        <textarea id="message" cols="30" rows="5" class="form-control"></textarea>
                                    </div>
                                    <div class="form-group">
                                        <label for="name">Họ và tên*</label>
                                        <input type="text" class="form-control" id="name">
                                    </div>
                                    <div class="form-group">
                                        <label for="email">Email *</label>
                                        <input type="email" class="form-control" id="email">
                                    </div>
                                    <div class="form-group mb-0">
                                        <input type="submit" value="Gửi đánh giá" class="btn btn-primary px-3">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Shop Detail End -->


    <!-- Products Start -->
    <div class="container-fluid py-5">
        <div class="text-center mb-4">
            <h2 class="section-title px-5"><span class="px-2">Có thể bạn thích</span></h2>
        </div>
        <div class="row px-xl-5">
            <div class="col">
                <div class="owl-carousel related-carousel">
                    <div class="card product-item border-0">
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
                    <div class="card product-item border-0">
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
                    <div class="card product-item border-0">
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
                    <div class="card product-item border-0">
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
                    <div class="card product-item border-0">
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
            </div>
        </div>
    </div>
    <!-- Products End -->


</asp:Content>
