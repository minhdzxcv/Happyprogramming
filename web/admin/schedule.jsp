<%-- 
    Document   : CVConfirm
    Created on : Jun 8, 2024, 6:10:41 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="model.Slot, java.util.ArrayList, model.User , model.Report, model.Mentee, model.Request, java.sql.Timestamp, DAO.MentorDAO, DAO.ScheduleDAO, model.CV, DAO.SkillDAO, java.text.SimpleDateFormat, model.RequestStatus, DAO.CvDAO" %>
<jsp:useBean id="getSchedule" class="DAO.ScheduleDAO"/>
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
        <style>
            /* Popup container */
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

            /* Popup Content */
            .popup-content {
                background-color: #fefefe;
                margin: 5% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
            }

            /* The Close Button */
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
        <script>
            $(document).ready(function () {
                $("#data-table").DataTable();
            }
            );
        </script>
        <%  
                ArrayList<Slot> arr = (ArrayList)request.getAttribute("memtors");
                int p = (int) Math.ceil((double)arr.size() / 5);
                User u = (User)session.getAttribute("email");
        %>
        <script>
            var max = <%=p%>;
            var p = 1;
        </script>

        <!-- Page Wrapper -->
        <div id="wrapper">

            <!-- Sidebar -->
            <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
                <!-- Sidebar - Brand -->
                <a class="sidebar-brand d-flex align-items-center justify-content-center" href="../admin/request">
                    <div class="sidebar-brand-icon rotate-n-15">
                        <i class="fas fa-laugh-wink"></i>
                    </div>
                    <div class="sidebar-brand-text mx-3">Hi Admin <sup>2</sup></div>
                </a>

                <!-- Nav Item - Pages Collapse Menu -->
                <li class="nav-item">
                    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                       aria-expanded="true" aria-controls="collapseTwo">
                        <i class="fas fa-fw fa-cog"></i>
                        Setting <%=u.getRole().equalsIgnoreCase("admin") ? "Admin" : "Manager"%>
                    </a>
                       <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                        <div class="bg-white py-2 collapse-inner rounded">
                            <h6 class="collapse-header">Happy Programming</h6>
                            <%if(u.getRole().equalsIgnoreCase("admin")) {%>
                            <a class="collapse-item" href="skill">Skills</a>
                            <a class="collapse-item" href="mentor">Mentors</a>
                            <a class="collapse-item" href="authorization">Authozization</a>
                          
                            <%}%>
                              <a class="collapse-item" href="request">Request</a>
                             <%if(u.getRole().equalsIgnoreCase("manager")) {%>
                            <a class="collapse-item" href="mentee">Mentee Statistic</a>
                            <a class="collapse-item" href="report">Report</a>
                            <a class="collapse-item" href="cv">CV Confirmation</a>
                            <a class="collapse-item" href="transaction">Transaction</a>
                            <a class="collapse-item" href="withdraw">Withdraw</a>
                            <a class="collapse-item" href="schedule">Schedule </a>
                              <%}%>
                        </div>
                    </div>
                </li>

                <div class="text-center d-none d-md-inline">
                    <button class="rounded-circle border-0" id="sidebarToggle"></button>
                </div>

                <!-- Sidebar Message -->
                <div class="sidebar-card d-none d-lg-flex">
                    <img class="sidebar-card-illustration mb-2" src="${pageContext.request.contextPath}/img/undraw_rocket.svg" alt="...">
                    <p class="text-center mb-2"><strong>SB Admin Pro</strong> is packed with premium features, components, and more!</p>
                    <a class="btn btn-success btn-sm" href="https://startbootstrap.com/theme/sb-admin-pro">Upgrade to Pro!</a>
                </div>
            </ul>
            <!-- End of Sidebar -->

            <!-- Content Wrapper -->
            <div id="content-wrapper" class="d-flex flex-column">
                <div id="content">
                    <!-- Topbar -->
                    <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
                        <ul class="navbar-nav ml-auto">
                            <div class="topbar-divider d-none d-sm-block"></div>
                            <!-- Nav Item - User Information -->
                            <li class="nav-item dropdown no-arrow">
                                <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%= u.getUsername() %></span>
                                    <img class="img-profile rounded-circle" src="https://i1.sndcdn.com/artworks-Zi3MyKTjU1uGOFnq-LGH9iQ-t500x500.jpg">
                                </a>
                                <!-- Dropdown - User Information -->
                                <div class="dropdown-menu dropdown-menu-right
                                     shadow animated--grow-in" aria-labelledby="userDropdown">
                                    <a class="dropdown-item" href="#">
                                        <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Setting <%=u.getRole().equalsIgnoreCase("admin") ? "Admin" : "Manager"%>
                                    </a>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                        <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                        Logout
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </nav>



                    <!-- Page Heading -->
                    <h1  class="h3 mb-2 text-gray-800" style="margin-left: 20px">Schedule</h1>

                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary"> List of Schedule</h6>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="data-table" width="100%" cellspacing="0">
                                <thead>
                                    <tr>
                                        <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>STT</th> 
                                        <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Avatar</th>
                                        <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Mentor</th>
                                        <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Schedule</th>
                                        <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Status</th>
                                        <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${memtors}" varStatus="index">
                                        <c:set var="sche" value="${getSchedule.getScheduleById(item.id)}" />
                                        <c:set var="slotsAdmin" value="${getSchedule.getSlotsForCheck(item.id)}" />
                                        <tr id='${index.index + 1}'>
                                            <td>${item.id}</td>
                                            <td><img src="<%=request.getContextPath()%>/${item.avatar}" height="50px" width="50px" style="border-radius: 50%"/></td>
                                            <td><c:out value="${item.fullname}" /></td>
                                            <td>
                                                <a href="#" onclick="popup(event, '${item.id}')">Schedule</a>
                                                <a href="<%=request.getContextPath()%>/view-slot-admin?mentorId=${item.id}" class="badge badge-warning">Slots</a>
                                            </td>
                                            <td>
                                                <c:if test="${sche.status != 'Reject'}">
                                                    <span class="label label-success">${sche.status}</span>
                                                </c:if>
                                                <c:if test="${sche.status == 'Reject'}">
                                                    <span class="label label-danger" onclick="openRejectPopupView('${sche.rejectReason}')">${sche.status}</span>
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:if test="${slotsAdmin.size() > 0}">
                                                    <c:if test="${sche.status != 'Reject'}">
                                                    <a href="schedule?type=confirm&amp;id=<c:out value="${item.id}" />">
                                                        <i class="fas fa-check" data-toggle="tooltip" title="confirm"></i>
                                                    </a>
                                                    <a href="#" onclick="openRejectPopup('${item.id}')" style="color: red;">
                                                        <i class="fas fa-ban" data-toggle="tooltip" title="reject"></i>
                                                    </a>
                                                </c:if>
                                                </c:if>
                                                
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
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
            <div id="rejectPopup" class="popup">
                <div class="popup-content">
                    <span class="close" onclick="closeRejectPopup()">&times;</span>
                    <h2>Reject Reason</h2>
                    <form id="rejectForm" method="post" action="schedule?type=reject">
                        <input type="hidden" id="rejectMentorId" name="id" value="">
                        <div class="form-group">
                            <label for="rejectReason">Reason:</label>
                            <textarea id="rejectReason" name="rejectReason" class="form-control" rows="4" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </form>
                </div>
            </div>

            <div id="viewReject" class="popup">
                <div class="popup-content">
                    <span class="close" onclick="closeRejectPopupView()">&times;</span>
                    <h2>Reject Reason</h2>
                    <div>
                        <div class="form-group">
                            <label for="rejectReason">Reason:</label>
                            <textarea readonly id="rejectReasonView" name="rejectReason" class="form-control" rows="4" required></textarea>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                function openRejectPopup(mentorId) {
                    document.getElementById('rejectMentorId').value = mentorId;
                    document.getElementById('rejectPopup').style.display = "block";
                }

                function closeRejectPopup() {
                    document.getElementById('rejectPopup').style.display = "none";
                }

                window.onclick = function (event) {
                    const popup = document.getElementById('rejectPopup');
                    if (event.target == popup) {
                        popup.style.display = "none";
                    }
                }
                
                function openRejectPopupView(message) {
                    document.getElementById('rejectReasonView').value = message;
                    document.getElementById('viewReject').style.display = "block";
                }

                function closeRejectPopupView() {
                    document.getElementById('viewReject').style.display = "none";
                }

                window.onclick = function (event) {
                    const popup = document.getElementById('viewReject');
                    if (event.target == popup) {
                        popup.style.display = "none";
                    }
                }
            </script>
        </div>

        <!-- Scroll to Top Button-->
        <a class="scroll-to-top rounded" href="#page-top">
            <i class="fas fa-angle-up"></i>
        </a>
    </div>

    <script>
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth'
            },
            events: [],
            eventClick: function (info) {
                alert(info.event.title + '\nRoom Link: ' + info.event.extendedProps.link + "\nStart: " + info.event.start.toLocaleString() + "\nEnd: " + info.event.end.toLocaleString());
            }
        });

        calendar.render();

        function updateCalendarEvents(slots) {
            console.log('Fetched slots:', slots);
            var events = slots.map(function (slot) {
                var start = new Date(slot.SlotTime);
                var end = new Date(start.getTime() + slot.hour * 60 * 60 * 1000);

                return {
                    id: slot.id,
                    title: 'Slot ID: ' + slot.id,
                    start: start,
                    end: end,
                    extendedProps: {
                        link: slot.link,
                        status: slot.Status.trim(),
                        menteeId: slot.menteeId
                    }
                };
            });
            console.log(events);
            calendar.removeAllEvents();
            calendar.addEventSource(events);
        }

        function popup(event, mentorId) {
            event.preventDefault();
            $.ajax({
                url: '<%=request.getContextPath()%>/getSlots?mentorId=' + mentorId,
                type: 'GET',
                dataType: 'json',
                success: function (slots) {
                    updateCalendarEvents(slots);
                    calendar.render();
                    $('#scheduleModal').modal('show').on('shown.bs.modal', function () {
                        calendar.render();
                    });
                    $('#scheduleModal').modal('show');
                },
                error: function (xhr, status, error) {
                    console.error('Error fetching slots:', error);
                }
            });
        }
    </script>
     <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="../signinadmin">Logout</a>
                </div>
            </div>
        </div>
    </div>
    <script>
        <%if(request.getAttribute("alert") != null) {%>
        setTimeout(function () {
            alert("<%=(String)request.getAttribute("alert")%>");
        }, 500);
        <%}%>
    </script>

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
