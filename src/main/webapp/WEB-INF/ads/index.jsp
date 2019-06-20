<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Viewing All The Ads"/>
    </jsp:include>
</head>
<body>

<jsp:include page="/WEB-INF/partials/navbar.jsp"/>
<div class="container">
    <div class="row input-group input-group-lg">
        <div class="input-group-prepend">
            <span class="input-group-text" id="inputGroup-sizing-lg">Search our ads</span>
        </div>
        <input type="text" name="title" id="title" class="form-control" aria-label="Sizing example input"
               aria-describedby="inputGroup-sizing-lg" placeholder="search">
    </div>
    <div id="adList" class="row">
    </div>

    <script
            src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
            crossorigin="anonymous">
    </script>
    <script>
        let ads = [];

        let searchBar = document.querySelector("#title");
        searchBar.addEventListener('input',updateAds);

        <c:forEach var="ad" items="${ads}">
            ads.push(
                {
                    title:"${ad.title}",
                    description:"${ad.description}",
                    userID:${ad.userId}
            });
        </c:forEach>

        function renderAd(ad) {
            let html='<div class="col-12">' +
                '<h2>'+ad.title+'</h2>' +
                '<p>'+ad.description+'</p>' +
                '<hr>' +
                '</div>';
            return html;
        }
        function renderAds(ads) {
            let html = '';
            for(let i = 0; i < ads.length; i++) {
                html += renderAd(ads[i]);
                console.log(html);
            }
            return html;
        }
        function updateAds() {
            let nameFilter = searchBar.value;
            let filteredAds = [];
            // iterate through function for specific coffee
            ads.forEach(function(ad) {
                // filter out coffee based on name
                if (ad.title.toLowerCase().includes(nameFilter.toLowerCase())) {
                    filteredAds.push(ad);
                }
            });
            $("#adList").html(renderAds(filteredAds));
        }
        updateAds();
    </script>
</div>
</body>
</html>
