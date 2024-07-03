<%-- 
    Document   : home
    Created on : May 13, 2024, 9:04:58 PM
    Author     : ADMIN
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import=" java.util.ArrayList, model.User, model.Mentor, model.Mentee , DAO.UserDAO" %>
<%@ page import="java.util.List" %>
<%@page import="model.Skill, java.util.ArrayList, model.User, model.Mentor, model.Mentee" %>
<%@page import="model.Skill, java.util.ArrayList, model.User, model.Mentor, model.Mentee, model.Rate, model.CV, java.text.SimpleDateFormat, DAO.FollowDAO,DAO.MentorDAO, model.Slot, java.util.Calendar, DAO.ScheduleDAO" %>

<!DOCTYPE html>

<html lang="en">

<head>
    <style>
        .img-fixed-size {
    width: 100%; /* Thiết lập kích thước chiều rộng của ảnh */
    height: auto; /* Đảm bảo tỷ lệ khung hình được giữ nguyên */
}
</style>
    <meta charset="utf-8">
    <title>Happy Programming</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

        <link href="https://img.lovepik.com/free-png/20210926/lovepik-cartoon-book-png-image_401449837_wh1200.png" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- // Libraries Stylesheet -->
    <link href="lib/animate/animate.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
</head>

<body>
    <!-- Spinner Start -->
    <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
            <span class="sr-only">Loading...</span>
        </div>
    </div>
    <!-- Spinner End -->
<%
            Mentor currMentor = (Mentor)request.getAttribute("CurrMentor");
            User um = (User)request.getAttribute("um");
            CV currCV = (CV)request.getAttribute("CurrCV");
            
    %>

   <%@include file="header.jsp" %>

  <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<div class="container">
<div class="row flex-lg-nowrap">
  <div class="col-12 col-lg-auto mb-3" style="width: 200px;">
    <div class="card p-3">
      <div class="e-navlist e-navlist--active-bg">
        <ul class="nav">
          <li class="nav-item"><a class="nav-link px-2 active" href="#"><i class="fa fa-fw fa-bar-chart mr-1"></i><span>Overview</span></a></li>
          <li class="nav-item"><a class="nav-link px-2" href="https://www.bootdey.com/snippets/view/bs4-crud-users" target="__blank"><i class="fa fa-fw fa-th mr-1"></i><span>CRUD</span></a></li>
          <li class="nav-item"><a class="nav-link px-2" href="https://www.bootdey.com/snippets/view/bs4-edit-profile-page" target="__blank"><i class="fa fa-fw fa-cog mr-1"></i><span>Settings</span></a></li>
        </ul>
      </div>
    </div>
  </div>

  <div class="col">
    <div class="row">
      <div class="col mb-3">
        <div class="card">
          <div class="card-body">
            <div class="e-profile">
              <div class="row">
                <div class="col-12 col-sm-auto mb-3">
                  <div class="mx-auto" style="width: 140px;">
                    <div class="d-flex justify-content-center align-items-center rounded" style=" background-color: rgb(233, 236, 239);">
                      <span style="color: rgb(166, 168, 170); font: bold 8pt Arial"><img  src="<%=um.getAvatar()%>" alt="alt" width="145.5px" height="164px"/></span>
                    </div>                   
                  </div>                    
                </div>                    
                <div class="col d-flex flex-column flex-sm-row justify-content-between mb-3">
                  <div class="text-center text-sm-left mb-2 mb-sm-0">
                    <h4 class="pt-sm-2 pb-1 text-nowrap"><%=currMentor.getFullname()%></h4>
                    <p class="mb-0"></p>                   
                    <hr>
                    
                    <div class="mt-8">
<!--                      <button class="btn btn-primary" type="button">
                        <i class="fa fa-fw fa-camera"></i>
                        <span>Change Photo</span>
                      </button>-->
<div class="nav-player-profile row">
                                <div class="col-md-4 col-xs-8">
                                    <div class="item-nav-name">
                                        <span>Đã được thuê</span>
                                    </div>
                                    <div class="item-nav-value">0&nbsp; <span>giờ</span>
                                    </div>
                                </div>
                                <div class="col-md-4 col-xs-8">
                                    <div class="item-nav-name">
                                        <span>Tỷ lệ hoàn thành</span>
                                    </div>
                                    <div class="item-nav-value">100&nbsp;%</div>
                                </div>
                                <div class="col-md-4 col-xs-8">
                                    <div class="item-nav-name">
                                        <span>Followers</span>
                                    </div>
                                    <div class="item-nav-value">
                                        <%=currMentor.getFollow()%> Follower
                                    </div>
                                </div>
                            </div>
                    </div>
                                    <style> 
                                    .game-category {
    display: flex;
    flex-direction: row;
    justify-content: start;
    align-items: center;
    flex-wrap: wrap;
}

