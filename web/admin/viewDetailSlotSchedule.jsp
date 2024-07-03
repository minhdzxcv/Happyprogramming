<%-- 
    Document   : CVConfirm
    Created on : Jun 8, 2024, 6:10:41 PM
    Author     : ADMIN
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Slot, java.util.ArrayList, model.User , model.Report, model.Mentee, model.Request, java.sql.Timestamp, DAO.MentorDAO, DAO.ScheduleDAO, model.CV, DAO.SkillDAO, java.text.SimpleDateFormat, model.RequestStatus, DAO.CvDAO" %>
<!DOCTYPE html>
<html lang="en">
    <head>
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
        </style>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>ADMIN - List Of Schedule</title>

        <!-- Custom fonts for this template -->

        <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="${pageContext.request.contextPath}/css/sb-admin-2.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/8.97b85fe3.chunk.css" rel="stylesheet">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
        <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.14/index.global.min.js'></script>
    </head>
    <body id="page-top">
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
        <%  
                User u = (User)session.getAttribute("email");
        %>
        <!-- Page Wrapper -->
        <div id="wrapper">

            <!-- Sidebar -->

            <!-- End of Sidebar -->

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <!-- Topbar -->




                    <!-- Page Heading -->
                    <h1  class="h3 mb-2 text-gray-800" style="margin-left: 20px">Schedule</h1>

                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary"> List of Schedule</h6>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <form action="new-schedule-detail" method="post">
                                <button class="btn btn-success" type="submit" onclick="return confirm('Are you sure to send to admin?')">Send to admin</button>

                                <table class="table table-striped table-hover" id="data-table-slot">
                                    <thead>
                                        <tr>
                                            <th>
                                                <span class="custom-checkbox">
                                                    <input type="checkbox" id="selectAll" onclick="selectAllCheckboxes(this)">
                                                    <label for="selectAll"></label>
                                                </span>
                                            </th>
                                            <th>Slot ID</th>
                                            <th>Start</th>
                                            <th>End</th>
                                            <th>Link</th>
                                            <th>Mentor</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="sl" items="${slots}">
                                            <tr>
                                                <td> <input type="checkbox" name="selectedSlots" value="${sl.id}"></td>
                                                <td>${sl.id}</td>
                                                <td>${sl.getSlotTime()}</td>
                                                <td>
                                                    <script>
                                                        document.write(calculateEndTime('${sl.getSlotTime()}', ${sl.hour}));
                                                    </script>
                                                </td>
                                                <td>
                                                    <a href="${sl.link}" class="badge badge-primary">Link meet</a>
                                                </td>
                                                <td>${mentor.fullname}</td>
                                                <td>${sl.status}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </form>
                            <script>
                                function selectAllCheckboxes(source) {
                                    checkboxes = document.getElementsByName('selectedSlots');
                                    for (var i in checkboxes) {
                                        checkboxes[i].checked = source.checked;
                                    }
                                }
                            </script>
                            <a href="admin/schedule" class="btn btn-primary">Back to Schedules</a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="scheduleModal" tabindex="-1" aria-labelledby="scheduleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="calendarModalLabel">Slots Calendar</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div id="calendar"></div> 
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>



        <!-- Scroll to Top Button-->
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>
    </div>
    <!-- Bootstrap core JavaScript-->
    <script src="${pageContext.request.contextPath}/vendoradmin/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Core plugin JavaScript-->
    <script src="${pageContext.request.contextPath}/vendoradmin/jquery-easing/jquery.easing.min.js"></script>
    <!-- Custom scripts for all pages-->
    <script src="${pageContext.request.contextPath}/js/sb-admin-2.min.js"></script>
    <!-- Page level plugins -->
    <script src="${pageContext.request.contextPath}/vendoradmin/chart.js/Chart.min.js"></script>
    <!-- Page level custom scripts -->
    <script src="${pageContext.request.contextPath}/js/demo/chart-area-demo.js"></script>
    <script src="${pageContext.request.contextPath}/js/demo/chart-pie-demo.js"></script>
</body>
</html>
