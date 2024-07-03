<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Skill, java.util.ArrayList, model.User, model.Mentor, model.Mentee, model.Message, model.Conversation" %>

<!DOCTYPE html>
<html>
    <head>
        <style>
            body {
                font-family: 'Nunito', sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            .message__popup--box-content {
                display: flex;
                height: 100vh;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .box__left {
                width: 25%;
                background-color: #f7f7f7;
                border-right: 1px solid #e6e6e6;
                overflow-y: auto;
                padding: 20px;
            }

            .user__chat {
                display: flex;
                align-items: center;
                margin-bottom: 15px;
                cursor: pointer;
            }

            .user__chat img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                margin-right: 10px;
            }

            .user__chat div {
                display: flex;
                flex-direction: column;
            }

            .user__chat-name {
                font-weight: bold;
                margin-bottom: 5px;
            }

            .user__chat-time {
                font-size: 12px;
                color: #999;
            }

            .box__right {
                width: 75%;
                display: flex;
                flex-direction: column;
                padding: 20px;
            }

            .box__right-header {
                display: flex;
                align-items: center;
                padding-bottom: 15px;
                border-bottom: 1px solid #e6e6e6;
            }

            .box__right-header img {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                margin-right: 10px;
            }

            .box__right-header div {
                display: flex;
                flex-direction: column;
            }

            .box__right-header-name {
                font-weight: bold;
            }

            .message__content {
                flex: 1;
                overflow-y: auto;
                padding-top: 15px;
            }
            .message1 {
    display: flex; /* Sử dụng flexbox */
    flex-direction: column; /* Dàn trang theo hướng dọc */
    align-items: flex-start; /* Căn phần tử con sang trái */
}
           /* Thêm các thuộc tính CSS cho phần tử chứa tin nhắn và thời gian gửi */


.message__footer {
    margin-top: 5px; /* Khoảng cách giữa nội dung tin nhắn và thời gian gửi */
}


            .message__content .message {
                display: flex;
                margin-bottom: 15px;
            }

            .message__content .message.sent {
                justify-content: flex-end;
            }

            .message__content .message.received {
                justify-content: flex-start;
            }

            .message__content .message .text {
                max-width: 60%;
                padding: 10px 15px;
                border-radius: 20px;
                font-size: 14px;
                line-height: 1.5;
            }

            .message__content .message.sent .text {
                background-color: #ff5e57;
                color: #fff;
            }

            .message__content .message.received .text {
                background-color: #f1f0f0;
                color: #333;
            }

            .box__right-footer {
                display: flex;
                align-items: center;
                padding-top: 15px;
                border-top: 1px solid #e6e6e6;
            }

            .box__right-footer input[type="text"] {
                flex: 1;
                padding: 10px 15px;
                border: 1px solid #ccc;
                border-radius: 20px;
                outline: none;
                font-size: 14px;
            }

            .box__right-footer button {
                background-color: #ff5e57;
                color: #fff;
                border: none;
                border-radius: 50%;
                padding: 10px 15px;
                margin-left: 10px;
                cursor: pointer;
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
        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="message__popup--box-content">
            <div class="box__left">
                <% 
                    Conversation currCon = (Conversation)request.getAttribute("currConver");
                    ArrayList<Conversation> conversations = (ArrayList<Conversation>)request.getAttribute("conversation");
                    for (Conversation c : conversations) {
                %>
                <div class="user__chat">
                    <div class="<%=c.getId() == currCon.getId() ? "active" : ""%> " 
                         onclick="<%=c.getId() == currCon.getId() ? "" : "window.location.href='chat?id=" + c.getUserID() + "'" %>">
                        <img src="<%=c.getAvatar() != null ? c.getAvatar() : "https://files.playerduo.net/production/images/avatar7.png"%>" alt="User Image">
                        <div>
                            <span class="user__chat-name"><%=c.getFullName()%></span>
                            <% if (c.getLastMsg() != null) { %>
                                <p id="lastMsg-<%=c.getId()%>"><%=c.getLastMsg()%></p>
                                <span class="user__chat-time"><%=c.getId()%><%=c.lastTimeFormat()%></span>
                            <% } %>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            <div class="box__right">
                <!-- Header -->
                <div class="box__right-header">
                    <img src="<%=currCon.getAvatar() != null ? currCon.getAvatar() : "https://files.playerduo.net/production/images/avatar7.png"%>" alt="Current User Image">
                    <div>
                        <span class="box__right-header-name"><%=currCon.getFullName()%></span>
                    </div>
                </div>
                <!-- Message Content -->
                <div id="MessageContent" class="message__content">
                    <% 
                        ArrayList<Message> msgs = (ArrayList<Message>)request.getAttribute("message");
                        if (msgs.isEmpty()) {
                    %>
                    <div class="message received">
                        <div class="text">No messages yet. Start the conversation!</div>
                    </div>
                    <% } else {
                        for (Message m : msgs) {
                    %>
                   
<div class="message <%= m.getSendID() == u.getId() ? "sent" : "received" %>">
    
        <div class="text"><%= m.getMsgContent() %></div>
        
</div>


                    <% } } %>
                </div>
                <!-- Footer -->
                <div class="box__right-footer">
                    <input type="text" id="msg" placeholder="Type a message ...">
                    <button onclick="sendMsg()">Send</button>
                </div>
            </div>
        </div>

        <script>
            async function sendMsg() {
                const msgInput = document.getElementById("msg");
                if (msgInput.value.length > 0) {
                    const body = 'cid=<%=currCon.getId()%>&sid=<%=u.getId()%>&msg=' + encodeURIComponent(msgInput.value);
                    const response = await fetch("chat", {
                        method: "POST",
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: body
                    });
                    const data = await response.json();
                    updateMessages(data);
                    msgInput.value = '';
                }
            }

            function updateMessages(data) {
                const messageContent = document.getElementById("MessageContent");
                messageContent.innerHTML = "";
                data.forEach(msg => {
                    const messageDiv = document.createElement("div");
                    messageDiv.className = "message " + (msg.sendID == <%= u.getId() %> ? "sent" : "received");
                    const textDiv = document.createElement("div");
                    textDiv.className = "text";
                    textDiv.textContent = msg.msgContent;
                    messageDiv.appendChild(textDiv);
                    messageContent.appendChild(messageDiv);
                });

                if (data.length > 0) {
                    document.getElementById("lastMsg-<%= currCon.getId() %>").innerHTML = data[data.length - 1].msgContent;
                    document.getElementById("lastTime-<%= currCon.getId() %>").innerHTML = data[data.length - 1].sendAt;
                }
            }

            let msgLen = <%= msgs.size() %>;

            setInterval(async () => {
                const body = 'getMsg=1&cid=<%= currCon.getId() %>';
                const response = await fetch("chat", {
                    method: "POST",
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: body
                });
                const data = await response.json();
                if (data.length !== msgLen) {
                    updateMessages(data);
                    msgLen = data.length;
                }
            }, 500);
        </script>
    </body>
</html>
