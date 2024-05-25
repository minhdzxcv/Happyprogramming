<%-- 
    Document   : profile
    Created on : May 19, 2024, 8:43:21 PM
    Author     : SHD
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import=" java.util.ArrayList, model.User, model.Mentor, model.Mentee , DAO.UserDAO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <style>
            .img-fixed-size {
                width: 100%; /* Thiết lập kích thước chiều rộng của ảnh */
                height: auto; /* Đảm bảo tỷ lệ khung hình được giữ nguyên */
            }
        </style>
        <meta charset="utf-8">
        <title>eLEARNING - eLearning HTML Template</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

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
    </head>
    <body>
        <%@include file="header.jsp" %>
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
        <div class="container">
            <div class="row">
                <c:forEach var="r" items="${list}">
                    <div class="col-4 mt-4">
                        <div>${r.reason}</div>
                        <div class="mt-1">${r.requestDate}</div>
                    </div>
                    <div class="col-4 mt-4">
                        <input type="text" class="form-control" value="${r.request}" readonly="" />
                        
                    </div>
                    <div class="col-2 mt-4">
                        <input type="text" class="form-control" value="${r.skill}" readonly="" />
                       
                    </div>
                    <div class="col-2 mt-4">
                        ${r.status}
                    </div>
                </c:forEach>
                <div class="col-4 mt-3">
                    Total of request: ${list.size()}
                </div>
                <div class="col-4 mt-3">
                    <c:if test="${list.size() > 0}">
                        Total of hours: 24 hours
                    </c:if>
                    <c:if test="${list.size() == 0}">
                        Total of hours: 0 hours
                    </c:if>
                    
                </div>
                <div class="col-4 mt-3">
                    Total of mentor: ${size}
                </div>
                <div class="btn btn-light mt-2">
                    Back
                </div>

            </div>
        </div>




    </body>
</html>
