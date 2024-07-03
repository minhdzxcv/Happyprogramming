<%-- 
    Document   : HomePage
    Created on : Oct 5, 2022, 9:46:55 AM
    Author     : DELL
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Skill, java.util.ArrayList, model.User, model.Mentor, model.Mentee, model.Slot, model.FollowRequest, java.sql.Timestamp, DAO.MentorDAO, DAO.CvDAO, model.CV, DAO.SkillDAO, java.text.SimpleDateFormat, java.util.Calendar" %>
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

        

       
        <link href="css/8.97b85fe3.chunk.css" rel="stylesheet">
    

        
    </head>

    <body>
         <!-- ======= Hero Section ======= -->
         <div class="row">
          <%@include file="header.jsp" %>
           
       <div class="menu__header fix-menu">
            <div class="container" style="width: 1000px">
                 
       
            
                                       <div class="col-md-12" style="display: flex; justify-content: center;">
                        <form method='post'>
                            <h2 style="font-family: inherit;font-weight: 500;line-height: 1.1;color: inherit;"> Activities for
                                <span id="ctl00_mainContent_lblStudent"><%=u.getUsername()%>'s (<%=u.getFullname()%>)</span> schedule <%=(u.getRole().equalsIgnoreCase("mentor") && MentorDAO.acceptedCv(u.getId())) ? "<button class=\"btn btn-success\" onclick=\"newSlot()\" style=\"margin-left: 1.25vw\">New Slot</button>" : ""%></h2>
                                <button onclick="goBackToSchedule()">Back to Schedule</button>
                                <script>
    function goBackToSchedule() {
        // Redirect back to the schedule page
        window.location.href = "schedule";
    }