.choose-game {
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 1px;
    padding: 2px;
    border: 1px solid #000; /* Đây là màu viền, bạn có thể thay đổi theo ý muốn */
    box-sizing: border-box;
    background-repeat: no-repeat;
    background-position: center center;
}

.overlay {
    text-align: center;
}

                                    </style>                                
                                
                  </div>
                   
                </div>
                                   
              </div>
                <div class="game-category row">
                                <%for(int i = 0; i < currCV.getSkills().size(); i++) {%>
                                <div class="choose-game" style="background: center center no-repeat;">
                                    <p class="overlay"><%=currCV.getSkills().get(i).getName()%> </p>
                                </div>
                                <%}%>
                            </div>                        
              <ul class="nav nav-tabs">
                <li class="nav-item"><a href="" class="active nav-link">Introduce</a></li>
              </ul>
              <div class="tab-content pt-3">
                <div class="tab-pane active">
                  <form class="form" novalidate="">
                    <div class="row">
                      <div class="col">
                        <div class="row">
                          <div class="col">
                            <div class="form-group">
                              <label>Full Name</label>
                            
                              <input class="form-control" type="text" name="name" placeholder="John Smith" value="<%=currMentor.getFullname()%>" readonly>

                            </div>
                          </div>
                          <div class="col">
                            <div class="form-group">
                              <label>Phone</label>
                              <input class="form-control" type="text" name="username" placeholder="johnny.s" value="<%=um.getPhone()%>" readonly>
                            </div>
                          </div>
                        </div>
                        <div class="row">
                          <div class="col">
                            <div class="form-group">
                              <label>Email</label>
                              <input class="form-control" type="text" placeholder="<%=um.getEmail()%>" readonly>
                            </div>
                          </div>
                        </div>
                        <div class="row">
                          <div class="col mb-3">
                            <div class="form-group">
                              <label>Mô tả</label>
                              <textarea class="form-control" rows="" placeholder="<%=currMentor.getDescription()%>" readonly></textarea>
                            </div>
                            <div class="form-group">
                              <label>Thành tựu</label>
                              <textarea class="form-control" rows="" placeholder="<%=currMentor.getAchivement()%>" readonly></textarea>
                            </div>
                            <div class="form-group">
                              <label>Profession Introduction</label>
                              <textarea class="form-control" rows="" placeholder="<%=currCV.getProfessionIntro()%>" readonly></textarea>
                            </div>
                            <div class="form-group">
                              <label>Description</label>
                              <textarea class="form-control" rows="" placeholder="<%=currCV.getDescription()%>" readonly></textarea>
                            </div>
                            <div class="form-group">
                              <label>Giá thuê mỗi slots</label>
                              <textarea class="form-control" rows="" placeholder="<%=currCV.getMoneyofslot()%>" readonly></textarea>
                            </div>
                            
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-12 col-sm-12 mb-6">
                        <div class="mb-2"><b>Đánh giá</b></div>
                        <style>
                            .full-size {
    display: flex;
    border: 1px solid #ddd;
    padding: 10px;
    margin-bottom: 10px;
}

.review-image-small {
    flex: 1;
}

.avt-rank {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    overflow: hidden;
}

.avt-img {
    width: 100%;
    height: auto;
}

.wrapper-content-rating {
    flex: 4;
    margin-left: 10px;
}

.review-content {
    display: flex;
    justify-content: space-between;
}

.name-player-review {
    font-weight: bold;
    color: #ff9900;
}

.time-player-review {
    font-size: 0.8em;
    color: #888;
}

.review-rating {
    display: flex;
    align-items: center;
}

.rateting-style {
    margin-right: 5px;
}

