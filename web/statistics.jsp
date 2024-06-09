<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="java.util.ArrayList, model.User, model.Mentor, model.Mentee , DAO.UserDAO" %>
<%@page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <style>
            body{
                background: #f5f5f5;
                margin-top:20px;
            }

            .ui-w-80 {
                width: 80px !important;
                height: auto;
            }

            .btn-default {
                border-color: rgba(24,28,33,0.1);
                background: rgba(0,0,0,0);
                color: #4E5155;
            }

            label.btn {
                margin-bottom: 0;
            }

            .btn-outline-primary {
                border-color: #26B4FF;
                background: transparent;
                color: #26B4FF;
            }

            .btn {
                cursor: pointer;
            }

            .text-light {
                color: #babbbc !important;
            }

            .btn-facebook {
                border-color: rgba(0,0,0,0);
                background: #3B5998;
                color: #fff;
            }

            .btn-instagram {
                border-color: rgba(0,0,0,0);
                background: #000;
                color: #fff;
            }

            .card {
                background-clip: padding-box;
                box-shadow: 0 1px 4px rgba(24,28,33,0.012);
            }

            .row-bordered {
                overflow: hidden;
            }

            .account-settings-fileinput {
                position: absolute;
                visibility: hidden;
                width: 1px;
                height: 1px;
                opacity: 0;
            }
            .account-settings-links .list-group-item.active {
                font-weight: bold !important;
            }
            html:not(.dark-style) .account-settings-links .list-group-item.active {
                background: transparent !important;
            }
            .account-settings-multiselect ~ .select2-container {
                width: 100% !important;
            }
            .light-style .account-settings-links .list-group-item {
                padding: 0.85rem 1.5rem;
                border-color: rgba(24, 28, 33, 0.03) !important;
            }
            .light-style .account-settings-links .list-group-item.active {
                color: #4e5155 !important;
            }
            .material-style .account-settings-links .list-group-item {
                padding: 0.85rem 1.5rem;
                border-color: rgba(24, 28, 33, 0.03) !important;
            }
            .material-style .account-settings-links .list-group-item.active {
                color: #4e5155 !important;
            }
            .dark-style .account-settings-links .list-group-item {
                padding: 0.85rem 1.5rem;
                border-color: rgba(255, 255, 255, 0.03) !important;
            }
            .dark-style .account-settings-links .list-group-item.active {
                color: #fff !important;
            }
            .light-style .account-settings-links .list-group-item.active {
                color: #4E5155 !important;
            }
            .light-style .account-settings-links .list-group-item {
                padding: 0.85rem 1.5rem;
                border-color: rgba(24,28,33,0.03) !important;
            }

        </style>
        <style>
            body{
                background: #f7f7ff;
                margin-top:20px;
            }
            .card {
                position: relative;
                display: flex;
                flex-direction: column;
                min-width: 0;
                word-wrap: break-word;
                background-color: #fff;
                background-clip: border-box;
                border: 0 solid transparent;
                border-radius: .25rem;
                margin-bottom: 1.5rem;
                box-shadow: 0 2px 6px 0 rgb(218 218 253 / 65%), 0 2px 6px 0 rgb(206 206 238 / 54%);
            }
            .me-2 {
                margin-right: .5rem!important;
            }

        </style>
        <meta charset="utf-8">
        <title>User Profile</title>
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
        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
    </head>

    <body>
        <div class="container">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->

        <%@include file="header.jsp" %>
        <div class="container mt-4">
        <div class="row">
            <!-- Cột trái -->
            <div class="col-sm-4">
                <div class="container light-style flex-grow-1 container-p-y">
                    <h4 class="font-weight-bold py-3 mb-4">TÀI KHOẢN</h4>

                    <div class="card overflow-hidden">
                        <div class="row no-gutters row-bordered row-border-light">
                            <div class="col-md-12 pt-0">
                                <div class="list-group list-group-flush account-settings-links">
                                    <a id="general" class="list-group-item list-group-item-action active" data-toggle="list" href="#account-general">General</a>
                                    <% if (u.getRole().equalsIgnoreCase("mentor")) { %>
                                        <a id="cv" class="list-group-item list-group-item-action" data-toggle="list" href="#">CV</a>
                                        <a id="statistics" class="list-group-item list-group-item-action" data-toggle="list" href="#">Request statistics</a>
                                    <% } else { %>
                                        <a id="statistics" class="list-group-item list-group-item-action" data-toggle="list" href="#">Request statistics</a>
                                    <% } %>
                                    <a id="password" class="list-group-item list-group-item-action" data-toggle="list" href="#">Change password</a>
                                    <a id="history" class="list-group-item list-group-item-action" data-toggle="list" href="#">Transaction history</a>
                                    <a id="pay" class="list-group-item list-group-item-action" data-toggle="list" href="#">Pay</a>
                                    <a id="wallet" class="list-group-item list-group-item-action" data-toggle="list" href="#">Wallet</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Cột phải -->
            <div class="col-md-8">
                <div class="card p-4">
                    <h3>Thống Kê Request</h3>
                    <hr>
                    <p>TỔNG SỐ REQUEST NHẬN ĐƯỢC:</p>
                    <hr>
                    <p>TỔNG SỐ REQUEST ĐÃ TỪ CHỐI:</p>
                    <hr>
                    <p>TỈ LỆ TỪ CHỐI REQUEST:</p>
                    <hr>
                    <p>TỔNG SỐ REQUEST ĐÃ CHẤP THUẬN:</p>
                    <hr>
                    <p>ĐÁNH GIÁ TỪ HỌC VIÊN:</p>
                    <hr>
                    <p>TỈ LỆ HOÀN THÀNH REQUEST:</p>
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
        <script src='https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js'></script>
        <script src="js/main.js"></script>
        <script>
            // Chọn các phần tử link
            const statisticsLink = document.getElementById('statistics');
            const historyLink = document.getElementById('history');
            const payLink = document.getElementById('pay');
            const walletLink = document.getElementById('wallet');
            const passwordLink = document.getElementById('password');
            const generalLink = document.getElementById('general');
            const cvLink = document.getElementById('cv');


            // Thêm sự kiện click cho từng link
            passwordLink.addEventListener('click', function () {
                window.location.href = 'setting';
            });
            statisticsLink.addEventListener('click', function () {
                window.location.href = 'statistics';
            });
            historyLink.addEventListener('click', function () {
                window.location.href = 'transaction';
            });
            payLink.addEventListener('click', function () {
                window.location.href = 'bank';
            });
            walletLink.addEventListener('click', function () {
                window.location.href = 'wallet';
            });
            cvLink.addEventListener('click', function () {
                window.location.href = 'cv';
            });
            generalLink.addEventListener('click', function () {
                window.location.href = 'profile';
            });

            // Hiển thị ảnh mới chọn
            document.getElementById('avatarInput').addEventListener('change', function (event) {
                const [file] = event.target.files;
                if (file) {
                    document.getElementById('avatarPreview').src = URL.createObjectURL(file);
                }
            });
        </script>
        s/bootstrap.bundle.min.js'></script>
</body>
</html>