</script>
                                <%if(u.getRole().equalsIgnoreCase("mentor")) {%>
                            <script>
                                Date.prototype.addDays = function (days) {
                                    var date = new Date(this.valueOf());
                                    date.setDate(date.getDate() + days);
                                    return date;
                                }
                                function edit(id) {
                                    event.preventDefault();
                                    if (!JSON.stringify(document.body.style).includes("overflow: hidden;")) {
                                        setTimeout(async () => {
                                            document.body.style = 'overflow: hidden; padding-right: 17px; background-color: rgb(233, 235, 238) !important;  display:flex';
                                            //document.body.style = 'background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                                            var response = await fetch("api/schedule?sid=" + id);
                                            var data = await response.json();
                                            let slotDate = new Date(Date.parse(data["SlotTime"]));
                                            let SlotDateonly = [slotDate.getMonth()+1, slotDate.getDate(), slotDate.getFullYear()];
                                            var slotTime = SlotDateonly[2] + "-" + (parseInt(SlotDateonly[0]) < 10 ? "0" + SlotDateonly[0] : SlotDateonly[0]) + "-" + (parseInt(SlotDateonly[1]) < 10 ? "0" + SlotDateonly[1] : SlotDateonly[1]);
                                            var slotHour = slotDate.toTimeString().split(":")[0] + ":"+slotDate.toTimeString().split(":")[1];
                                            var slot = 0;
                                            if(slotHour === "05:00") {
                                                slot = 0;
                                            }
                                            if(slotHour === "07:30") {
                                                slot = 1;
                                            }
                                            if(slotHour === "10:00") {
                                                slot = 2;
                                            }
                                            if(slotHour === "12:50") {
                                                slot = 3;
                                            }
                                            if(slotHour === "15:20") {
                                                slot = 4;
                                            }
                                            if(slotHour === "17:50") {
                                                slot = 5;
                                            }
                                            if(slotHour === "20:30") {
                                                slot = 6;
                                            }
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
        <span>Update Slot</span>\n\
      </h4>\n\
    </div>\n\
    <form method="post">\n\
      <div class="modal-body">\n\
        <table style="width: 100%;">\n\
          <tbody>\n\
              <input type="hidden" name="type" value="update">\n\
              <input type="hidden" name="id" value="' + id + '">\n\
            <tr>\n\
              <td>\n\
                <span>Meet Link</span>:\n\
              </td>\n\
              <td>\n\
                <input placeholder="Nhập link meet" required name="link" maxlength="255" type="text" class="form-control" value="'+data["link"]+'"/>\n\
              </td>\n\
            </tr>\n\
            <tr>\n\
              <td>\n\
                <span>Ngày dạy slot</span>:\n\
              </td>\n\
              <td>\n\
                <input placeholder="Chọn ngày dạy" required name="start" type="date" class="form-control" value="'+slotTime+'"/>\n\
              </td>\n\
            </tr>\n\
            <tr>\n\
              <td>\n\
                <span>Chọn slot dạy học</span>:\n\
              </td>\n\
              <td>\n\
                <select name="slot" onchange="changeSlot(this)"><option value="0" '+(slot === 0 ? "selected" : "")+'>Slot 0 (05:00 - 07:20) </option><option value="1" '+(slot === 1 ? "selected" : "")+'>Slot 1 (07:30 - 09:50) </option><option value="2" '+(slot === 2 ? "selected" : "")+'>Slot 2 (10:00 - 12:20) </option><option value="3" '+(slot === 3 ? "selected" : "")+'>Slot 3 (12:50 - 15:10) </option><option value="4" '+(slot === 4 ? "selected" : "")+'>Slot 4 (15:20 - 17:40) </option><option value="5" '+(slot === 5 ? "selected" : "")+'>Slot 5 (17:50 - 20:10) </option><option value="6" '+(slot === 6 ? "selected" : "")+'>Slot 6 (20:30 - 22:50) </option></select>\n\
                <input class="hidden" type="time" name="time" value="'+slotHour+'">\n\
              </td>\n\
            </tr>\n\
                <input placeholder="Nhập số giờ dạy" required name="hour" type="hidden" class="form-control" value="'+data["hour"]+'"/>\n\
          </tbody>\n\
        </table>\n\
      </div>\n\
      <div class="modal-footer">\n\
        <button type="submit" onclick="validate(this, event)" class="btn btn-success">\n\
          <span>Cập Nhật</span>\n\
        </button>\n\
        <button type="button" class="btn ' + (parseInt(data["menteeId"]) === 0 ? "btn-danger" : "btn-default") + '">\n\
          <span>' + (parseInt(data["menteeId"]) === 0 ? "Xóa" : "Đóng") + '</span>\n\
        </button>\n\
      </div>\n\
    </form>\n\
  </div>\n\
</div>\n\
</div>\n\
</div>';
                                            let date = new Date();
                                            let dateonly = [date.getMonth()+1, date.getDate(), date.getFullYear()];
                                            modal.querySelector("input[type=date]").min = dateonly[2] + "-" + (parseInt(dateonly[0]) < 10 ? "0" + dateonly[0] : dateonly[0]) + "-" + (parseInt(dateonly[1]) < 10 ? "0" + dateonly[1] : dateonly[1]);
                                            document.body.appendChild(modal.firstChild);
                                            let btn = document.body.lastChild.getElementsByTagName('button');
                                            btn[0].onclick = function () {
                                                document.body.lastChild.children[0].classList.remove("in");
                                                document.body.lastChild.children[1].classList.remove("in");
                                                setTimeout(function () {
                                                    document.body.style = 'background-color: rgb(233, 235, 238) !important;display:flex';
                                                    document.body.removeChild(document.body.lastChild);
                                                    window.onclick = null;
                                                }, 100);

                                            }
                                            if (parseInt(data["menteeId"]) !== 0) {
                                                btn[2].onclick = function () {
                                                    document.body.lastChild.children[0].classList.remove("in");
                                                    document.body.lastChild.children[1].classList.remove("in");
                                                    setTimeout(function () {
                                                        document.body.style = 'background-color: rgb(233, 235, 238) !important; display:flex';
                                                        document.body.removeChild(document.body.lastChild);
                                                        window.onclick = null;
                                                    }, 100);

                                                }
                                            } else {
                                                btn[2].onclick = function () {
                                                    window.location.href = "schedule?type=delete&id="+id;
                                                }
                                            }
                                            setTimeout(function () {
                                                document.body.lastChild.children[1].classList.add("in");
                                                document.body.lastChild.children[0].classList.add("in");
                                                window.onclick = function (e) {
                                                    if (!document.getElementsByClassName('modal-content')[0].contains(e.target)) {
                                                        document.body.lastChild.children[0].classList.remove("in");
                                                        document.body.lastChild.children[1].classList.remove("in");
                                                        setTimeout(function () {
                                                            document.body.style = 'background-color: rgb(233, 235, 238) !important; display:flex';
                                                            document.body.removeChild(document.body.lastChild);
                                                            window.onclick = null;
                                                        }, 100);
                                                    }
                                                };
                                            }, 1);
                                        }, 0);
                                    } else {
                                        //document.body.style = 'overflow: hidden; padding-right: 17px; background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                                        document.body.lastChild.children[1].classList.remove("in");
                                        document.body.lastChild.children[0].classList.remove("in");
                                        setTimeout(function () {
                                            document.body.style = 'background-color: rgb(233, 235, 238) !important; display:flex';
                                            document.body.removeChild(document.body.lastChild);
                                            window.onclick = null;
                                        }, 100);
                                    }
                                }
                                function changeType(input) {
                                    let modal = input.parentNode.parentNode.parentNode;
                                    if (input.options[input.selectedIndex].value === 'byWeek') {
                                        let hidden = modal.querySelectorAll("tr[class=hidden]");
                                        let datetime = modal.querySelector("input[type=datetime-local]");
                                        datetime.setAttribute("type", "time");
                                        document.getElementsByName("fromDay")[0].setAttribute("required", "true");
                                        document.getElementsByName("toDay")[0].setAttribute("required", "true");
                                        for (let i = 0; i < hidden.length; i++) {
                                            hidden[i].classList = "unhidden";
                                        }
                                    } else {
                                        let hidden = modal.querySelectorAll("tr[class=unhidden]");
                                        let datetime = modal.querySelector("input[type=time]");
                                        datetime.setAttribute("type", "datetime-local");
                                        document.getElementsByName("fromDay")[0].removeAttribute("required");
                                        document.getElementsByName("toDay")[0].removeAttribute("required");
                                        for (let i = 0; i < hidden.length; i++) {
                                            hidden[i].classList = "hidden";
                                        }
                                    }
                                }
                                function URLValidate(url) {
                                    try {
                                        new URL(url);
                                        return true;
                                    } catch (e) {
                                        return false;
                                    }
                                }
                                function validate(input, event) {
                                    event.preventDefault();
                                    let link = document.querySelector("input[name=link]");
                                    let type = document.getElementById("schedule");
                                    if (type !== null && type.options[type.selectedIndex].value === "byWeek") {
                                        let checkbox = document.querySelectorAll("input[type=checkbox]");
                                        let count = 0;
                                        for (let i = 0; i < checkbox.length; i++) {
                                            if (checkbox[i].checked) {
                                                count++;
                                            }
                                        }
                                        if (count < 1) {
                                            alert("Bạn phải chọn ít nhất 1 ngày trong tuần!");
                                        } else {
                                            if (URLValidate(link.value)) {
                                                input.form.submit();
                                            } else {
                                                alert("Vui lòng nhập link chính xác!");
                                            }
                                        }
                                    } else {
                                        if (URLValidate(link.value)) {
                                            input.form.submit();
                                        } else {
                                            alert("Vui lòng nhập link chính xác!");
                                        }
                                    }
                                }
                                function changeSlot(select) {
                                    var time = document.querySelector("input[type=time]");
                                    if(select.value === '0') {
                                        time.value = "05:00";
                                    }
                                    if(select.value === '1') {
                                        time.value = "07:30";
                                    }
                                    if(select.value === '2') {
                                        time.value = "10:00";
                                    }
                                    if(select.value === '3') {
                                        time.value = "12:50";
                                    }
                                    if(select.value === '4') {
                                        time.value = "15:20";
                                    }
                                    if(select.value === '5') {
                                        time.value = "17:50";
                                    }
                                    if(select.value === '6') {
                                        time.value = "20:30";
                                    }
                                }
                                function newSlot() {
                                    event.preventDefault();
                                    if (!JSON.stringify(document.body.style).includes("overflow: hidden;")) {
                                        document.body.style = 'overflow: hidden; padding-right: 17px; background-color: rgb(233, 235, 238) !important; display:flex';
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
        <span>Thêm Slot</span>\n\
      </h4>\n\
    </div>\n\
    <form method="post">\n\
      <input class="hidden" placeholder="Chọn giờ bắt đầu" required name="start" type="datetime-local" class="form-control"/>\n\
      <input placeholder="Nhập số giờ dạy" required name="hour" type="hidden" value="1.33333333" class="form-control"/>\n\
      <div class="modal-body">\n\
        <table style="width: 100%;">\n\
          <tbody>\n\
              <input type="hidden" name="id" value="' + <%=u.getId()%> + '">\n\
            <tr>\n\
              <td>\n\
                <span>Meet Link</span>:\n\
              </td>\n\
              <td>\n\
                <input placeholder="Nhập link meet" required name="link" maxlength="255" type="text" class="form-control"/>\n\
              </td>\n\
            </tr>\n\
            <tr class="unhidden">\n\
              <td>\n\
                <span>Lịch học</span>:\n\
              </td>\n\
              <td>\n\
                <select id="schedule" name="type" required onchange="changeType(this)"><option value="byDay">Theo Ngày Cụ Thể</option><option selected value="byWeek">Theo Ngày Trong Tuần</option></select>\n\
              </td>\n\
            </tr>\n\
            <tr>\n\
              <td>\n\
                <span>Chọn slot dạy học</span>:\n\
              </td>\n\
              <td>\n\
                <select name="slot" onchange="changeSlot(this)"><option value="0">Slot 0 (05:00 - 07:20) </option><option value="1">Slot 1 (07:30 - 09:50) </option><option value="2">Slot 2 (10:00 - 12:20) </option><option value="3">Slot 3 (12:50 - 15:10) </option><option value="4">Slot 4 (15:20 - 17:40) </option><option value="5">Slot 5 (17:50 - 20:10) </option><option value="6">Slot 6 (20:30 - 22:50) </option></select>\n\
              </td>\n\
            </tr>\n\
            <tr class="hidden">\n\
              <td>\n\
                <span>Ngày trong tuần</span>:\n\
              </td>\n\
              <td>\n\
                <input type="checkbox" name="weekday" value="mon" id="mon" style="margin-left: 10px"><label style="margin-left: 2px" for="mon">Thứ 2</label>\n\
                <input type="checkbox" name="weekday" value="tue" id="tue" style="margin-left: 10px"><label style="margin-left: 2px" for="tue">Thứ 3</label>\n\
                <input type="checkbox" name="weekday" value="wen" id="wen" style="margin-left: 10px"><label style="margin-left: 2px" for="wen">Thứ 4</label>\n\
                <input type="checkbox" name="weekday" value="thu" id="thu" style="margin-left: 10px"><label style="margin-left: 2px" for="thu">Thứ 5</label>\n\
                <input type="checkbox" name="weekday" value="fri" id="fri" style="margin-left: 10px"><label style="margin-left: 2px" for="fri">Thứ 6</label>\n\
                <input type="checkbox" name="weekday" value="sat" id="sat" style="margin-left: 10px"><label style="margin-left: 2px" for="sat">Thứ 7</label>\n\
                <input type="checkbox" name="weekday" value="sun" id="sun" style="margin-left: 10px"><label style="margin-left: 2px" for="sun">CN</label>\n\
              </td>\n\
            </tr>\n\
            <tr class="hidden">\n\
              <td>\n\
                <span>Thời gian thực hiện</span>:\n\
              </td>\n\
              <td>\n\
                <input placeholder="Chọn ngày bắt đầu" name="fromDay" required type="date" style="max-width: 50%;float: left;" class="form-control"/>\n\
                <input placeholder="Chọn ngày kết thúc" name="toDay" required type="date" style="max-width: 50%;float: left;" class="form-control"/>\n\
              </td>\n\
            </tr>\n\
          </tbody>\n\
        </table>\n\
      </div>\n\
      <div class="modal-footer">\n\
        <button type="submit" onclick="validate(this, event)" class="btn btn-success">\n\
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
                                        let date = new Date();
                                        date = date.addDays(7);
                                        let dateonly = [date.getMonth()+1, date.getDate(), date.getFullYear()];
                                        modal.querySelector("input[type=datetime-local]").min = dateonly[2] + "-" + (parseInt(dateonly[1]) < 10 ? "0" + dateonly[1] : dateonly[1]) + "-" + (parseInt(dateonly[0]) < 10 ? "0" + dateonly[0] : dateonly[0]) + "T" + date.toTimeString().split(":")[0] + ":" + date.toTimeString().split(":")[1];
                                        document.body.appendChild(modal.firstChild);
                                        var fromDate = document.querySelector("input[name=fromDay]");
                                        var toDate = document.querySelector("input[name=toDay]");
                                        fromDate.min = dateonly[2] + "-" + (parseInt(dateonly[0]) < 10 ? "0" + dateonly[0] : dateonly[0]) + "-" + (parseInt(dateonly[1]) < 10 ? "0" + dateonly[1] : dateonly[1]);
                                        toDate.min = dateonly[2] + "-" + (parseInt(dateonly[0]) < 10 ? "0" + dateonly[0] : dateonly[0]) + "-" + (parseInt(dateonly[1]) < 10 ? "0" + dateonly[1] : dateonly[1]);
                                        fromDate.onchange = function (e) {
                                            if (toDate.value) {
                                                if (fromDate.value >= toDate.value) {
                                                    alert("Ngày bắt đầu phải trước ngày kết thúc");
                                                    fromDate.value = null;
                                                }
                                            }
                                        }
                                        toDate.onchange = function (e) {
                                            if (fromDate.value) {
                                                if (fromDate.value >= toDate.value) {
                                                    alert("Ngày bắt đầu phải trước ngày kết thúc");
                                                    toDate.value = null;
                                                }
                                            }
                                        }
                                        let hidden = document.querySelectorAll("tr[class=hidden]");
                                        let unhidden = document.querySelectorAll("tr[class=unhidden]");
                                        unhidden[0].classList = "hidden";
                                        let datetime = document.querySelector("input[type=datetime-local]");
                                        datetime.setAttribute("type", "time");
                                        datetime.value = "05:00";
                                        document.getElementsByName("fromDay")[0].setAttribute("required", "true");
                                        document.getElementsByName("toDay")[0].setAttribute("required", "true");
                                        for (let i = 0; i < hidden.length; i++) {
                                            hidden[i].classList = "unhidden";
                                        }
                                        let btn = document.body.lastChild.getElementsByTagName('button');
                                        btn[0].onclick = function () {
                                            document.body.lastChild.children[0].classList.remove("in");
                                            document.body.lastChild.children[1].classList.remove("in");
                                            setTimeout(function () {
                                                document.body.style = 'background-color: rgb(233, 235, 238) !important; display:flex';
                                                document.body.removeChild(document.body.lastChild);
                                                window.onclick = null;
                                            }, 100);

                                        }
                                        btn[2].onclick = function () {
                                            document.body.lastChild.children[0].classList.remove("in");
                                            document.body.lastChild.children[1].classList.remove("in");
                                            setTimeout(function () {
                                                document.body.style = 'background-color: rgb(233, 235, 238) !important;  display:flex';
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
                                                        document.body.style = 'background-color: rgb(233, 235, 238) !important; display:flex';
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
                                            document.body.style = 'background-color: rgb(233, 235, 238) !important; display:flex';
                                            document.body.removeChild(document.body.lastChild);
                                            window.onclick = null;
                                        }, 100);
                                    }
                                }
                            </script>
                            <% } %>
                            <table style="font-size: 13px; border: 2px solid white;">
                                <tbody>
                                    <tr style="border-bottom: 0 none">
                                        <td>
                                            <div>
                                                <%
                                                    int year = (int)request.getAttribute("year");
                                                    int numberOfWeek = (int)request.getAttribute("numberOfWeek");
                                                    int weekOfYear = (int)request.getAttribute("weekOfYear");
                                                    Calendar fistDate = (Calendar)request.getAttribute("fistDate");
                                                    Calendar firstOfWeek = (Calendar)request.getAttribute("firstOfWeek");
                                                    Calendar endWeek = Calendar.getInstance();
                                                    endWeek.setTime(fistDate.getTime());
                                                    endWeek.add(Calendar.DATE, 6);
                                                    ArrayList<Slot> arr = (ArrayList)request.getAttribute("Slots");
                                                    ArrayList<Slot> mon = new ArrayList();
                                                    ArrayList<Slot> tue = new ArrayList();
                                                    ArrayList<Slot> wen = new ArrayList();
                                                    ArrayList<Slot> thu = new ArrayList();
                                                    ArrayList<Slot> fri = new ArrayList();
                                                    ArrayList<Slot> sat = new ArrayList();
                                                    ArrayList<Slot> sun = new ArrayList();
                                                    int[] hod = new int[] { 5, 7, 10, 12, 15, 17, 20 };
                                                    for(int i = 0; i < arr.size(); i++) {
                                                        Calendar c = Calendar.getInstance();
                                                        c.setTime(arr.get(i).getSlotTime());
                                                        if(c.get(Calendar.DAY_OF_WEEK) == 1) {
                                                            while(c.get(Calendar.HOUR_OF_DAY) != hod[sun.size()]) {
                                                                sun.add(null);
                                                            }
                                                            sun.add(arr.get(i));
                                                        }
                                                        if(c.get(Calendar.DAY_OF_WEEK) == 2) {
                                                            while(c.get(Calendar.HOUR_OF_DAY) != hod[mon.size()]) {
                                                                mon.add(null);
                                                            }
                                                            mon.add(arr.get(i));
                                                        }
                                                        if(c.get(Calendar.DAY_OF_WEEK) == 3) {
                                                            while(c.get(Calendar.HOUR_OF_DAY) != hod[tue.size()]) {
                                                                tue.add(null);
                                                            }
                                                            tue.add(arr.get(i));
                                                        }
                                                        if(c.get(Calendar.DAY_OF_WEEK) == 4) {
                                                            while(c.get(Calendar.HOUR_OF_DAY) != hod[wen.size()]) {
                                                                wen.add(null);
                                                            }
                                                            wen.add(arr.get(i));
                                                        }
                                                        if(c.get(Calendar.DAY_OF_WEEK) == 5) {
                                                            while(c.get(Calendar.HOUR_OF_DAY) != hod[thu.size()]) {
                                                                thu.add(null);
                                                            }
                                                            thu.add(arr.get(i));
                                                        }
                                                        if(c.get(Calendar.DAY_OF_WEEK) == 6) {
                                                            while(c.get(Calendar.HOUR_OF_DAY) != hod[fri.size()]) {
                                                                fri.add(null);
                                                            }
                                                            fri.add(arr.get(i));
                                                        }
                                                        if(c.get(Calendar.DAY_OF_WEEK) == 7) {
                                                            while(c.get(Calendar.HOUR_OF_DAY) != hod[sat.size()]) {
                                                                sat.add(null);
                                                            }
                                                            sat.add(arr.get(i));
                                                        }
                                                    }
                                                    int max = mon.size();
                                                    if(tue.size() > max) max = tue.size();
                                                    if(wen.size() > max) max = wen.size();
                                                    if(thu.size() > max) max = thu.size();
                                                    if(fri.size() > max) max = fri.size();
                                                    if(sat.size() > max) max = sat.size();
                                                    if(sun.size() > max) max = sun.size();
                                                %>
                                                <style>
                                                    th {
                                                        border-right: 1px solid #fff;
                                                        text-align: center;
                                                        padding: 2px;
                                                        text-transform: uppercase;
                                                        height: 23px;
                                                        background-color: #6b90da;
                                                        font-weight: normal;
                                                        min-width: 5.5vw;
                                                    }
                                                    th.year-week {
                                                        min-width: 12.25vw;
                                                    }
                                                    tbody th {
                                                        text-align: left;
                                                        padding: 2px;
                                                    }
                                                    table:not(.modal-body table), th, td:not(.modal-body td) {
                                                        border: 1px solid;
                                                    }
                                                    div.online-indicator {
                                                        display: inline-block;
                                                        width: 15px;
                                                        height: 15px;
                                                        margin-right: 5px;

                                                        background-color: #0fcc45;
                                                        border-radius: 50%;

                                                        position: relative;
                                                    }
                                                    span.blink {
                                                        display: block;
                                                        width: 15px;
                                                        height: 15px;

                                                        background-color: #0fcc45;
                                                        opacity: 0.7;
                                                        border-radius: 50%;

                                                        animation: blink 1s linear infinite;
                                                    }

                                                    h3.online-text {
                                                        display: inline;

                                                        font-family: 'Rubik', sans-serif;
                                                        font-weight: 400;
                                                        text-shadow: 0px 3px 6px rgba(150, 150, 150, 0.2);

                                                        position: relative;
                                                        cursor: pointer;
                                                    }

                                                    /*Animations*/

                                                    @keyframes blink {
                                                        100% {
                                                            transform: scale(2, 2);
                                                            opacity: 0;
                                                        }
                                                    }
                                                    .auto-style1 {
                                                        color: #FF3300;
                                                    }
                                                    .auto-style2 {
                                                        color: #FF3300;
                                                        font-size: 14pt;
                                                    }
                                                </style>
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th rowspan="2" class='year-week'>
                                                                <span class="auto-style1"><strong>Year</strong></span>
                                                                <script>
                                                                    function changeYear() {
                                                                        let weekSel = document.getElementById('ctl00_mainContent_drpSelectWeek');
                                                                        weekSel.options[weekSel.selectedIndex].value = 1;
                                                                        setTimeout(function () {
                                                                            document.getElementById('ctl00_mainContent_drpYear').form.submit()
                                                                        }, 500);
                                                                    }
                                                                    function confirmation(input, event) {
                                                                        event.preventDefault();
                                                                        if (!JSON.stringify(document.body.style).includes("overflow: hidden;")) {
                                                                            document.body.style = 'overflow: hidden; padding-right: 17px; background-color: rgb(233, 235, 238) !important; display:flex';
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
        <span>Xác nhận hoàn thành</span>\n\
      </h4>\n\
    </div>\n\
      <div class="modal-body">\n\
Xác nhận đã hoàn thành Slot học này?\n\
      </div>\n\
      <div class="modal-footer">\n\
        <button type="submit" class="btn btn-success">\n\
          <span>Xác Nhận</span>\n\
        </button>\n\
        <button type="button" class="btn btn-default">\n\
          <span>Đóng</span>\n\
        </button>\n\
      </div>\n\
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
                                                                                    document.body.style = 'background-color: rgb(233, 235, 238) !important; display:flex';
                                                                                    document.body.removeChild(document.body.lastChild);
                                                                                    window.onclick = null;
                                                                                }, 100);

                                                                            }
                                                                            btn[1].onclick = function () {
                                                                                window.location.href = input.href;
                                                                            }
                                                                            btn[2].onclick = function () {
                                                                                document.body.lastChild.children[0].classList.remove("in");
                                                                                document.body.lastChild.children[1].classList.remove("in");
                                                                                setTimeout(function () {
                                                                                    document.body.style = 'background-color: rgb(233, 235, 238) !important;  display:flex';
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
                                                                                            document.body.style = 'background-color: rgb(233, 235, 238) !important; display:flex';
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
                                                                                document.body.style = 'background-color: rgb(233, 235, 238) !important;  display:flex';
                                                                                document.body.removeChild(document.body.lastChild);
                                                                                window.onclick = null;
                                                                            }, 100);
                                                                        }
                                                                    }
                                                                </script>
                                                                <select name="year" onchange="changeYear()" id="ctl00_mainContent_drpYear">
                                                                    <option value="<%=year-3%>"><%=year-3%></option>
                                                                    <option value="<%=year-2%>"><%=year-2%></option>
                                                                    <option value="<%=year-1%>"><%=year-1%></option>
                                                                    <option selected="selected" value="<%=year%>"><%=year%></option>
                                                                    <option value="<%=year+1%>"><%=year+1%></option>
                                                                </select>
                                                                <br>
                                                                Week
                                                                <select name="week" onchange="setTimeout(function () {
                                                                            document.getElementById('ctl00_mainContent_drpYear').form.submit()
                                                                        }, 500)" id="ctl00_mainContent_drpSelectWeek">
                                                                    <%for(int i = 0; i < numberOfWeek; i++) {
                                                                        if(endWeek.get(Calendar.YEAR) == year) {
                                                                    %>
                                                                    <option <%= (i+1) == weekOfYear ? "selected" : ""%> value="<%=i+1%>"><%=fistDate.get(Calendar.DAY_OF_MONTH) < 10 ? "0"+fistDate.get(Calendar.DAY_OF_MONTH) : fistDate.get(Calendar.DAY_OF_MONTH)%>/<%=(fistDate.get(Calendar.MONTH)+1) < 10 ? "0"+(fistDate.get(Calendar.MONTH)+1) : (fistDate.get(Calendar.MONTH)+1)%> To <%=endWeek.get(Calendar.DAY_OF_MONTH) < 10 ? "0"+endWeek.get(Calendar.DAY_OF_MONTH) : endWeek.get(Calendar.DAY_OF_MONTH)%>/<%=(endWeek.get(Calendar.MONTH)+1) < 10 ? "0"+(endWeek.get(Calendar.MONTH)+1) : (endWeek.get(Calendar.MONTH)+1)%></option>
                                                                    <%  fistDate.add(Calendar.DATE, 7);
                                                                        endWeek.add(Calendar.DATE, 7);
                                                                        }}%>
                                                                </select>
                                                            </th>
                                                            <th align="center">Mon</th><th align="center">Tue</th><th align="center">Wed</th><th align="center">Thu</th><th align="center">Fri</th><th align="center">Sat</th><th align="center">Sun</th>
                                                        </tr>
                                                        <tr>
                                                            <%for(int i = 0; i < 7; i++) {%>
                                                            <th align="center"><%=firstOfWeek.get(Calendar.DAY_OF_MONTH) < 10 ? "0"+firstOfWeek.get(Calendar.DAY_OF_MONTH) : firstOfWeek.get(Calendar.DAY_OF_MONTH)%>/<%=(firstOfWeek.get(Calendar.MONTH)+1) < 10 ? "0"+(firstOfWeek.get(Calendar.MONTH)+1) : (firstOfWeek.get(Calendar.MONTH)+1)%></th>
                                                                <%  
                                                                    firstOfWeek.add(Calendar.DATE, 1);
                                                                }%>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%for(int i = 0; i < (7 < max ? max : 7); i++) {%>
                                                        <tr>
                                                            <td>Slot <%=i%> </td>
                                                            <td>
                                                                <%if(mon.size() > i && mon.get(i) != null) {
                                                                    Slot s = mon.get(i);
                                                                %>
                                                                <p>
                                                                    <a href="#" <%if(u.getRole().equalsIgnoreCase("mentor") && (s.getStatus().toLowerCase().contains("not confirm") || s.getStatus().toLowerCase().contains("not paid"))) {%>onclick="edit(<%=s.getId()%>)" <%}%>><%=s.getSkill() == null ? "Free" : s.getSkill()%>-</a>
                                                                    <a class="label label-default" href="<%=(u.getRole().equalsIgnoreCase("mentee") && s.getStatus().toLowerCase().contains("not paid")) ? "#" : (((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "#" : s.getLink())%>">Meet URL</a>
                                                                    <span>
                                                                        <br>( <font color="<%=((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "green" : "red"%>"><%=((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "Done" : "Not Yet"%></font>)
                                                                        <%  java.util.Date today = new java.util.Date();
                                                                            if(s.getSkill() != null && !((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done") || s.getStatus().toLowerCase().contains("not paid")) && today.after(s.getSlotTime())) {%>
                                                                        <a class="label label-success" target="_blank" onclick="confirmation(this, event)" href="schedule?type=confirm&id=<%=s.getId()%>">-Confirm </a>
                                                                        <%}%>
                                                                    </span><br>
                                                                    <%
                                                                        Calendar c = Calendar.getInstance();
                                                                        c.setTime(s.getSlotTime());
                                                                        Calendar to = Calendar.getInstance();
                                                                        to.setTime(s.getSlotTime());
                                                                        to.add(Calendar.MINUTE, (int)(60*s.getHour()));
                                                                    %>
                                                                    <span class="label label-<%=s.getStatus().toLowerCase().contains("done") ? "default" : "success"%>">(<%=c.get(Calendar.HOUR_OF_DAY) < 10 ? "0" + c.get(Calendar.HOUR_OF_DAY) : c.get(Calendar.HOUR_OF_DAY)%>:<%=c.get(Calendar.MINUTE) < 10 ? "0"+c.get(Calendar.MINUTE) : c.get(Calendar.MINUTE)%>-<%=to.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+to.get(Calendar.HOUR_OF_DAY) : to.get(Calendar.HOUR_OF_DAY)%>:<%=to.get(Calendar.MINUTE) < 10 ? "0"+to.get(Calendar.MINUTE) : to.get(Calendar.MINUTE)%>)</span>
                                                                    <br>
                                                                </p>
                                                                <%} else {%>
                                                                -
                                                                <%}%>
                                                            </td>
                                                            <td>
                                                                <%if(tue.size() > i && tue.get(i) != null) {
                                                                    Slot s = tue.get(i);
                                                                %>
                                                                <p>
                                                                    <a href="#" <%if(u.getRole().equalsIgnoreCase("mentor") && (s.getStatus().toLowerCase().contains("not confirm") || s.getStatus().toLowerCase().contains("not paid"))) {%>onclick="edit(<%=s.getId()%>)" <%}%>><%=s.getSkill() == null ? "Free" : s.getSkill()%>-</a>
                                                                    <a class="label label-default" href="<%=(u.getRole().equalsIgnoreCase("mentee") && s.getStatus().toLowerCase().contains("not paid")) ? "#" : (((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "#" : s.getLink())%>">Meet URL</a>
                                                                    <span>
                                                                        <br>( <font color="<%=((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "green" : "red"%>"><%=((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "Done" : "Not Yet"%></font>)
                                                                        <%  java.util.Date today = new java.util.Date();
                                                                            if(s.getSkill() != null && !((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done") || s.getStatus().toLowerCase().contains("not paid")) && today.after(s.getSlotTime())) {%>
                                                                        <a class="label label-success" target="_blank" onclick="confirmation(this, event)" href="schedule?type=confirm&id=<%=s.getId()%>">-Confirm </a>
                                                                        <%}%>
                                                                    </span><br>
                                                                    <%
                                                                        Calendar c = Calendar.getInstance();
                                                                        c.setTime(s.getSlotTime());
                                                                        Calendar to = Calendar.getInstance();
                                                                        to.setTime(s.getSlotTime());
                                                                        to.add(Calendar.MINUTE, (int)(60*s.getHour()));
                                                                    %>
                                                                    <span class="label label-<%=s.getStatus().toLowerCase().contains("done") ? "default" : "success"%>">(<%=c.get(Calendar.HOUR_OF_DAY) < 10 ? "0" + c.get(Calendar.HOUR_OF_DAY) : c.get(Calendar.HOUR_OF_DAY)%>:<%=c.get(Calendar.MINUTE) < 10 ? "0"+c.get(Calendar.MINUTE) : c.get(Calendar.MINUTE)%>-<%=to.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+to.get(Calendar.HOUR_OF_DAY) : to.get(Calendar.HOUR_OF_DAY)%>:<%=to.get(Calendar.MINUTE) < 10 ? "0"+to.get(Calendar.MINUTE) : to.get(Calendar.MINUTE)%>)</span>
                                                                    <br>
                                                                </p>
                                                                <%} else {%>
                                                                -
                                                                <%}%>
                                                            </td>
                                                            <td>
                                                                <%if(wen.size() > i && wen.get(i) != null) {
                                                                    Slot s = wen.get(i);
                                                                %>
                                                                <p>
                                                                    <a href="#" <%if(u.getRole().equalsIgnoreCase("mentor") && (s.getStatus().toLowerCase().contains("not confirm") || s.getStatus().toLowerCase().contains("not paid"))) {%>onclick="edit(<%=s.getId()%>)" <%}%>><%=s.getSkill() == null ? "Free" : s.getSkill()%>-</a>
                                                                    <a class="label label-default" href="<%=(u.getRole().equalsIgnoreCase("mentee") && s.getStatus().toLowerCase().contains("not paid")) ? "#" : (((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "#" : s.getLink())%>">Meet URL</a>
                                                                    <span>
                                                                        <br>( <font color="<%=((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "green" : "red"%>"><%=((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "Done" : "Not Yet"%></font>)
                                                                        <%  java.util.Date today = new java.util.Date();
                                                                            if(s.getSkill() != null && !((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done") || s.getStatus().toLowerCase().contains("not paid")) && today.after(s.getSlotTime())) {%>
                                                                        <a class="label label-success" target="_blank" onclick="confirmation(this, event)" href="schedule?type=confirm&id=<%=s.getId()%>">-Confirm </a>
                                                                        <%}%>
                                                                    </span><br>
                                                                    <%
                                                                        Calendar c = Calendar.getInstance();
                                                                        c.setTime(s.getSlotTime());
                                                                        Calendar to = Calendar.getInstance();
                                                                        to.setTime(s.getSlotTime());
                                                                        to.add(Calendar.MINUTE, (int)(60*s.getHour()));
                                                                    %>
                                                                    <span class="label label-<%=s.getStatus().toLowerCase().contains("done") ? "default" : "success"%>">(<%=c.get(Calendar.HOUR_OF_DAY) < 10 ? "0" + c.get(Calendar.HOUR_OF_DAY) : c.get(Calendar.HOUR_OF_DAY)%>:<%=c.get(Calendar.MINUTE) < 10 ? "0"+c.get(Calendar.MINUTE) : c.get(Calendar.MINUTE)%>-<%=to.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+to.get(Calendar.HOUR_OF_DAY) : to.get(Calendar.HOUR_OF_DAY)%>:<%=to.get(Calendar.MINUTE) < 10 ? "0"+to.get(Calendar.MINUTE) : to.get(Calendar.MINUTE)%>)</span>
                                                                    <br>
                                                                </p>
                                                                <%} else {%>
                                                                -
                                                                <%}%>
                                                            </td>
                                                            <td>
                                                                <%if(thu.size() > i && thu.get(i) != null) {
                                                                    Slot s = thu.get(i);
                                                                %>
                                                                <p>
                                                                    <a href="#" <%if(u.getRole().equalsIgnoreCase("mentor") && (s.getStatus().toLowerCase().contains("not confirm") || s.getStatus().toLowerCase().contains("not paid"))) {%>onclick="edit(<%=s.getId()%>)" <%}%>><%=s.getSkill() == null ? "Free" : s.getSkill()%>-</a>
                                                                    <a class="label label-default" href="<%=(u.getRole().equalsIgnoreCase("mentee") && s.getStatus().toLowerCase().contains("not paid")) ? "#" : (((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "#" : s.getLink())%>">Meet URL</a>
                                                                    <span>
                                                                        <br>( <font color="<%=((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "green" : "red"%>"><%=((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "Done" : "Not Yet"%></font>) 
                                                                        <%  java.util.Date today = new java.util.Date();
                                                                            if(s.getSkill() != null && !((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done") || s.getStatus().toLowerCase().contains("not paid")) && today.after(s.getSlotTime())) {%>
                                                                        <a class="label label-success" target="_blank" onclick="confirmation(this, event)" href="schedule?type=confirm&id=<%=s.getId()%>">-Confirm </a>
                                                                        <%}%>
                                                                    </span><br>
                                                                    <%
                                                                        Calendar c = Calendar.getInstance();
                                                                        c.setTime(s.getSlotTime());
                                                                        Calendar to = Calendar.getInstance();
                                                                        to.setTime(s.getSlotTime());
                                                                        to.add(Calendar.MINUTE, (int)(60*s.getHour()));
                                                                    %>
                                                                    <span class="label label-<%=s.getStatus().toLowerCase().contains("done") ? "default" : "success"%>">(<%=c.get(Calendar.HOUR_OF_DAY) < 10 ? "0" + c.get(Calendar.HOUR_OF_DAY) : c.get(Calendar.HOUR_OF_DAY)%>:<%=c.get(Calendar.MINUTE) < 10 ? "0"+c.get(Calendar.MINUTE) : c.get(Calendar.MINUTE)%>-<%=to.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+to.get(Calendar.HOUR_OF_DAY) : to.get(Calendar.HOUR_OF_DAY)%>:<%=to.get(Calendar.MINUTE) < 10 ? "0"+to.get(Calendar.MINUTE) : to.get(Calendar.MINUTE)%>)</span>
                                                                    <br>
                                                                </p>
                                                                <%} else {%>
                                                                -
                                                                <%}%>
                                                            </td>
                                                            <td>
                                                                <%if(fri.size() > i && fri.get(i) != null) {
                                                                    Slot s = fri.get(i);
                                                                %>
                                                                <p>
                                                                    <a href="#" <%if(u.getRole().equalsIgnoreCase("mentor") && (s.getStatus().toLowerCase().contains("not confirm") || s.getStatus().toLowerCase().contains("not paid"))) {%>onclick="edit(<%=s.getId()%>)" <%}%>><%=s.getSkill() == null ? "Free" : s.getSkill()%>-</a>
                                                                    <a class="label label-default" href="<%=(u.getRole().equalsIgnoreCase("mentee") && s.getStatus().toLowerCase().contains("not paid")) ? "#" : (((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "#" : s.getLink())%>">Meet URL</a>
                                                                    <span>
                                                                        <br>( <font color="<%=((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "green" : "red"%>"><%=((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "Done" : "Not Yet"%></font>) 
                                                                        <%  java.util.Date today = new java.util.Date();
                                                                            if(s.getSkill() != null && !((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done") || s.getStatus().toLowerCase().contains("not paid")) && today.after(s.getSlotTime())) {%>
                                                                        <a class="label label-success" target="_blank" onclick="confirmation(this, event)" href="schedule?type=confirm&id=<%=s.getId()%>">-Confirm </a>
                                                                        <%}%>
                                                                    </span><br>
                                                                    <%
                                                                        Calendar c = Calendar.getInstance();
                                                                        c.setTime(s.getSlotTime());
                                                                        Calendar to = Calendar.getInstance();
                                                                        to.setTime(s.getSlotTime());
                                                                        to.add(Calendar.MINUTE, (int)(60*s.getHour()));
                                                                    %>
                                                                    <span class="label label-<%=s.getStatus().toLowerCase().contains("done") ? "default" : "success"%>">(<%=c.get(Calendar.HOUR_OF_DAY) < 10 ? "0" + c.get(Calendar.HOUR_OF_DAY) : c.get(Calendar.HOUR_OF_DAY)%>:<%=c.get(Calendar.MINUTE) < 10 ? "0"+c.get(Calendar.MINUTE) : c.get(Calendar.MINUTE)%>-<%=to.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+to.get(Calendar.HOUR_OF_DAY) : to.get(Calendar.HOUR_OF_DAY)%>:<%=to.get(Calendar.MINUTE) < 10 ? "0"+to.get(Calendar.MINUTE) : to.get(Calendar.MINUTE)%>)</span>
                                                                    <br>
                                                                </p>
                                                                <%} else {%>
                                                                -
                                                                <%}%>
                                                            </td>
                                                            <td>
                                                                <%if(sat.size() > i && sat.get(i) != null) {
                                                                    Slot s = sat.get(i);
                                                                %>
                                                                <p>
                                                                    <a href="#" <%if(u.getRole().equalsIgnoreCase("mentor") && (s.getStatus().toLowerCase().contains("not confirm") || s.getStatus().toLowerCase().contains("not paid"))) {%>onclick="edit(<%=s.getId()%>)" <%}%>><%=s.getSkill() == null ? "Free" : s.getSkill()%>-</a>
                                                                    <a class="label label-default" href="<%=(u.getRole().equalsIgnoreCase("mentee") && s.getStatus().toLowerCase().contains("not paid")) ? "#" : (((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "#" : s.getLink())%>">Meet URL</a>
                                                                    <span>
                                                                        <br>( <font color="<%=((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "green" : "red"%>"><%=((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "Done" : "Not Yet"%></font>)
                                                                        <%  java.util.Date today = new java.util.Date();
                                                                            if(s.getSkill() != null && !((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done") || s.getStatus().toLowerCase().contains("not paid")) && today.after(s.getSlotTime())) {%>
                                                                        <a class="label label-success" target="_blank" onclick="confirmation(this, event)" href="schedule?type=confirm&id=<%=s.getId()%>">-Confirm </a>
                                                                        <%}%>
                                                                    </span><br>
                                                                    <%
                                                                        Calendar c = Calendar.getInstance();
                                                                        c.setTime(s.getSlotTime());
                                                                        Calendar to = Calendar.getInstance();
                                                                        to.setTime(s.getSlotTime());
                                                                        to.add(Calendar.MINUTE, (int)(60*s.getHour()));
                                                                    %>
                                                                    <span class="label label-<%=s.getStatus().toLowerCase().contains("done") ? "default" : "success"%>">(<%=c.get(Calendar.HOUR_OF_DAY) < 10 ? "0" + c.get(Calendar.HOUR_OF_DAY) : c.get(Calendar.HOUR_OF_DAY)%>:<%=c.get(Calendar.MINUTE) < 10 ? "0"+c.get(Calendar.MINUTE) : c.get(Calendar.MINUTE)%>-<%=to.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+to.get(Calendar.HOUR_OF_DAY) : to.get(Calendar.HOUR_OF_DAY)%>:<%=to.get(Calendar.MINUTE) < 10 ? "0"+to.get(Calendar.MINUTE) : to.get(Calendar.MINUTE)%>)</span>
                                                                    <br>
                                                                </p>
                                                                <%} else {%>
                                                                -
                                                                <%}%>
                                                            </td>
                                                            <td>
                                                                <%if(sun.size() > i && sun.get(i) != null) {
                                                                    Slot s = sun.get(i);
                                                                %>
                                                                <p>
                                                                    <a href="#" <%if(u.getRole().equalsIgnoreCase("mentor") && (s.getStatus().toLowerCase().contains("not confirm") || s.getStatus().toLowerCase().contains("not paid"))) {%>onclick="edit(<%=s.getId()%>)" <%}%>><%=s.getSkill() == null ? "Free" : s.getSkill()%>-</a>
                                                                    <a class="label label-default" href="<%=(u.getRole().equalsIgnoreCase("mentee") && s.getStatus().toLowerCase().contains("not paid")) ? "#" : (((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "#" : s.getLink())%>">Meet URL</a>
                                                                    <span>
                                                                        <br>( <font color="<%=((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "green" : "red"%>"><%=((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done")) ? "Done" : "Not Yet"%></font>)
                                                                        <%  java.util.Date today = new java.util.Date();
                                                                            if(s.getSkill() != null && !((u.getRole().equalsIgnoreCase("mentor") ? s.getStatus().toLowerCase().contains("mentor confirm") : s.getStatus().toLowerCase().contains("mentee confirm")) || s.getStatus().toLowerCase().contains("done") || s.getStatus().toLowerCase().contains("not paid")) && today.after(s.getSlotTime())) {%>
                                                                        <a class="label label-success" target="_blank" onclick="confirmation(this, event)" href="schedule?type=confirm&id=<%=s.getId()%>">-Confirm </a>
                                                                        <%}%>
                                                                    </span><br>
                                                                    <%
                                                                        Calendar c = Calendar.getInstance();
                                                                        c.setTime(s.getSlotTime());
                                                                        Calendar to = Calendar.getInstance();
                                                                        to.setTime(s.getSlotTime());
                                                                        to.add(Calendar.MINUTE, (int)(60*s.getHour()));
                                                                    %>
                                                                    <span class="label label-<%=s.getStatus().toLowerCase().contains("done") ? "default" : "success"%>">(<%=c.get(Calendar.HOUR_OF_DAY) < 10 ? "0" + c.get(Calendar.HOUR_OF_DAY) : c.get(Calendar.HOUR_OF_DAY)%>:<%=c.get(Calendar.MINUTE) < 10 ? "0"+c.get(Calendar.MINUTE) : c.get(Calendar.MINUTE)%>-<%=to.get(Calendar.HOUR_OF_DAY) < 10 ? "0"+to.get(Calendar.HOUR_OF_DAY) : to.get(Calendar.HOUR_OF_DAY)%>:<%=to.get(Calendar.MINUTE) < 10 ? "0"+to.get(Calendar.MINUTE) : to.get(Calendar.MINUTE)%>)</span>
                                                                    <br>
                                                                </p>
                                                                <%} else {%>
                                                                -
                                                                <%}%>
                                                            </td>
                                                        </tr>
                                                        <% } %>
                                                    </tbody>
                                                </table>
                                                <p>
                                                    <b style="font-size: 20px; color: red">More note / Chú thích thêm:</b>
                                                </p>
                                                <div id="ctl00_mainContent_divfoot">
                                                    <ul>
                                                        <li>Note: Only show class schedules when you have registered and been confirmed by a mentor</li>
                                                        <li>( <font color="green">Done</font>): <%=u.getUsername()%> had confirm this activity / <%=u.getFullname()%> đã xác nhận hoạt động này </li>
                                                        <li>( <font color="red">Not Yet</font>): <%=u.getUsername()%> had NOT confirm this activity / <%=u.getFullname()%> chưa xác nhận buổi này </li>
                                                        <li>(-): no data was given / chưa có dữ liệu</li>
                                                    </ul>
                                                </div>
                                                <p>
                                                <div id="ctl00_divSupport">
                                                    <br>
                                                    <b>Mọi góp ý, thắc mắc xin liên hệ: <br></b><span style="color: rgb(34, 34, 34); font-family: arial, sans-serif; font-size: 13.333333969116211px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); display: inline !important; float: none;">Class: SE1756-Group3</span><br> Email: <a href="##">HappyProgamming@email.com</a>.
                                                    <br>Điện thoại: <span style="color: rgb(34, 34, 34); font-weight: bold; font-family: arial, sans-serif; font-size: 13.333333969116211px; font-style: normal; font-variant: normal; letter-spacing: normal; line-height: normal; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); display: inline !important; float: none;">0987654321 </span>
                                                    <br>
                                                </div>
                                                </p>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div id="preloader"></div>
        <a href="#" class="back-to-top d-flex align-items-center justify-content-center" style="
           display: flex!important;
           justify-content: center!important;
           align-items: center!important;
           box-sizing: border-box;
           text-align: var(--bs-body-text-align);
           -webkit-text-size-adjust: 100%;
           -webkit-tap-highlight-color: transparent;
           "><i class="bi bi-arrow-up-short"></i></a>

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
