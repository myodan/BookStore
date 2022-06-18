<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">
<head>
    <%@include file="../components/head.jsp" %>
    <title>Books | Delete</title>
</head>
<body>
<div class="page">
    <c:import url="../components/header.jsp"/>
    <div class="page-wrapper">
        <div class="container-xl">
            <div class="page-header d-print-none">
                <div class="row g-2 align-items-center">
                    <div class="col">
                        <div class="page-pretitle">
                            도서 관리
                        </div>
                        <h2 class="page-title">
                            도서 삭제
                        </h2>
                    </div>
                </div>
            </div>
        </div>
        <div class="page-body">
            <div class="container-xl">
                <form action="${pageContext.request.contextPath}/books/delete" method="post">
                    <div class="card">
                        <div class="card-body">
                            <h3 class="text-center">정말 삭제하시겠습니까?</h3>
                        </div>
                        <div class="card-footer">
                            <div class="d-flex justify-content-between">
                                <a href="${pageContext.request.contextPath}/books" class="btn btn-link">취소</a>
                                <button type="submit" class="btn btn-primary">수정</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <c:import url="../components/footer.jsp"/>
    </div>
</div>
</body>
</html>