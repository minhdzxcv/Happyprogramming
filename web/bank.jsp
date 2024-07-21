<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page import="model.Skill, java.util.ArrayList, model.User, java.text.SimpleDateFormat, model.Mentor, model.Mentee, model.MenteeStatistic, model.MentorStatistic, model.Bank" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <style>
        body {
            background: #f5f5f5;
            margin-top: 20px;
        }

        .ui-w-80 {
            width: 80px !important;
            height: auto;
        }

        .btn-default {
            border-color: rgba(24, 28, 33, 0.1);
            background: rgba(0, 0, 0, 0);
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
            border-color: rgba(0, 0, 0, 0);
            background: #3B5998;
            color: #fff;
        }

        .btn-instagram {
            border-color: rgba(0, 0, 0, 0);
            background: #000;
            color: #fff;
        }

        .card {
            background-clip: padding-box;
            box-shadow: 0 1px 4px rgba(24, 28, 33, 0.012);
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

        .account-settings-multiselect~.select2-container {
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
            border-color: rgba(24, 28, 33, 0.03) !important;
        }

        .withdraw-form label {
            font-weight: bold;
            margin-top: 15px;
        }

        .withdraw-form input,
        .withdraw-form select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }

        .withdraw-form button.btn-update {
            background-color: #26B4FF;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }

        .withdraw-form button.btn-update:hover {
            background-color: #1e90ff;
        }
    </style>

    <meta charset="utf-8">
    <title>Bank</title>
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

    <%@include file="header.jsp" %>

    <div class="container light-style flex-grow-1 container-p-y">
        <h4 class="font-weight-bold py-3 mb-4">TÀI KHOẢN</h4>

        <div class="card overflow-hidden">
            <div class="row no-gutters row-bordered row-border-light">
                <div class="col-md-3 pt-0">
                    <div class="list-group list-group-flush account-settings-links">
                        <a id="general" class="list-group-item list-group-item-action active" data-toggle="list" href="#account-general">General</a>
                        <% if (u.getRole().equalsIgnoreCase("mentor")) { %>
                            <a id="cv" class="list-group-item list-group-item-action" data-toggle="list" href="#">CV</a>
                            <a id="statistics" class="list-group-item list-group-item-action " data-toggle="list" href="#">Request statistics</a>
                        <% } else { %>
                            <a id="statistics" class="list-group-item list-group-item-action " data-toggle="list" href="#">Request statistics</a>
                        <% } %>
                        <a id="password" class="list-group-item list-group-item-action " data-toggle="list" href="#">Change password</a>
                        <a id="history" class="list-group-item list-group-item-action " data-toggle="list" href="#">Transaction history</a>
                        <a id="pay" class="list-group-item list-group-item-action " data-toggle="list" href="#">Pay</a>
                        <a id="wallet" class="list-group-item list-group-item-action " data-toggle="list" href="#">Wallet</a>
                    </div>
                </div>

                <div class="col-md-9">
                    <div class="container">
                         <%
                                Bank bank = (Bank)request.getAttribute("Bank");
                            %>
                        <h2>Cài đặt thanh toán</h2>
                        <form class="withdraw-form row" method="post">
                            <div class="col-md-6">
                                <label for="bankName">Cổng thanh toán:</label>
                                <select id="bankName" name="bankName" required>
                                    <option selected="" disabled="">--- Chọn ngân hàng ---</option>
                                        <option value="Vietcombank" <%=(bank != null && bank.getTypeBank().contains("Vietcombank")) ? "selected" : ""%>>Vietcombank</option>
                                        <option value="Vietinbank" <%=(bank != null && bank.getTypeBank().contains("Vietinbank")) ? "selected" : ""%>>Vietinbank</option>
                                        <option value="BIDV" <%=(bank != null && bank.getTypeBank().contains("BIDV")) ? "selected" : ""%>>BIDV</option>
                                        <option value="Sacombank" <%=(bank != null && bank.getTypeBank().contains("Sacombank")) ? "selected" : ""%>>Sacombank</option>
                                        <option value="Á Châu" <%=(bank != null && bank.getTypeBank().contains("Á Châu")) ? "selected" : ""%>>Á Châu</option>
                                        <option value="MBBank" <%=(bank != null && bank.getTypeBank().contains("MBBank")) ? "selected" : ""%>>MBBank</option>
                                        <option value="Techcombank" <%=(bank != null && bank.getTypeBank().contains("Techcombank")) ? "selected" : ""%>>Techcombank</option>
                                        <option value="DongA" <%=(bank != null && bank.getTypeBank().contains("DongA")) ? "selected" : ""%>>Đông Á</option>
                                        <option value="VP bank" <%=(bank != null && bank.getTypeBank().contains("VP bank")) ? "selected" : ""%>>VP bank</option>
                                        <option value="Eximbank" <%=(bank != null && bank.getTypeBank().contains("Eximbank")) ? "selected" : ""%>>Eximbank</option>
                                        <option value="TP bank" <%=(bank != null && bank.getTypeBank().contains("TP bank")) ? "selected" : ""%>>TP bank</option>
                                        <option value="Ocean bank" <%=(bank != null && bank.getTypeBank().contains("Ocean bank")) ? "selected" : ""%>>Ocean bank</option>
                                        <option value="OCB" <%=(bank != null && bank.getTypeBank().contains("OCB")) ? "selected" : ""%>>OCB</option>
                                        <option value="SHBank" <%=(bank != null && bank.getTypeBank().contains("SHBank")) ? "selected" : ""%>>SHBank</option>
                                    </select>
                                <label for="bankAccountName">Chủ tài khoản:</label>
                                <input style="text-align: left" type="text" name="bankAccountName" required placeholder="Ví dụ: NGUYEN VAN A" maxlength="100" autocomplete="false" value="<%=bank != null ? bank.getUserBank() : ""%>">
                                <label for="bankAccountNumber">Số tài khoản:</label>
                                 <input style="text-align: left" type="text" name="bankAccountNumber" required placeholder="Ví dụ: 0123456789" maxlength="100" autocomplete="false" value="<%=bank != null ? bank.getNoBank() : ""%>">
                                <button type="submit" class="btn-update">Cập nhật</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        let cog = document.querySelector('.fas.fa-cog').nextElementSibling;
        let collapse = cog.closest('.menu-item').querySelector('.submenu');

        document.querySelector('.fas.fa-cog').parentElement.onclick = function () {
            if (cog.classList.contains("fa-chevron-right")) {
                cog.classList.add("fa-chevron-down");
                cog.classList.remove("fa-chevron-right");
                collapse.style.display = "block";
            } else {
                cog.classList.remove("fa-chevron-down");
                cog.classList.add("fa-chevron-right");
                collapse.style.display = "none";
            }
        };

        function isValidUrl(string) {
            try {
                new URL(string);
                return true;
            } catch (err) {
                return false;
            }
        }

        let menuLinks = document.querySelectorAll('.menu__setting--last.panel.panel-default, .menu__setting--sub.panel.panel-default');

        menuLinks[0].onclick = function () {
            window.location.href = "email";
        };
        menuLinks[1].onclick = function () {
            window.location.href = "setting";
        };
        menuLinks[2].onclick = function () {
            window.location.href = "profile";
        };
        <% if (u.getRole().equalsIgnoreCase("mentor")) { %>
        menuLinks[3].onclick = function () {
            window.location.href = "cv";
        };
        menuLinks[4].onclick = function () {
            window.location.href = "statistic";
        };
        menuLinks[5].onclick = function () {
            window.location.href = "transaction";
        };
        menuLinks[6].onclick = function () {
            window.location.href = "bank";
        };
        menuLinks[7].onclick = function () {
            window.location.href = "wallet";
        };
        <% } else { %>
        menuLinks[3].onclick = function () {
            window.location.href = "statistic";
        };
        menuLinks[4].onclick = function () {
            window.location.href = "transaction";
        };
        menuLinks[5].onclick = function () {
            window.location.href = "bank";
        };
        menuLinks[6].onclick = function () {
            window.location.href = "wallet";
        };
        <% } %>
    </script>

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

</body>
</html>
