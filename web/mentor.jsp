<%-- 
    Document   : HomePage
    Created on : Oct 5, 2022, 9:46:55 AM
    Author     : DELL
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Skill, java.util.ArrayList, model.User, model.Mentor, model.Mentee, model.Rate, model.CV, java.text.SimpleDateFormat, DAO.FollowDAO, model.Slot, java.util.Calendar, DAO.ScheduleDAO" %>
<!DOCTYPE html>
<html lang="en">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js'></script>
    <%
            Mentor currMentor = (Mentor)request.getAttribute("CurrMentor");
            CV currCV = (CV)request.getAttribute("CurrCV");
    %>
    <head>

        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <title><%=currMentor.getFullname()%></title>
        <meta content="" name="description">
        <meta content="" name="keywords">


        <link href="https://img.lovepik.com/free-png/20210926/lovepik-cartoon-book-png-image_401449837_wh1200.png" rel="icon">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">


        <link href="assets/vendor/animate.css/animate.min.css" rel="stylesheet">
        <link href="assets/vendor/aos/aos.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
        <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
        <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.css" rel="stylesheet">

        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!--        <link href="css/4.2ddfb1d3.chunk.css" rel="stylesheet">-->
        <link href="css/8.97b85fe3.chunk.css" rel="stylesheet">

        <link href="font-awesome/css/all.css" rel="stylesheet">

        <link href="https://img.lovepik.com/free-png/20210926/lovepik-cartoon-book-png-image_401449837_wh1200.png" rel="icon">


        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap" rel="stylesheet">


        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">


        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">




        <link href="css/style.css" rel="stylesheet">

        <style>
            /* Font and Button Styling */
            .table-title h2, .btn span, .table th, .table td {
                font-size: 18px; /* Adjusted font size for consistency */
            }

            .table-title h2 {
                font-size: 24px;
                font-weight: bold;
                color: black;
            }

            .btn span {
                font-size: 18px;
            }
            /* Style for the price display */
            .price-player-profile {
                background-color: #f8f9fa;
                color: #2c3e50;
                padding: 10px 15px;
                margin: 5px 0;
                border-radius: 5px;
                font-size: 16px;
                font-weight: bold;
                display: inline-block;
                transition: background-color 0.3s ease, color 0.3s ease;
                text-align: center;
            }

            .price-player-profile:hover {
                background-color: #ecf0f1;
                color: #34495e;
            }

            /* Style for the rating display */
            .rateting-style {
                background-color: #fdf2e9;
                color: #d35400;
                padding: 10px 15px;

                border-radius: 5px;
                font-size: 16px;
                font-weight: bold;
                display: inline-block;
                transition: background-color 0.3s ease, color 0.3s ease;
                text-align: center;
            }

            .rateting-style:hover {
                background-color: #fae5d3;
                color: #e67e22;
            }

            /* Additional styling for the rating text */
            .rateting-style span {
                display: block;
                margin-top: 5px;
                font-size: 14px;
                color: #7f8c8d;
            }


            .table th {
                font-weight: bold;
                color: black;
            }

            .table td {
                font-size: 16px;
            }

            /* Preloader Styling */
            #preloader {
                position: fixed;
                left: 0;
                top: 0;
                z-index: 9999;
                width: 100%;
                height: 100%;
                overflow: visible;
                background: #fff url('assets/img/preloader.gif') no-repeat center center;
            }

            /* Back to Top Button Styling */
            .back-to-top {
                display: flex !important;
                justify-content: center !important;
                align-items: center !important;
                box-sizing: border-box;
                text-align: var(--bs-body-text-align);
                -webkit-text-size-adjust: 100%;
                -webkit-tap-highlight-color: transparent;
                position: fixed;
                bottom: 15px;
                right: 15px;
                width: 40px;
                height: 40px;
                background: #007bff;
                color: #fff;
                border-radius: 50%;
                transition: background 0.3s;
            }

            .back-to-top:hover {
                background: #0056b3;
            }

            /* Avatar Styling */
            .avt-lg img {
                width: 100%;
                height: auto;
                border-radius: 50%;
            }

            /* Table Achievement Styling */
            .table-achievement {
                width: 100%;
                margin-top: 20px;
            }

            .table-achievement td {
                padding: 10px;
            }

            /* Player Profile Styling */
            .player-profile-main-wrap, .player-profile-right-wrap {
                margin-top: 20px;
            }

            .name-player-profile {
                font-size: 24px;
                font-weight: bold;
            }

            .item-nav-name {
                font-weight: bold;
            }

            .item-nav-value {
                font-size: 20px;
            }

            /* Game Category Styling */
            .game-category .choose-game {
                margin: 10px;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }

            .game-category .choose-game p {
                margin: 0;
                font-size: 16px;
            }

            /* Review Section Styling */
            .review-duo-player .full-size {
                display: flex;
                align-items: center;
                margin-bottom: 15px;
            }

            .review-image-small .avt-rank img {
                width: 50px;
                height: 50px;
                border-radius: 50%;
            }

            .wrapper-content-rating {
                flex-grow: 1;
                padding-left: 15px;
            }

            .review-content .name-player-review {
                font-size: 18px;
                font-weight: bold;
            }

            .review-content .Deadline-player-review {
                font-size: 14px;
                color: #999;
            }

            .review-rating .rateting-style i {
                color: #ffd700;
            }

            /* Page Navigation Styling */
            .page_account {
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .page_account p {
                margin: 0 5px;
                cursor: pointer;
            }

            .page_account p.active {
                font-weight: bold;
            }
            .btn-my-style {
                padding: 5px 20px;
                margin: 5px;
                border: none;
                border-radius: 5px;
                transition: background-color 0.3s ease, transform 0.3s ease;
                cursor: pointer;
                font-size: 16px;
                font-weight: bold;
                text-transform: uppercase;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .btn-my-style:hover {
                transform: scale(1.05);
            }

            .btn-my-style.red {
                background-color: #e74c3c;
                color: white;
            }

            .btn-my-style.red:hover {
                background-color: #c0392b;
            }

            .btn-my-style.white {
                background-color: white;
                color: #333;
                border: 1px solid #ccc;
            }

            .btn-my-style.white:hover {
                background-color: #f0f0f0;
            }

            .btn-my-style.blue {
                background-color: #3498db;
                color: white;
            }

            .btn-my-style.blue:hover {
                background-color: #2980b9;
            }

            .btn-my-style.green {
                background-color: #2ecc71;
                color: white;
            }

            .btn-my-style.green:hover {
                background-color: #27ae60;
            }

            /* Style for skill tags */
            .skill-tag {
                display: inline-block;
                background-color: #f1c40f;
                color: #333;
                padding: 5px 10px;
                margin: 5px;
                border-radius: 5px;
                font-size: 14px;
                font-weight: bold;
                transition: background-color 0.3s ease;
                cursor: pointer;
            }

            .skill-tag:hover {
                background-color: #f39c12;
            }


        </style>

        <!-- =======================================================
        * Template Name: Mentor - v4.9.0
        * Template URL: https://bootstrapmade.com/mentor-free-education-bootstrap-theme/
        * Author: BootstrapMade.com
        * License: https://bootstrapmade.com/license/
        ======================================================== -->
        <link rel="stylesheet" type="text/css" href="css/3.fe7e74cf.chunk.css">
        <link rel="stylesheet" type="text/css" href="css/10.697bc269.chunk.css">
    </head>

    <body>

        <%@include file="header.jsp" %>
        <div id="root">
            <div class="wrapper">
                <div class="container player-infomation">
                    <div class="player-profile-left-wrap col-md-3">
                        <div class="avt-player false">
                            <div>
                                <div class="avt avt-lg">
                                    <img src="<%=currMentor.getAvatar() != null ? currMentor.getAvatar() : "https://files.playerduo.net/production/images/avatar31.png"%>" class="avt-img" alt="PD">
                                </div>
                            </div>
                        </div>
                        <div style="margin-left: 50px" class="rent-time-wrap">
                            <p style="font-weight: bold; font-size: 20px">Đang Sẵn Sàng</p>
                        </div>
                        <div class="ui-category">
                            <div class="border-category"></div>
                            <div class="title-category">
                                <p style="font-weight: bold; font-size: 20px"> Thành Tích</p>
                            </div>
                        </div>
                        <table class="table-achievement table">
                            <tbody>
                                <tr style="display: flex; flex-direction: column;">
                                    <td><%=currMentor.getAchivement() != null ? currMentor.getAchivement() : ""%> </td>

                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="player-profile-right-wrap col-md-3 col-md-push-6">
                        <p class="price-player-profile"><%=currCV.getMoneyofslot()%> đ/slot</p>
                        <div class="right-player-profile">
                            <div class="rateting-style">
                                <%=(String)request.getAttribute("Rate")%>
                                </i>&nbsp; <span><%=currMentor.getRatingTime()%> <span>Đánh giá</span>
                                </span>
                            </div>
                            <div class="text-center">
                                <button class="btn-my-style red">Tạo Request</button>
                                <button class="btn-my-style red" onclick="window.location.href = 'chat?id=<%=currMentor.getId()%>'">
                                    <i class="fas fa-comment-alt"></i>Chat </button>
                                    
                                    <%if(u != null && u.getRole().equalsIgnoreCase("mentee")) {%>
                                     <button class="btn-my-style red" onclick="window.location.href = 'skill?id=${skillid}'">
                                    <i class="fas fa-reply"></i>Back </button>
                                <button class="btn-my-style red" onclick="Follow()">
                                    <i class="fas fa-user-plus"></i><%=FollowDAO.onPending(u, currMentor.getId()) ? "Hủy Yêu Cầu" : (FollowDAO.onFollow(u, currMentor.getId()) ? "Hủy Follow" : "Follow")%> </button>
                                <script>

                                    function Follow() {
                                        event.preventDefault();
                                        if (!JSON.stringify(document.body.style).includes("overflow: hidden;")) {
                                            document.body.style = 'overflow: hidden; padding-right: 17px; ';
                                            //document.body.style = 'background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                                            let modal = document.createElement('div');
                                    <%if(FollowDAO.onPending(u, currMentor.getId())) {
                                    %>
                                            modal.innerHTML = '<div role="dialog" aria-hidden="true">\n\
<div class="fade modal-backdrop"></div>\n\
<div role="dialog" tabindex="-1" class="fade modal-donate modal" style="display: block;">\n\
<div class="modal-dialog">\n\
  <div class="modal-content" role="document">\n\
    <div class="modal-header">\n\
      <button type="button" class="close">\n\
        <span aria-hidden="true">×</span>\n\
        <span class="sr-only">Close</span>\n\
      </button>\n\
      <h4 class="modal-title">\n\
        <span>Hủy Yêu Cầu Follow</span>\n\
      </h4>\n\
    </div>\n\
    <form method="post">\n\
      <div class="modal-body">\n\
        <input type="hidden" name="type" value="cancel follow">\n\
        <input type="hidden" name="id" value="<%=currMentor.getId()%>">\n\
        Bạn có chắc chắn muốn hủy yêu cầu?\n\
      </div>\n\
      <div class="modal-footer">\n\
        <button type="submit" class="btn btn-success">\n\
          <span>Xác Nhận</span>\n\
        </button>\n\
        <button type="button" class="btn btn-default">\n\
          <span>Đóng</span>\n\
        </button>\n\
      </div>\n\
    </form>\n\
  </div>\n\
</div>\n\
</div>\n\
</div>';
                                    <%
                                    } else if(FollowDAO.onFollow(u, currMentor.getId())) {
                                    %>
                                            modal.innerHTML = '<div role="dialog" aria-hidden="true">\n\
<div class="fade modal-backdrop"></div>\n\
<div role="dialog" tabindex="-1" class="fade modal-donate modal" style="display: block;">\n\
<div class="modal-dialog">\n\
  <div class="modal-content" role="document">\n\
    <div class="modal-header">\n\
      <button type="button" class="close">\n\
        <span aria-hidden="true">×</span>\n\
        <span class="sr-only">Close</span>\n\
      </button>\n\
      <h4 class="modal-title">\n\
        <span>Hủy Follow</span>\n\
      </h4>\n\
    </div>\n\
    <form method="post">\n\
      <div class="modal-body">\n\
        <input type="hidden" name="type" value="unfollow">\n\
        <input type="hidden" name="id" value="<%=currMentor.getId()%>">\n\
        Bạn có chắc chắn muốn hủy follow?\n\
      </div>\n\
      <div class="modal-footer">\n\
        <button type="submit" class="btn btn-success">\n\
          <span>Xác Nhận</span>\n\
        </button>\n\
        <button type="button" class="btn btn-default">\n\
          <span>Đóng</span>\n\
        </button>\n\
      </div>\n\
    </form>\n\
  </div>\n\
</div>\n\
</div>\n\
</div>';
                                    <%
                                    } else {%>
                                            modal.innerHTML = '<div role="dialog" aria-hidden="true">\n\
<div class="fade modal-backdrop"></div>\n\
<div role="dialog" tabindex="-1" class="fade modal-donate modal" style="display: block;">\n\
<div class="modal-dialog">\n\
  <div class="modal-content" role="document">\n\
    <div class="modal-header">\n\
      <button type="button" class="close">\n\
        <span aria-hidden="true">×</span>\n\
        <span class="sr-only">Close</span>\n\
      </button>\n\
      <h4 class="modal-title">\n\
        <span>Follow Request</span>\n\
      </h4>\n\
    </div>\n\
    <form method="post">\n\
      <div class="modal-body">\n\
        <table style="width: 100%;">\n\
          <tbody>\n\
            <tr>\n\
              <input type="hidden" name="type" value="follow">\n\
              <input type="hidden" name="id" value="<%=currMentor.getId()%>">\n\
              <td>\n\
                <span>Tiêu Đề Yêu Cầu</span>:\n\
              </td>\n\
              <td>\n\
                <input placeholder="Nhập Tiêu Đề" required name="title" maxlength="255" type="text" class="form-control"/>\n\
              </td>\n\
            </tr>\n\
            <tr>\n\
              <td>\n\
                <span>Lý do follow</span>:\n\
              </td>\n\
              <td>\n\
                <textarea placeholder="Nhập lý do..." required name="reason" maxlength="255" type="text" class="form-control" style="height:50px"></textarea>\n\
              </td>\n\
            </tr>\n\
          </tbody>\n\
        </table>\n\
      </div>\n\
      <div class="modal-footer">\n\
        <button type="submit" class="btn btn-success">\n\
          <span>Xác Nhận</span>\n\
        </button>\n\
        <button type="button" class="btn btn-default">\n\
          <span>Đóng</span>\n\
        </button>\n\
      </div>\n\
    </form>\n\
  </div>\n\
</div>\n\
</div>\n\
</div>';
                                    <%}%>
                                            document.body.appendChild(modal.firstChild);
                                            let btn = document.body.lastChild.getElementsByTagName('button');
                                            btn[0].onclick = function () {
                                                document.body.lastChild.children[0].classList.remove("in");
                                                document.body.lastChild.children[1].classList.remove("in");
                                                setTimeout(function () {
                                                    document.body.style = 'padding-top: 0px;';
                                                    document.body.removeChild(document.body.lastChild);
                                                    window.onclick = null;
                                                }, 100);

                                            }
                                            btn[2].onclick = function () {
                                                document.body.lastChild.children[0].classList.remove("in");
                                                document.body.lastChild.children[1].classList.remove("in");
                                                setTimeout(function () {
                                                    document.body.style = 'padding-top: 0px;';
                                                    document.body.removeChild(document.body.lastChild);
                                                    window.onclick = null;
                                                }, 100);

                                            }
                                            setTimeout(function () {
                                                document.body.lastChild.children[1].classList.add("in");
                                                document.body.lastChild.children[0].classList.add("in");
                                                window.onclick = function (e) {
                                                    if (!document.getElementsByClassName('modal-content')[0].contains(e.target)) {
                                                        document.body.lastChild.children[0].classList.remove("in");
                                                        document.body.lastChild.children[1].classList.remove("in");
                                                        setTimeout(function () {
                                                            document.body.style = 'padding-top: 0px;';
                                                            document.body.removeChild(document.body.lastChild);
                                                            window.onclick = null;
                                                        }, 100);
                                                    }
                                                };
                                            }, 1);
                                        } else {
                                            //document.body.style = 'overflow: hidden; padding-right: 17px; background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                                            document.body.lastChild.children[1].classList.remove("in");
                                            document.body.lastChild.children[0].classList.remove("in");
                                            setTimeout(function () {
                                                document.body.style = 'padding-top: 0px;';
                                                document.body.removeChild(document.body.lastChild);
                                                window.onclick = null;
                                            }, 100);
                                        }
                                    }
                                </script>
                                <%}%>
                            </div>
                        </div>
                    </div>
                    <div class="player-profile-main-wrap col-md-6 col-md-pull-3">
                        <div>
                            <div class="row">
                                <div class="center-item col-md-12">
                                    <span class="name-player-profile hidden-over-name"><%=currMentor.getFullname() != null ? currMentor.getFullname() : ""%> </span>
                                </div>
                            </div>
                            <div class="nav-player-profile row">
                                <div class="col-md-3 col-xs-6">
                                    <div class="item-nav-name">
                                        <span>Đã được thuê</span>
                                    </div>
                                    <div class="item-nav-value">0&nbsp; <span>giờ</span>
                                    </div>
                                </div>
                                <div class="col-md-3 col-xs-6">
                                    <div class="item-nav-name">
                                        <span>Tỷ lệ hoàn thành</span>
                                    </div>
                                    <div class="item-nav-value">100&nbsp;%</div>
                                </div>
                                <div class="col-md-3 col-xs-6">
                                    <div class="item-nav-name">
                                        <span>Followers</span>
                                    </div>
                                    <div class="item-nav-value">
                                        <%=currMentor.getFollow()%> Follower
                                    </div>
                                </div>
                            </div>
                            <hr>
                            <div class="skills">
                                <%for(int i = 0; i < currCV.getSkills().size(); i++) {%>
                                <div class="choose-game" style="background: center center no-repeat;">
                                    <p class="skill-tag"><%=currCV.getSkills().get(i).getName()%> </p>
                                </div>
                                <%}%>
                            </div>
                            <hr>
                            <div class="title-player-profile row">
                                <div class="col-xs-6">
                                    <p style="font-weight: bold; font-size: 20px">Thông Tin</p>
                                </div>
                            </div>
                            <div class="content-player-profile">
                                <p><%=currMentor.getDescription() != null ? currMentor.getDescription() : ""%> </p>
                                <p><%=currCV.getDescription() != null ? currCV.getDescription() : ""%> </p>
                                <br>
                                <p style="font-weight: bold; font-size: 20px">Profession Introduction</p>
                                <p><%=currCV.getProfessionIntro() != null ? currCV.getProfessionIntro() : ""%> </p>
                                <p></p>
                            </div>
                            <div class="content-player-profile">
                                <h3 style="font-weight: bold; font-size: 20px">Lịch của mentor</h3>
                                <div id="calendar"></div> 
                            </div>
                            <hr>
                            <div class="title-player-profile row">
                                <div class="col-xs-6">
                                    <span>Đánh giá</span>
                                </div>
                            </div>
                            <div class="text-center review-duo-player row">
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
                                                <p class="Deadline-player-review">

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

                                <script>
                                    var max = <%=p%>;
                                    var total = <%=rates.size()%>;
                                    var p = 1;
                                </script>
                                <div class="col-md-12">
                                    <div class="page_account">
                                        <%for(int i = 0; i < p; i++) {%>
                                        <p class="<%=(i==0) ? "active" : ""%>" id="p-<%=i+1%>" onclick="paging(this, event)"  href='<%=i+1%>'></p>
                                        <% } %>
                                        <p class="active" style="cursor: auto;" id="from-to">1/<%=p%></p>
                                    </div>
                                </div>
                                <script>
                                    function paging(input, event) {
                                        event.preventDefault();
                                        let str = JSON.stringify(input.href).replace("http://localhost:9999/Group3/", "").replaceAll('"', '');
                                        if (input.innerHTML !== "Next" && input.innerHTML !== "Previous") {
                                            if (parseInt(str) !== p) {
                                                document.getElementById("from-to").innerHTML = parseInt(str) + "/" + max
                                            }
                                            document.getElementById("p-" + p).classList.remove("active");
                                            input.classList.add("active");
                                            for (var i = (p - 1) * 5 + 1; i <= (p * 5 > total ? total : p * 5); i++) {
                                                document.getElementById(i).classList.add("hidden");
                                            }
                                            p = parseInt(str);
                                            for (var i = (p - 1) * 5 + 1; i <= (p * 5 > total ? total : p * 5); i++) {
                                                document.getElementById(i).classList.remove("hidden");
                                            }
                                        }
                                    }
                                </script>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="preloader"></div></div>
        <script>
            <%if(request.getAttribute("status") != null) {%>
            setTimeout(function () {
                alert("<%=request.getAttribute("status")%>");
            }, 500);
            <%}%>
            function previous() {
                let week = document.getElementById("week");
                let preWeek = document.getElementById("week-" + (parseInt(week.value) - 1));
                if (preWeek != null) {
                    preWeek.classList.remove("hidden");
                    document.getElementById("week-" + week.value).classList.add("hidden");
                    document.getElementById("body-" + week.value).classList.add("hidden");
                    document.getElementById("body-" + (parseInt(week.value) - 1)).classList.remove("hidden");
                    week.value = (parseInt(week.value) - 1);
                }
            }
            function next() {
                let week = document.getElementById("week");
                let preWeek = document.getElementById("week-" + (parseInt(week.value) + 1));
                if (preWeek != null) {
                    preWeek.classList.remove("hidden");
                    document.getElementById("week-" + week.value).classList.add("hidden");
                    document.getElementById("body-" + week.value).classList.add("hidden");
                    document.getElementById("body-" + (parseInt(week.value) + 1)).classList.remove("hidden");
                    week.value = (parseInt(week.value) + 1);
                }
            }
            function schedule(input, event) {
                event.preventDefault();
                console.log(input.parentNode.lastChild)
                if (!input.parentNode.lastChild.classList.contains("hidden")) {
                    input.parentNode.lastChild.classList.add("hidden")
                } else {
            <% 
                int year = (int)request.getAttribute("year");
                int week = (int)request.getAttribute("week");
                Calendar firstDay = (Calendar)request.getAttribute("firstOfWeek");
                Calendar lastDay = Calendar.getInstance();
                lastDay.setTime(firstDay.getTime());
                lastDay.add(Calendar.DATE, 6);
                ArrayList<Slot> arr = (ArrayList)request.getAttribute("FreeSlot");
                int weekCount = ScheduleDAO.weekCount(arr);
            %>
                    input.parentNode.lastChild.classList.remove("hidden");
                }
            }
            let title = document.title;
            <%if(currMentor.getStatus().equalsIgnoreCase("accepted")) {%>
            document.getElementsByClassName('btn-my-style red')[0].onclick = function () {
            <%if(u != null && u.getRole().equalsIgnoreCase("mentee")) {%>
                if (!JSON.stringify(document.body.style).includes("overflow: hidden;")) {
                    document.body.style = 'overflow: hidden; padding-right: 17px; background-color: rgb(233, 235, 238) !important;';
                    //document.body.style = 'background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                    let modal = document.createElement('div');
                    modal.innerHTML = '<div role="dialog" aria-hidden="true"><div class="fade modal-backdrop"></div><div role="dialog" tabindex="-1" class="fade modal-donate modal" style="display: block;"><div class="modal-dialog"><div class="modal-content" role="document"><div class="modal-header"><button type="button" class="close"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button><h4 class="modal-title"><span>Tạo Request</span></h4></div><form method="post"><div class="modal-body"><table style="width: 100%;"><tbody><tr><td>Mentor:</td><td><%=currMentor.getFullname()%></td></tr><tr><td><span>Request Deadline</span>:</td><td><input type="datetime-local" required name="deadline"></td></tr>\n\
            <tr><td><span>Chọn Lịch</span>:</td><td><button class="btn btn-default" style="font: inherit;" onclick="schedule(this, event)">Nhấn để Hiện Lịch</button>\n\
            <div class="bootstrap-datetimepicker-widget dropdown-menu hidden" id="datepicker" style="width: 17em; inset: auto auto auto auto;">\n\
        <div class="row">\n\
<div class="datepicker">\n\
<div class="datepicker-days" style="display: block;">\n\
<table class="table-condensed">\n\
<thead>\n\
<tr>\n\
<th class="fa-thin fa-fish" data-action="previous" onclick="previous()"><span class="glyphicon glyphicon-chevron-left" title="Previous Week"></span></th>\n\
<input type="hidden" id="week" name="currWeek" value=<%=week%>>\n\
            <%for(int i = 0; i < weekCount; i++) {%>\n\
<th class="picker-switch <%=i==0 ? "" : "hidden"%>" data-action="pickerSwitch" colspan="5" title="Select Week" id="week-<%=week+i%>">\n\
            <%=firstDay.get(Calendar.DAY_OF_MONTH) < 10 ? "0"+firstDay.get(Calendar.DAY_OF_MONTH) : firstDay.get(Calendar.DAY_OF_MONTH)%>/<%=(firstDay.get(Calendar.MONTH)+1) < 10 ? "0"+(firstDay.get(Calendar.MONTH)+1) : (firstDay.get(Calendar.MONTH)+1)%> - <%=lastDay.get(Calendar.DAY_OF_MONTH) < 10 ? "0"+lastDay.get(Calendar.DAY_OF_MONTH) : lastDay.get(Calendar.DAY_OF_MONTH)%>/<%=(lastDay.get(Calendar.MONTH)+1) < 10 ? "0"+(lastDay.get(Calendar.MONTH)+1) : (lastDay.get(Calendar.MONTH)+1)%>\n\
</th>\n\
            <%  firstDay.add(Calendar.DATE, 7);
                lastDay.add(Calendar.DATE, 7);
                }%>\n\
<th class="fa-thin fa-check" data-action="next" onclick="next()"><span class="glyphicon glyphicon-chevron-right" title="Next Week"></span></th>\n\
</tr><tr><th class="dow">Mo</th><th class="dow">Tu</th><th class="dow">We</th><th class="dow">Th</th><th class="dow">Fr</th><th class="dow">Sa</th><th class="dow">Su</th></tr>\n\
</thead>\n\
            <%  firstDay.add(Calendar.DATE, -(7*weekCount));
                lastDay.add(Calendar.DATE, -(7*weekCount));
                float currWidth = 17;
                float maxWidth = 17;
                for(int j = 0; j < weekCount; j++) {
                    currWidth = 17;
                                    ArrayList<Slot> thisWeek = ScheduleDAO.sortByWeek(firstDay, lastDay, arr);
                                                                ArrayList<Slot> mon = new ArrayList();
                                                                ArrayList<Slot> tue = new ArrayList();
                                                                ArrayList<Slot> wen = new ArrayList();
                                                                ArrayList<Slot> thu = new ArrayList();
                                                                ArrayList<Slot> fri = new ArrayList();
                                                                ArrayList<Slot> sat = new ArrayList();
                                                                ArrayList<Slot> sun = new ArrayList();
                                                                int[] hod = new int[] { 5, 7, 10, 12, 15, 17, 20 };
                                                                for(int i = 0; i < thisWeek.size(); i++) {
                                                                    Calendar c = Calendar.getInstance();
                                                                    c.setTime(thisWeek.get(i).getSlotTime());
                                                                    if(c.get(Calendar.DAY_OF_WEEK) == 1) {
                                                                        while(c.get(Calendar.HOUR_OF_DAY) != hod[sun.size()]) {
                                                                            sun.add(null);
                                                                        }
                                                                        sun.add(thisWeek.get(i));
                                                                    }
                                                                    if(c.get(Calendar.DAY_OF_WEEK) == 2) {
                                                                        while(c.get(Calendar.HOUR_OF_DAY) != hod[mon.size()]) {
                                                                            mon.add(null);
                                                                        }
                                                                        mon.add(thisWeek.get(i));
                                                                    }
                                                                    if(c.get(Calendar.DAY_OF_WEEK) == 3) {
                                                                        while(c.get(Calendar.HOUR_OF_DAY) != hod[tue.size()]) {
                                                                            tue.add(null);
                                                                        }
                                                                        tue.add(thisWeek.get(i));
                                                                    }
                                                                    if(c.get(Calendar.DAY_OF_WEEK) == 4) {
                                                                        while(c.get(Calendar.HOUR_OF_DAY) != hod[wen.size()]) {
                                                                            wen.add(null);
                                                                        }
                                                                        wen.add(thisWeek.get(i));
                                                                    }
                                                                    if(c.get(Calendar.DAY_OF_WEEK) == 5) {
                                                                        while(c.get(Calendar.HOUR_OF_DAY) != hod[thu.size()]) {
                                                                            thu.add(null);
                                                                        }
                                                                        thu.add(thisWeek.get(i));
                                                                    }
                                                                    if(c.get(Calendar.DAY_OF_WEEK) == 6) {
                                                                        while(c.get(Calendar.HOUR_OF_DAY) != hod[fri.size()]) {
                                                                            fri.add(null);
                                                                        }
                                                                        fri.add(thisWeek.get(i));
                                                                    }
                                                                    if(c.get(Calendar.DAY_OF_WEEK) == 7) {
                                                                        while(c.get(Calendar.HOUR_OF_DAY) != hod[sat.size()]) {
                                                                            sat.add(null);
                                                                        }
                                                                        sat.add(thisWeek.get(i));
                                                                    }
                                                                }
                                                                int max = mon.size();
                                                                if(tue.size() > max) max = tue.size();
                                                                if(wen.size() > max) max = wen.size();
                                                                if(thu.size() > max) max = thu.size();
                                                                if(fri.size() > max) max = fri.size();
                                                                if(sat.size() > max) max = sat.size();
                                                                if(sun.size() > max) max = sun.size();
            %>\n\
<tbody class="<%=j==0 ? "" : "hidden"%>" id="body-<%=week+j%>">\n\
            <%for(int i = 0; i < (7 < max ? max : 7); i++) {                                                   
            %>\n\
<tr>\n\
            <%if(mon.size() > i && mon.get(i) != null) {
                Slot s = mon.get(i);
                Calendar c = Calendar.getInstance();
                c.setTime(s.getSlotTime());
                Calendar to = Calendar.getInstance();
                to.setTime(s.getSlotTime());
                to.add(Calendar.MINUTE, (int)(60*s.getHour()));
                currWidth += 1.5;
            %>\n\
<td data-action="selectDay" class="day" title="Slot <%=i%>">\n\
<input type="checkbox" name="slot" value="<%=s.getId()%>" id="checkbox-<%=s.getId()%>" >\n\
<label for="checkbox-<%=s.getId()%>"><%=c.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+c.get(Calendar.HOUR_OF_DAY) : c.get(Calendar.HOUR_OF_DAY)%>:<%=c.get(Calendar.MINUTE) < 10 ? "0"+c.get(Calendar.MINUTE) : c.get(Calendar.MINUTE)%><br><%=to.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+to.get(Calendar.HOUR_OF_DAY) : to.get(Calendar.HOUR_OF_DAY)%>:<%=to.get(Calendar.MINUTE) < 10 ? "0"+to.get(Calendar.MINUTE) : to.get(Calendar.MINUTE)%></label>\n\
            <% } else {%><td data-action="selectDay" class="day"> -<%}%>\n\
</td>\n\
            <%if(tue.size() > i && tue.get(i) != null) {
                Slot s = tue.get(i);
                Calendar c = Calendar.getInstance();
                c.setTime(s.getSlotTime());
                Calendar to = Calendar.getInstance();
                to.setTime(s.getSlotTime());
                to.add(Calendar.MINUTE, (int)(60*s.getHour()));
                currWidth += 1.5;
            %>\n\
<td data-action="selectDay" class="day" title="Slot <%=i%>">\n\
<input type="checkbox" name="slot" value="<%=s.getId()%>" id="checkbox-<%=s.getId()%>" >\n\
<label for="checkbox-<%=s.getId()%>"><%=c.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+c.get(Calendar.HOUR_OF_DAY) : c.get(Calendar.HOUR_OF_DAY)%>:<%=c.get(Calendar.MINUTE) < 10 ? "0"+c.get(Calendar.MINUTE) : c.get(Calendar.MINUTE)%><br><%=to.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+to.get(Calendar.HOUR_OF_DAY) : to.get(Calendar.HOUR_OF_DAY)%>:<%=to.get(Calendar.MINUTE) < 10 ? "0"+to.get(Calendar.MINUTE) : to.get(Calendar.MINUTE)%></label>\n\
            <% } else {%><td data-action="selectDay" class="day"> -<%}%>\n\
</td>\n\
            <%if(wen.size() > i && wen.get(i) != null) {
                Slot s = wen.get(i);
                Calendar c = Calendar.getInstance();
                c.setTime(s.getSlotTime());
                Calendar to = Calendar.getInstance();
                to.setTime(s.getSlotTime());
                to.add(Calendar.MINUTE, (int)(60*s.getHour()));
                currWidth += 1.5;
            %>\n\
<td data-action="selectDay" class="day" title="Slot <%=i%>">\n\
<input type="checkbox" name="slot" value="<%=s.getId()%>" id="checkbox-<%=s.getId()%>" >\n\
<label for="checkbox-<%=s.getId()%>"><%=c.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+c.get(Calendar.HOUR_OF_DAY) : c.get(Calendar.HOUR_OF_DAY)%>:<%=c.get(Calendar.MINUTE) < 10 ? "0"+c.get(Calendar.MINUTE) : c.get(Calendar.MINUTE)%><br><%=to.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+to.get(Calendar.HOUR_OF_DAY) : to.get(Calendar.HOUR_OF_DAY)%>:<%=to.get(Calendar.MINUTE) < 10 ? "0"+to.get(Calendar.MINUTE) : to.get(Calendar.MINUTE)%></label>\n\
            <% } else {%><td data-action="selectDay" class="day"> -<%}%>\n\
</td>\n\
            <%if(thu.size() > i && thu.get(i) != null) {
                Slot s = thu.get(i);
                Calendar c = Calendar.getInstance();
                c.setTime(s.getSlotTime());
                Calendar to = Calendar.getInstance();
                to.setTime(s.getSlotTime());
                to.add(Calendar.MINUTE, (int)(60*s.getHour()));
                currWidth += 1.5;
            %>\n\
<td data-action="selectDay" class="day" title="Slot <%=i%>">\n\
<input type="checkbox" name="slot" value="<%=s.getId()%>" id="checkbox-<%=s.getId()%>" >\n\
<label for="checkbox-<%=s.getId()%>"><%=c.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+c.get(Calendar.HOUR_OF_DAY) : c.get(Calendar.HOUR_OF_DAY)%>:<%=c.get(Calendar.MINUTE) < 10 ? "0"+c.get(Calendar.MINUTE) : c.get(Calendar.MINUTE)%><br><%=to.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+to.get(Calendar.HOUR_OF_DAY) : to.get(Calendar.HOUR_OF_DAY)%>:<%=to.get(Calendar.MINUTE) < 10 ? "0"+to.get(Calendar.MINUTE) : to.get(Calendar.MINUTE)%></label>\n\
            <% } else {%><td data-action="selectDay" class="day"> -<%}%>\n\
</td>\n\
            <%if(fri.size() > i && fri.get(i) != null) {
                Slot s = fri.get(i);
                Calendar c = Calendar.getInstance();
                c.setTime(s.getSlotTime());
                Calendar to = Calendar.getInstance();
                to.setTime(s.getSlotTime());
                to.add(Calendar.MINUTE, (int)(60*s.getHour()));
                currWidth += 1.5;
            %>\n\
<td data-action="selectDay" class="day" title="Slot <%=i%>">\n\
<input type="checkbox" name="slot" value="<%=s.getId()%>" id="checkbox-<%=s.getId()%>" >\n\
<label for="checkbox-<%=s.getId()%>"><%=c.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+c.get(Calendar.HOUR_OF_DAY) : c.get(Calendar.HOUR_OF_DAY)%>:<%=c.get(Calendar.MINUTE) < 10 ? "0"+c.get(Calendar.MINUTE) : c.get(Calendar.MINUTE)%><br><%=to.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+to.get(Calendar.HOUR_OF_DAY) : to.get(Calendar.HOUR_OF_DAY)%>:<%=to.get(Calendar.MINUTE) < 10 ? "0"+to.get(Calendar.MINUTE) : to.get(Calendar.MINUTE)%></label>\n\
            <% } else {%><td data-action="selectDay" class="day"> -<%}%>\n\
</td>\n\
            <%if(sat.size() > i && sat.get(i) != null) {
                Slot s = sat.get(i);
                Calendar c = Calendar.getInstance();
                c.setTime(s.getSlotTime());
                Calendar to = Calendar.getInstance();
                to.setTime(s.getSlotTime());
                to.add(Calendar.MINUTE, (int)(60*s.getHour()));
                currWidth += 1.5;
            %>\n\
<td data-action="selectDay" class="day" title="Slot <%=i%>">\n\
<input type="checkbox" name="slot" value="<%=s.getId()%>" id="checkbox-<%=s.getId()%>" >\n\
<label for="checkbox-<%=s.getId()%>"><%=c.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+c.get(Calendar.HOUR_OF_DAY) : c.get(Calendar.HOUR_OF_DAY)%>:<%=c.get(Calendar.MINUTE) < 10 ? "0"+c.get(Calendar.MINUTE) : c.get(Calendar.MINUTE)%><br><%=to.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+to.get(Calendar.HOUR_OF_DAY) : to.get(Calendar.HOUR_OF_DAY)%>:<%=to.get(Calendar.MINUTE) < 10 ? "0"+to.get(Calendar.MINUTE) : to.get(Calendar.MINUTE)%></label>\n\
            <% } else {%><td data-action="selectDay" class="day"> -<%}%>\n\
</td>\n\
            <%if(sun.size() > i && sun.get(i) != null) {
                Slot s = sun.get(i);
                Calendar c = Calendar.getInstance();
                c.setTime(s.getSlotTime());
                Calendar to = Calendar.getInstance();
                to.setTime(s.getSlotTime());
                to.add(Calendar.MINUTE, (int)(60*s.getHour()));
                currWidth += 1.5;
            %>\n\
<td data-action="selectDay" class="day" title="Slot <%=i%>">\n\
<input type="checkbox" class="slotToLearn" name="slot" value="<%=s.getId()%>" id="checkbox-<%=s.getId()%>" >\n\
<label for="checkbox-<%=s.getId()%>"><%=c.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+c.get(Calendar.HOUR_OF_DAY) : c.get(Calendar.HOUR_OF_DAY)%>:<%=c.get(Calendar.MINUTE) < 10 ? "0"+c.get(Calendar.MINUTE) : c.get(Calendar.MINUTE)%><br><%=to.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+to.get(Calendar.HOUR_OF_DAY) : to.get(Calendar.HOUR_OF_DAY)%>:<%=to.get(Calendar.MINUTE) < 10 ? "0"+to.get(Calendar.MINUTE) : to.get(Calendar.MINUTE)%></label>\n\
            <% } else {%><td data-action="selectDay" class="day"> -<%}%>\n\
</td>\n\
</tr>\n\
            <%}%>\n\
</tbody>\n\
            <%  firstDay.add(Calendar.DATE, 7);
                lastDay.add(Calendar.DATE, 7);
                if(currWidth > maxWidth) {
                    maxWidth = currWidth;
                }
                }%>\n\
</table>\n\
</div>\n\
</div></div></div></td>\n\
</tr>\n\
<tr><td><span>Tiêu Đề</span>:</td><td><input placeholder="Nhập tiêu đề..." required name="subject"></td></tr><tr><td><span>Yêu Cầu</span>:</td><td><textarea placeholder="Nhập yêu cầu..." required name="reason" maxlength="255" type="text" class="form-control" style="height:50px"></textarea></td></tr><tr><td><span>Chọn kĩ năng cần học</span>:</td><td><%for(int i = 0; i < currCV.getSkills().size(); i++) {%><div class="col-sm-6"><input class="skilltolearn" type="checkbox" <%if(request.getParameter("sid") != null) {
                                                                                                                                                                                                        try {
                                                                                                                                                                                                        int sid = Integer.parseInt(request.getParameter("sid"));
                                                                                                                                                                                                        if(sid == currCV.getSkills().get(i).getId()) {
            %>checked<%}} catch(Exception e) {}
}%> name="skill" value="<%=currCV.getSkills().get(i).getId()%>" id="<%=currCV.getSkills().get(i).getId()%>"><label for="<%=currCV.getSkills().get(i).getId()%>" style="margin-left: 5px"><%=currCV.getSkills().get(i).getName()%></label></div><%}%></td></tr></tbody></table></div><div class="modal-body"><div id="totalAmount"></div></div><div class="modal-footer">\n\
<button type="submit" class="btn-fill btn btn-danger"><span>Tạo Request</span></button><button type="button" class="btn btn-default"><span>Đóng</span></button></div></form></div></div></div></div>';
                    let date = new Date();
                    let dateonly = [date.getMonth() + 1, date.getDate(), date.getFullYear()];
                    modal.querySelector("input[type=datetime-local]").min = dateonly[2] + "-" + (parseInt(dateonly[0]) < 10 ? "0" + dateonly[0] : dateonly[0]) + "-" + (parseInt(dateonly[1]) < 10 ? "0" + dateonly[1] : dateonly[1]) + "T" + date.toTimeString().split(":")[0] + ":" + date.toTimeString().split(":")[1];
                    document.body.appendChild(modal.firstChild);
                    if (17 < <%=maxWidth%>) {
                        document.getElementById("datepicker").style.width = <%=maxWidth%> + "em";
                    }
                    let skills = document.body.lastChild.querySelectorAll("input[type=checkbox]");
                    for (var i = 0; i < skills.length; i++) {
                        skills[i].onclick = function (e) {
                            if (this.checked) {
                                let checkeds = document.body.querySelectorAll(".skilltolearn:checked");
                                if (checkeds.length > 1) {
                                    this.checked = false;
                                    alert("Bạn chỉ được chọn tối đa 1 skills!");
                                }
                            }
                        }
                    }
                    let btn = document.body.lastChild.getElementsByTagName('button');
                    btn[2].onclick = function (e) {
                        console.log(document.body.lastChild);
                        e.preventDefault();
                        let checkeds = document.body.querySelectorAll(".skilltolearn:checked");
                        console.log(checkeds)
                        if (checkeds.length < 1) {
                            alert('Vui lòng chọn ít nhất 1 skill!');
                        } else {
                            let slot = document.body.querySelectorAll("input[name=slot]:checked");
                            if (slot.length > 0) {
                                this.onclick = null;
                                this.click();
                            } else {
                                alert('Vui lòng chọn ít nhất 1 slot!');
                            }
                        }
                    }
                    btn[0].onclick = function () {
                        document.body.lastChild.firstChild.classList.remove("in");
                        document.body.lastChild.children[1].classList.remove("in");
                        setTimeout(function () {
                            document.body.style = 'background-color: rgb(233, 235, 238) !important;';
                            document.body.removeChild(document.body.lastChild);
                            window.onclick = null;
                        }, 100);
                        document.title = title;

                    }
                    btn[3].onclick = function () {
                        document.body.lastChild.firstChild.classList.remove("in");
                        document.body.lastChild.children[1].classList.remove("in");
                        setTimeout(function () {
                            document.body.style = 'background-color: rgb(233, 235, 238) !important;';
                            document.body.removeChild(document.body.lastChild);
                            window.onclick = null;
                        }, 100);
                        document.title = title;

                    }
                    setTimeout(function () {
                        document.body.lastChild.children[1].classList.add("in");
                        document.body.lastChild.firstChild.classList.add("in");
                        window.onclick = function (e) {
                            if (!document.getElementsByClassName('modal-content')[0].contains(e.target)) {
                                document.body.lastChild.firstChild.classList.remove("in");
                                document.body.lastChild.children[1].classList.remove("in");
                                setTimeout(function () {
                                    document.body.style = 'background-color: rgb(233, 235, 238) !important;';
                                    document.body.removeChild(document.body.lastChild);
                                    window.onclick = null;
                                }, 100);
                                document.title = title;
                            }
                        };
                        document.title = "Create Request";
                    }, 1);
                } else {
                    //document.body.style = 'overflow: hidden; padding-right: 17px; background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                    document.body.lastChild.children[1].classList.remove("in");
                    document.body.lastChild.firstChild.classList.remove("in");
                    setTimeout(function () {
                        document.body.style = 'background-color: rgb(233, 235, 238) !important; ';
                        document.body.removeChild(document.body.lastChild);
                        window.onclick = null;
                    }, 100);
                    document.title = title;
                }
            <%} else if(u != null) {%>
                alert("Vui lòng dùng tài khoản mentee để thuê");
            <%} else {%>
                alert("Vui lòng đăng nhập trước khi thuê");
            <%}%>
            }
            <%} else {%>
            document.getElementsByClassName('btn-my-style red')[0].onclick = function (e) {
                e.preventDefault();
            }
            <%}%>
        </script>
        <style>
            /* Popup container */
            .popup {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgb(0,0,0);
                background-color: rgba(0,0,0,0.4);
                padding-top: 60px;
            }

            /* Popup Content */
            .popup-content {
                background-color: #fefefe;
                margin: 5% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
            }

            /* The Close Button */
            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }
        </style>

        <div id="viewSlot" class="popup">
            <div class="popup-content">
                <span class="close" onclick="closeRejectPopupView()">&times;</span>
                <h2>Slot detail</h2>
                <div>
                    <div class="form-group">
                        <div id="slot-content-view">
                            <p id="eventStartEnd"></p>
                            <p id="slotNumber"></p>
                            <p id="eventLink"></p>
                            <p id="eventStatus"></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function openRejectPopupView() {
                document.getElementById('viewSlot').style.display = "block";
            }

            function closeRejectPopupView() {
                document.getElementById('viewSlot').style.display = "none";
            }

            window.onclick = function (event) {
                const popup = document.getElementById('viewSlot');
                if (event.target == popup) {
                    popup.style.display = "none";
                }
            }
            document.addEventListener('DOMContentLoaded', function () {
                var calendarEl = document.getElementById('calendar');
                var calendar = new FullCalendar.Calendar(calendarEl, {
                    initialView: 'dayGridMonth',
                    headerToolbar: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'dayGridMonth'
                    },
                    events: [],
                    eventClick: function (info) {
                        var slotHour = info.event.start.getHours() + ':' + ('0' + info.event.start.getMinutes()).slice(-2);
                        var slot;
                        if (slotHour === "05:00") {
                            slot = 0;
                        } else if (slotHour === "07:30") {
                            slot = 1;
                        } else if (slotHour === "10:00") {
                            slot = 2;
                        } else if (slotHour === "12:50") {
                            slot = 3;
                        } else if (slotHour === "15:20") {
                            slot = 4;
                        } else if (slotHour === "17:50") {
                            slot = 5;
                        } else if (slotHour === "20:30") {
                            slot = 6;
                        } else {
                            slot = -1;
                        }

                        var modalBody = document.querySelector('#slot-content-view');

                        document.getElementById('eventStartEnd').innerHTML = "Start:" + info.event.start.toLocaleString() + "</br>End: " + info.event.end.toLocaleString();
                        document.getElementById('slotNumber').textContent = "Slot Number: " + slot;
                        document.getElementById('eventLink').innerHTML = "Room Link: " + "<a href=\"" + info.event.extendedProps.link + "\">Link meet</a>";
                        document.getElementById('eventStatus').textContent = "Status: " + info.event.extendedProps.status;

                        openRejectPopupView();
                    }
                }
                );

                calendar.render();

                function updateCalendarEvents(slots) {
                    var events = slots.map(function (slot) {
                        var start = new Date(slot.SlotTime);
                        var end = new Date(start.getTime() + slot.hour * 60 * 60 * 1000);

                        var slotHour = start.getHours() + ':' + ('0' + start.getMinutes()).slice(-2);
                        var slotNumber = -1;

                        switch (slotHour) {
                            case "05:00":
                                slotNumber = 1;
                                break;
                            case "07:30":
                                slotNumber = 2;
                                break;
                            case "10:00":
                                slotNumber = 3;
                                break;
                            case "12:50":
                                slotNumber = 4;
                                break;
                            case "15:20":
                                slotNumber = 5;
                                break;
                            case "17:50":
                                slotNumber = 6;
                                break;
                            case "20:30":
                                slotNumber = 7;
                                break;
                            default:
                                slotNumber = -1;
                        }

                        return {
                            id: slot.id,
                            title: 'Slot ' + slotNumber,
                            start: start,
                            end: end,
                            extendedProps: {
                                link: slot.link,
                                status: slot.Status.trim(),
                                menteeId: slot.menteeId
                            }
                        };
                    });

                    calendar.removeAllEvents();
                    calendar.addEventSource(events);
                }

                var jsonSlots = '<%= request.getAttribute("jsonSlots") %>';
                var slotsData = JSON.parse(jsonSlots);
                updateCalendarEvents(slotsData);
            });
        </script>


        <script>
            function calculateTotal() {
                let total = 0;
                let checkedSlots = document.querySelectorAll("input[name=slot]:checked");
                checkedSlots.forEach(function (slot) {
                    total += parseFloat(<%=currCV.getMoneyofslot()%>);
                });
                return total.toFixed(2);
            }

            function updateTotal() {
                let total = calculateTotal();
                document.getElementById('totalAmount').innerHTML = "Số tiền phải thanh toán: <b>" + total + "</b> VNĐ";
            }

            document.addEventListener('change', function (event) {
                if (event.target && event.target.type === 'checkbox' && event.target.name === 'slot') {
                    updateTotal();
                }
            });
        </script>
        <a href="#" class="back-to-top d-flex align-items-center justify-content-center" style="
           display: flex!important;
           justify-content: center!important;
           align-items: center!important;
           box-sizing: border-box;
           text-align: var(--bs-body-text-align);
           -webkit-text-size-adjust: 100%;
           -webkit-tap-highlight-color: transparent;
           "><i class="bi bi-arrow-up-short"></i></a>

        <!-- Vendor JS Files -->
        <script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
        <script src="assets/vendor/aos/aos.js"></script>
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
        <script src="assets/vendor/php-email-form/validate.js"></script>

        <!-- Template Main JS File -->
        <script src="assets/js/main.js"></script>
        <%if(request.getParameter("invite") != null) {%>
        <script>
            setTimeout(function () {
                document.getElementsByClassName('btn-my-style red')[0].click();
            }, 1);
        </script>
        <% } %>
    </body>

</html>

