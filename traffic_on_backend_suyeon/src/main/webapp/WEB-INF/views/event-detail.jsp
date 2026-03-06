<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TRAFFIC:ON - 이벤트 상세</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/EventDetailPage.css">

    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>

<div class="event-detail-container">

    <header class="top-header">
        <div class="left">
            <div style="width:40px;"></div>
        </div>

        <div class="center">
            <img src="${pageContext.request.contextPath}/images/Pengrimi.png"
                 alt="logo"
                 class="header-logo">
            <span class="logo-text">TRAFFIC:ON</span>
        </div>

        <div class="right">
            <c:if test="${!isLoggedIn}">
                <button class="user-btn"
                        type="button"
                        onclick="location.href='${pageContext.request.contextPath}/login'"
                        aria-label="로그인">
                    <i data-lucide="user-plus"></i>
                </button>
            </c:if>

            <c:if test="${isLoggedIn}">
                <button class="user-btn"
                        type="button"
                        onclick="location.href='${pageContext.request.contextPath}/mypage'"
                        aria-label="마이페이지">
                    <i data-lucide="user"></i>
                </button>
            </c:if>
        </div>
    </header>

    <main class="event-detail-wrap">
        <section class="event-detail-card">
            <div class="detail-image-wrap">
                <img src="${pageContext.request.contextPath}${eventImage}" alt="${eventTitle}">
            </div>

            <div class="detail-info">
                <span class="detail-badge">${eventCategory}</span>
                <h2>${eventTitle}</h2>
                <p class="detail-date">${eventDate}</p>
                <p class="detail-desc">${eventDesc}</p>

                <button class="detail-confirm-btn" type="button"
                        onclick="location.href='${pageContext.request.contextPath}/events'">
                    확인
                </button>
            </div>
        </section>
    </main>

    <nav class="bottom-nav">
        <a class="nav-item" href="${pageContext.request.contextPath}/">
            <i data-lucide="search"></i>
            <span>사전해결 가이드</span>
        </a>

        <div class="nav-divider"></div>

        <a class="nav-item" href="${pageContext.request.contextPath}/guide">
            <i data-lucide="layout-grid"></i>
            <span>민원유형</span>
        </a>

        <div class="nav-divider"></div>

        <a class="nav-item" href="${pageContext.request.contextPath}/application-process">
            <i data-lucide="file-check"></i>
            <span>신청절차 안내</span>
        </a>
    </nav>
</div>

<script>
    lucide.createIcons();
</script>

</body>
</html>