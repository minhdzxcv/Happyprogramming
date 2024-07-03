<%-- 
    Document   : profile
    Created on : Jan 17, 2024, 1:13:45 PM
    Author     : TGDD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Skill, java.util.ArrayList, model.User, java.text.SimpleDateFormat, model.Mentor, model.Mentee, model.MenteeStatistic, model.MentorStatistic, model.Bank, model.Transaction" %>
<!doctype html>
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
         <style>
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
</style>
<style>
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
    <style>
        .clearfix {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .pagination {
            display: flex;
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        .pagination .page-item {
            margin: 0 5px;
        }

        .pagination .page-link {
            text-decoration: none;
            color: black;
            padding: 5px 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        .pagination .page-item.disabled .page-link {
            pointer-events: none;
            opacity: 0.6;
        }

        .pagination .page-item.active .page-link {
            background-color: #007bff;
            color: white;
            border: 1px solid #007bff;
        }

        .hidden {
            display: none;
        }
         .modal-backdrop {
    background-color: rgba(0, 0, 0, 0.5);
}

.modal-dialog {
    max-width: 600px;
    margin: 30px auto;
}

.modal-content {
    border-radius: 8px;
    border: none;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.modal-header {
    background-color: #f5f5f5;
    border-bottom: 1px solid #ddd;
    border-top-left-radius: 8px;
    border-top-right-radius: 8px;
    padding: 15px;
}

.modal-title {
    margin: 0;
    font-size: 18px;
}

.close {
    color: #333;
    opacity: 0.6;
}

.close:hover {
    color: #000;
    opacity: 1;
}

.modal-body {
    padding: 20px;
}

.modal-footer {
    background-color: #f5f5f5;
    border-top: 1px solid #ddd;
    padding: 15px;
    border-bottom-left-radius: 8px;
    border-bottom-right-radius: 8px;
    text-align: right;
}

.btn {
    padding: 10px 20px;
    border-radius: 4px;
}

.btn-fill {
    background-color: #d9534f;
    color: #fff;
}

.btn-fill:hover {
    background-color: #c9302c;
    color: #fff;
}

.btn-default {
    background-color: #fff;
    color: #333;
    border: 1px solid #ccc;
}

.btn-default:hover {
    background-color: #e6e6e6;
    color: #333;
}

table {
    width: 100%;
}

td {
    padding: 10px;
}

input[type="text"], input[type="file"], select, textarea {
    width: 100%;
    padding: 8px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
}

textarea {
    height: 100px;
    resize: vertical;
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
        
            <%@include file="header.jsp" %>
            <%
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            %>
            
            
          
  <div class="container light-style flex-grow-1 container-p-y">
     
            <h4 class="font-weight-bold py-3 mb-4">TÀI KHOẢN</h4>

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
                            
                        
                 
                    <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12">
                        <div class="aside">
                        <h3>Your Transaction</h3>
                        <div class="transaction-table">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-condensed table-hover">
                                    <thead>
                                        <tr>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>STT</th>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Kiểu</th>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Số tiền</th>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Nội dung</th>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Thời gian</th>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Trạng thái</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%  ArrayList<Transaction> arr = (ArrayList)request.getAttribute("transactions");
                                            int p = (int) Math.ceil((double)arr.size() / 5);
                                            for(int i = 0; i < arr.size(); i++) {%>
                                             <script>
        var max = <%=p%>;
        var p = 1;
    </script>
                                        <tr id='<%=i+1%>' <%=(i >= 5? "class=\"hidden\"" : "")%>>
                                            <td>
                                                <%=i+1%>
                                            </td>
                                            <td style="font-weight: bold; <%=arr.get(i).getType().equalsIgnoreCase("+") ? "color: green;" : "color: red;"%>"><%=arr.get(i).getType()%></td>
                                            <td><%=arr.get(i).getPrice()%></td>
                                            <td>
                                                <%=arr.get(i).getContent()%>
                                            </td>
                                            <td><%=arr.get(i).getTime()%></td>
                                            <td style="<%=arr.get(i).getStatus().equalsIgnoreCase("success") ? "color: green;" : "color: red;"%>"><%=arr.get(i).getStatus()%></td>
                                        </tr> 
                                        <%}%>
                                    </tbody>
                           </table>
                        <% if(arr.size() == 0) {%><div class="text-center mt-20 col-md-12"><span>Không có dữ liệu</span></div><%}%>
                        <div class="clearfix">
                                    <div class="hint-text" >Showing <b id="from"><%=(arr.size() >= 5 ? 5 : arr.size())%></b> out of <b id="max"><%=arr.size()%></b> entries</div>
                                    <ul class="pagination" style="padding-left: 500px;">
                                        <li class="page-item disabled"><a onclick='paging(this, event)' href="" id='Previous' class="page-link">Previous</a></li>
                                            <%
                                                for(int i = 0; i < p; i++) {
                                            %>
                                        <li class="page-item <%=(i==0) ? "active" : ""%>"><a onclick='paging(this, event)' href='<%=i+1%>' class="page-link"><%=i+1%></a></li>
                                            <%}%>
                                        <li class="page-item <%=(p > 1) ? "" : "disabled"%>"><a id='Next' onclick='paging(this, event)' href="" class="page-link">Next</a></li>
                                        
                <script>
                
  function paging(input, event) {
                                                event.preventDefault();
                                                let str = JSON.stringify(input.href).replace("<%=request.getRequestURL().toString().replace(request.getRequestURI(), "")+request.getContextPath()+"/admin/"%>", "").replaceAll('"', '');
                                                if (input.innerHTML !== "Next" && input.innerHTML !== "Previous") {
                                                    if (parseInt(str) !== p) {
                                                        let checks = document.querySelectorAll("input[type=checkbox]");
                                                        for (var i = 0; i < checks.length; i++) {
                                                            checks[i].checked = false;
                                                        }
                                                        let f = document.getElementById("from");
                                                        let m = document.getElementById("max");
                                                        document.getElementsByClassName("page-item active")[0].classList.remove("active");
                                                        input.parentNode.classList.add("active");
                                                        for (var i = (p - 1) * 5 + 1; i <= (p * 5 > parseInt(m.innerHTML) ? parseInt(m.innerHTML) : p * 5); i++) {
                                                            document.getElementById(i).classList.add("hidden");
                                                        }
                                                        p = parseInt(str);
                                                        for (var i = (p - 1) * 5 + 1; i <= (p * 5 > parseInt(m.innerHTML) ? parseInt(m.innerHTML) : p * 5); i++) {
                                                            document.getElementById(i).classList.remove("hidden");
                                                        }
                                                        if (p === max) {
                                                            document.getElementById("Next").parentNode.classList.add("disabled");
                                                        } else {
                                                            document.getElementById("Next").parentNode.classList.remove("disabled");
                                                        }
                                                        if (p === 1) {
                                                            document.getElementById("Previous").parentNode.classList.add("disabled");
                                                        } else {
                                                            document.getElementById("Previous").parentNode.classList.remove("disabled");
                                                        }
                                                        f.innerHTML = (parseInt(m.innerHTML) >= p * 5 ? 5 : (parseInt(m.innerHTML) - (p - 1) * 5));
                                                    }
                                                } else {
                                                    if (input.innerHTML === "Previous" && p !== 1) {
                                                        let checks = document.querySelectorAll("input[type=checkbox]");
                                                        for (var i = 0; i < checks.length; i++) {
                                                            checks[i].checked = false;
                                                        }
                                                        let f = document.getElementById("from");
                                                        let m = document.getElementById("max");
                                                        document.getElementsByClassName("page-item active")[0].classList.remove("active");
                                                        document.getElementsByClassName("pagination")[0].children[p - 1].classList.add("active");
                                                        for (var i = (p - 1) * 5 + 1; i <= (p * 5 > parseInt(m.innerHTML) ? parseInt(m.innerHTML) : p * 5); i++) {
                                                            document.getElementById(i).classList.add("hidden");
                                                        }
                                                        p = p - 1;
                                                        for (var i = (p - 1) * 5 + 1; i <= (p * 5 > parseInt(m.innerHTML) ? parseInt(m.innerHTML) : p * 5); i++) {
                                                            document.getElementById(i).classList.remove("hidden");
                                                        }
                                                        if (p === max) {
                                                            document.getElementById("Next").parentNode.classList.add("disabled");
                                                        } else {
                                                            document.getElementById("Next").parentNode.classList.remove("disabled");
                                                        }
                                                        if (p === 1) {
                                                            document.getElementById("Previous").parentNode.classList.add("disabled");
                                                        } else {
                                                            document.getElementById("Previous").parentNode.classList.remove("disabled");
                                                        }
                                                        f.innerHTML = (parseInt(m.innerHTML) >= p * 5 ? 5 : (parseInt(m.innerHTML) - (p - 1) * 5));
                                                    } else if (input.innerHTML === "Next" && p !== max) {
                                                        let checks = document.querySelectorAll("input[type=checkbox]");
                                                        for (var i = 0; i < checks.length; i++) {
                                                            checks[i].checked = false;
                                                        }
                                                        let f = document.getElementById("from");
                                                        let m = document.getElementById("max");
                                                        document.getElementsByClassName("page-item active")[0].classList.remove("active");
                                                        document.getElementsByClassName("pagination")[0].children[p + 1].classList.add("active");
                                                        for (var i = (p - 1) * 5 + 1; i <= (p * 5 > parseInt(m.innerHTML) ? parseInt(m.innerHTML) : p * 5); i++) {
                                                            document.getElementById(i).classList.add("hidden");
                                                        }
                                                        p = p + 1;
                                                        for (var i = (p - 1) * 5 + 1; i <= (p * 5 > parseInt(m.innerHTML) ? parseInt(m.innerHTML) : p * 5); i++) {
                                                            document.getElementById(i).classList.remove("hidden");
                                                        }
                                                        if (p === max) {
                                                            document.getElementById("Next").parentNode.classList.add("disabled");
                                                        } else {
                                                            document.getElementById("Next").parentNode.classList.remove("disabled");
                                                        }
                                                        if (p === 1) {
                                                            document.getElementById("Previous").parentNode.classList.add("disabled");
                                                        } else {
                                                            document.getElementById("Previous").parentNode.classList.remove("disabled");
                                                        }
                                                        f.innerHTML = (parseInt(m.innerHTML) >= p * 5 ? 5 : (parseInt(m.innerHTML) - (p - 1) * 5));
                                                    }
                                                }
                                            }
                </script>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
  </div>                      
                                                
                                                
            
        
        <script>

            let cog = document.getElementsByClassName('fas fa-cog')[0].parentNode.children[1];
            let collapse = cog.parentNode.parentNode.parentNode.parentNode.children[1];
            document.getElementsByClassName('fas fa-cog')[0].parentNode.onclick = function () {
                if (cog.classList.contains("fa-chevron-right")) {
                    cog.classList.add("fa-chevron-down");
                    cog.classList.remove("fa-chevron-right");
                    collapse.classList.remove("collapse");
                    collapse.classList.add("collapsing");
                    setTimeout(function () {
                        collapse.style = "height: 72px;";
                    }, 1);
                    setTimeout(function () {
                        collapse.classList.remove("collapsing");
                        collapse.classList.add("collapse");
                        collapse.style = "";
                        collapse.classList.add("in");
                    }, 300);
                } else {
                    cog.classList.remove("fa-chevron-down");
                    cog.classList.add("fa-chevron-right");
                    collapse.style = "height: 72px;";
                    collapse.classList.remove("collapse");
                    collapse.classList.add("collapsing");
                    setTimeout(function () {
                        collapse.style = "height: 0px;";
                    }, 1);
                    setTimeout(function () {
                        collapse.classList.remove("collapsing");
                        collapse.classList.add("collapse");
                        collapse.style = "height: 0px;";
                        collapse.classList.remove("in");
                    }, 300);
                }
            }
            function isValidUrl(string) {
                try {
                    new URL(string);
                    return true;
                } catch (err) {
                    return false;
                }
            }

        </script>
        
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
    passwordLink.addEventListener('click', function() {
        window.location.href = 'setting';
    });
    
    statisticsLink.addEventListener('click', function() {
        window.location.href = 'statistics';
    });

    historyLink.addEventListener('click', function() {
        window.location.href = 'transaction';
    });

    payLink.addEventListener('click', function() {
        window.location.href = 'bank';
    });

    walletLink.addEventListener('click', function() {
        window.location.href = 'wallet';
    });
    
    cvLink.addEventListener('click', function() {
        window.location.href = 'cv';
    });
    generalLink.addEventListener('click', function() {
        window.location.href = 'profile';
    });
       
    
    
</script>
    </body>
</html>
