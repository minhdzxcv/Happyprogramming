<%-- 
    Document   : home
    Created on : May 13, 2024, 9:04:58 PM
    Author     : ADMIN
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import=" java.util.ArrayList, model.User, model.Mentor, model.Mentee , DAO.UserDAO" %>
<%@page import="java.util.ArrayList, model.User, model.Mentor, model.Mentee , DAO.UserDAO" %>
<%@page import="model.Skill, java.util.ArrayList, model.User, model.Mentor, model.Mentee, model.FollowRequest, java.sql.Timestamp, DAO.MentorDAO, DAO.CvDAO, model.CV, DAO.SkillDAO, java.text.SimpleDateFormat" %>
<%@page import="model.Skill, java.util.ArrayList, model.User, java.text.SimpleDateFormat, model.Mentor, model.Mentee, DAO.FollowDAO" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>

<html lang="en">

<head>
    <style>
        .img-fixed-size {
            width: 100%;
            height: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-family: Arial, sans-serif;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
            transition: background-color 0.3s ease;
        }

        th {
            background-color: #4CAF50;
            color: white;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
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
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        .btn-danger:hover {
            background-color: #e53935;
        }

        .btn-primary {
            background-color: #4CAF50;
            border: none;
            color: white;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #45a049;
        }

        .actions i {
            font-size: 18px;
            margin: 0 5px;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .actions i:hover {
            color: #333;
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

    <!-- Libraries Stylesheet -->
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

    <%ArrayList<FollowRequest> arr = (ArrayList<FollowRequest>)request.getAttribute("requests"); %>
    <table>
        <thead>
            <tr>
                <th>Subject</th>
                <th>Reason</th>
                <th>Sender</th>
                <th>Create Date</th>
                <th>Deadline Date</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%for(FollowRequest fr : arr) {%>
                <tr>
                    <td><%=fr.getTitle()%></td>
                    <td><%=fr.getContent()%></td>
                    <td><%=fr.getSend()%></td>
                    <td><%=fr.getCreateAt()%></td>
                    <td><%=fr.getDeadline()%></td>
                    <td><%=fr.getStatus()%></td>
                    <td class="actions">
                        <a href="followrequest?type=accept&id=<%=fr.getId()%>" class="btn-primary">
                            <i class="fas fa-check" data-toggle="tooltip" title="Accept"></i>
                        </a>
                        <a href="followrequest?type=reject&id=<%=fr.getId()%>" class="btn-danger">
                            <i class="fas fa-ban" data-toggle="tooltip" title="Reject"></i>
                        </a>
                    </td>
                </tr>
            <%}%>
        </tbody>
    </table>

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
