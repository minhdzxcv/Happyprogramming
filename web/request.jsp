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
    </head>

    <body>
        <%ArrayList<Request> arr = (ArrayList)request.getAttribute("requests");
        int p = (int) Math.ceil((double)arr.size() / 10);
        %>

        <div class="row">
            <%@include file="header.jsp" %>
            <!-- ======= Hero Section ======= -->
            <script>
                var max = <%=p%>;
                var p = 1;
            </script>
            <div  style="padding-top: 100px" class="menu__header fix-menu">
                <div class="container" style="width: 100000px">


                    <div class="table-title">
                        <div class="col-sm-10">
                            <h2 style="font-size: 24px;">Your <b>Requests</b></h2>
                        </div>
                        <div  class="col-sm-2">
                            <a href="request?type=cancel" id="deletebtn" class="btn btn-danger" data-toggle="modal">
                                <i class="fas fa-trash"></i>
                                <span style="font-size: 18px;">Cancel</span>
                            </a>
                        </div>
                    </div>

                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>
                                    <span class="custom-checkbox">
                                        <input type="checkbox" id="selectAll">
                                        <label for="selectAll"></label>
                                    </span>
                                </th>
                                <th style="font-weight: bold; color: black">Subject</th>
                                <th style="font-weight: bold; color: black">Reason</th>
                                <th style="font-weight: bold; color: black">Mentor</th>
                                <th style="font-weight: bold; color: black">Skills</th>
                                <th style="font-weight: bold; color: black">Deadline Date</th>
                                <th style="font-weight: bold; color: black">Status</th>
                                <th style="font-weight: bold; color: black">Actions</th>
                            </tr>
                        </thead>
                        <script>
                            Date.prototype.addDays = function (days) {
                                var date = new Date(this.valueOf());
                                date.setDate(date.getDate() + days);
                                return date;
                            }
                            Date.prototype.getWeekNumber = function () {
                                var d = new Date(Date.UTC(this.getFullYear(), this.getMonth(), this.getDate()));
                                var dayNum = d.getUTCDay() || 7;
                                d.setUTCDate(d.getUTCDate() + 4 - dayNum);
                                var yearStart = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));
                                return Math.ceil((((d - yearStart) / 86400000) + 1) / 7)
                            };
                            Date.prototype.addMinutes = function (minutes) {
                                return new Date(this.getTime() + minutes * 60000);
                            };
                            function sortByWeek(firstDay, lastDay, list) {
                                let temp = [];
                                for (var i = 0; i < list.length; i++) {
                                    let tempDate = new Date(Date.parse(list[i]["SlotTime"]));
                                    if (tempDate >= firstDay && tempDate <= lastDay) {
                                        temp.push(list[i]);
                                    }
                                }
                                return temp;
                            }
                            function getMonday(d) {
                                d = new Date(d);
                                var day = d.getDay(),
                                        diff = d.getDate() - day + (day == 0 ? -6 : 1);
                                return new Date(d.setDate(diff));
                            }
                            function previous() {
                                let week = document.getElementById("week");
                                let preWeek = document.getElementById("week-" + (parseInt(week.value) - 1));
                                if (preWeek != null) {
                                    preWeek.classList.remove("hidden");
                                    document.getElementById("week-" + week.value).classList.add("hidden");
                                    document.getElementById("body-" + week.value).classList.add("hidden");
                                    document.getElementById("body-" + (parseInt(week.value) - 1)).classList.remove("hidden");
                                    week.value = (parseInt(week.value) - 1);
                                }
                            }
                            function next() {
                                let week = document.getElementById("week");
                                let preWeek = document.getElementById("week-" + (parseInt(week.value) + 1));
                                if (preWeek != null) {
                                    preWeek.classList.remove("hidden");
                                    document.getElementById("week-" + week.value).classList.add("hidden");
                                    document.getElementById("body-" + week.value).classList.add("hidden");
                                    document.getElementById("body-" + (parseInt(week.value) + 1)).classList.remove("hidden");
                                    week.value = (parseInt(week.value) + 1);
                                }
                            }
                            function schedule(input, event, id, mid) {
                                event.preventDefault();
                                if (input.parentNode.children.length > 1) {
                                    if (!input.parentNode.lastChild.classList.contains("hidden")) {
                                        input.parentNode.lastChild.classList.add("hidden")
                                    } else {
                                        input.parentNode.lastChild.classList.remove("hidden");
                                    }
                                } else {
                                    fetch("api/schedule?<%if(u.getRole().equalsIgnoreCase("mentee")) { %>free=true&mid=" + mid + "&<%}%>id=" + id).then(function (response) {
                                        if (!response.ok) {
                                            throw new Error('Response was not ok');
                                        }
                                        return response.json();
                                    }).then(function (body) {
                                        let schedule = document.createElement("div");
                                        let weekCount = body["weekCount"];
                                        let firstDay = getMonday(new Date());
                                        let week = new Date().getWeekNumber();
                                        let lastDay = getMonday(new Date()).addDays(6);
                                        let innerString = '<div class="bootstrap-datetimepicker-widget dropdown-menu" id="datepicker" style="width: 15em; inset: auto auto auto auto;">\n\
    <div class="row">\n\
<div class="datepicker" style="margin-right: 14px;margin-left: 14px;">\n\
<div class="datepicker-days" style="display: block;">\n\
<table class="table-condensed">\n\
<thead>\n\
<tr>\n\
<th class="prev" data-action="previous" onclick="previous()"><span class="glyphicon glyphicon-chevron-left" title="Previous Week"></span></th>\n\
<input type="hidden" id="week" name="currWeek" value=' + week + '>\n\
';
                                        for (let i = 0; i < weekCount; i++) {
                                            innerString += '\n\
<th class="picker-switch ' + (i === 0 ? "" : "hidden") + '" data-action="pickerSwitch" colspan="5" title="Select Week" id="week-' + (week + i) + '">\n\
' + (firstDay.getDate() < 10 ? "0" + firstDay.getDate() : firstDay.getDate()) + '/' + ((firstDay.getMonth() + 1) < 10 ? "0" + (firstDay.getMonth() + 1) : (firstDay.getMonth() + 1)) + ' - ' + (lastDay.getDate() < 10 ? "0" + lastDay.getDate() : lastDay.getDate()) + '/' + ((lastDay.getMonth() + 1) < 10 ? "0" + (lastDay.getMonth() + 1) : (lastDay.getMonth() + 1)) + '\n\
</th>';
                                            firstDay = firstDay.addDays(7);
                                            lastDay = lastDay.addDays(7);
                                        }
                                        innerString += '\n\
<th class="next" data-action="next" onclick="next()"><span class="glyphicon glyphicon-chevron-right" title="Next Week"></span></th>\n\
</tr><tr><th class="dow">Mo</th><th class="dow">Tu</th><th class="dow">We</th><th class="dow">Th</th><th class="dow">Fr</th><th class="dow">Sa</th><th class="dow">Su</th></tr>\n\
</thead>';
                                        firstDay = firstDay.addDays(-(7 * weekCount));
                                        firstDay.setHours(0);
                                        firstDay.setMinutes(0);
                                        firstDay.setSeconds(0);
                                        lastDay = lastDay.addDays(-(7 * weekCount));
                                        lastDay.setHours(23);
                                        lastDay.setMinutes(59);
                                        lastDay.setSeconds(59);
                                        let currWidth = 15;
                                        let maxWidth = 15;
                                        for (let j = 0; j < weekCount; j++) {
                                            currWidth = 15;
                                            let thisWeek = sortByWeek(firstDay, lastDay, body["slots"]);
                                            let mon = [];
                                            let tue = [];
                                            let wen = [];
                                            let thu = [];
                                            let fri = [];
                                            let sat = [];
                                            let sun = [];
                                            var hod = [5, 7, 10, 12, 15, 17, 20];
                                            for (var i = 0; i < thisWeek.length; i++) {
                                                let tempDate = new Date(Date.parse(thisWeek[i]["SlotTime"]));
                                                if (tempDate.getDay() === 1) {
                                                    while (tempDate.getHours() !== hod[mon.length]) {
                                                        mon.push(null);
                                                    }
                                                    mon.push(thisWeek[i]);
                                                }
                                                if (tempDate.getDay() === 2) {
                                                    while (tempDate.getHours() !== hod[tue.length]) {
                                                        tue.push(null);
                                                    }
                                                    tue.push(thisWeek[i]);
                                                }
                                                if (tempDate.getDay() === 3) {
                                                    while (tempDate.getHours() !== hod[wen.length]) {
                                                        wen.push(null);
                                                    }
                                                    wen.push(thisWeek[i]);
                                                }
                                                if (tempDate.getDay() === 4) {
                                                    while (tempDate.getHours() !== hod[thu.length]) {
                                                        thu.push(null);
                                                    }
                                                    thu.push(thisWeek[i]);
                                                }
                                                if (tempDate.getDay() === 5) {
                                                    while (tempDate.getHours() !== hod[fri.length]) {
                                                        fri.push(null);
                                                    }
                                                    fri.push(thisWeek[i]);
                                                }
                                                if (tempDate.getDay() === 6) {
                                                    while (tempDate.getHours() !== hod[sat.length]) {
                                                        sat.push(null);
                                                    }
                                                    sat.push(thisWeek[i]);
                                                }
                                                if (tempDate.getDay() === 0) {
                                                    while (tempDate.getHours() !== hod[sun.length]) {
                                                        sun.push(null);
                                                    }
                                                    sun.push(thisWeek[i]);
                                                }
                                            }
                                            let max = mon.length;
                                            if (tue.length > max)
                                                max = tue.length;
                                            if (wen.length > max)
                                                max = wen.length;
                                            if (thu.length > max)
                                                max = thu.length;
                                            if (fri.length > max)
                                                max = fri.length;
                                            if (sat.length > max)
                                                max = sat.length;
                                            if (sun.length > max)
                                                max = sun.length;
                                            innerString += '<tbody class="' + (j === 0 ? "" : "hidden") + '" id="body-' + (week + j) + '">'
                                            for (let i = 0; i < (7 < max ? max : 7); i++) {
                                                innerString += '\n\
<tr>';
                                                if (mon.length > i && mon[i] !== null) {
                                                    let s = mon[i];
                                                    let c = new Date(Date.parse(s["SlotTime"]));
                                                    let to = new Date(Date.parse(s["SlotTime"])).addMinutes(60 * s["hour"]);
                                                    currWidth += 2;
                                                    innerString += '\n\
<td data-action="selectDay" class="day" title="Slot ' + i + '">\n\
<input type="checkbox" name="slot" value="' + s["id"] + '" id="checkbox-' + s["id"] + '" <%=u.getRole().equalsIgnoreCase("mentor") ? "disabled" : ""%> ' + (s["checked"] ? "checked" : "") + '>\n\
<label for="checkbox-' + s["id"] + '">' + (c.getHours() < 10 ? "0" + c.getHours() : c.getHours()) + ':' + (c.getMinutes() < 10 ? "0" + c.getMinutes() : c.getMinutes()) + '<br>' + (to.getHours() < 10 ? "0" + to.getHours() : to.getHours()) + ':' + (to.getMinutes() < 10 ? "0" + to.getMinutes() : to.getMinutes()) + '</label>'
                                                } else {
                                                    innerString += '<td data-action="selectDay" class="day"> -'
                                                }
                                                innerString += '\n\
</td>'
                                                if (tue.length > i && tue[i] !== null) {
                                                    let s = tue[i];
                                                    let c = new Date(Date.parse(s["SlotTime"]));
                                                    let to = new Date(Date.parse(s["SlotTime"])).addMinutes(60 * s["hour"]);
                                                    currWidth += 2;
                                                    innerString += '\n\
<td data-action="selectDay" class="day" title="Slot ' + i + '">\n\
<input type="checkbox" name="slot" value="' + s["id"] + '" id="checkbox-' + s["id"] + '" <%=u.getRole().equalsIgnoreCase("mentor") ? "disabled" : ""%> ' + (s["checked"] ? "checked" : "") + '>\n\
<label for="checkbox-' + s["id"] + '">' + (c.getHours() < 10 ? "0" + c.getHours() : c.getHours()) + ':' + (c.getMinutes() < 10 ? "0" + c.getMinutes() : c.getMinutes()) + '<br>' + (to.getHours() < 10 ? "0" + to.getHours() : to.getHours()) + ':' + (to.getMinutes() < 10 ? "0" + to.getMinutes() : to.getMinutes()) + '</label>'
                                                } else {
                                                    innerString += '<td data-action="selectDay" class="day"> -'
                                                }
                                                innerString += '\n\
</td>'
                                                if (wen.length > i && wen[i] !== null) {
                                                    let s = wen[i];
                                                    let c = new Date(Date.parse(s["SlotTime"]));
                                                    let to = new Date(Date.parse(s["SlotTime"])).addMinutes(60 * s["hour"]);
                                                    currWidth += 2;
                                                    innerString += '\n\
<td data-action="selectDay" class="day" title="Slot ' + i + '">\n\
<input type="checkbox" name="slot" value="' + s["id"] + '" id="checkbox-' + s["id"] + '" <%=u.getRole().equalsIgnoreCase("mentor") ? "disabled" : ""%> ' + (s["checked"] ? "checked" : "") + '>\n\
<label for="checkbox-' + s["id"] + '">' + (c.getHours() < 10 ? "0" + c.getHours() : c.getHours()) + ':' + (c.getMinutes() < 10 ? "0" + c.getMinutes() : c.getMinutes()) + '<br>' + (to.getHours() < 10 ? "0" + to.getHours() : to.getHours()) + ':' + (to.getMinutes() < 10 ? "0" + to.getMinutes() : to.getMinutes()) + '</label>'
                                                } else {
                                                    innerString += '<td data-action="selectDay" class="day"> -'
                                                }
                                                innerString += '\n\
</td>'
                                                if (thu.length > i && thu[i] !== null) {
                                                    let s = thu[i];
                                                    let c = new Date(Date.parse(s["SlotTime"]));
                                                    let to = new Date(Date.parse(s["SlotTime"])).addMinutes(60 * s["hour"]);
                                                    currWidth += 2;
                                                    innerString += '\n\
<td data-action="selectDay" class="day" title="Slot ' + i + '">\n\
<input type="checkbox" name="slot" value="' + s["id"] + '" id="checkbox-' + s["id"] + '" <%=u.getRole().equalsIgnoreCase("mentor") ? "disabled" : ""%> ' + (s["checked"] ? "checked" : "") + '>\n\
<label for="checkbox-' + s["id"] + '">' + (c.getHours() < 10 ? "0" + c.getHours() : c.getHours()) + ':' + (c.getMinutes() < 10 ? "0" + c.getMinutes() : c.getMinutes()) + '<br>' + (to.getHours() < 10 ? "0" + to.getHours() : to.getHours()) + ':' + (to.getMinutes() < 10 ? "0" + to.getMinutes() : to.getMinutes()) + '</label>'
                                                } else {
                                                    innerString += '<td data-action="selectDay" class="day"> -'
                                                }
                                                innerString += '\n\
</td>'
                                                if (fri.length > i && fri[i] !== null) {
                                                    let s = fri[i];
                                                    let c = new Date(Date.parse(s["SlotTime"]));
                                                    let to = new Date(Date.parse(s["SlotTime"])).addMinutes(60 * s["hour"]);
                                                    currWidth += 2;
                                                    innerString += '\n\
<td data-action="selectDay" class="day" title="Slot ' + i + '">\n\
<input type="checkbox" name="slot" value="' + s["id"] + '" id="checkbox-' + s["id"] + '" <%=u.getRole().equalsIgnoreCase("mentor") ? "disabled" : ""%> ' + (s["checked"] ? "checked" : "") + '>\n\
<label for="checkbox-' + s["id"] + '">' + (c.getHours() < 10 ? "0" + c.getHours() : c.getHours()) + ':' + (c.getMinutes() < 10 ? "0" + c.getMinutes() : c.getMinutes()) + '<br>' + (to.getHours() < 10 ? "0" + to.getHours() : to.getHours()) + ':' + (to.getMinutes() < 10 ? "0" + to.getMinutes() : to.getMinutes()) + '</label>'
                                                } else {
                                                    innerString += '<td data-action="selectDay" class="day"> -'
                                                }
                                                innerString += '\n\
</td>'
                                                if (sat.length > i && sat[i] !== null) {
                                                    let s = sat[i];
                                                    let c = new Date(Date.parse(s["SlotTime"]));
                                                    let to = new Date(Date.parse(s["SlotTime"])).addMinutes(60 * s["hour"]);
                                                    currWidth += 2;
                                                    innerString += '\n\
<td data-action="selectDay" class="day" title="Slot ' + i + '">\n\
<input type="checkbox" name="slot" value="' + s["id"] + '" id="checkbox-' + s["id"] + '" <%=u.getRole().equalsIgnoreCase("mentor") ? "disabled" : ""%> ' + (s["checked"] ? "checked" : "") + '>\n\
<label for="checkbox-' + s["id"] + '">' + (c.getHours() < 10 ? "0" + c.getHours() : c.getHours()) + ':' + (c.getMinutes() < 10 ? "0" + c.getMinutes() : c.getMinutes()) + '<br>' + (to.getHours() < 10 ? "0" + to.getHours() : to.getHours()) + ':' + (to.getMinutes() < 10 ? "0" + to.getMinutes() : to.getMinutes()) + '</label>'
                                                } else {
                                                    innerString += '<td data-action="selectDay" class="day"> -'
                                                }
                                                innerString += '\n\
</td>'
                                                if (sun.length > i && sun[i] !== null) {
                                                    let s = sun[i];
                                                    let c = new Date(Date.parse(s["SlotTime"]));
                                                    let to = new Date(Date.parse(s["SlotTime"])).addMinutes(60 * s["hour"]);
                                                    currWidth += 2;
                                                    innerString += '\n\
<td data-action="selectDay" class="day" title="Slot ' + i + '">\n\
<input type="checkbox" name="slot" value="' + s["id"] + '" id="checkbox-' + s["id"] + '" <%=u.getRole().equalsIgnoreCase("mentor") ? "disabled" : ""%> ' + (s["checked"] ? "checked" : "") + '>\n\
<label for="checkbox-' + s["id"] + '">' + (c.getHours() < 10 ? "0" + c.getHours() : c.getHours()) + ':' + (c.getMinutes() < 10 ? "0" + c.getMinutes() : c.getMinutes()) + '<br>' + (to.getHours() < 10 ? "0" + to.getHours() : to.getHours()) + ':' + (to.getMinutes() < 10 ? "0" + to.getMinutes() : to.getMinutes()) + '</label>'
                                                } else {
                                                    innerString += '<td data-action="selectDay" class="day"> -'
                                                }
                                                innerString += '\n\
</td></tr>'
                                            }
                                            innerString += '\n\
</tbody>'
                                            firstDay = firstDay.addDays(7);
                                            lastDay = lastDay.addDays(7);
                                            if (currWidth > maxWidth) {
                                                maxWidth = currWidth;
                                            }
                                        }
                                        innerString += '\n\
</table>\n\
</div>\n\
</div></div></div>';
                                        schedule.innerHTML = innerString;
                                        input.parentNode.appendChild(schedule.firstChild);
                                        if (15 < maxWidth) {
                                            document.getElementById("datepicker").style.width = maxWidth + "em";
                                        }
                                    });
                                }
                            }
                        </script>
                        <tbody>
                            <%for(int i = 0; i < arr.size(); i++) {%>
                            <tr id='<%=i+1%>' <%=(i >= 10 ? "class=\"hidden\"" : "")%>>
                                <td>
                                    <span class="custom-checkbox">
                                        <input type="<%=(i >= 10 ? "hidden" : "checkbox")%>" id="checkbox1" name="options[]" value="<%=arr.get(i).getId()%>">
                                        <label for="checkbox1"></label>
                                    </span>
                                </td>
                                <td><%=arr.get(i).getSubject()%></td>
                                <td><%=arr.get(i).getReason()%></td>
                                <td>
                                    <a href="mentor?id=<%=arr.get(i).getUserID()%>"><%=arr.get(i).getMentor()%></a>
                                </td>
                                <td><%=arr.get(i).getSkillsName()%></td>
                                <td><%=arr.get(i).getDeadlineTime()%></td>
                                <td>
                                    <% if (arr.get(i).getStatus().equalsIgnoreCase("Reject")) { %>
                                    <button class="btn btn-danger" data-toggle="modal" data-target="#rejectReasonModal" onclick="showRejectReason('<%=arr.get(i).getRejectReason()%>', event)">Reject</button>
                                    <% } else { %>
                                    <%= arr.get(i).getStatus() %>
                                    <% } %>
                                </td>

                                <td>
                                    <%if(arr.get(i).getStatus().equalsIgnoreCase("open") || arr.get(i).getStatus().equalsIgnoreCase("reopen") || arr.get(i).getStatus().equalsIgnoreCase("reject")) {%>
                                    <a href="" onclick="update<%=arr.get(i).getId()%>(event)" class="edit" data-toggle="modal">
                                        <i class="fas fa-edit" data-toggle="tooltip" title="Edit"></i>
                                    </a>
                                    <script>
                                        function update<%=arr.get(i).getId()%>(event) {
                                            event.preventDefault();
                                            let title = document.title;
                                            if (!JSON.stringify(document.body.style).includes("overflow: hidden;")) {
                                        <%
                                            try {
                                                Mentor currMentor = MentorDAO.getMentor(arr.get(i).getUserID());
                                                CV currCV = CvDAO.getCV(currMentor.getCvID());
                                        %>
                                                document.body.style = 'overflow: hidden; padding-right: 17px; background-color: rgb(233, 235, 238) !important;  display:flex';
                                                //document.body.style = 'background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                                                let modal = document.createElement('div');
                                                modal.innerHTML = '<div role="dialog" aria-hidden="true">\n\
                                                <div class="fade modal-backdrop"></div>\n\
<div role="dialog" tabindex="-1" class="fade modal-donate modal" style="display: block;">\n\
<div class="modal-dialog">\n\
<div class="modal-content" role="document">\n\
<div class="modal-header"><button type="button" class="close">\n\
<span aria-hidden="true">×</span>\n\
<span class="sr-only">Close</span>\n\
</button><h4 class="modal-title"><span>Sửa Request</span></h4></div><form method="post"><input type="hidden" name="id" value="<%=arr.get(i).getId()%>"><input type="hidden" name="type" value="update"><div class="modal-body"><table style="width: 100%;"><tbody><tr><td>Mentor:</td><td><%=currMentor.getFullname()%></td></tr><tr><td><span>Request Deadline</span>:</td><td><input type="datetime-local" value="<%=new SimpleDateFormat("yyyy-MM-dd'T'HH:mm").format(arr.get(i).getDeadlineTime())%>" required name="deadline"></td></tr><tr><td><span>Tiêu Đề</span>:</td><td><input placeholder="Nhập tiêu đề..." value="<%=arr.get(i).getSubject()%>" required name="subject"></td></tr><tr><td><span>Yêu Cầu</span>:</td><td><textarea placeholder="Nhập yêu cầu..." required name="reason" maxlength="255" type="text" class="form-control" style="height:50px"><%=arr.get(i).getReason()%></textarea></td></tr>\n\
<tr><td><span>Xem Lịch</span>:</td><td><button class="btn btn-default" style="font: inherit;" onclick="schedule(this, event, <%=arr.get(i).getId()%>, <%=currMentor.getId()%>)">Nhấn để Hiện Lịch</button>\n\
</td></tr>\n\
<tr><td><span>Trạng Thái</span>:</td><td><%=arr.get(i).getStatus()%><input type="hidden" name="status" value="<%=arr.get(i).getStatus().equalsIgnoreCase("reject") ? "Reopen" : "Open"%>"></td></tr><%if(arr.get(i).getStatus().equalsIgnoreCase("reject")) {%><tr><td><span>Lý Do Từ Chối</span>:</td><td><%=arr.get(i).getRejectReason()%></td></tr><%}%><tr><td><span>Chọn kĩ năng cần học</span>:</td><td><%for(int j = 0; j < currCV.getSkills().size(); j++) {%><div class="col-sm-6"><input type="checkbox" name="skill" value="<%=currCV.getSkills().get(j).getId()%>" id="<%=currCV.getSkills().get(j).getId()%>" <%=SkillDAO.contains(arr.get(i).getSkills(), currCV.getSkills().get(j)) ? "checked" : ""%>><label for="<%=currCV.getSkills().get(j).getId()%>" style="margin-left: 5px"><%=currCV.getSkills().get(j).getName()%></label></div><%}%></td></tr></tbody></table></div><div class="modal-footer"><button type="submit" class="btn-fill btn btn-danger"><span>Cập Nhật</span></button><button type="button" class="btn btn-default"><span>Đóng</span></button></div></form></div></div></div></div>';
                                                let date = new Date();
                                                let dateonly = [date.getMonth() + 1, date.getDate(), date.getFullYear()];
                                                modal.querySelector("input[type=datetime-local]").min = dateonly[2] + "-" + (parseInt(dateonly[0]) < 10 ? "0" + dateonly[0] : dateonly[0]) + "-" + (parseInt(dateonly[1]) < 10 ? "0" + dateonly[1] : dateonly[1]) + "T" + date.toTimeString().split(":")[0] + ":" + date.toTimeString().split(":")[1];
                                                modal.querySelector("input[type=datetime-local]").min = new Date().toISOString().split(":")[0] + ":" + new Date().toISOString().split(":")[1];
                                                document.body.appendChild(modal.firstChild);
                                                let skills = document.body.lastChild.querySelectorAll("input[name=skill]");
                                                for (var i = 0; i < skills.length; i++) {
                                                    skills[i].onclick = function (e) {
                                                        if (this.checked) {
                                                            let checkeds = document.body.lastChild.querySelectorAll("input[name=skill]:checked");
                                                            if (checkeds.length > 1) {
                                                                this.checked = false;
                                                                alert("Bạn chỉ được chọn tối đa 1 skills!");
                                                            }
                                                        }
                                                    }
                                                }
                                                let btn = document.body.lastChild.getElementsByTagName('button');
                                                btn[2].onclick = function (e) {
                                                    e.preventDefault();
                                                    let checkeds = document.body.lastChild.querySelectorAll("input[type=checkbox]:checked");
                                                    if (checkeds.length < 1) {
                                                        alert('Vui lòng chọn ít nhất 1 skill!');
                                                    } else {
                                                        let slots = document.querySelectorAll("input[name=slot]");
                                                        if (slots.length > 0) {
                                                            if (document.querySelectorAll("input[name=slot]:checked").length == 0) {
                                                                alert('Vui lòng chọn ít nhất 1 slots!');
                                                                return;
                                                            }
                                                        }
                                                        this.onclick = null;
                                                        this.click();
                                                    }
                                                }
                                                btn[0].onclick = function () {
                                                    document.body.lastChild.children[0].classList.remove("in");
                                                    document.body.lastChild.children[1].classList.remove("in");
                                                    setTimeout(function () {
                                                        document.body.style = 'background-color: rgb(233, 235, 238) !important;  display:flex';
                                                        document.body.removeChild(document.body.lastChild);
                                                        window.onclick = null;
                                                    }, 100);
                                                    document.title = title;

                                                }
                                                btn[3].onclick = function () {
                                                    document.body.lastChild.children[0].classList.remove("in");
                                                    document.body.lastChild.children[1].classList.remove("in");
                                                    setTimeout(function () {
                                                        document.body.style = 'background-color: rgb(233, 235, 238) !important;display:flex';
                                                        document.body.removeChild(document.body.lastChild);
                                                        window.onclick = null;
                                                    }, 100);
                                                    document.title = title;

                                                }
                                                setTimeout(function () {
                                                    document.body.lastChild.children[1].classList.add("in");
                                                    document.body.lastChild.children[0].classList.add("in");
                                                    window.onclick = function (e) {
                                                        if (!document.getElementsByClassName('modal-content')[0].contains(e.target)) {
                                                            document.body.lastChild.children[0].classList.remove("in");
                                                            document.body.lastChild.children[1].classList.remove("in");
                                                            setTimeout(function () {
                                                                document.body.style = 'background-color: rgb(233, 235, 238) !important;display:flex';
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
                                                document.body.lastChild.children[0].classList.remove("in");
                                                document.body.lastChild.children[1].classList.remove("in");
                                                setTimeout(function () {
                                                    document.body.style = 'background-color: rgb(233, 235, 238) !important;display:flex';
                                                    document.body.removeChild(document.body.lastChild);
                                                    window.onclick = null;
                                                }, 100);
                                                document.title = title;
                                            }
                                        }
                                    </script>
                                    <%} else if(arr.get(i).getStatus().equalsIgnoreCase("done") && !arr.get(i).isRated()) {%> 
                                    <a href="" onclick="rate(event, <%=arr.get(i).getId()%>)" class="edit" data-toggle="modal">
                                        <i class="fas fa-comment" data-toggle="tooltip" title="Rate"></i>
                                    </a>

                                    <%} else if(arr.get(i).getStatus().equalsIgnoreCase("accept") && !arr.get(i).isRated()) {%> 
                                    <a href="" onclick="pay<%=arr.get(i).getId()%>(event)" class="success" data-toggle="modal">
                                        <i class="fas fa-dollar-sign" data-toggle="tooltip" title="pay"></i>

                                    </a>
                                    <script>
                                        function pay<%=arr.get(i).getId()%>(event) {
                                            event.preventDefault();
                                            if (!JSON.stringify(document.body.style).includes("overflow: hidden;")) {
                                                document.body.style = 'overflow: hidden; padding-right: 17px; background-color: rgb(233, 235, 238) !important; display:flex';
                                                //document.body.style = 'background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                                                let modal = document.createElement('div');
                                                modal.innerHTML = '<div role="dialog" aria-hidden="true">\n\
<div class="fade modal-backdrop"></div>\n\
<div role="dialog" tabindex="-1" class="fade modal-donate modal" style="display: block;">\n\
<form method="post">\n\
<div class="modal-dialog">\n\
<div class="modal-content" role="document">\n\
<div class="modal-header">\n\
  <button type="button" class="close">\n\
    <span aria-hidden="true">×</span>\n\
    <span class="sr-only">Close</span>\n\
  </button>\n\
  <h4 class="modal-title">\n\
    <span>Xác nhận trả tiền</span>\n\
  </h4>\n\
</div>\n\
  <div class="modal-body">\n\
<table style="width: 100%;">\n\
          <tbody>\n\
              <input type="hidden" name="type" value="pay">\n\
              <input type="hidden" name="id" value="<%=arr.get(i).getId()%>">\n\
              <input type="hidden" name="uid" value="<%=arr.get(i).getSendID()%>">\n\
              <input type="hidden" name="oid" value="<%=arr.get(i).getUserID()%>">\n\
            <tr>\n\
              <td>\n\
                <span>Mentor</span>:\n\
              </td>\n\
              <td>\n\
                                        <%=arr.get(i).getMentor()%>\n\
              </td>\n\
            </tr>\n\
            <tr>\n\
              <td>\n\
                <span>Giá trên 1 slot</span>:\n\
              </td>\n\
              <td>\n\
                                        <%int slotCash = MentorDAO.getSlotCash(arr.get(i).getUserID());
                                            int Rslots = RequestDAO.getSlots(arr.get(i).getId());
                                        %>\n\
                                        <%=slotCash%>đ\n\
              </td>\n\
            </tr>\n\
            <tr>\n\
              <td>\n\
                <span>Số slot muốn thuê</span>:\n\
              </td>\n\
              <td>\n\
                                        <%=Rslots%>\n\
              </td>\n\
            </tr>\n\
            <tr>\n\
              <td>\n\
                <span>Tổng tiền phải trả</span>:\n\
              </td>\n\
              <td>\n\
                                        <%=slotCash*Rslots%>đ\n\
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
</div>\n\
</form>\n\
</div>\n\
</div>\n\
</div>';
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
                                                btn[1].onclick = function (e) {
                                                    e.preventDefault();
                                                    if (<%=slotCash*Rslots%> > <%=u.getWallet()%>) {
                                                        alert("Bạn không có đủ tiền, vui lòng nạp thêm!");
                                                    } else {
                                                        btn[1].form.submit();
                                                    }
                                                }
                                                btn[2].onclick = function () {
                                                    document.body.lastChild.children[0].classList.remove("in");
                                                    document.body.lastChild.children[1].classList.remove("in");
                                                    setTimeout(function () {
                                                        document.body.style = 'background-color: rgb(233, 235, 238) !important; display:flex';
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
                                    <%}%>
                                    <%if(arr.get(i).getStatus().equalsIgnoreCase("open") || arr.get(i).getStatus().equalsIgnoreCase("reopen") || arr.get(i).getStatus().equalsIgnoreCase("reject")) {%>
                                    <a href="request?type=cancel&id=<%=arr.get(i).getId()%>" class="delete" data-toggle="modal">
                                        <i class="fas fa-ban" data-toggle="tooltip" title="Cancel"></i>
                                    </a>
                                    <%}%>
                                </td>
                            </tr> 
                            <%}%>
                        </tbody>
                    </table>
                    <script>
                        function ratingStar(input) {
                            let star = parseInt(input.value);
                            for (var i = 1; i <= star; i++) {
                                document.getElementById("label-" + i).classList.remove("far");
                                document.getElementById("label-" + i).classList.add("fas");
                            }
                            for (var i = star + 1; i <= 5; i++) {
                                document.getElementById("label-" + i).classList.add("far");
                                document.getElementById("label-" + i).classList.remove("fas");
                            }
                        }
                        function rate(event, id) {
                            event.preventDefault();
                            if (!JSON.stringify(document.body.style).includes("overflow: hidden;")) {
                                document.body.style = 'overflow: hidden; padding-right: 17px; background-color: rgb(233, 235, 238) !important; display:flex';
                                //document.body.style = 'background-color: rgb(233, 235, 238) !important; padding-top: 66px;';
                                let modal = document.createElement('div');
                                modal.innerHTML = '<div role="dialog" aria-hidden="true">\n\
<div class="fade modal-backdrop"></div>\n\
<div role="dialog" tabindex="-1" class="fade modal-donate modal" style="display: block;">\n\
<form method="post">\n\
<div class="modal-dialog">\n\
<div class="modal-content" role="document">\n\
<div class="modal-header">\n\
<button type="button" class="close">\n\
<span aria-hidden="true">×</span>\n\
<span class="sr-only">Close</span>\n\
</button>\n\
<h4 class="modal-title">\n\
<span>Đánh giá Mentor</span>\n\
</h4>\n\
</div>\n\
<div class="modal-body">\n\
<table style="width: 100%;">\n\
      <tbody>\n\
          <input type="hidden" name="type" value="rate">\n\
          <input type="hidden" name="id" value="' + id + '">\n\
        <tr>\n\
          <td>\n\
            <span>Đánh giá</span>:\n\
          </td>\n\
          <td>\n\
                <input class="hidden" type="radio" name="noStar" value="1" onclick="ratingStar(this)" id="star-1"><label class="far fa-star" id="label-1" for="star-1"></label>\n\
                <input class="hidden" type="radio" name="noStar" value="2" onclick="ratingStar(this)" id="star-2"><label class="far fa-star" id="label-2" for="star-2"></label>\n\
                <input class="hidden" type="radio" name="noStar" value="3" onclick="ratingStar(this)" id="star-3"><label class="far fa-star" id="label-3" for="star-3"></label>\n\
                <input class="hidden" type="radio" name="noStar" value="4" onclick="ratingStar(this)" id="star-4"><label class="far fa-star" id="label-4" for="star-4"></label>\n\
                <input class="hidden" type="radio" name="noStar" value="5" onclick="ratingStar(this)" id="star-5"><label class="far fa-star" id="label-5" for="star-5"></label>\n\
          </td>\n\
        </tr><tr>\n\
          <td>\n\
            <span>Đánh giá cụ thể</span>:\n\
          </td>\n\
          <td>\n\
            <textarea placeholder="Nhập đánh giá..." required name="comment" maxlength="255" type="text" class="form-control" style="height:50px"></textarea>\n\
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
</div>\n\
</form>\n\
</div>\n\
</div>\n\
</div>';
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
                                btn[1].onclick = function (e) {
                                    e.preventDefault();
                                    let q = document.querySelectorAll("input[name=noStar]:checked");
                                    if (q.length < 1) {
                                        alert("Vui lòng đánh giá số sao!");
                                    } else {
                                        this.form.submit();
                                    }
                                }
                                btn[2].onclick = function () {
                                    document.body.lastChild.children[0].classList.remove("in");
                                    document.body.lastChild.children[1].classList.remove("in");
                                    setTimeout(function () {
                                        document.body.style = 'background-color: rgb(233, 235, 238) !important; display:flex';
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
                                                document.body.style = 'background-color: rgb(233, 235, 238) !important;  display:flex';
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
                    <div class="clearfix">
                        <div class="hint-text">Showing <b id="from"><%=(arr.size() >= 10 ? 10 : arr.size())%></b> out of <b id="max"><%=arr.size()%></b> entries</div>
                        <ul class="pagination">
                            <li class="page-item disabled"><a onclick='paging(this, event)' href="" id='Previous'>Previous</a></li>
                                <%
                                    for(int i = 0; i < p; i++) {
                                %>
                            <li class="page-item <%=(i==0) ? "active" : ""%>"><a onclick='paging(this, event)' href='<%=i+1%>' class="page-link"><%=i+1%></a></li>
                                <%}%>
                            <li class="page-item <%=(p > 1) ? "" : "disabled"%>"><a id='Next' onclick='paging(this, event)' href="" class="page-link">Next</a></li>
                            <script>
                                function paging(input, event) {
                                    event.preventDefault();
                                    let str = JSON.stringify(input.href).replace("http://localhost:9999/Group3/", "").replaceAll('"', '');
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
                                                document.getElementById(i).children[0].children[0].children[0].setAttribute("type", "hidden");
                                            }
                                            p = parseInt(str);
                                            for (var i = (p - 1) * 10 + 1; i <= (p * 10 > parseInt(m.innerHTML) ? parseInt(m.innerHTML) : p * 10); i++) {
                                                document.getElementById(i).classList.remove("hidden");
                                                document.getElementById(i).children[0].children[0].children[0].setAttribute("type", "checkbox");
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
                                                document.getElementById(i).children[0].children[0].children[0].setAttribute("type", "hidden");
                                            }
                                            p = p - 1;
                                            for (var i = (p - 1) * 10 + 1; i <= (p * 10 > parseInt(m.innerHTML) ? parseInt(m.innerHTML) : p * 10); i++) {
                                                document.getElementById(i).classList.remove("hidden");
                                                document.getElementById(i).children[0].children[0].children[0].setAttribute("type", "checkbox");
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
                                                document.getElementById(i).children[0].children[0].children[0].setAttribute("type", "hidden");
                                            }
                                            p = p + 1;
                                            for (var i = (p - 1) * 10 + 1; i <= (p * 10 > parseInt(m.innerHTML) ? parseInt(m.innerHTML) : p * 10); i++) {
                                                document.getElementById(i).classList.remove("hidden");
                                                document.getElementById(i).children[0].children[0].children[0].setAttribute("type", "checkbox");
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


            <div id="preloader"></div>
            <script>

                document.getElementsByClassName('custom-checkbox')[0].onclick = function (e) {
                    let checkbox = document.querySelectorAll("input[type=checkbox]");
                    for (let i = 1; i < checkbox.length; i++) {
                        if (!checkbox[0].checked) {
                            checkbox[i].checked = false;
                            document.getElementById('deletebtn').href = "request?type=delete";
                        } else {
                            checkbox[i].checked = true;
                            document.getElementById('deletebtn').href = "request?type=delete&id=all";
                        }
                    }
                }
                let checkbox = document.getElementsByClassName('custom-checkbox');
                for (let i = 1; i < checkbox.length; i++) {
                    checkbox[i].onclick = function () {
                        if (!checkbox[i].children[0].checked) {
                            if (checkbox[0].children[0].checked) {
                                checkbox[0].children[0].checked = false;
                                document.getElementById('deletebtn').href = "request?type=delete";
                                for (let j = 1; j < checkbox.length; j++) {
                                    if (j !== i) {
                                        console.log(JSON.stringify(document.getElementById('deletebtn').href).replace("http://localhost:9999/Group3/", ""));
                                        document.getElementById('deletebtn').href = document.getElementById('deletebtn').href.replace("http://localhost:9999/Group3/", "") + "&id=" + checkbox[j].children[0].value;
                                    }
                                }
                            } else {
                                console.log(JSON.stringify(document.getElementById('deletebtn').href).replace("http://localhost:9999/Group3/", ""));
                                document.getElementById('deletebtn').href = document.getElementById('deletebtn').href.replace("http://localhost:9999/Group3/", "").replace("&id=" + checkbox[i].children[0].value, "");
                            }
                        } else {
                            console.log(document.getElementById('deletebtn').href.replace("http://localhost:9999/Group3/", ""));
                            document.getElementById('deletebtn').href = document.getElementById('deletebtn').href.replace("http://localhost:9999/Group3/", "") + "&id=" + checkbox[i].children[0].value;
                        }
                    };
                }
            </script>
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
