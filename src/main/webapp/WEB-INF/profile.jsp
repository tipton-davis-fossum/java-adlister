<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile</title>
    <jsp:include page="/WEB-INF/partials/head.jsp">
        <jsp:param name="title" value="Your Profile"/>
    </jsp:include>
    <style>
        .profileImage{
            width:100px;
            border-radius: 50%;
            transition: opacity 0.3s ease-in-out;
            cursor: pointer;
            background: #777;
        }
        #profileImage:hover{
            opacity:.5;
        }
        #file{
            width:0px;
            height:0px;
            overflow:hidden;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/partials/navbar.jsp">
        <jsp:param name="current" value="profile"/>
    </jsp:include>

    <div class="container-fluid p-3">
        <div class="row">
            <div class="col-8 mx-auto">
                <h1>Welcome, ${sessionScope.user.username}!</h1>
                <div>
                    <div class="profileImage" >
                        <img id="profileImage" class="profileImage"  src="/img/profile_${sessionScope.user.getId()}" alt=""/>
                    </div>
                    <form id="PFPUpload" method="post" enctype="multipart/form-data">
                        <input id="file" accept="image/*" type="file" name="file"/>
                    </form>
                    ${message}
                </div>
                <c:forEach var="ad" items="${requestScope.adsList}">
                    <div class="card my-3">
                        <div class="card-body">
                            <h3>${ad.title}</h3>
                            <p>${ad.description}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    <script
            src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
            crossorigin="anonymous">
    </script>
    <script>
        function getBase64(file) {
            return new Promise((resolve, reject) => {
                const reader = new FileReader();
                reader.readAsDataURL(file);
                reader.onload = () => resolve(reader.result);
                reader.onerror = error => reject(error);
            });
        }
        $("#profileImage").click(function(e){
            $("#file").trigger('click');
        });
        $("#PFPUpload").change(function(e) {
            let file = $("#file")[0].files[0];
            getBase64(file).then(
                data => {
                    $("#profileImage").attr("src", data);
                }
            );

            let data = new FormData();
            data.append('file-1',file);
            $.ajax({
                type: "POST",
                url: "/profile",
                enctype:"multipart/form-data",
                processData: false,  // Important!
                contentType: false,
                cache: false,
                data: data, // serializes the form's elements.
                success: function(data)
                {
                    $("#profileImage").attr("src","data:image/jpeg;base64,"+data);
                }
            });
        });
    </script>
</body>
</html>
