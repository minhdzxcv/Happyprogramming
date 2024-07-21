<%-- 
    Document   : HomePage
    Created on : Oct 5, 2022, 9:46:55 AM
    Author     : DELL
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Skill, java.util.ArrayList, model.User, model.Mentor, model.Mentee, model.Request, java.sql.Timestamp, DAO.MentorDAO, DAO.CvDAO, model.CV, DAO.SkillDAO, java.text.SimpleDateFormat, DAO.RequestDAO" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <style>

            .table-title h2 {
                font-size: 24px; /* Điều chỉnh kích thước chữ theo ý bạn */
            }

            .btn span {
                font-size: 18px; /* Điều chỉnh kích thước chữ theo ý bạn */
            }

            .table-title h2 {
                font-size: 24px; /* Điều chỉnh kích thước chữ theo ý bạn */
            }

            .btn span {
                font-size: 18px; /* Điều chỉnh kích thước chữ theo ý bạn */
            }
            .table th {
                font-size: 18px; /* Điều chỉnh kích thước chữ theo ý bạn */
                font-weight: bold;
                color: black;
            }

            .table td {
                font-size: 16px; /* Điều chỉnh kích thước chữ theo ý bạn */
            }
            .table th {
                font-size: 18px; /* Điều chỉnh kích thước chữ theo ý bạn */
                font-weight: bold;
                color: black;
            }

            .table td {
                font-size: 16px; /* Điều chỉnh kích thước chữ theo ý bạn */
            }

        </style>


        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <title>List of requests</title>
        <meta content="" name="description">
        <meta content="" name="keywords">


        <link href="assets/img/favicon.png" rel="icon">
        <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">


        <link href="assets/vendor/animate.css/animate.min.css" rel="stylesheet">
        <link href="assets/vendor/aos/aos.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
        <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
        <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.css" rel="stylesheet">

        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!--        <link href="css/4.2ddfb1d3.chunk.css" rel="stylesheet">-->
        <link href="css/8.97b85fe3.chunk.css" rel="stylesheet">

        <link href="font-awesome/css/all.css" rel="stylesheet">

        <link href="https://img.lovepik.com/free-png/20210926/lovepik-cartoon-book-png-image_401449837_wh1200.png" rel="icon">


        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&display=swap" rel="stylesheet">


        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">


        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">




        <link href="css/style.css" rel="stylesheet">

    </head>

    <body>
        <link rel="stylesheet" href="https://cdn.datatables.net/2.0.8/css/dataTables.bootstrap4.css"/>
        <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.datatables.net/2.0.8/js/dataTables.js"></script>
        <script src="https://cdn.datatables.net/2.0.8/js/dataTables.bootstrap5.js"></script>
        <script>
            $(document).ready(function () {
                $("#data-table").DataTable();
            }
            );
        </script>
        <style>
            .popup {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgb(0,0,0);
                background-color: rgba(0,0,0,0.4);
                padding-top: 60px;
            }


            .popup-content {
                background-color: #fefefe;
                margin: 5% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
            }

            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }
        </style>
        <div class="row">
            <%@include file="header.jsp" %>
            <!-- ======= Hero Section ======= -->
            <div  style="padding-top: 100px" class="menu__header fix-menu">
                <div class="container" style="width: 100000px">
                    <form action="new-schedule" method="post">
                        <button class="btn btn-success" type="submit" name="action" value="send" onclick="return confirm('Are you sure to submit?')">Submit</button>
                        <button class="btn btn-danger" type="submit" name="action" value="delete" onclick="return confirm('Are you sure to delete selected schedules?')">Delete</button>
                        <table class="table table-striped table-hover" id="data-table">
                            <thead>
                                <tr>
                                    <th>
                                        <span class="custom-checkbox">
                                            <input type="checkbox" id="selectAll">
                                            <label for="selectAll"></label>
                                        </span>
                                    </th>
                                    <th style="font-weight: bold; color: black">No.</th>
                                    <th style="font-weight: bold; color: black">Year</th>
                                    <th style="font-weight: bold; color: black">Week</th>
                                    <th style="font-weight: bold; color: black">Status</th>
                                    <th style="font-weight: bold; color: black">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="schedule" items="${schedulesNew}" varStatus="index">
                                    <tr>
                                        <td>
                                            <c:if test="${schedule.status != 'Reject'}">
                                                <input type="checkbox" name="scheduleID" value="${schedule.scheduleID}">
                                            </c:if>
                                        </td>
                                        <td>${index.index + 1}</td>
                                        <td>${schedule.year}</td>
                                        <td>${schedule.week}</td>
                                        <td>${schedule.status}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${schedule.status == 'Reject'}">
                                                    <button class="btn btn-danger" data-toggle="modal" data-target="#rejectReasonModal" onclick="showRejectReason('${schedule.rejectReason}', event)">Reject</button>
                                                </c:when>
                                                <c:otherwise>

                                                </c:otherwise>
                                            </c:choose>
                                            <a href="new-schedule-detail?scheduleID=${schedule.scheduleID}" class="btn btn-info">Details</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </form>
                </div>
            </div>        
            <div id="preloader"></div>
        </div>
        <div id="rejectReasonPopup" class="popup">
            <div class="popup-content">
                <span class="close" onclick="closeRejectReason()">&times;</span>
                <h2>Reject Reason</h2>
                <p id="rejectReasonText"></p>
            </div>
        </div>

        <script>
            function showRejectReason(rejectReason, event) {
                event.preventDefault();
                document.getElementById('rejectReasonText').innerText = rejectReason;
                document.getElementById('rejectReasonPopup').style.display = "block";
            }

            function closeRejectReason() {
                document.getElementById('rejectReasonPopup').style.display = "none";
            }
        </script>
        <script>
            document.getElementById('selectAll').addEventListener('click', function (event) {
                let checkboxes = document.querySelectorAll('input[type="checkbox"][name="scheduleID"]');
                for (let checkbox of checkboxes) {
                    checkbox.checked = event.target.checked;
                }
            });

            document.getElementById('scheduleForm').addEventListener('submit', function (event) {
                let selectedCheckboxes = document.querySelectorAll('input[type="checkbox"][name="scheduleID"]:checked');
                if (selectedCheckboxes.length === 0) {
                    event.preventDefault();
                    alert('Please select at least one schedule to send.');
                }
            });
        </script>


        <!-- Vendor JS Files -->
        <script src="assets/vendor/purecounter/purecounter_vanilla.js"></script>
        <script src="assets/vendor/aos/aos.js"></script>
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="assets/vendor/swiper/swiper-bundle.min.js"></script>
        <script src="assets/vendor/php-email-form/validate.js"></script>

        <!-- Template Main JS File -->
        <script src="assets/js/main.js"></script>

    </body>

</html>
