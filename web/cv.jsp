<%-- 
    Document   : cv
    Created on : May 21, 2024, 12:55:20 PM
    Author     : ADMIN
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Skill, java.util.ArrayList, model.User, java.text.SimpleDateFormat, model.Mentor, model.Mentee, model.CV, DAO.CvDAO" %>


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
        <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css'>
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
            ArrayList<Skill> skills = (ArrayList<Skill>)request.getAttribute("skills");
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
            CV cv = null;   
            Mentor m = (Mentor)session.getAttribute("Mentor");
            if(m.getCvID() != 0) {
                cv = CvDAO.getCV(m.getCvID());
            }
        %>

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
                            <a class="list-group-item list-group-item-action" data-toggle="list" href="#account-notifications">Notifications</a>                  
                        </div>
                    </div>
                    <div class="col-md-9">
                        <div class="tab-content">
                            <!-- General -->

                            <!-- Change password -->

                            <div class="container">
                                <div class="main-body">
                                    <div class="row">
                                        <div class="col-lg-4">
                                            <div class="card">
                                                <div class="card-body">
                                                    <hr>
                                                    <div class="d-flex flex-column align-items-center text-center">
                                                        <img src="<%=u.getAvatar() == null ? "https://files.playerduo.net/production/images/avatar31.png" : u.getAvatar() %>" alt="Admin" class="rounded-circle p-1 bg-primary" width="110">
                                                        <div class="mt-3">
                                                            <h4><%=u.getFullname()%></h4>
                                                            <p class="text-secondary mb-1"><%=u.getPhone()%></p>
                                                            <p class="text-secondary mb-1"><%=u.getEmail()%></p>
                                                            <p class="text-muted font-size-sm"><%=u.getAddress()%></p>

                                                        </div>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-lg-8">
                                            <div class="card">
                                                <hr>
                                                <h3>Thông tin cơ bản</h3>

                                                <form  method="post">
                                                    <div class="card-body">
                                                        <div class="row mb-3">
                                                            <div class="col-sm-3">
                                                                <h6 class="mb-0">Mô tả:</h6>
                                                            </div>
                                                            <div class="col-sm-9 text-secondary">
                                                                <input class="form-control"type="text" name="description" placeholder="" maxlength="5000" autocomplete="false" value="<%=(m == null || m.getDescription() == null) ? "" : m.getDescription()%>">
                                                            </div>
                                                        </div>
                                                        <div class="row mb-3">
                                                            <div class="col-sm-3">
                                                                <h6 class="mb-0">Thành tựu:</h6>
                                                            </div>
                                                            <div class="col-sm-9 text-secondary">
                                                                <input class="form-control"type="text" name="achivement" placeholder="" maxlength="5000" autocomplete="false" value="<%=(m == null || m.getAchivement() == null) ? "" : m.getAchivement()%>">
                                                            </div>
                                                        </div>
                                                        <div class="row mb-3">
                                                            <button class="form-control"type="submit" class="btn-update">Update</button>                                                            
                                                        </div>
                                                        <div class="row mb-3">
                                                            <button class="form-control"type="reset" class="btn-update">Cancel</button>                                                            
                                                        </div>

                                                    </div>
                                                </form>        
                                            </div>
                                            <div class="row">

                                                <div class="col-sm-12">

                                                    <div class="card">
                                                        <hr>
                                                        <h3>Thông tin CV</h3>
