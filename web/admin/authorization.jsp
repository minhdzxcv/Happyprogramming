<%-- 
    Document   : authorization
    Created on : Jun 18, 2024, 9:40:13 PM
    Author     : ADMIN
--%>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Skill, java.util.ArrayList, model.User, model.Mentor, model.Mentee, model.Request, java.sql.Timestamp, DAO.MentorDAO, DAO.CvDAO, model.CV, DAO.SkillDAO, java.text.SimpleDateFormat, java.util.HashMap, model.Role" %>
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
         .modal-backdrop {
    background-color: rgba(0, 0, 0, 0.5);
}

.modal-dialog {
    max-width: 600px;
    margin: 30px auto;
}

.modal-content {
    border-radius: 8px;
    border: none;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.modal-header {
    background-color: #f5f5f5;
    border-bottom: 1px solid #ddd;
    border-top-left-radius: 8px;
    border-top-right-radius: 8px;
    padding: 15px;
}

.modal-title {
    margin: 0;
    font-size: 18px;
}

.close {
    color: #333;
    opacity: 0.6;
}

.close:hover {
    color: #000;
    opacity: 1;
}

.modal-body {
    padding: 20px;
}

.modal-footer {
    background-color: #f5f5f5;
    border-top: 1px solid #ddd;
    padding: 15px;
    border-bottom-left-radius: 8px;
    border-bottom-right-radius: 8px;
    text-align: right;
}

.btn {
    padding: 10px 20px;
    border-radius: 4px;
}

.btn-fill {
    background-color: #d9534f;
    color: #fff;
}

.btn-fill:hover {
    background-color: #c9302c;
    color: #fff;
}

.btn-default {
    background-color: #fff;
    color: #333;
    border: 1px solid #ccc;
}

.btn-default:hover {
    background-color: #e6e6e6;
    color: #333;
}

table {
    width: 100%;
}

td {
    padding: 10px;
}

input[type="text"], input[type="file"], select, textarea {
    width: 100%;
    padding: 8px;
    box-sizing: border-box;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
}

textarea {
    height: 100px;
    resize: vertical;
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
    <link href="${pageContext.request.contextPath}/css/8.97b85fe3.chunk.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
   
    <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
</head>
<body id="page-top">
    <%  
            User u = (User)session.getAttribute("email");
            HashMap<String, String> arr = (HashMap)request.getAttribute("maps");
            ArrayList<Role> roles = (ArrayList)request.getAttribute("roles");
            int p = (int) Math.ceil((double)arr.size() / 10);
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
             <script>
            let avt = document.getElementById('header-nav-dropdown');
            avt.onclick = function () {
                if (avt.parentNode.classList.contains("open")) {
                    avt.parentNode.classList.remove("open");
                } else {
                    avt.parentNode.classList.add("open");
                }
            };

        </script>

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
                
                
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Authorization</h6>
                    </div>
                </div>

                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                            <thead>
                                <tr>
                                            <tr>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>STT</th>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Path</th>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Authorite Role</th>
                                            <th style='font-family: "Open Sans", sans-serif; font-weight: bold; color: black'>Action</th>
 </tr>
                                </tr>
                                           </thead>
                                         
                <tbody>
                                        <%  int i = 0;
                                            for(String path : arr.keySet()) {%>
                                        <tr id='<%=i+1%>' <%=(i >= 10 ? "class=\"hidden\"" : "")%>>
                                            <td>
                                                <%=i+1%>
                                            </td>
                                            <td><%=path%></td>
                                            <td><%=arr.get(path)%></td>
                                            <td>
                                                <a href="" id="" onclick="update<%=i+1%>(event)" class="edit" data-toggle="modal">
                                            <i class="fas fa-edit" data-toggle="tooltip" title="update"></i>
                                        </a>
                                            <script>
                                                function update<%=i+1%>(event) {
                                                event.preventDefault();
              let title = document.title;
              if (!JSON.stringify(document.body.style).includes("overflow: hidden;")) {
          <%
              try {
          %>
                  document.body.style = 'overflow: hidden; padding-right: 17px; background-color: rgb(233, 235, 238) !important; ';
                  //document.body.style = 'background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                  let modal = document.createElement('div');
                    modal.innerHTML = '<div role="dialog" aria-hidden="true"><div class="fade modal-backdrop"></div><div role="dialog" tabindex="-1" class="fade modal-donate modal" style="display: block;"><div class="modal-dialog"><div class="modal-content" role="document"><div class="modal-header"><button type="button" class="close"><span aria-hidden="true"></span><span class="sr-only">Close</span></button><h4 class="modal-title"><span>Update Authorization</span></h4></div><form method="post"><div class="modal-body"><table style="width: 100%;"><tbody><tr><td>Path:</td><td><%=path%></td></tr><tr><td><span>Authorite Role</span>:</td><td><%for(int j = 0; j < roles.size(); j++) {%><div class="col-sm-6"><input type="checkbox" name="role" value="<%=roles.get(j).getName()%>" id="<%=roles.get(j).getId()%>" <%=arr.get(path.toLowerCase()).contains(roles.get(j).getName().toLowerCase()) ? "checked" : ""%>><label for="<%=roles.get(j).getId()%>" style="margin-left: 5px"><%=roles.get(j).getName()%></label></div><%}%><div class="col-sm-6"><input type="checkbox" name="role" value="all user" id="all" <%=arr.get(path.toLowerCase()).contains("all user") ? "checked" : ""%>><label for="all" style="margin-left: 5px">All User</label></div><div class="col-sm-6"><input type="checkbox" name="role" value="guest" id="guest" <%=arr.get(path.toLowerCase()).contains("guest") ? "checked" : ""%>><label for="guest" style="margin-left: 5px">Guest</label></div><input type="hidden" name="id" value="<%=path%>"></td></tr></tbody></table></div><div class="modal-footer"><button type="submit" class="btn-fill btn btn-danger"><span>Update</span></button><button type="button" class="btn btn-default"><span>Đóng</span></button></div></form></div></div></div></div>';
                            document.body.appendChild(modal.firstChild);
                  let btn = document.body.lastChild.getElementsByTagName('button');
                  btn[0].onclick = function () {
                      document.body.lastChild.firstChild.classList.remove("in");
                      document.body.lastChild.children[1].classList.remove("in");
                      setTimeout(function () {
                          document.body.style = 'background-color: rgb(233, 235, 238) !important; ';
                          document.body.removeChild(document.body.lastChild);
                          window.onclick = null;
                      }, 100);
                      document.title = title;

                  }
                  btn[1].onclick = function () {
                      document.body.lastChild.firstChild.classList.remove("in");
                      document.body.lastChild.children[1].classList.remove("in");
                      setTimeout(function () {
                          document.body.style = 'background-color: rgb(233, 235, 238) !important; ';
                          document.body.removeChild(document.body.lastChild);
                          window.onclick = null;
                      }, 100);
                      document.title = title;

                  }
                  setTimeout(function () {
                      document.body.lastChild.children[1].classList.add("in");
                      document.body.lastChild.firstChild.classList.add("in");
                      window.onclick = function (e) {
                          if (!document.getElementsByClassName('modal-content')[0].contains(e.target)) {
                              document.body.lastChild.firstChild.classList.remove("in");
                              document.body.lastChild.children[1].classList.remove("in");
                              setTimeout(function () {
                                  document.body.style = 'background-color: rgb(233, 235, 238) !important;  ';
                                  document.body.removeChild(document.body.lastChild);
                                  window.onclick = null;
                              }, 100);
                              document.title = title;
                          }
                      };
                      document.title = "Update Request";
                  }, 1);
          <%} catch(Exception e) {}%>
              } else {
                  //document.body.style = 'overflow: hidden; padding-right: 17px; background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                  document.body.lastChild.children[1].classList.remove("in");
                  document.body.lastChild.firstChild.classList.remove("in");
                  setTimeout(function () {
                      document.body.style = 'background-color: rgb(233, 235, 238) !important; ';
                      document.body.removeChild(document.body.lastChild);
                      window.onclick = null;
                  }, 100);
                  document.title = title;
              }
          
      }
  </script>
                                             </td>
                                        </tr> 
                                        <%i++;
                                            }
                                        %>
                                    </tbody>
                                </table>
         <% if(arr.size() == 0) {%><div class="text-center mt-20 col-md-12"><span>Không có dữ liệu</span></div><%}%>
                                <div class="clearfix">
                                    <div class="hint-text">Showing <b id="from"><%=(arr.size() >= 10 ? 10 : arr.size())%></b> out of <b id="max"><%=arr.size()%></b> entries</div>
                                    <ul class="pagination">
                                        <li class="page-item disabled"><a onclick='paging(this, event)' href="" id='Previous'>Previous</a></li>
                                            <%
                                                for(int j = 0; j < p; j++) {
                                            %>
                                        <li class="page-item <%=(j==0) ? "active" : ""%>"><a onclick='paging(this, event)' href='<%=j+1%>' class="page-link"><%=j+1%></a></li>
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
                                                        for (var i = (p - 1) * 10 + 1; i <= (p * 10 > parseInt(m.innerHTML) ? parseInt(m.innerHTML) : p * 10); i++) {
                                                            document.getElementById(i).classList.add("hidden");
                                                        }
                                                        p = parseInt(str);
                                                        for (var i = (p - 1) * 10 + 1; i <= (p * 10 > parseInt(m.innerHTML) ? parseInt(m.innerHTML) : p * 10); i++) {
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
                                                        f.innerHTML = (parseInt(m.innerHTML) >= p * 10 ? 10 : (parseInt(m.innerHTML) - (p - 1) * 10));
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
                                                        for (var i = (p - 1) * 10 + 1; i <= (p * 10 > parseInt(m.innerHTML) ? parseInt(m.innerHTML) : p * 10); i++) {
                                                            document.getElementById(i).classList.add("hidden");
                                                        }
                                                        p = p - 1;
                                                        for (var i = (p - 1) * 10 + 1; i <= (p * 10 > parseInt(m.innerHTML) ? parseInt(m.innerHTML) : p * 10); i++) {
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
                                                        f.innerHTML = (parseInt(m.innerHTML) >= p * 10 ? 10 : (parseInt(m.innerHTML) - (p - 1) * 10));
                                                    } else if (input.innerHTML === "Next" && p !== max) {
                                                        let checks = document.querySelectorAll("input[type=checkbox]");
                                                        for (var i = 0; i < checks.length; i++) {
                                                            checks[i].checked = false;
                                                        }
                                                        let f = document.getElementById("from");
                                                        let m = document.getElementById("max");
                                                        document.getElementsByClassName("page-item active")[0].classList.remove("active");
                                                        document.getElementsByClassName("pagination")[0].children[p + 1].classList.add("active");
                                                        for (var i = (p - 1) * 10 + 1; i <= (p * 10 > parseInt(m.innerHTML) ? parseInt(m.innerHTML) : p * 10); i++) {
                                                            document.getElementById(i).classList.add("hidden");
                                                        }
                                                        p = p + 1;
                                                        for (var i = (p - 1) * 10 + 1; i <= (p * 10 > parseInt(m.innerHTML) ? parseInt(m.innerHTML) : p * 10); i++) {
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
                                                        f.innerHTML = (parseInt(m.innerHTML) >= p * 10 ? 10 : (parseInt(m.innerHTML) - (p - 1) * 10));
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
     <%if(request.getAttribute("message") != null) {%>
        <script>
            setTimeout(function() {
                alert("<%=(String)request.getAttribute("message")%>");
            }, 100);
        </script>
        <%}%>
</body>
</html>
