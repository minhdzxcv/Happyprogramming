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
        .main-container {
            margin: 20px auto;
            max-width: 1200px;
            padding: 0 15px;
        }
        .table-wrapper {
            margin-top: 20px;
            box-shadow: 0 2px 15px rgba(64, 64, 64, 0.2);
            border-radius: 5px;
            overflow: hidden;
        }
        .styled-table {
            width: 100%;
            border-collapse: collapse;
            font-family: 'Nunito', sans-serif;
        }
        .styled-table th, .styled-table td {
            border: 1px solid #ddd;
            padding: 12px 15px;
            text-align: left;
            transition: all 0.3s ease;
        }
        .styled-table th {
            background-color: #4CAF50;
            color: white;
            text-transform: uppercase;
        }
        .styled-table tr {
            background-color: #f9f9f9;
        }
        .styled-table tr:hover {
            background-color: #f1f1f1;
        }
        .styled-table tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .btn-chat {
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
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .btn-chat:hover {
            background-color: #d32f2f;
        }
        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
        }
        .no-mentors-message {
            text-align: center;
            font-family: 'Nunito', sans-serif;
            margin-top: 20px;
            color: #555;
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
  <div class="main-container">
        
 
    <%
        ArrayList<Mentee> follower = (ArrayList<Mentee>)request.getAttribute("follower");
        if(follower != null && !follower.isEmpty()) {
    %>
    
   <div class="table-wrapper">
                <table class="styled-table">
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
                                <td><img src="<%=mentee.getAvatar()%>" class="user-avatar"></td>
                                <td><%=mentee.getFullname()%></td>
                                <td><a href="chat?id=<%=mentee.getId()%>" class="btn-chat">Chat</a></td>
                            </tr>
                        <%}%>
                    </tbody>
                </table>
            </div>
        <%
            } else {
        %>
            <div class="no-mentors-message">Không có mentor nào trong danh sách following.</div>
        <%
            }
        %>
    </div>
   
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