<%if(cv == null) {%> <p class="control-label">Chưa có CV</p><%} 
                                                    if(cv != null) {%> 
                                                        <form  method="post">
                                                            <input type="hidden" name="type" value="update">
                                                            <div class="card-body">
                                                                <div class="row mb-3">
                                                                    <div class="col-sm-3">
                                                                        <h6 class="mb-0">Profession Introduction:</h6>
                                                                    </div>
                                                                    <div class="col-sm-9 text-secondary">
                                                                        <input class="form-control" type="text" name="profession" placeholder="" required maxlength="255" autocomplete="false" value="<%=cv.getProfessionIntro() == null ? "" : cv.getProfessionIntro()%>">
                                                                    </div>
                                                                </div>
                                                                <div class="row mb-3">
                                                                    <div class="col-sm-3">
                                                                        <h6 class="mb-0">Description:</h6>
                                                                    </div>
                                                                    <div class="col-sm-9 text-secondary">
                                                                        <input class="form-control"type="text" name="descrip" placeholder="" required maxlength="255" autocomplete="false" value="<%=cv.getDescription() == null ? "" : cv.getDescription()%>">
                                                                    </div>
                                                                </div>
                                                                <div class="row mb-3">
                                                                    <div class="col-sm-3">
                                                                        <h6 class="mb-0">Giá thuê mỗi slots:</h6>
                                                                    </div>
                                                                    <div class="col-sm-9 text-secondary">
                                                                        <input class="form-control"type="number" name="MoneyOfSlot" min="1" required value="<%=cv.getMoneyofslot()%>">
                                                                    </div>
                                                                </div>
                                                                <div class="row mb-3">
                                                                    <div class="col-sm-3">
                                                                        <h6 class="mb-0">Skills:</h6>
                                                                    </div>
                                                                    <div class="col-sm-9 text-secondary">
                                                                       <%for(int i = 0; i < cv.getSkills().size(); i++) {%>
                                                    <div class="choose-game" title="Nhấn để xóa skill" onclick="deleteSkill(<%=cv.getSkills().get(i).getId()%>)" style="background:  center center no-repeat;margin: 0 8px 6px 0;border-radius: 10px;float: left;min-width: 100px;text-align: center;">
                                                        <p class="overlay" style="text-shadow: 2px 0 0 #000;margin: 0;padding: 13px 16px;color: #fff;font-weight: 700;font-size: 13px;background: rgba(0,0,0,.75);border-radius: 10px;text-transform: capitalize;"><%=cv.getSkills().get(i).getName()%> </p>
                                                    </div><%}%>
                                                                    </div>
                                                                    <div class="col-sm-9 text-secondary">
                                                                       <select style="margin-bottom: 0px;" onchange="if (this.selectedIndex)
                                                                changeSelection(this);">
                                                        <option selected disable>Thêm skill mới</option><%for(int i = 0; i < skills.size(); i++) {%> <option value="<%=skills.get(i).getId()%>"><%=skills.get(i).getName()%> </option><%}%>
                                                    </select>
                                                                    </div>
                                                                </div>
                                                                
                                                                <%}%> 
                                                                <div class="row mb-3">
                                                                   <button class="form-control"type="submit" class="btn-update" id="<%=(m == null || m.getCvID() == 0) ? "createCV" : "updateCV"%>"><%=(m == null || m.getCvID() == 0) ? "createCV" : "updateCV"%> </button><%=cv != null ? "</form>" : ""%>
                                                                </div>
                                                                <div class="row mb-3">
                                                                    <button class="form-control"type="reset" class="btn-update">Cancel</button>                                                            
                                                                </div>

                                                            </div>
                                                        </form>  
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    
<%@include file="footer.jsp" %>
        <!-- Notifications -->

        <script>
            function deleteSkill(id) {
            <%if(cv != null && cv.getSkills().size() > 1) {%>
                let param = "type=delete&id=" + id;
                fetch("cv",
                        {
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded'
                            },
                            method: "POST",
                            body: param
                        })
                setTimeout(function () {
                    window.location.reload();
                }, 100);
            <%} else {%>
                alert('Bạn phải có ít nhất 1 skill!');
            <%}%>
            }
            function changeSelection(select) {
                let param = "type=add&id=" + select.value;
                fetch("cv",
                        {
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded'
                            },
                            method: "POST",
                            body: param
                        })
                setTimeout(function () {
                    window.location.reload();
                }, 100);
                //console.log(select.value);
            }
            if (document.getElementById('createCV') != null) {
                document.getElementById('createCV').onclick = function () {
                    if (!JSON.stringify(document.body.style).includes("overflow: hidden;")) {
                        document.body.style = 'overflow: hidden; padding-right: 17px; background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                        //document.body.style = 'background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                        let modal = document.createElement('div');
                modal.innerHTML = '<div role="dialog"><div class="fade modal-backdrop"></div><div role="dialog" tabindex="-1" class="fade modal" style="display: block;"><div class="auth-modal modal-dialog"><div class="modal-content" role="document"><div class="modal-body"><div class="logo"><img alt="logo playerduo" style="border-radius: 20%;" src="images/logo.png"><h1>Happy Programming</h1></div><div class="content-main"><form method="post"><div class="fieldGroup "><input type="text" name="profession" placeholder="Profession Introduction" maxlength="255" autocomplete="false" required value=""></div><div class="fieldGroup "><input type="text" name="service" placeholder="Service Description" required maxlength="255" autocomplete="false" value=""></div><div class="fieldGroup" style="text-align: center;"><span>Chọn kĩ năng bạn dạy:</span></div><div style="margin: 10px 0 0;" class="fieldGroup"><select name="skills" style="height: 100px" required multiple><%for(int i = 0; i < skills.size(); i++) {%><option value="<%=skills.get(i).getId()%>"><%=skills.get(i).getName()%></option><%}%></select></div><div class="fieldGroup" style="text-align: center;"><input type="number" name="cash" step="1" min="1" placeholder="Giá Thuê Trên Slot"></div><button type="submit"><span>Tạo CV</span></button><input type="hidden" name="type" value="create"></form></div></div></div></div></div></div>';
                        document.body.appendChild(modal.firstChild);
                        setTimeout(function () {
                            document.body.lastChild.children[1].classList.add("in");
                            document.body.lastChild.firstChild.classList.add("in");
                            window.onclick = function (e) {
                                if (!document.getElementsByClassName('modal-content')[0].contains(e.target)) {
                                    document.body.lastChild.firstChild.classList.remove("in");
                                    document.body.lastChild.children[1].classList.remove("in");
                                    setTimeout(function () {
                                        document.body.style = 'background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                                        document.body.removeChild(document.body.lastChild);
                                        window.onclick = null;
                                    }, 100)
                                }
                            }
                        }, 1)
                    } else {
                        //document.body.style = 'overflow: hidden; padding-right: 17px; background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                        document.body.lastChild.children[1].classList.remove("in");
                        document.body.lastChild.firstChild.classList.remove("in");
                        setTimeout(function () {
                            document.body.style = 'background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                            document.body.removeChild(document.body.lastChild);
                            window.onclick = null;
                        }, 100)
                    }
                }
            } 
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
                window.location.href = 'statistic';
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


        <script src='https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js'></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>

    </body>

</html>
