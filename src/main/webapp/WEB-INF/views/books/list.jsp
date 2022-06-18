<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="pageable" scope="request" type="dev.myodan.bookstore.util.Pageable"/>

<html lang="ko">
<head>
    <%@include file="../components/head.jsp" %>
    <title>Books | List</title>
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
                            도서 목록
                        </h2>
                    </div>
                    <div class="col-12 col-md-auto ms-auto d-print-none">
                        <div class="btn-list">
                            <div class="btn-group">
                                <a href="${pageContext.request.contextPath}/books/dummy" class="btn">
                                    임시 데이터 추가
                                </a>
                                <a href="${pageContext.request.contextPath}/books/init" class="btn">
                                    임시 데이터 삭제
                                </a>
                            </div>
                            <a href="${pageContext.request.contextPath}/books/create" class="btn btn-primary">
                                추가
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="page-body">
            <div class="container-xl">
                <div class="card">
                    <div class="card-body border-bottom py-3">
                        <form method="get" class="d-flex justify-content-between">
                            <div class="d-flex gap-1">
                                <input type="text" name="offset" size="3" class="form-control form-control-sm" value="${pageable.offset}">
                                개씩
                            </div>
                            <div class="d-flex gap-1">
                                <select name="filter" class="form-select form-select-sm w-auto" >
                                    <option value="1" ${pageable.filter == 1 ? "selected" : ""}>번호</option>
                                    <option value="2" ${pageable.filter == 2 ? "selected" : ""}>제목</option>
                                    <option value="3" ${pageable.filter == 3 ? "selected" : ""}>출판</option>
                                </select>
                                <input type="text" name="keyword" class="form-control form-control-sm w-auto" placeholder="검색어" value="${pageable.keyword}">
                                <button type="submit" class="btn btn-sm btn-primary">
                                    검색
                                </button>
                            </div>
                        </form>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-vcenter card-table">
                            <thead>
                            <tr>
                                <th>번호</th>
                                <th>제목</th>
                                <th>출판</th>
                                <th>가격</th>
                                <th class="w-5">관리</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="book" items="${bookList}">
                                <tr>
                                    <td>${book.bookId}</td>
                                    <td>${book.bookName}</td>
                                    <td>${book.publisher}</td>
                                    <td><fmt:formatNumber value="${book.price}"/></td>
                                    <td>
                                        <div class="btn-group">
                                            <a href="${pageContext.request.contextPath}/books/update?bookId=${book.bookId}" class="btn btn-sm">
                                                수정
                                            </a>
                                            <a href="${pageContext.request.contextPath}/books/delete?bookId=${book.bookId}" class="btn btn-sm">
                                                삭제
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer d-flex align-items-center">
                        <p class="m-0 text-muted">총 ${pageable.total}개</p>
                        <ul class="pagination m-0 ms-auto">
                            <li class="page-item ${pageable.page <= 1 ? "disabled": ""}">
                                <a class="page-link" href="${pageContext.request.contextPath}/books?page=1&${pageable.query}">
                                    <i class="ti ti-chevrons-left icon"></i>
                                </a>
                            </li>
                            <li class="page-item ${pageable.page <= 1 ? "disabled": ""}">
                                <a class="page-link" href="${pageContext.request.contextPath}/books?page=${pageable.pre}&${pageable.query}">
                                    <i class="ti ti-chevron-left icon"></i>
                                </a>
                            </li>
                            <c:forEach var="page" items="${pageable.list}">
                                <li class="page-item ${page == pageable.page ? "active" : ""}">
                                    <a class="page-link" href="${pageContext.request.contextPath}/books?page=${page}&${pageable.query}">${page}</a>
                                </li>
                            </c:forEach>
                            <li class="page-item ${pageable.last <= pageable.page ? "disabled": ""}">
                                <a class="page-link" href="${pageContext.request.contextPath}/books?page=${pageable.next}&${pageable.query}">
                                    <i class="ti ti-chevron-right icon"></i>
                                </a>
                            </li>
                            <li class="page-item ${pageable.last <= pageable.page ? "disabled": ""}">
                                <a class="page-link" href="${pageContext.request.contextPath}/books?page=${pageable.last}&${pageable.query}">
                                    <i class="ti ti-chevrons-right icon"></i>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <c:import url="../components/footer.jsp"/>
    </div>
</div>
</body>
</html>