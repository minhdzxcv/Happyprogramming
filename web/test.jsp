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
<style>
       body{margin-top:20px;
background: #f5f5f5;
}
.theme-bg-white {
    background-color: #fff !important;
}
.ui-w-100 {
    width: 100px !important;
    height: auto;
}
.ui-w-40 {
    width: 40px !important;
    height: auto;
}
.row-bordered>.col::before, .row-bordered>[class^="col-"]::before, .row-bordered>[class*=" col-"]::before, .row-bordered>[class^="col "]::before, .row-bordered>[class*=" col "]::before, .row-bordered>[class$=" col"]::before, .row-bordered>[class="col"]::before {
    content: "";
    position: absolute;
    right: 0;
    bottom: -1px;
    left: 0;
    display: block;
    height: 0;
    border-top: 1px solid rgba(24,28,33,0.06);
}
.row-bordered>.col::after, .row-bordered>[class^="col-"]::after, .row-bordered>[class*=" col-"]::after, .row-bordered>[class^="col "]::after, .row-bordered>[class*=" col "]::after, .row-bordered>[class$=" col"]::after, .row-bordered>[class="col"]::after {
    content: "";
    position: absolute;
    top: 0;
    bottom: 0;
    left: -1px;
    display: block;
    width: 0;
    border-left: 1px solid rgba(24,28,33,0.06);
}

.ui-bg-cover {
    background-color: rgba(0,0,0,0);
    background-position: center center;
    background-size: cover;
}

.ui-square {
    padding-top: 100% !important;
}
.ui-square, .ui-rect, .ui-rect-30, .ui-rect-60, .ui-rect-67, .ui-rect-75 {
    position: relative !important;
    display: block !important;
    padding-top: 100% !important;
    width: 100% !important;
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


   <%@include file="header.jsp" %>

   
 <%
            Mentor currMentor = (Mentor)request.getAttribute("CurrMentor");
            CV currCV = (CV)request.getAttribute("CurrCV");
            
    %>
    <div class="layout-content">

          <!-- Content -->
          <div class="container flex-grow-1 container-p-y">

            <!-- Header -->
            <div class="container-m-nx container-m-ny theme-bg-white mb-4">
              <div class="media col-md-10 col-lg-8 col-xl-7 py-5 mx-auto">
                <img src="<%=u.getAvatar() == null ? "https://files.playerduo.net/production/images/avatar31.png" : u.getAvatar() %>" alt="" class="d-block ui-w-100 rounded-circle">
                <div class="media-body ml-5">
                  <h4 class="font-weight-bold mb-4"><%=currMentor.getFullname()%></h4>
             

                  <a href="javascript:void(0)" class="d-inline-block text-body">
                    
                    <span class="text-muted">followers: <%=FollowDAO.following(currMentor.getId())%></span>
                  </a>
                  <a href="javascript:void(0)" class="d-inline-block text-body ml-3">
                    
                  </a>
                </div>
              </div>
              <hr class="m-0">
            </div>
            <!-- Header -->

            <div class="row">
              <div class="col">

                <!-- Info -->
                <div class="card mb-4">
                  <div class="card-body">

                    <div class="row mb-2">
                      <div class="col-md-3 text-muted">Profession Introduction:</div>
                      <div class="col-md-9">
                       <%=currCV.getProfessionIntro() == null ? "" : currCV.getProfessionIntro()%>
                      </div>
                    </div>

                    <div class="row mb-2">
                      <div class="col-md-3 text-muted">Description:</div>
                      <div class="col-md-9">
                        <%=currCV.getDescription() == null ? "" : currCV.getDescription()%>
                      </div>
                    </div>

                    

                    

                   

                  </div>
                  
                </div>
                <!-- / Info -->

                <!-- Posts -->

                <div class="card mb-4">
                  <div class="card-body">
                   
                    <div class="ui-bordered">
                      
                      <div class="p-4">
                        <h5>Đánh giá</h5>
                         <% ArrayList<Rate> rates = (ArrayList)request.getAttribute("Rates");
                                    int p = (int) Math.ceil((double)rates.size() / 5);
                                    for(int i = 0; i < rates.size(); i++) {%>
                                <div id='<%=i+1%>' class="col-md-12 <%=i > 5 ? "hidden" : ""%>">
                                    <div class="full-size">
                                        <div class="review-image-small">
                                            <div class="avt-rank avt-md">
                                                <img src="<%=rates.get(i).getSendAvatar() == null ? "https://files.playerduo.net/production/images/avatar31.png":rates.get(i).getSendAvatar()%>" class="avt-1-15 avt-img" alt="PD">
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

                      </div>
                    </div>
                  </div>
                 
                </div>

              

               

                <!-- / Posts -->

              </div>
              <div class="col-xl-4">

                <!-- Side info -->
                <div class="card mb-4">
                  <div class="card-body">
                    <a href="javascript:void(0)" class="btn btn-primary rounded-pill">+&nbsp; Follow</a>
                    &nbsp;
                    <a href="javascript:void(0)" class="btn icon-btn btn-default md-btn-flat rounded-pill">
                      <span class="ion ion-md-mail"></span>
                    </a>
                  </div>
                  <hr class="border-light m-0">
                  
                  <hr class="border-light m-0">
                 
                </div>
                <!-- / Side info -->

                

              </div>
            </div>

          </div>
          <!-- / Content -->

          <!-- Layout footer -->
          
          <!-- / Layout footer -->

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