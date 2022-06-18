<%@ page contentType="text/html;charset=UTF-8" %>

<header class="navbar navbar-expand-md navbar-light d-print-none">
    <div class="container-xl">
        <h1 class="navbar-brand navbar-brand-autodark d-none-navbar-horizontal py-3 pe-0 pe-md-3">
            <a href=".">
                스토어
            </a>
        </h1>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar-menu">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbar-menu">
            <div class="d-flex flex-column flex-md-row flex-fill align-items-stretch align-items-md-center">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/books">
                            <span class="nav-link-title">
                            도서 관리
                            </span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</header>