<%@ page import="com.codeup.adlister.models.User" %>
<%@ page import="com.codeup.adlister.dao.DaoFactory" %>
<%@ page import="com.codeup.adlister.models.Message" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Direct Messages" />
    </jsp:include>
    <style>
        .Author{
            font-size:0.8em;
            color:#888;
        }
        .messageListing:hover{
            opacity: 1;
            background:inherit;
            cursor:pointer;
        }
        .messageListing{
            opacity: 0.8;
            background: #eee;
            border-radius: 5px;
            -webkit-box-shadow: 2px 2px 8px -7px rgba(0,0,0,0.75);
            -moz-box-shadow: 2px 2px 8px -7px rgba(0,0,0,0.75);
            box-shadow: 2px 2px 8px -7px rgba(0,0,0,0.75);
        }
        .unread{
            border-left:10px solid #f22;
        }
        .ounread{
            border-left:10px solid #66f;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/partials/navbar.jsp">
    <jsp:param name="current" value="messages"/>
</jsp:include>

<div class="container-fluid p-3">
    <div class="row">
        <div id="MessagesHolder" class="col-8 mx-auto">
        </div>
    </div>
</div>

<script>

    let messages = [];
    //StartHere
    <c:forEach var="message" items="${messagesList}">
    //betweenMessages
    messages.push(
        {
            id:${message.id},
            fromID:${message.fromID},
            toID:${message.toID},
            content:"${message.content}",
            unread:${message.unread},
            authorName:"${message.authorName}",
            toName:"${message.toName}",
        });
    </c:forEach>
    //EndHere
    function renderMessage(message) {
        let mainID = (message.fromID == ${sessionScope.user.id} ? message.toID : message.fromID);
        let mainName = (message.fromID == ${sessionScope.user.id} ? message.toName : message.authorName);
        let unread = (message.unread == true ?
            (message.toID == ${sessionScope.user.id} ? " unread " : " ounread ") : "");
        let htmlBuffer =
            "<div class='messageListing" + unread +
            " card my-2' onclick=location.href=\"/messages/" +mainID+"\">"+
                "<div class='card-header p-1 pl-2'>" +
                    "<a href='/profile/"+mainID+"'>"+mainName+"</a>" +
                "</div>"+
                "<div class='card-body py-1 pr-1 pl-3'>"+
                    "<a class='card-title' href='/profile/"+message.fromID+"'>" +
                        "<span class='w-100 card-text'>" + message.authorName + "</span>" +
                    "</a>"+
                    "<p class='w-100 mb-0'>" + message.content + "</p>" +
                "</div>"+
            "</div>";
        return htmlBuffer;
    }
    function renderMessages(messages) {
        let html = '<div class="col-12 mx-auto">';
        for(let i = 0; i < messages.length; i++) {
            html += renderMessage(messages[i]);
        }
        html+='</div>';
        return html;
    }
    function updateMessages() {
        curHTML = renderMessages(messages);
        $("#MessagesHolder").html(curHTML);
    }
    updateMessages();

</script>
</body>
</html>
