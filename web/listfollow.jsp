<%-- 
    Document   : home
    Created on : May 13, 2024, 9:04:58 PM
    Author     : ADMIN
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import=" java.util.ArrayList, model.User, model.Mentor, model.Mentee , DAO.UserDAO" %>
<%@page import="java.util.ArrayList, model.User, model.Mentor, model.Mentee , DAO.UserDAO" %>
<%@page import="model.Skill, java.util.ArrayList, model.User, java.text.SimpleDateFormat, model.Mentor, model.Mentee, DAO.FollowDAO" %>
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


 <%= u.getRole()%>
 
 
 <%
    ArrayList<Mentee> follower = (ArrayList<Mentee>)request.getAttribute("follower");
    if(follower != null && !follower.isEmpty()) {
%>
        <style>
    table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
        font-family: Arial, sans-serif;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }
    th {
        background-color: #4CAF50;
        color: white;
    }
    tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    .btn-danger {
        background-color: #f44336;
        border: none;
        color: white;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 4px 2px;
        cursor: pointer;
    }
</style>

<table>
    <thead>
        <tr>
            <th>Avatar</th>
            <th>Tên</th>
            
            <th>Chat</th>
        </tr>
    </thead>
    <tbody>
        <%for(Mentee mentee : follower) {%>
            <tr>
                <td><img src="<%=mentee.getAvatar()%>" style="width: 50px; height: 50px"></td>
                <td><%=mentee.getFullname()%></td>
                
                <td><button class="btn btn-danger" id="<%=mentee.getId()%>">Chat</button></td>
            </tr>
        <%}%>
    </tbody>
</table>

<%
    } else {
        out.println("Không có mentor nào trong danh sách following.");
    }
%>

    
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
    <script src="js/main.js"></script>
</body>

</html>