<%-- 
    Document   : skill
    Created on : May 21, 2024, 4:27:52 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="model.Skill, java.util.ArrayList, model.User, model.Mentor, model.Mentee, model.Request, java.sql.Timestamp, DAO.MentorDAO, DAO.CvDAO, model.CV, DAO.SkillDAO, java.text.SimpleDateFormat, model.MentorDetail, java.util.HashMap" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

    <!-- Libraries Stylesheet -->
    <link href="lib/animate/animate.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="assets/vendor/animate.css/animate.min.css" rel="stylesheet">
    <link href="assets/vendor/aos/aos.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/8.97b85fe3.chunk.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
    <style>
        body {
            background: white;
        }

        .card {
            box-shadow: 0 20px 27px 0 rgb(0 0 0 / 5%);
        }

        header {
            margin-bottom: 50px;
        }

        .avatar.sm {
            width: 2.25rem;
            height: 2.25rem;
            font-size: .818125rem;
        }

        .table-nowrap .table td,
        .table-nowrap .table th {
            white-space: nowrap;
        }

        .table>:not(caption)>*>* {
            padding: 0.75rem 1.25rem;
            border-bottom-width: 1px;
        }

        table th {
            font-weight: 600;
            background-color: #eeecfd !important;
        }

        .fa-arrow-up {
            color: #00CED1;
        }

        .fa-arrow-down {
            color: #FF00FF;
        }

        .table td {
            max-width: 200px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .table td img {
            max-width: 100px;
            max-height: 100px;
        }

        .table td.description {
            max-width: 300px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: normal; /* Allow text wrapping */
        }
    </style>
</head>

<body>
    <%
        ArrayList<Skill> arr = (ArrayList) request.getAttribute("skills");
        int itemsPerPage = 10;
        int pageNum = 1;
        if (request.getParameter("page") != null) {
            pageNum = Integer.parseInt(request.getParameter("page"));
        }
        int start = (pageNum - 1) * itemsPerPage;
        int end = Math.min(start + itemsPerPage, arr.size());
        int totalPages = (int) Math.ceil((double) arr.size() / itemsPerPage);
    %>
    <div class="row">
        <%@ include file="header.jsp" %>
   

    <div class="container">
        <div class="row">
            <div class="col-12 mb-3 mb-lg-5">
                <div class="position-relative card table-nowrap table-card">
                    <div class="card-header align-items-center">
                        <h5 class="mb-2" style="font-size: 30px">List Of Skills</h5>
                        <div style="color: black" class="col-sm-2">
                            <select name="sort">
                                <option disabled selected>Lọc theo tên</option>
                                <option value="A-Z">Từ A đến Z</option>
                                <option value="Z-A">Từ Z đến A</option>
                            </select>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table mb-0">
                            <thead class="small text-uppercase bg-body text-muted">
                                <tr>
                                    <th style="width: 50px">#</th>
                                    <th>Name</th>
                                    <th>Id</th>
                                    <th>Avatar</th>
                                    <th>Description</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (int i = start; i < end; i++) {
                                %>
                                <tr>
                                    <td><%= i + 1 %></td>
                                    <td><a href="skill?id=<%= arr.get(i).getId() %>"><%= arr.get(i).getName() %></a></td>
                                    <td><a href="skill?id=<%= arr.get(i).getId() %>"><%= arr.get(i).getId() %></a></td>
                                    <td><img src="<%= arr.get(i).getAvatar() %>" style="width: 100px; height: 100px"></td>
                                    <td class="description"><%= arr.get(i).getDescription() %></td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer">
                        <ul class="pagination mb-0">
                            <li class="page-item <%= (pageNum == 1) ? "disabled" : "" %>">
                                <a class="page-link" href="?page=<%= pageNum - 1 %>">Previous</a>
                            </li>
                            <%
                                for (int i = 1; i <= totalPages; i++) {
                            %>
                            <li class="page-item <%= (pageNum == i) ? "active" : "" %>">
                                <a class="page-link" href="?page=<%= i %>"><%= i %></a>
                            </li>
                            <%
                                }
                            %>
                            <li class="page-item <%= (pageNum == totalPages) ? "disabled" : "" %>">
                                <a class="page-link" href="?page=<%= pageNum + 1 %>">Next</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
                            
    <script>
    document.querySelector("select[name=sort]").onchange = function () {
        if (this.selectedIndex) {
            let sortType = this.value;
            let tableBody = document.querySelector("tbody");
            let str = "";
            let itemsPerPage = 10; // Số lượng mục hiển thị trên mỗi trang

            if (sortType === 'A-Z') {
                <% 
                    ArrayList<Skill> az = (ArrayList) request.getAttribute("a-z");
                    int totalAz = az.size();
                    for (int i = 0; i < totalAz && i < itemsPerPage; i++) {
                %>
                str += `<tr>
                            <td><%= i + 1 %></td>
                            <td><a href="skill?id=<%= az.get(i).getId() %>"><%= az.get(i).getName() %></a></td>
                            <td><a href="skill?id=<%= az.get(i).getId() %>"><%= az.get(i).getId() %></a></td>
                            <td><img src="<%= az.get(i).getAvatar() %>" style="width: 100px; height: 100px"></td>
                            <td class="description"><%= az.get(i).getDescription() %></td>
                        </tr>`;
                <% } %>
            } else if (sortType === 'Z-A') {
                <% 
                    ArrayList<Skill> za = (ArrayList) request.getAttribute("z-a");
                    int totalZa = za.size();
                    for (int i = 0; i < totalZa && i < itemsPerPage; i++) {
                %>
                str += `<tr>
                            <td><%= i + 1 %></td>
                            <td><a href="skill?id=<%= za.get(i).getId() %>"><%= za.get(i).getName() %></a></td>
                            <td><a href="skill?id=<%= za.get(i).getId() %>"><%= za.get(i).getId() %></a></td>
                            <td><img src="<%= za.get(i).getAvatar() %>" style="width: 100px; height: 100px"></td>
                            <td class="description"><%= za.get(i).getDescription() %></td>
                        </tr>`;
                <% } %>
            }
            tableBody.innerHTML = str;
        }
    }
</script>

  <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>

</div>
   
    
       <% if(request.getAttribute("mentors") != null) {
            HashMap<Mentor, MentorDetail> mentors = (HashMap)request.getAttribute("mentors");
        %>
        <div role="dialog">
            <div class="fade modal-backdrop"></div>
            <div role="dialog" tabindex="-1" class="fade modal" style="display: block;">
                <div class="modal-dialog">
                    <div class="modal-content" role="document">
                        <div class="modal-header"><button type="button" class="close"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button><h4 class="modal-title"><span>Mentor Suggest</span></h4></div>
                        <div class="modal-body">
                            <div class="content-main">
                                <table class="table table-striped table-bordered table-condensed table-hover">
                                    <thead>
                                        <tr>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Avatar</th>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Fullname</th>                             
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Rating</th>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Requests</th>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Accepted</th>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%for(Mentor m : mentors.keySet()) {%>
                                        <tr>
                                            <td><img src="<%=m.getAvatar()%>" style="height: 50px; width: 50px"></td>
                                            <td><a href="mentor?id=<%=m.getId()%>"><%=m.getFullname()%></a></td>
                                          
                                            <td><%=mentors.get(m).getRating()%></td>
                                            <td><%=mentors.get(m).getRequests()%></td>
                                            <td><%=mentors.get(m).getAcceptedRequest()%></td>
                                            <td>
                                                <a href="mentor?id=<%=m.getId()%>&invite=true&sid=<%=request.getParameter("id")%>" class="delete" data-toggle="modal">
                                            <i class="fas fa-user-plus" data-toggle="tooltip" title="Thuê"></i>
                                        </a>
                                            </td>
                                        </tr> 
                                        <%}%>
                                    </tbody>
                                </table>
                                    <%if(mentors.size() == 0) {%>
                                    <div class="text-center mt-20"><span>Không có dữ liệu</span></div>
                                    <% } %>
                            </div>
                        </div>
                            <div class="modal-footer"><button type="button" class="btn btn-default"><span>Đóng</span></button></div>
                    </div>
                </div>
            </div>
        </div>
        <script>
                                    document.body.style = 'overflow: hidden;  background-color: rgb(233, 235, 238) !important; ';
                                    setTimeout(function () {
                                        document.body.children[document.body.children.length - 2].children[1].classList.add("in");
                                        document.body.children[document.body.children.length - 2].children[0].classList.add("in");
                                        window.onclick = function (e) {
                                            if (!document.getElementsByClassName('modal-content')[0].contains(e.target)) {
                                                    document.body.children[document.body.children.length - 2].children[1].classList.remove("in");
                                                    document.body.children[document.body.children.length - 2].children[0].classList.remove("in");
                                                    document.body.style = 'display:flex';
                                                    setTimeout(function () {
                                                        document.body.removeChild(document.body.children[document.body.children.length - 2]);
                                                    }, 200);
                                            }
                                        }
                                        document.getElementsByClassName('btn btn-default')[<%=(u==null) ? 3 : 2%>].onclick = function (e) {
                                                    document.body.children[document.body.children.length - 2].children[1].classList.remove("in");
                                                    document.body.children[document.body.children.length - 2].children[0].classList.remove("in");
                                                    document.body.style = 'display:flex';
                                                    setTimeout(function () {
                                                        document.body.removeChild(document.body.children[document.body.children.length - 2]);
                                                    }, 200);
                                        }
                                        document.getElementsByClassName('close')[0].onclick = function (e) {
                                                    document.body.children[document.body.children.length - 2].children[1].classList.remove("in");
                                                    document.body.children[document.body.children.length - 2].children[0].classList.remove("in");
                                                    document.body.style = 'display:flex';
                                                    setTimeout(function () {
                                                        document.body.removeChild(document.body.children[document.body.children.length - 2]);
                                                    }, 200);
                                        }
                                    }, 1);
        </script>
        <% } %>

        
        
         <!-- JavaScript Libraries -->
  
    </body>

</html>
