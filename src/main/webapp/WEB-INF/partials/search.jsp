<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="row">
    <div class="col-12 mx-auto input-group input-group-lg">
        <div class="input-group-prepend">
            <span class="input-group-text" id="inputGroup-sizing-lg">Search our ads</span>
        </div>
        <input type="text" name="title" id="title" class="form-control" aria-label="Sizing example input"
               aria-describedby="inputGroup-sizing-lg" placeholder="search">
    </div>
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
            id:${ad.id},
            title:"${ad.title}",
            description:"${ad.description}",
            userID:${ad.userId},
            htmlDisplay:"${ad.getDisplay()}"
        });
    </c:forEach>

    function renderAd(ad) {
        return ad.htmlDisplay
    }
    function renderAds(ads) {
        let html = '<div class="col-12 mx-auto">';
        for(let i = 0; i < ads.length; i++) {
            html += renderAd(ads[i]);
            console.log(html);
        }
        html+='</div>';
        return html;
    }
    function updateAds() {
        let nameFilter = searchBar.value;
        let filteredAds = [];
        // iterate through function for specific ads
        ads.forEach(function(ad) {
            // filter out ads based on name
            if (ad.title.toLowerCase().includes(nameFilter.toLowerCase()) ||
                ad.description.toLowerCase().includes(nameFilter.toLowerCase())) {
                filteredAds.push(ad);
            }
        });
        $("#adList").html(renderAds(filteredAds));
    }
    updateAds();
</script>