<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-expand-sm navbar-dark bg-dark">
    <!-- Brand and toggle get grouped for better mobile display -->
    <a class="mr-3 text-light" href="/"><i class="fas fa-home"></i></a>
    <a class="navbar-brand" href="/ads">Adlister</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarText">
        <ul class="navbar-nav ml-auto">
            <c:choose>
                <c:when test="${user != null}">
                    <li class="nav-item <c:if test="${param.current.equals('profile')}">active</c:if>"><a href="/profile" class="nav-link">Profile (${user.getUsername()})</a></li>
                    <li class="nav-item"><a href="/logout" class="nav-link">Logout</a></li>
                </c:when>
                <c:otherwise>
                    <li class="nav-item <c:if test="${param.current.equals('register')}">active</c:if>"><a href="/register" class="nav-link">Register</a></li>
                    <li class="nav-item <c:if test="${param.current.equals('login')}">active</c:if>"><a href="/login" class="nav-link">Login</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div><!-- /.navbar-collapse -->
</nav>
