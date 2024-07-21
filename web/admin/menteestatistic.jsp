<%-- 
    Document   : menteestatistic
    Created on : Jun 18, 2024, 9:56:18 PM
    Author     : ADMIN
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Skill, java.util.ArrayList, model.MenteeStatistic, model.User, model.Mentor, model.Mentee, java.util.Collections, java.util.Comparator, model.Request, java.sql.Timestamp, DAO.MentorDAO, DAO.CvDAO, model.CV, DAO.SkillDAO, java.text.SimpleDateFormat, java.util.HashMap, model.Role" %>
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

    <title>ADMIN - List Of Mentor</title>

    <!-- Custom fonts for this template -->
    <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/sb-admin-2.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
</head>
<body id="page-top">
     <%  
            User u = (User)session.getAttribute("email");
            ArrayList<MenteeStatistic> arr = (ArrayList)request.getAttribute("mstatistic");
            ArrayList<MenteeStatistic> AZ = (ArrayList)arr.clone();
            ArrayList<MenteeStatistic> ZA = (ArrayList)arr.clone();
            Collections.sort(AZ, new Comparator<MenteeStatistic>() {
                @Override
                public int compare(MenteeStatistic o1, MenteeStatistic o2) {
                    return o1.getName().compareTo(o2.getName()) == 0 ? o1.getFullname().compareTo(o2.getFullname()) : o1.getName().compareTo(o2.getName());
                }
            });
            Collections.sort(ZA, new Comparator<MenteeStatistic>() {
                @Override
                public int compare(MenteeStatistic o1, MenteeStatistic o2) {
                    return o2.getName().compareTo(o1.getName()) == 0 ? o2.getFullname().compareTo(o1.getFullname()) : o2.getName().compareTo(o1.getName());
                }
            });
            int p = (int) Math.ceil((double)arr.size() / 5);
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

                <script>
                    function sort(input) {
                        let body = document.getElementById("tbody");
                        if(input.options[input.selectedIndex].value === 'asc') {
                            body.innerHTML = '<% for(int i = 0; i < AZ.size(); i++) {%>\n\
                                                <td><%=i+1%></td>\n\
                                                <td><%=AZ.get(i).getName()%></td>\n\
                                            <td><%=AZ.get(i).getFullname()%></td>\n\
                                            <td><%=AZ.get(i).getTotalHours()%></td>\n\
                                            <td><%=AZ.get(i).getTotalRequest()%></td>\n\
                                            <td><%=AZ.get(i).getAcceptedRequest()%></td>\n\
                                            <td><%=AZ.get(i).getRejectedRequest()%></td>\n\
                                            <td><%=AZ.get(i).getTotalSkill()%></td>\n\
                                        </tr> \n\
                                                <%}%>';
                        } else {
                            body.innerHTML = '<% for(int i = 0; i < ZA.size(); i++) {%>\n\
                                                <td><%=i+1%></td>\n\
                                                <td><%=ZA.get(i).getName()%></td>\n\
                                            <td><%=ZA.get(i).getFullname()%></td>\n\
                                            <td><%=ZA.get(i).getTotalHours()%></td>\n\
                                            <td><%=ZA.get(i).getTotalRequest()%></td>\n\
                                            <td><%=ZA.get(i).getAcceptedRequest()%></td>\n\
                                            <td><%=ZA.get(i).getRejectedRequest()%></td>\n\
                                            <td><%=ZA.get(i).getTotalSkill()%></td>\n\
                                        </tr> \n\
                                                <%}%>';
                        }
                    }
                                                        </script>

                <!-- Page Heading -->
                <h1  class="h3 mb-2 text-gray-800" style="margin-left: 20px">Mentee</h1>

                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Mentee Statistic</h6>
                    </div>
                </div>

                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                   <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>STT</th>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Username</th>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Fullname</th>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Total Hours</th>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Total Request</th>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Accepted Request</th>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Rejected Request</th>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Total Skill</th>
                                </tr>
                            </thead>
                           <tbody id="tbody">
                                        <% 
                                            for(int i = 0; i < arr.size(); i++) {%>
                                        <tr id='<%=i+1%>' <%=(i >= 5 ? "class=\"hidden\"" : "")%>>
                                            <td>
                                                <%=i+1%>
                                            </td>
                                            <td><%=arr.get(i).getName()%></td>
                                            <td><%=arr.get(i).getFullname()%></td>
                                            <td><%=arr.get(i).getTotalHours()%></td>
                                            <td><%=arr.get(i).getTotalRequest()%></td>
                                            <td><%=arr.get(i).getAcceptedRequest()%></td>
                                            <td><%=arr.get(i).getRejectedRequest()%></td>
                                            <td><%=arr.get(i).getTotalSkill()%></td>
                                        </tr> 
                                        <%
                                            }
                                        %>
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
                                                

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
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

    <!-- Bootstrap core JavaScript-->
    <script src="${pageContext.request.contextPath}/vendoradmin/jquery/jquery.min.js"></script>
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
