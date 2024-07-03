<%-- 
    Document   : ViewSkill
    Created on : May 15, 2024, 9:46:55 AM
    Author     : ADMIN
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Skill, java.util.ArrayList, model.User, model.Mentor, model.Mentee , DAO.UserDAO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">



    <head>
      <style>
        .img-fixed-size {
            width: 100%;
            height: auto;
        }

        .input-group .form-control {
            border-top-left-radius: 25px;
            border-bottom-left-radius: 25px;
        }

        .input-group .btn {
            border-top-right-radius: 25px;
            border-bottom-right-radius: 25px;
            background-color: #007bff;
            color: white;
        }

        .input-group .btn:hover {
            background-color: #0056b3;
        }
    </style>


     

        <meta charset="utf-8">
        <title>Happy Programming</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Favicon -->
        <link href="https://img.lovepik.com/free-png/20210926/lovepik-cartoon-book-png-image_401449837_wh1200.png" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
        <link href="css/15.7bac9b00.chunk.css" rel="stylesheet">

    </head>

    <body> 

        <%
         
            ArrayList<Skill> arr = (ArrayList<Skill>)request.getAttribute("skills");
            
        %>
<%@include file="header.jsp" %>
        <!-- Carousel Start -->

        <!-- Carousel Start -->
        <div class="container-fluid p-0 mb-5">
            
            <div class="owl-carousel header-carousel position-relative">
                <div class="owl-carousel-item position-relative">
                    <img class="img-fluid" src="img/carousel-1.jpg" alt="">
                    <div class="position-absolute top-0 start-0 w-100 h-100 d-flex align-items-center" style="background: rgba(24, 29, 56, .7);">
                        <div class="container">
                            <div class="row justify-content-start">
                                <div class="col-sm-10 col-lg-8">
                                    <h5 class="text-primary text-uppercase mb-3 animated slideInDown">Best Online Education</h5>
                                    <h1 class="display-3 text-white animated slideInDown">The Best Online Learning Platform</h1>
                                    <p class="fs-5 text-white mb-4 pb-2">Happy Programming is the world's leading educational website</p>
                                    <a href="" class="btn btn-primary py-md-3 px-md-5 me-3 animated slideInLeft">Read More</a>
                                    <a href="" class="btn btn-light py-md-3 px-md-5 animated slideInRight">Join Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="owl-carousel-item position-relative">
                    <img class="img-fluid" src="img/carousel-2.jpg" alt="">
                    <div class="position-absolute top-0 start-0 w-100 h-100 d-flex align-items-center" style="background: rgba(24, 29, 56, .7);">
                        <div class="container">
                            <div class="row justify-content-start">
                                <div class="col-sm-10 col-lg-8">
                                    <h5 class="text-primary text-uppercase mb-3 animated slideInDown">Professional team</h5>
                                    <h1 class="display-3 text-white animated slideInDown">The world's top selected mentor</h1>
                                    <p class="fs-5 text-white mb-4 pb-2">Happy programming is a website taught by highly qualified mentors</p>
                                    <a href="" class="btn btn-primary py-md-3 px-md-5 me-3 animated slideInLeft">Read More</a>
                                    <a href="" class="btn btn-light py-md-3 px-md-5 animated slideInRight">Join Now</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <main id="main">
            <div class="container">
                <!-- ======= About Section ======= -->
             
               <form method="GET" action="viewskill">
                <div class="input-group mb-3">
                    <input type="text" class="form-control" name="search" placeholder="Search skill by name" aria-label="Search skill by name" aria-describedby="button-search">
                    <button class="btn btn-primary" type="submit" id="button-search">Search</button>
                </div>
            </form>

                    <div class="list-player">
                        <div class="box vip-player">
                            <header class="title-header vip">
                                <h5  class="title-header-left"></h5>
                            </header>
                            <div class="card-player row">
                                <%  if(arr != null) {
                                    for(int i = 0; i < (arr.size() > 14 ? 14 : arr.size()); i++) {%>
                                <div class="col-md-3">
                                    <div class="player-information-card-wrap">
                                        <div  class="player-avatar">
                                            <a target="_blank" href="skill?id=<%=arr.get(i).getId()%>">
                                                <img  style="height: 280px;
                                                width: 300px  " src="<%=arr.get(i).getAvatar() != null ? arr.get(i).getAvatar() : "images/no-image.jpg"%>" class="" alt="PD" id="avt-img-reponsiver">
                                                </a>
                                            </div>
                                            <a target="_blank" class="player-information" href="skill?id=<%=arr.get(i).getId()%>">
                                                <h3 class="player-name">
                                                    <span style="font-weight: 700;
                                                color: #000;" target="_blank" href="skill?id=<%=arr.get(i).getId()%>"><%=arr.get(i).getName() != null ? arr.get(i).getName() : ""%> </span>
                                                <i class="fas fa-check-circle kyc" aria-hidden="true"></i>
                                                <div class="player-status ready"></div>
                                            </h3>
                                            <p class="player-title"><%=arr.get(i).getDescription() != null ? arr.get(i).getDescription() : ""%> </p>
                                        </a>
                                    </div>
                                </div>
                                <%}%>
                                <div class="col-md-3">
                                    <div class="player-information-card-wrap">
                                        <div class="player-avatar">
                                            <a target="_blank" href="skill">
                                                <img src="https://playerduo.net/api/upload-service/game_avatars/715867c6-698f-411a-b4f9-1e9093130b60__d8d57300-37bc-11ed-838c-b120e70abb59__game_avatars.jpg" class="" alt="PD" id="avt-img-reponsiver">
                                            </a>
                                        </div>
                                        <a target="_blank" class="player-information" href="skill">
                                            <h3 class="player-name">
                                                <span style="font-weight: 700;
                                                color: #000;" target="_blank" href="skill">Khác</span>
                                            </h3>
                                            <p class="player-title"></p>
                                        </a>
                                    </div>
                                </div>
                                <% } 
                                %>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
        </main><!-- End #main -->

        <%
          UserDAO md = new UserDAO();
          List<User> listU = md.getTopUsersWithRoleID3();
        %>

        <!-- Updated layout for Expert Mentor -->
        <div class="container-xxl py-5">
            <div class="container">
                <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                    <h6 class="section-title bg-white text-center text-primary px-3">Mentor</h6>
                    <h1 class="mb-5">Expert Mentor</h1>
                </div>
                <div class="row g-4">
                    <% for (User user : listU) { %>
                    <div class="col-lg-3 col-md-6 wow fadeInUp" data-wow-delay="0.1s">
                        <div class="team-item bg-light">
                            <div class="overflow-hidden">
                                <!-- Displaying user avatar -->
                                <img style="height: 300px;
                                width: 300px" class="img-fluid img-fixed-size" src="<%= user.getAvatar() %>" alt="<%= user.getFullname() %>">
                                </div>
                                <div class="position-relative d-flex justify-content-center" style="margin-top: -23px;">
                                <div class="bg-light d-flex justify-content-center pt-2 px-1">
                                    <!-- Social media links can be added here if available -->
                                </div>
                            </div>
                            <div class="text-center p-4">
                                <!-- Displaying user full name -->
                                <h5 class="mb-0"><%= user.getFullname() %></h5>
                                <small>Mentor</small>
                                <h5 style="color: red" class="mb-0">
                                        <% 
                                            int starCount = user.getId(); // Assuming getStarCount() returns the number of stars
                                            for (int i = 0; i < starCount; i++) {
                                        %>
                                        ★
                                        <% 
                                            }
                                            for (int i = starCount; i < 5; i++) {
                                        %>
                                        ☆
                                        <% 
                                            }
                                        %>
                                    </h5>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>

                </div>
            </div>






        </main><!-- End #main -->
        <%@include file="footer.jsp" %>
        <!-- ======= Footer ======= -->


        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>


        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>



        <script src="js/main.js"></script>
    </body>

</html>
