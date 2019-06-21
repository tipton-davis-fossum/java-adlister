<%--
  Created by IntelliJ IDEA.
  User: alexandrafossum
  Date: 2019-06-20
  Time: 15:25
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="adlister"/>
    </jsp:include>
</head>
<body>
<jsp:include page="/WEB-INF/partials/navbar.jsp"/>

<div class="container-fluid">
    <form action="/ads/update/" method="POST">

        <div class="form-group">
            <label for="adTitle">Former title: ${ad.title}</label>
            <input id="adTitle" class="form-control" type="text" placeholder="Ad Title">
            <label for="adDescription">Former description: ${ad.description}</label>
            <input id="adDescription" class="form-control" type="text" placeholder="Default input">
            <button id="adSubmit" class="btn" type="submit">Submit edits</button>
        </div>
    </form>
</div>

        <script>
            let adTitle = document.getElementById("adTitle");
            let adDescription = document.getElementById("adDescription");

            let emptyTitle;
            let emptyDescription;

            adTitle.oninput = function changeAdTitle () {
                let adTitleInput = document.getElementById("adTitle").value;

                if (adTitleInput.length > 0) {
                    document.getElementById("adSubmit").removeAttribute("disabled");
                    emptyTitle = false;
                } else {
                    alert("Please fill in the title section.");
                }
            }

            adDescription.oninput = function changeAdDescription () {
                let adDescriptionInput = document.getElementById("adDescription").value;

                if (adDescriptionInput.length > 0) {
                    document.getElementById("adSubmit").removeAttribute("disabled");
                    emptyDescription = false;
                } else {
                    alert("Please fill in the description section.");
                }
            }

            document.getElementById("submit").onclick = function () {

                let inputAdTitle = document.getElementById("adTitle").value;
                let inputAdDescription = document.getElementById("adDescription").value;

                if (inputAdTitle.length > 0 && inputAdDescription.length > 0) {
                    emptyTitle = false;
                    emptyDescription = false;
                    document.getElementById("submit").removeAttribute("disabled", "");
                } else {
                    emptyTitle = true;
                    emptyDescription = true;
                    document.getElementById("submit").setAttribute("disabled", "");
                }
            }

        </script>
</body>
</html>