.content-player-review {
    margin-top: 10px;
}

                            
                        </style>
                        <% ArrayList<Rate> rates = (ArrayList)request.getAttribute("Rates");
                                    int p = (int) Math.ceil((double)rates.size() / 5);
                                    for(int i = 0; i < rates.size(); i++) {%>
                                <div id='<%=i+1%>' class="col-md-12 <%=i > 5 ? "hidden" : ""%>">
                                    <div class="full-size">
                                        <div class="review-image-small">
                                            <div class="avt-rank avt-md">
                                                <img src="<%=rates.get(i).getSendAvatar() != null ? rates.get(i).getSendAvatar() : "https://files.playerduo.net/production/images/avatar31.png"%>" class="avt-1-15 avt-img" alt="PD">
                                            </div>
                                        </div>
                                        <div class="wrapper-content-rating">
                                            <div class="review-content">
                                                <a target="_blank">
                                                    <p class="name-player-review color-vip-1"><%=rates.get(i).getSendName()%></p>
                                                </a>
                                                <p class="time-player-review">
                                                    
                                                    <span><%=new SimpleDateFormat("HH:mm:ss dd/MM/yyyy").format(rates.get(i).getRateTime())%></span>
                                                </p>
                                            </div>
                                            <div class="review-rating">
                                                <div class="rateting-style">
                                                    <%for(int j = 0; j < rates.get(i).getNoStar(); j++) {%>
                                                    <i class="fas fa-star"></i>
                                                    <%}%>
                                                    <%for(int j = rates.get(i).getNoStar()+1; j <= 5; j++) {%>
                                                    <i class="far fa-star"></i>
                                                    <%}%>
                                                    &nbsp;
                                                </div>
                                            </div>
                                            <p class="content-player-review"><%=rates.get(i).getContent()%> </p>
                                        </div>
                                    </div>
                                </div>
                                <%}%>
<!--                        <div class="row">
                          <div class="col">
                            <div class="form-group">
                              <label>Current Password</label>
                              <input class="form-control" type="password" placeholder="••••••">
                            </div>
                          </div>
                        </div>
                        <div class="row">
                          <div class="col">
                            <div class="form-group">
                              <label>New Password</label>
                              <input class="form-control" type="password" placeholder="••••••">
                            </div>
                          </div>
                        </div>
                        <div class="row">
                          <div class="col">
                            <div class="form-group">
                              <label>Confirm <span class="d-none d-xl-inline">Password</span></label>
                              <input class="form-control" type="password" placeholder="••••••"></div>
                          </div>
                        </div>-->
                      </div>
                      <div class="col-12 col-sm-5 offset-sm-1 mb-3">
                        
                      </div>
                    </div>
                    <div class="row">
                      <div class="col d-flex justify-content-end">
                        
                      </div>
                    </div>
                  </form>

                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="col-12 col-md-3 mb-3">
<!--        <div class="card mb-3">
          <div class="card-body">
            <div class="px-xl-3">
              <button class="btn btn-block btn-secondary">
                <i class="fa fa-sign-out"></i>
                <span>Tạo Request</span>
              </button>
            </div>
          </div>
        </div>
        <div class="card mb-3">
          <div class="card-body">
            <div class="px-xl-3">
              <button class="btn btn-block btn-secondary">
                <i class="fa fa-sign-out"></i>
                <span>Chat</span>
              </button>
            </div>
          </div>
        </div>-->

<style>
    .card1 {
    width: 200px;
    border: 1px solid #ddd;
    padding: 10px;
    box-sizing: border-box;
}

.price-tag1 {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 10px;
}

.rating1 {
    display: flex;
    justify-content: space-between;
    margin-bottom: 10px;
}

.stars1 {
    color: #ff9900;
}

.buttons1 {
    display: flex;
    justify-content: space-between;
}

.request-button1 {
    background-color: #ff0000;
    color: #fff;
    border: none;
    padding: 10px;
    cursor: pointer;
}

.chat-button1 {
    background-color: #fff;
    color: #000;
    border: 1px solid #000;
    padding: 10px;
    cursor: pointer;
}

</style>

        <div class="card">
    <div class="price-tag1">50,000 ₫/slot</div>
    <div class="rating1">
        <span class="stars1">****</span>
        <span class="review-count1"></span>
    </div>
   <div class="buttons1">
    <button class="request-button1" onclick="window.location.href='#'">TAO REQUEST</button>
    <button class="chat-button1" onclick="window.location.href='chat?id=<%=currMentor.getId()%>'">CHAT</button>
</div>

</div>

      </div>
    </div>

  </div>
</div>
</div>
    
   <%@include file="footer.jsp" %>
    <!-- Footer End -->


    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>


    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
</body>

</html>