<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Direct Message" />
    </jsp:include>
    <style>
        #MessageHolder{
            height:400px;
            max-height:400px;
            overflow:scroll;
        }
        .Author{
            font-size:0.8em;
            color:#888;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/partials/navbar.jsp" />

<div class="container-fluid p-3">
    <div class="row">
        <div id="MessageHolder" class="col-8 mx-auto">

        </div>
        <div id="MessageInput" class="col-8 mx-auto">
            <form id="postMessage" method="post">
                <input id="MessageContent" class="w-100" type="text" name="content" placeholder="Message @${messageUser.username}" autofocus>
                <button class="w-100" type="submit">Send</button>
            </form>
        </div>
    </div>
</div>

<script>
    let curHTML = ""
    $("#postMessage").on("submit",function(e){
        e.preventDefault();
        if($("#MessageContent").val() !== "") {
            var url = $(this).attr("action");
            var formData = $(this).serializeArray();
            $.post(url, formData);
            $("#MessageContent").val("");
            getMessages();
        }
    })
    let messages = [];
    //StartHere
    <c:forEach var="message" items="${messages}">
    //betweenMessages
    messages.push(
        {
            id:${message.id},
            fromID:${message.fromID},
            toID:${message.toID},
            content:"${message.content}",
            htmlDisplay:"${message.getDisplay(sessionScope.user)}"
        });
    </c:forEach>
    //EndHere
    function renderMessage(message) {
        return message.htmlDisplay;
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
        $("#MessageHolder").html(curHTML);
        $("#MessageHolder").scrollTop($("#MessageHolder").prop("scrollHeight"));
    }
    updateMessages();

    function getMessages(){
        console.log("Checking for new messages");
        $.ajax({
            type: "get",
            url: "/messages/"+${requestScope.messageUser.id},
            data:{oldMessages:"true"},
            success: function(data)
            {
                if(!data.includes("Author")){
                    return;
                }
                let html = '<div class="col-12 mx-auto">';
                html+=data;
                html+='</div>';
                if(curHTML != html){
                    curHTML = html;
                    $("#MessageHolder").html(curHTML);
                    $("#MessageHolder").scrollTop($("#MessageHolder").prop("scrollHeight"));
                }else{
                    //console.log("nope");
                }
            }
        });
    }
    setInterval(getMessages,500)
</script>
</body>
</html>
