<%-- 
    Document   : home
    Created on : May 13, 2024, 9:04:58 PM
    Author     : ADMIN
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import=" java.util.ArrayList, model.User, model.Mentor, model.Mentee , DAO.UserDAO" %>
<%@ page import="java.util.List" %>

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
    body {
    background: #f7f7ff; /* Lấy giá trị mới nhất */
    margin-top: 20px;
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

.modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0,0,0,0.4);
}

.modal-content {
    background-color: #fefefe;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
}

.centered-form {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    width: 300px;
    margin: 0 auto;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 10px;
}

.input-field {
    width: 100%;
    margin-bottom: 10px;
}

.input-field input {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.centered-text {
    text-align: center;
    margin-bottom: 10px;
}

.margin-div {
    margin: 10px 0;
}

.submit-button {
    background-color: #4CAF50;
    color: white;
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    margin: 4px 2px;
    cursor: pointer;
    border: none;
    border-radius: 5px;
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

    
<div class="container light-style flex-grow-1 container-p-y">

    <h4 class="font-weight-bold py-3 mb-4">
      TÀI KHOẢN
    </h4>

    <div class="card overflow-hidden">
  <div class="row no-gutters row-bordered row-border-light">
      <div class="col-md-3 pt-0">
          <div class="list-group list-group-flush account-settings-links">                  
                            <a id="general" class="list-group-item list-group-item-action active" data-toggle="list" href="#account-general">General</a>
                            <%if(u.getRole().equalsIgnoreCase("mentor")) {%>
                            <a id="cv" class="list-group-item list-group-item-action" data-toggle="list" href="#">CV</a>    
                            <a id="statistics" class="list-group-item list-group-item-action " data-toggle="list" href="#">Request statistics</a>
                            <%}else {%>
                            <a id="statistics" class="list-group-item list-group-item-action " data-toggle="list" href="#">Request statistics</a>
                            <%}%>
                            <a id="password" class="list-group-item list-group-item-action " data-toggle="list" href="#">Change password</a>  

                            <a id="history" class="list-group-item list-group-item-action " data-toggle="list" href="#">Transaction history</a>                      
                            <a id="pay" class="list-group-item list-group-item-action " data-toggle="list" href="#">Pay</a>
                            <a id="wallet" class="list-group-item list-group-item-action " data-toggle="list" href="#">Wallet</a>           
                                         
                        </div>
      </div>
        <div class="col-md-9">
            <div class="tab-content">
                <h3>Cài đặt mật khẩu</h3>
              
                 <form class="card-body pb-2" action="setting" method="post"> 
              
 
                <div class="form-group">
                  <label class="form-label">Current password</label>
                  <input class="form-control" type="password" name="oldpass"  value="">
                </div>

                <div class="form-group">
                  <label class="form-label">New password</label>
                  <input class="form-control" type="password" required name="newPassword" placeholder="" maxlength="5000" autocomplete="false" value="">
                </div>

                <div class="form-group">
                  <label class="form-label">Repeat new password</label>
                  <input class="form-control" required type="password" name="confirmNewPassword" placeholder="" maxlength="5000" autocomplete="false" value="">
                </div>

              <hr>
                                    <button type="submit" class="form-group">Change Pass</button>
                     </form>
                <%if(request.getAttribute("error") != null) {%>
                            <span class="err-message"><%=(String)request.getAttribute("error")%></span>
                            <% } %>
            
            </div>
        </div>
      </div>
    </div>

    

  </div>
    
   <%@include file="footer.jsp" %>
    <!-- Footer End -->


    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
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



        </script>

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