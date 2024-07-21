<%-- 
    Document   : HomePage
    Created on : Oct 5, 2022, 9:46:55 AM
    Author     : DELL
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
        <div class="row">
            <%@include file="header.jsp" %>
            <!-- ======= Hero Section ======= -->
            <div  style="padding-top: 100px" class="menu__header fix-menu">
                <div class="container" style="width: 100000px">
                    <h2>Schedule Details for Schedule ID: ${scheduleID}</h2>
                    <script>
                        function calculateEndTime(slotTime, hours) {
                            const slotTimeDate = new Date(slotTime);
                            const utcSlotTime = new Date(Date.UTC(
                                    slotTimeDate.getFullYear(),
                                    slotTimeDate.getMonth(),
                                    slotTimeDate.getDate(),
                                    slotTimeDate.getHours(),
                                    slotTimeDate.getMinutes(),
                                    slotTimeDate.getSeconds(),
                                    ));

                            const endTimeDate = new Date(utcSlotTime.getTime() + hours * 60 * 60 * 1000);

                            const formattedEndTime = endTimeDate.toISOString().slice(0, 19).replace('T', ' ');

                            return formattedEndTime;
                        }

                    </script>
                    <form action="new-schedule-detail" method="post">
                        <button class="btn btn-danger" type="submit" onclick="return confirm('Are you sure to send to admin?')">Delete all checked</button>
                        <input type="hidden" value="${scheduleID}" name="scheduleId" />
                        <table class="table table-striped table-hover" id="data-table-slot">
                            <thead>
                                <tr>
                                    <th>
                                        <span class="custom-checkbox">
                                            <input type="checkbox" id="selectAll" onclick="selectAllCheckboxes(this)">
                                            <label for="selectAll"></label>
                                        </span>
                                    </th>
                                    <th>No.</th>
                                    <th>Start</th>
                                    <th>End</th>
                                    <th>Link</th>
                                    <th>Status</th>
                                    <td>Action</td>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="slot" items="${slots}" varStatus="index">
                                    <tr>
                                        <td> <input type="checkbox" name="selectedSlots" value="${slot.id}"></td>
                                        <td>${index.index + 1}</td>
                                        <td>${slot.slotTime}</td>
                                        <td>
                                            <script>
                                                document.write(calculateEndTime('${slot.slotTime}', ${slot.hour}));
                                            </script>
                                        </td>
                                        <td>
                                            <a href="${slot.link}" class="badge badge-primary">Link meet</a>
                                        </td>
                                        <td>${slot.status}</td>
                                        <td>
                                            <a href="javascript:void(0);" onclick="edit(${slot.id})" class="btn btn-info">Edit</a>
                                            <a onclick="return confirm('Are you sure to delete ?')" href="new-schedule-detail?action=delete&slotID=${slot.id}" class="btn btn-danger">Delete</a>
                                        </td>
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
                    <a href="new-schedule" class="btn btn-primary">Back to Schedules</a>
                </div>
            </div>        


            <div id="preloader"></div>
        </div>


        <script>
            Date.prototype.addDays = function (days) {
                var date = new Date(this.valueOf());
                date.setDate(date.getDate() + days);
                return date;
            }

            async function edit(id) {
                event.preventDefault();
                if (!JSON.stringify(document.body.style).includes("overflow: hidden;")) {
                    setTimeout(async () => {
                        document.body.style = 'overflow: hidden; padding-right: 17px; background-color: rgb(233, 235, 238) !important; display:flex';
                        var response = await fetch("getSlotToEditNew?sid=" + id);
                        var data = await response.json();
                        console.log(data["SlotTime"])
                        let slotDate = new Date(Date.parse(data["SlotTime"]));
                        let SlotDateonly = [slotDate.getMonth() + 1, slotDate.getDate(), slotDate.getFullYear()];
                        var slotTime = SlotDateonly[2] + "-" + (parseInt(SlotDateonly[0]) < 10 ? "0" + SlotDateonly[0] : SlotDateonly[0]) + "-" + (parseInt(SlotDateonly[1]) < 10 ? "0" + SlotDateonly[1] : SlotDateonly[1]);
                        var slotHour = slotDate.toTimeString().split(":")[0] + ":" + slotDate.toTimeString().split(":")[1];
                        var slot = 0;
                        if (slotHour === "05:00") {
                            slot = 0;
                        }
                        if (slotHour === "07:30") {
                            slot = 1;
                        }
                        if (slotHour === "10:00") {
                            slot = 2;
                        }
                        if (slotHour === "12:50") {
                            slot = 3;
                        }
                        if (slotHour === "15:20") {
                            slot = 4;
                        }
                        if (slotHour === "17:50") {
                            slot = 5;
                        }
                        if (slotHour === "20:30") {
                            slot = 6;
                        }

                        let modal = document.createElement('div');
                        modal.innerHTML = '<div role="dialog" aria-hidden="true">\n\
<div class="fade modal-backdrop"></div>\n\
<div role="dialog" tabindex="-1" class="fade modal-donate modal" style="display: block;">\n\
<div class="modal-dialog">\n\
  <div class="modal-content" role="document">\n\
    <div class="modal-header">\n\
      <button type="button" class="close" onclick="closeModal()">\n\
        <span aria-hidden="true">×</span>\n\
        <span class="sr-only">Close</span>\n\
      </button>\n\
      <h4 class="modal-title">\n\
        <span>Update Slot</span>\n\
      </h4>\n\
    </div>\n\
    <form method="post" action="getSlotToEditNew">\n\
      <div class="modal-body">\n\
        <table style="width: 100%;">\n\
          <tbody>\n\
              <input type="hidden" name="type" value="update">\n\
              <input type="hidden" name="id" value="' + id + '">\n\
\n\<input type="hidden" name="scheduleId" value="${scheduleID}">\n\
            <tr>\n\
              <td>\n\
                <span>Meet Link</span>:\n\
              </td>\n\
              <td>\n\
                <input placeholder="Nhập link meet" required name="link" maxlength="255" type="text" class="form-control" value="' + data["link"] + '"/>\n\
              </td>\n\
            </tr>\n\
            <tr>\n\
              <td>\n\
                <span>Ngày dạy slot</span>:\n\
              </td>\n\
              <td>\n\
                <input placeholder="Chọn ngày dạy" required name="start" type="date" class="form-control" value="' + slotTime + '"/>\n\
              </td>\n\
            </tr>\n\
            <tr>\n\
              <td>\n\
                <span>Chọn slot dạy học</span>:\n\
              </td>\n\
              <td>\n\
                <select name="slot" onchange="changeSlot(this)"><option value="0" ' + (slot === 0 ? "selected" : "") + '>Slot 0 (05:00 - 07:20) </option><option value="1" ' + (slot === 1 ? "selected" : "") + '>Slot 1 (07:30 - 09:50) </option><option value="2" ' + (slot === 2 ? "selected" : "") + '>Slot 2 (10:00 - 12:20) </option><option value="3" ' + (slot === 3 ? "selected" : "") + '>Slot 3 (12:50 - 15:10) </option><option value="4" ' + (slot === 4 ? "selected" : "") + '>Slot 4 (15:20 - 17:40) </option><option value="5" ' + (slot === 5 ? "selected" : "") + '>Slot 5 (17:50 - 20:10) </option><option value="6" ' + (slot === 6 ? "selected" : "") + '>Slot 6 (20:30 - 22:50) </option></select>\n\
                <input class="hidden" type="time" name="time" value="' + slotHour + '">\n\
              </td>\n\
            </tr>\n\
                <input placeholder="Nhập số giờ dạy" required name="hour" type="hidden" class="form-control" value="' + data["hour"] + '"/>\n\
          </tbody>\n\
        </table>\n\
      </div>\n\
      <div class="modal-footer">\n\
        <button type="submit" onclick="validate(this, event)" class="btn btn-success">\n\
          <span>Cập Nhật</span>\n\
        </button>\n\
      </div>\n\
    </form>\n\
  </div>\n\
</div>\n\
</div>\n\
</div>';
                        let date = new Date();
                        let dateonly = [date.getMonth() + 1, date.getDate(), date.getFullYear()];
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
                    document.body.lastChild.children[1].classList.remove("in");
                    document.body.lastChild.children[0].classList.remove("in");
                    setTimeout(function () {
                        document.body.style = 'background-color: rgb(233, 235, 238) !important; display:flex';
                        document.body.removeChild(document.body.lastChild);
                        window.onclick = null;
                    }, 100);
                }
            }

            function closeModal() {
                document.body.lastChild.children[0].classList.remove("in");
                document.body.lastChild.children[1].classList.remove("in");
                setTimeout(function () {
                    document.body.style = 'background-color: rgb(233, 235, 238) !important; display:flex';
                    document.body.removeChild(document.body.lastChild);
                    window.onclick = null;
                }, 100);
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

            function changeSlot(input) {
                let selectedOption = input.options[input.selectedIndex].value;
                let timeInput = input.parentNode.querySelector("input[type=time]");
                let slotTimes = {
                    0: "05:00",
                    1: "07:30",
                    2: "10:00",
                    3: "12:50",
                    4: "15:20",
                    5: "17:50",
                    6: "20:30"
                };
                timeInput.value = slotTimes[selectedOption];
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
