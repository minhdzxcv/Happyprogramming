<%-- 
    Document   : request
    Created on : May 22, 2024, 3:32:15 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import=" java.util.ArrayList, model.User, model.Mentor, model.Mentee , model.Request, DAO.UserDAO, DAO.RequestDAO, Controller.RequestServlet" %>
<%@page import="java.util.List" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>

        <title>
            <c:if test="${role=='mentee'}">
                List of requests
            </c:if>
            <c:if test="${role=='mentor'}">
                List of inviting requests
            </c:if>
        </title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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

        <%@include file="header.jsp" %>
        <div class="container my-5">
            <h5>Request</h5>
            <c:if test="${role=='mentee'}">
                <div class="my-4">
                    <c:if test="${requests.size()==0||requests==null}">You have made no request</c:if>
                    <c:if test="${requests.size()==1}">You have made 1 request</c:if>
                    <c:if test="${requests.size()>=2}">You have made ${requests.size()} requests</c:if>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Request</th>
                                    <th>Deadline time</th>
                                    <th>Subject</th>
                                    <th>Skill</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:if test="${not empty requests}">
                                <c:forEach var="req" items="${requests}">
                                    <tr>
                                        <td>${req.reason}</td>
                                        <td>${req.deadlineTime}</td>
                                        <td>${req.subject}</td>
                                        <td>${req.getSkillsName()}</td>
                                        <td>${req.status}</td>
                                        <td>

                                            <button type="button" class="btn btn-primary btn-sm" onclick="#">Update</button>
                                            <button type="button" class="btn btn-danger btn-sm" onclick="#">Delete</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty requests}">
                                <tr>
                                    <td>N/A</td>
                                    <td>N/A</td>
                                    <td>N/A</td>
                                    <td>N/A</td>
                                    <td>N/A</td>
                                    <td></td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>

                <div class="my-4">
                    <a href="statistic" class="btn btn-primary">View statistic request</a>
                    <a href="CreateRequest" class="btn btn-primary">Create request</a>
                </div>
            </c:if>

            <c:if test="${role=='mentor'}">
                <div class="my-4">
                    <c:if test="${requests.size()==0||requests==null}">You have no request</c:if>
                    <c:if test="${requests.size()==1}">You have 1 request</c:if>
                    <c:if test="${requests.size()>=2}">You have ${requests.size()} requests</c:if>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Request</th>
                                    <th>Deadline Time</th>
                                    <th>Skill</th>
                                    <th>Subject</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:if test="${not empty requests}">
                                <c:forEach var="req" items="${requests}">
                                    <tr>
                                        <td>${req.reason}</td>
                                        <td>${req.deadlineTime}</td>
                                        <td>${req.getSkillsName()}</td>
                                        <td>${req.subject}</td>
                                        <td>${req.status}</td>
                                        <td>
                                            <button type="button" class="btn btn-primary btn-sm" onclick="#">Accept</button>
                                            <button type="button" class="btn btn-primary btn-sm" onclick="#">Reject</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty requests}">
                                <tr>
                                    <td>N/A</td>
                                    <td>N/A</td>
                                    <td>N/A</td>
                                    <td>N/A</td>
                                    <td>N/A</td>
                                    <td></td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
                <div class="d-flex justify-content-center">
                    <a class="btn btn-light " href="home.jsp">Back</a>
                </div>
            </c:if>
        </div>
    </body>
</html>
