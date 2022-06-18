<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="ko">
<head>
    <%@include file="../components/head.jsp" %>
    <title>Books | Create</title>
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
                            도서 등록
                        </h2>
                    </div>
                </div>
            </div>
        </div>
        <div class="page-body">
            <div class="container-xl">
                <form action="${pageContext.request.contextPath}/books/create" method="post">
                    <div class="card">
                        <div class="card-header">
                            <h3 class="card-title">도서 정보</h3>
                        </div>
                        <div class="card-body">
                            <div class="row mb-3">
                                <label for="bookId" class="form-label col-3 col-form-label">도서 ID</label>
                                <input type="number" id="bookId" name="bookId" class="form-control col" required/>
                            </div>

                            <div class="row mb-3">
                                <label for="bookName" class="form-label col-3 col-form-label">제목</label>
                                <input type="text" id="bookName" name="bookName" class="form-control col" required/>
                            </div>

                            <div class="row mb-3">
                                <label for="publisher" class="form-label col-3 col-form-label">출판</label>
                                <input type="text" id="publisher" name="publisher" class="form-control col" required/>
                            </div>

                            <div class="row">
                                <label for="price" class="form-label col-3 col-form-label">가격</label>
                                <input type="number" id="price" name="price" class="form-control col" required/>
                            </div>
                        </div>
                        <div class="card-footer">
                            <div class="d-flex justify-content-between">
                                <a href="${pageContext.request.contextPath}/books" class="btn btn-link">취소</a>
                                <button type="submit" class="btn btn-primary">등록</button>
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