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
        #EditProfile{
            cursor: pointer;
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
                <div class="row">
                    <div class="col-sm-12 col-md-3">
                        <div class="profileImage mx-auto" >
                            <img id="profileImage" class="profileImage"  src="/img/profile_${sessionScope.profileUser.getId()}" alt=""/>
                        </div>
                    </div>
                    <div class="col-sm-12 col-md-9">
                        <h3 id="usernameDisplay" class="text-center text-md-left">${sessionScope.profileUser.username}</h3>
                        <h4 id="emailDisplay" class="text-center text-md-left">${sessionScope.profileUser.email}</h4>
                        <c:if test="${sessionScope.profileUser.id == sessionScope.user.id}">
                            <h5 id="editDisplay" class="text-center text-md-left"><i id="EditProfile" class="fas fa-user-edit"></i></h5>
                            <form id="editProfileForm" method="post" style="display:none">
                                <input id="username"  type="text" name="username" placeholder="${sessionScope.profileUser.username}" value="<c:if test="${requestScope.username != null}">${requestScope.username}</c:if><c:if test="${requestScope.username == null}">${sessionScope.profileUser.username}</c:if>"/><br/>
                                <input id="email"  type="text" name="email" placeholder="${sessionScope.profileUser.email}" value="<c:if test="${requestScope.email != null}">${requestScope.email}</c:if><c:if test="${requestScope.email == null}">${sessionScope.profileUser.email}</c:if>"/><br/>
                                <c:if test="${FormError != null}">
                                    <div class="mb-2 alert alert-danger" role="alert">
                                            ${FormError}
                                    </div>
                                </c:if>
                                <button type="submit">Submit</button>
                            </form>
                        </c:if>
                    </div>
                    <c:if test="${sessionScope.profileUser.id == sessionScope.user.id}">
                        <form id="PFPUpload" method="post" enctype="multipart/form-data">
                            <input id="file" accept="image/*" type="file" name="file"/>
                        </form>
                        ${message}
                    </c:if>
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

    <c:if test="${sessionScope.profileUser.id == sessionScope.user.id}">
        <script
                src="https://code.jquery.com/jquery-3.4.1.min.js"
                integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
                crossorigin="anonymous">
        </script>
        <script>
            <c:if test="${FormError != null}">
                $("#usernameDisplay").hide();
                $("#emailDisplay").hide();
                $("#editDisplay").hide();
                $("#editProfileForm").show();
            </c:if>
            $("#EditProfile").click(e=>{
                $("#usernameDisplay").hide();
                $("#emailDisplay").hide();
                $("#editDisplay").hide();
                $("#editProfileForm").show();
            });

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
                    url: "/profile/"+${sessionScope.profileUser.id},
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
    </c:if>
</body>
</html>
