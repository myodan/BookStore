<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="ko">
<head>
    <%@include file="components/head.jsp" %>
    <title>Home</title>
</head>
<body>
<div class="page">
    <c:import url="components/header.jsp"/>
    <div class="page-wrapper">
        <div class="container-xl">
            <div class="page-header d-print-none">
                <div class="row g-2 align-items-center">
                    <h2 class="page-title">
                        홈
                    </h2>
                </div>
            </div>
        </div>
        <c:import url="components/footer.jsp"/>
    </div>
</div>
</body>
</html>