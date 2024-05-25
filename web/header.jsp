<%-- 
    Document   : header
    Created on : May 14, 2024, 7:15:15 PM
    Author     : Admin
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
    .form-control:focus {
  box-shadow: none;
}
.input-group {
    width: 300px;
        height: 38px;
    
}
  

.form-control-underlined {
  border-width: 0;
  border-bottom-width: 1px;
  border-radius: 0;
  padding-left: 0;
}


.form-control::placeholder {
  font-size: 0.95rem;
  color: #aaa;
  font-style: italic;
}
</style>
<script>
    function searching() {
        window.location.href = 'viewskill?search=' + document.getElementById('search-skill').value;
    }
</script>
<%
    User u = (User) session.getAttribute("email");
    if (u == null) {
%>
<header class="menu__header fix-menu" id="header-menu">
    <div class="navbar-header">
        <nav class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">
            <a href="home.jsp" class="navbar-brand d-flex align-items-center px-4 px-lg-5">
                <h2 class="m-0 text-primary"><i class="fa fa-book me-3"></i>Happy Programming</h2>
            </a>
            <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            
                 <div class="input-group">
            <div class="input-group-prepend"  >
              <button id="button-addon8" type="button" onclick="searching()" class="btn btn-danger" >
                  <i class="fa fa-search" aria-hidden="true"></i>
              </button>
            </div>
            <input placeholder="Skill ..." type="text" class="form-control" value="" id="search-skill">
          </div>
            
            
            <div  class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav ms-auto p-4 p-lg-0">
                    <a href="home.jsp" class="nav-item nav-link">Home</a>
                    <a href="404.jsp" class="nav-item nav-link">Messenger</a>
                    <a href="404.jsp" class="nav-item nav-link">List Request</a>
                    <a href="Contact.jsp" class="nav-item nav-link active">Contact</a>
                    <a href="SignIn.jsp" class="nav-item nav-link active">SignIn</a>
                </div>
            </div>
        </nav>

    </div>
</header>
<%
    } else {
        boolean isMentor = false;
        if (session.getAttribute("Mentee") == null) {
            isMentor = true;
        }
%>
<header class="menu__header fix-menu" id="header-menu">
    <div class="navbar-header">
        <nav class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0">
            <a href="home.jsp" class="navbar-brand d-flex align-items-center px-4 px-lg-5">
                <h2 class="m-0 text-primary"><i class="fa fa-book me-3"></i>Happy programming</h2>
            </a>
            <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
             <div class="input-group">
            <div class="input-group-prepend"  >
              <button id="button-addon8" type="button" onclick="searching()" class="btn btn-danger" >
                  <i class="fa fa-search" aria-hidden="true"></i>
              </button>
            </div>
          <input placeholder="Skill ..." type="text" class="form-control" value="" id="search-skill">
          </div>
            
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav ms-auto p-4 p-lg-0">
                    <a href="home.jsp" class="nav-item nav-link">Home</a>
                    <a href="#" class="nav-item nav-link">Messenger</a>
                    <a href="request" class="nav-item nav-link">List Request</a>
                    <a href="Contact.jsp" class="nav-item nav-link active">Contact</a>
                </div>
            </div>
       
   

    <ul class="nav navbar-nav navbar-right">
    <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            <i class="far fa-plus"></i> <%=u.getWallet()%>đ 
        </a>
        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
            <script>
                setInterval(async () => {
                    var resp = await fetch("api/wallet");
                    var data = await resp.json();
                    var m = document.getElementById("money-main");
                    if (data["wallet"] !== parseInt(m.innerHTML.toString().replaceAll('<i class="far fa-plus"></i> ', "").replaceAll('đ ', ''))) {
                        m.innerHTML = '<i class="far fa-plus"></i> ' + data["wallet"] + 'đ ';
                    }
                }, 500);
            </script>
            <a class="dropdown-item" href="profile.jsp">
                <img src="<%=u.getAvatar() == null ? "https://files.playerduo.net/production/images/avatar31.png" : u.getAvatar()%>" class="rounded-circle" style="max-height:45px; max-width: 45px" alt="User Avatar">
                <div class="ml-3">
                    <h5><%=u.getUsername()%></h5>
                    <p>ID: <%=u.getEmail()%></p>
                </div>
            </a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="wallet"><i class="fas fa-minus"></i> Rút tiền</a>
            <a class="dropdown-item" href="wallet"><i class="fas fa-credit-card"></i> Nạp Tiền</a>
            <% if(u.getRole().equalsIgnoreCase("mentor")) { %>
                <a class="dropdown-item" href="cv"><i class="fas fa-user-lock"></i> Tạo/Sửa CV</a>
            <% } %>
            <a class="dropdown-item" href="transaction"><i class="fas fa-clock"></i> Lịch sử giao dịch</a>
            <a class="dropdown-item" href="<%=(u.getRole().equalsIgnoreCase("admin") || u.getRole().equalsIgnoreCase("manager")) ? "admin/request" : "schedule"%>">
                <i class="fas fa-users"></i> <%=(u.getRole().equalsIgnoreCase("admin") || u.getRole().equalsIgnoreCase("manager")) ? "Admin Setting" : "Schedule"%>
            </a>
            <a class="dropdown-item" href="setting"><i class="fas fa-cogs"></i> Cài đặt tài khoản</a>
            <a class="dropdown-item" href="logout"><i class="fas fa-power-off"></i> Đăng xuất</a>
            <div class="box-item mt-2">
        <a href="#" target="_blank" rel="noopener noreferrer">
            <span>Fanpage</span>
        </a>
        <a href="#" target="_blank" onclick="popupReport()" rel="noopener noreferrer">
            <span>Report</span>
        </a>
    
</div>
        </div>
    </li>
</ul>

    
 </div>
 </nav>

<!-- Custom CSS -->
<style>
.nav-item.dropdown {
    position: relative;
}
.dropdown-menu {
    position: absolute;
    top: 100%;
    left: auto;
    right: 0;
    margin: 0;
    padding: 0.5rem 1rem;
    background-color: #fff;
    border: 1px solid #e3e6f0;
    border-radius: 0.35rem;
    box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
}
.dropdown-item {
    display: flex;
    align-items: center;
    padding: 0.5rem 1rem;
    color: #3a3b45;
    text-decoration: none;
}
.dropdown-item:hover {
    background-color: #f8f9fc;
    color: #2e59d9;
}
.dropdown-item img {
    margin-right: 0.75rem;
}
.dropdown-divider {
    height: 0;
    margin: 0.5rem 0;
    overflow: hidden;
    border-top: 1px solid #e3e6f0;
}
.list-flag {
    display: flex;
    align-items: center;
}
.box-item {
    margin-right: 1rem;
}
.box-item img.flag {
    max-height: 30px;
}
.box-item a {
    text-decoration: none;
    color: #3a3b45;
}
.box-item a:hover {
    text-decoration: underline;
}
</style>            

<script>
                        function popupReport() {
                            event.preventDefault();
                            if (!JSON.stringify(document.body.style).includes("overflow: hidden;")) {
                                let pre = document.body.style.cssText;
                                document.body.style = 'overflow: hidden; padding-right: 17px; ' + pre;
                                //document.body.style = 'background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                                let modal = document.createElement('div');
                                modal.innerHTML = '<div role="dialog" aria-hidden="true">\n\
<div class="fade modal-backdrop"></div>\n\
<div role="dialog" tabindex="-1" class="fade modal-donate modal" style="display: block;">\n\
<div class="modal-dialog">\n\
<div class="modal-content" role="document">\n\
<div class="modal-header">\n\
<button type="button" class="close">\n\
<span aria-hidden="true">×</span>\n\
<span class="sr-only">Close</span>\n\
</button>\n\
<h4 class="modal-title">\n\
<span>Report Reason</span>\n\
</h4>\n\
</div>\n\
<form method="post">\n\
<div class="modal-body">\n\
<table style="width: 100%;">\n\
  <tbody>\n\
    <tr>\n\
      <input type="hidden" name="type" value="report">\n\
      <input type="hidden" name="id" value="<%=u.getId()%>">\n\
      <td>\n\
        <span>Lý do report</span>:\n\
      </td>\n\
      <td>\n\
        <textarea placeholder="Nhập lý do..." required name="reason" maxlength="255" type="text" class="form-control" style="height:50px"></textarea>\n\
      </td>\n\
    </tr>\n\
  </tbody>\n\
</table>\n\
</div>\n\
<div class="modal-footer">\n\
<button type="submit" class="btn btn-success">\n\
  <span>Xác Nhận</span>\n\
</button>\n\
<button type="button" class="btn btn-default">\n\
  <span>Đóng</span>\n\
</button>\n\
</div>\n\
</form>\n\
</div>\n\
</div>\n\
</div>\n\
</div>';
                                document.body.appendChild(modal.firstChild);
                                let btn = document.body.lastChild.getElementsByTagName('button');
                                btn[0].onclick = function () {
                                    document.body.lastChild.children[0].classList.remove("in");
                                    document.body.lastChild.children[1].classList.remove("in");
                                    setTimeout(function () {
                                        document.body.style = (document.body.style.cssText).replace('overflow: hidden; padding-right: 17px; ', '');
                                        document.body.removeChild(document.body.lastChild);
                                        window.onclick = null;
                                    }, 100);

                                }
                                btn[2].onclick = function () {
                                    document.body.lastChild.children[0].classList.remove("in");
                                    document.body.lastChild.children[1].classList.remove("in");
                                    setTimeout(function () {
                                        document.body.style = (document.body.style.cssText).replace('overflow: hidden; padding-right: 17px; ', '');
                                        document.body.removeChild(document.body.lastChild);
                                        window.onclick = null;
                                    }, 100);

                                }
                                setTimeout(function () {
                                    document.body.lastChild.children[1].classList.add("in");
                                    document.body.lastChild.children[0].classList.add("in");
                                    window.onclick = function (e) {
                                        if (!document.getElementsByClassName('modal-content')[0].contains(e.target)) {
                                            document.body.lastChild.children[0].classList.remove("in");
                                            document.body.lastChild.children[1].classList.remove("in");
                                            setTimeout(function () {
                                                document.body.style = (document.body.style.cssText).replace('overflow: hidden; padding-right: 17px; ', '');
                                                document.body.removeChild(document.body.lastChild);
                                                window.onclick = null;
                                            }, 100);
                                        }
                                    };
                                }, 1);
                            } else {
                                //document.body.style = 'overflow: hidden; padding-right: 17px; background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                                document.body.lastChild.children[1].classList.remove("in");
                                document.body.lastChild.children[0].classList.remove("in");
                                setTimeout(function () {
                                    document.body.style = (document.body.style.cssText).replace('overflow: hidden; padding-right: 17px; ', '');
                                    document.body.removeChild(document.body.lastChild);
                                    window.onclick = null;
                                }, 100);
                            }
                        }
                        <%if(request.getAttribute("alert") != null) {%>
                        setTimeout(function () {
                            alert("<%=(String)request.getAttribute("alert")%>");
                        }, 1000);
                        <%}%>
                        <%if(session.getAttribute("alert") != null) {%>
                        setTimeout(function () {
                            alert("<%=(String)session.getAttribute("alert")%>");
                        }, 1000);
                        <%  session.removeAttribute("alert");
                        }%>
                    </script>
                </div>
            </ul>
        </li>
    </ul>
</div>

</header>
<!-- End Header -->
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
<% } %>