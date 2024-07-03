<%-- 
    Document   : wallet
    Created on : Jun 8, 2024, 3:55:43 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Skill, java.util.ArrayList, model.User, java.text.SimpleDateFormat, model.Mentor, model.Mentee, model.MenteeStatistic, model.MentorStatistic, model.Bank" %>

<!DOCTYPE html>
<html lang="en">

<head>
     <style>
        .modal-backdrop {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1040;
        }
        .modal {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1050;
            width: 90%;
            max-width: 500px;
            background-color: white;
            box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5);
            border-radius: 5px;
        }
        .modal-header, .modal-body, .modal-footer {
            padding: 15px;
        }
        .modal-header {
            border-bottom: 1px solid #e5e5e5;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .modal-title {
            margin: 0;
        }
        .close {
            cursor: pointer;
            background: none;
            border: none;
            font-size: 1.5rem;
        }
        .modal-footer {
            border-top: 1px solid #e5e5e5;
            text-align: right;
        }
        
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-success {
            background-color: #28a745;
            color: white;
        }
        .option {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }
        .option img {
            width: 40px;
            height: 40px;
            margin-right: 10px;
        }
        .option-title {
            display: flex;
            flex-direction: column;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
        }
    </style>
     <style>
         
         
         .wallet-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        

        .wallet-card label {
            font-weight: bold;
            color: #333;
        }

        .wallet-card .balance {
            font-size: 2em;
            color: #ff4e42;
        }

        .wallet-card .btn {
            font-size: 1em;
            font-weight: bold;
            color: #ff4e42;
            display: inline-flex;
            align-items: center;
            border: none;
            background: none;
            cursor: pointer;
        }

        .wallet-card .btn i {
            margin-right: 5px;
        }
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
                            Bank bank = (Bank) request.getAttribute("Bank");
                            if (bank == null) {
                        %>
                        <h3>Bạn Cần Tạo Ví Trong Mục Thanh Toán Trước</h3>
                        <% } else { %>
                        <h3>Ví</h3>
                        <div class="wallet-card">
                            <div>
                                <label>Số dư hiện tại</label>
                                <div class="balance"><%= u.getWallet() %> đ</div>
                            </div>
                             <div>
                                <button type="button" id="a" class="btn">
                                    <i class="fas fa-wallet"></i> Nạp thêm
                                </button>
                                <button type="button" id="withdraw" class="btn">
                                    <i class="fas fa-money-bill-alt"></i> Rút tiền
                                </button>
                            </div>
                        </div>

                        </div>
                            </div>
                    </div>
                </div>
            </div>
                                   
<!--                           <script>  document.getElementById("a").onclick = function () {
                             event.preventDefault();
                                    if (!JSON.stringify(document.body.style).includes("overflow: hidden;")) {
                                        let pre = document.body.style.cssText;
                                        document.body.style = 'overflow: hidden; padding-right: 17px; ' + pre;
                                        //document.body.style = 'background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                                        let modal = document.createElement('div');
                                        modal.innerHTML = '<div role="dialog" aria-hidden="true">\n\
<div class="fade modal-backdrop"></div>\n\
<div role="dialog" tabindex="-1" class="fade recharge-modal modal" style="display: block;">\n\
<div class="modal-dialog">\n\
<div class="modal-content" role="document">\n\
<div class="modal-header">\n\
  <button type="button" class="close">\n\
    <span aria-hidden="true">×</span>\n\
    <span class="sr-only">Close</span>\n\
  </button>\n\
  <h4 class="modal-title">\n\
    <span>Nạp Tiền</span>\n\
  </h4>\n\
</div>\n\
  <div class="modal-body">\n\
<div id="accordion-controlled-example" role="tablist" class="panel-group">\n\
  <div class="panel panel-default">\n\
    <div role="tab" id="accordion-controlled-example-heading-3" class="panel-heading">\n\
      <div class="panel-title">\n\
        <a aria-expanded="false" class="collapsed" aria-controls="accordion-controlled-example-body-3" role="button" href="#">\n\
          <div class="option">\n\
            <img src="https://files.playerduo.net/production/static-files/icon/atm-card.png" alt="PD" class="option-icon img-rounded">\n\
            <div class="option-title">\n\
              <p>\n\
                <span>Thanh toán trực tiếp thẻ quốc tế</span>.\n\
              </p>\n\
              <p>\n\
                <span>Nạp qua mastercard/visa</span>\n\
              </p>\n\
            </div>\n\
          </div>\n\
        </a>\n\
      </div>\n\
    </div>\n\
    <div class="panel-collapse collapse" id="accordion-controlled-example-body-1" role="tabpanel" aria-labelledby="accordion-controlled-example-heading-1006" aria-expanded="false">\n\
      <div class="option-content panel-body">\n\
        <div>\n\
          <div class="form-recharge row">\n\
            <div class="col-xs-12">\n\
              <form method="post">\n\
                <div class="fieldGroup ">\n\
                  <input type="hidden" name="type" value="INTCARD">\n\
                  <input type="text" name="amount" placeholder="Số tiền muốn nạp (VND)" maxlength="5000" autocomplete="false" value="">\n\
                </div>\n\
                <p class="text-center">\n\
                  <button type="submit" class="btn btn-success">\n\
                    <span>Nạp tiền</span>\n\
                  </button>\n\
                </p>\n\
              </form>\n\
            </div>\n\
          </div>\n\
        </div>\n\
      </div>\n\
    </div>\n\
  </div>\n\
  <div class="panel panel-default">\n\
    <div role="tab" id="accordion-controlled-example-heading-1006" class="panel-heading">\n\
      <div class="panel-title">\n\
        <a aria-expanded="false" class="collapsed" aria-controls="accordion-controlled-example-body-1006" role="button" href="#">\n\
          <div class="option">\n\
            <img src="https://files.playerduo.net/production/static-files/icon/qr_code.png" alt="PD" class="option-icon img-rounded">\n\
            <div class="option-title">\n\
              <p>\n\
                <span>Thanh toán trực tiếp qua QR Code</span>\n\
              </p>\n\
              <p>\n\
                <span>Quét mã QR thông qua VNPAY</span>\n\
              </p>\n\
            </div>\n\
          </div>\n\
        </a>\n\
      </div>\n\
    </div>\n\
    <div class="panel-collapse collapse" id="accordion-controlled-example-body-2" role="tabpanel" aria-labelledby="accordion-controlled-example-heading-1006" aria-expanded="false">\n\
      <div class="option-content panel-body">\n\
        <div>\n\
          <div class="form-recharge row">\n\
            <div class="col-xs-12">\n\
              <form method="post">\n\
                <div class="fieldGroup ">\n\
                  <input type="hidden" name="type" value="">\n\
                  <input type="text" name="amount" placeholder="Số tiền muốn nạp (VND)" maxlength="5000" autocomplete="false" value="">\n\
                </div>\n\
                <p class="text-center">\n\
                  <button type="submit" class="btn btn-success">\n\
                    <span>Nạp tiền</span>\n\
                  </button>\n\
                </p>\n\
              </form>\n\
            </div>\n\
          </div>\n\
        </div>\n\
      </div>\n\
    </div>\n\
  </div>\n\
  <div class="panel panel-default">\n\
    <div role="tab" id="accordion-controlled-example-heading-7" class="panel-heading">\n\
      <div class="panel-title">\n\
        <a aria-expanded="false" class="collapsed" aria-controls="accordion-controlled-example-body-7" role="button" href="#">\n\
          <div class="option">\n\
            <img src="https://files.playerduo.net/production/static-files/icon/atm-card.png" alt="PD" class="option-icon img-rounded">\n\
            <div class="option-title">\n\
              <p>\n\
                <span>Nạp tiền qua thẻ ATM nội địa</span>\n\
              </p>\n\
              <p>\n\
                <span>Nạp thông qua thẻ nội địa</span>\n\
              </p>\n\
            </div>\n\
          </div>\n\
        </a>\n\
      </div>\n\
    </div>\n\
    <div class="panel-collapse collapse" id="accordion-controlled-example-body-3" role="tabpanel" aria-labelledby="accordion-controlled-example-heading-1006" aria-expanded="false">\n\
      <div class="option-content panel-body">\n\
        <div>\n\
          <div class="form-recharge row">\n\
            <div class="col-xs-12">\n\
              <form method="post">\n\
                <div class="fieldGroup ">\n\
                  <input type="hidden" name="type" value="VNBANK">\n\
                  <input type="text" name="amount" placeholder="Số tiền muốn nạp (VND)" maxlength="5000" autocomplete="false" value="">\n\
                </div>\n\
                <p class="text-center">\n\
                  <button type="submit" class="btn btn-success">\n\
                    <span>Nạp tiền</span>\n\
                  </button>\n\
                </p>\n\
              </form>\n\
            </div>\n\
          </div>\n\
        </div>\n\
      </div>\n\
    </div>\n\
  </div>\n\
</div>\n\
  </div>\n\
  <div class="modal-footer">\n\
    <button type="button" class="btn btn-default">\n\
      <span>Đóng</span>\n\
    </button>\n\
  </div>\n\
</div>\n\
</div>\n\
</div>\n\
</div>';
                                        document.body.appendChild(modal.firstChild);
                                        
                                        
                                        let parentDiv = document.getElementById('accordion-controlled-example');
                                        parentDiv.children[0].children[0].onclick = function() {
                                            let curr = document.getElementById('accordion-controlled-example-body-1');
                                            if(!curr.classList.contains("in")) {
                                               curr.classList.remove("collapse");
                                                curr.classList.add("collapsing");
                                                setTimeout(function() {
                                                    curr.style = "height: 130px;";
                                                }, 1);
                                                setTimeout(function() {
                                                    curr.classList.remove("collapsing");
                                                    curr.classList.add("collapse");
                                                    curr.classList.add("in");
                                                    curr.style = "";
                                                }, 500);
                                            } else {
                                                curr.classList.remove("collapse");
                                                curr.classList.remove("in");
                                                curr.classList.add("collapsing");
                                                curr.style = "height: 130px;";
                                                setTimeout(function() {
                                                    curr.style = "height: 0px;";
                                                }, 1);
                                                setTimeout(function() {
                                                    curr.classList.remove("collapsing");
                                                    curr.classList.add("collapse");
                                                }, 500);
                                            }
                                        }
                                        
                                        parentDiv.children[1].children[0].onclick = function() {
                                            let curr = document.getElementById('accordion-controlled-example-body-2');
                                            if(!curr.classList.contains("in")) {
                                               curr.classList.remove("collapse");
                                                curr.classList.add("collapsing");
                                                setTimeout(function() {
                                                    curr.style = "height: 130px;";
                                                }, 1);
                                                setTimeout(function() {
                                                    curr.classList.remove("collapsing");
                                                    curr.classList.add("collapse");
                                                    curr.classList.add("in");
                                                    curr.style = "";
                                                }, 500);
                                            } else {
                                                curr.classList.remove("collapse");
                                                curr.classList.remove("in");
                                                curr.classList.add("collapsing");
                                                curr.style = "height: 130px;";
                                                setTimeout(function() {
                                                    curr.style = "height: 0px;";
                                                }, 1);
                                                setTimeout(function() {
                                                    curr.classList.remove("collapsing");
                                                    curr.classList.add("collapse");
                                                }, 500);
                                            }
                                        }
                                        
                                        parentDiv.children[2].children[0].onclick = function() {
                                            let curr = document.getElementById('accordion-controlled-example-body-3');
                                            if(!curr.classList.contains("in")) {
                                               curr.classList.remove("collapse");
                                                curr.classList.add("collapsing");
                                                setTimeout(function() {
                                                    curr.style = "height: 130px;";
                                                }, 1);
                                                setTimeout(function() {
                                                    curr.classList.remove("collapsing");
                                                    curr.classList.add("collapse");
                                                    curr.classList.add("in");
                                                    curr.style = "";
                                                }, 500);
                                            } else {
                                                curr.classList.remove("collapse");
                                                curr.classList.remove("in");
                                                curr.classList.add("collapsing");
                                                curr.style = "height: 130px;";
                                                setTimeout(function() {
                                                    curr.style = "height: 0px;";
                                                }, 1);
                                                setTimeout(function() {
                                                    curr.classList.remove("collapsing");
                                                    curr.classList.add("collapse");
                                                }, 500);
                                            }
                                        }
                                        
                                        let btn = document.body.lastChild.getElementsByTagName('button');
                                        btn[0].onclick = function () {
                                            document.body.lastChild.children[0].classList.remove("in");
                                            document.body.lastChild.children[1].classList.remove("in");
                                            setTimeout(function () {
                                                document.body.style = (document.body.style.cssText).replace('overflow: hidden; padding-right: 17px; ', '');
                                                document.body.removeChild(document.body.lastChild);
                                                window.onclick = null;
                                            }, 100);

                                        }
                                        btn[4].onclick = function () {
                                            document.body.lastChild.children[0].classList.remove("in");
                                            document.body.lastChild.children[1].classList.remove("in");
                                            setTimeout(function () {
                                                document.body.style = (document.body.style.cssText).replace('overflow: hidden; padding-right: 17px; ', '');
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
                                                        document.body.style = (document.body.style.cssText).replace('overflow: hidden; padding-right: 17px; ', '');
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
                                            document.body.style = (document.body.style.cssText).replace('overflow: hidden; padding-right: 17px; ', '');
                                            document.body.removeChild(document.body.lastChild);
                                            window.onclick = null;
                                        }, 100);
                                    }
                                }
                                
                                document.getElementById("withdraw").onclick = function () {
                                    event.preventDefault();
                                    if (!JSON.stringify(document.body.style).includes("overflow: hidden;")) {
                                        let pre = document.body.style.cssText;
                                        document.body.style = 'overflow: hidden; padding-right: 17px; ' + pre;
                                        //document.body.style = 'background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                                        let modal = document.createElement('div');
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
    <span>Rút Tiền</span>\n\
  </h4>\n\
</div>\n\
<form class="withdraw" method="post">\n\
  <div class="modal-body">\n\
  <div class="fieldGroup "><input type="hidden" name="type" value="withdraw"><p class="control-label">Cổng thanh toán</p><input type="text" name="bankName" placeholder="" disabled="" maxlength="5000" autocomplete="false" value="<%=bank.getTypeBank()%>" style="width: 100%; font-size: 18px; text-align: left; height: 54px; padding: 16px 17px; border: 1px solid #e6eeee; color: #354052; border-radius: 5px;"></div><div class="fieldGroup "><p class="control-label">Chủ tài khoản</p><input type="text" name="bankAccountName" placeholder="" disabled="" maxlength="5000" autocomplete="false" value="<%=bank.getUserBank()%>"  style="width: 100%; font-size: 18px; text-align: left; height: 54px; padding: 16px 17px; border: 1px solid #e6eeee; color: #354052; border-radius: 5px;"></div><div class="fieldGroup "><p class="control-label">Số tài khoản:</p><input type="text" name="bankAccountNumber" placeholder="" disabled="" maxlength="5000" autocomplete="false" value="<%=bank.getNoBank()%>"  style="width: 100%; font-size: 18px; text-align: left; height: 54px; padding: 16px 17px; border: 1px solid #e6eeee; color: #354052; border-radius: 5px;"></div><div class="fieldGroup "><p class="control-label">Số tiền có thể rút</p><input type="text" name="totalMoney" placeholder="" disabled="" maxlength="5000" autocomplete="false" value="<%=u.getWallet()%> VNĐ"  style="width: 100%; font-size: 18px; text-align: left; height: 54px; padding: 16px 17px; border: 1px solid #e6eeee; color: #354052; border-radius: 5px;"></div><div class="fieldGroup "><p class="control-label">Bạn muốn rút</p><input type="number" name="amount" placeholder="" min="1000" value=""  style="width: 100%; font-size: 18px; text-align: left; height: 54px; padding: 16px 17px; border: 1px solid #e6eeee; color: #354052; border-radius: 5px;"></div><br>\n\
  </div>\n\
  <div class="modal-footer">\n\
    <button type="submit" class="btn-update btn btn-default">\n\
      <span>Rút Tiền</span>\n\
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
                                        document.body.appendChild(modal.firstChild);
                                        let btn = document.body.lastChild.getElementsByTagName('button');
                                        
                                        btn[1].onclick = function (e) {
                                            e.preventDefault();
                                            if(document.getElementsByName("amount")[0].value > <%=u.getWallet()%>) {
                                                alert("Bạn chỉ có thể rút tối đa <%=u.getWallet()%>VND");
                                            } else {
                                                btn[1].form.submit();
                                            }
                                        }
                                        btn[0].onclick = function () {
                                            document.body.lastChild.children[0].classList.remove("in");
                                            document.body.lastChild.children[1].classList.remove("in");
                                            setTimeout(function () {
                                                document.body.style = (document.body.style.cssText).replace('overflow: hidden; padding-right: 17px; ', '');
                                                document.body.removeChild(document.body.lastChild);
                                                window.onclick = null;
                                            }, 100);

                                        }
                                        btn[2].onclick = function () {
                                            document.body.lastChild.children[0].classList.remove("in");
                                            document.body.lastChild.children[1].classList.remove("in");
                                            setTimeout(function () {
                                                document.body.style = (document.body.style.cssText).replace('overflow: hidden; padding-right: 17px; ', '');
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
                                                        document.body.style = (document.body.style.cssText).replace('overflow: hidden; padding-right: 17px; ', '');
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
                                            document.body.style = (document.body.style.cssText).replace('overflow: hidden; padding-right: 17px; ', '');
                                            document.body.removeChild(document.body.lastChild);
                                            window.onclick = null;
                                        }, 100);
                                    }
                                }
                            </script>
    -->

                            <%
                                }
                            %>
    
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
 <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>
</html>

