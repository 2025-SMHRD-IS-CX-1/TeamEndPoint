<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TRAFFIC:ON - 이벤트 및 소식</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/SideMenu.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/EventPage.css">

    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>

<div class="event-container">

    <header class="top-header">
        <div class="left">
            <button class="icon-btn" type="button" aria-label="menu" onclick="openSideMenu()">
                <i data-lucide="menu"></i>
            </button>
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

    <aside id="sideMenu" class="side-menu">
        <div class="side-menu-header">
            <button type="button" class="close-btn" onclick="closeSideMenu()">
                <i data-lucide="x"></i>
            </button>
        </div>

        <nav class="side-menu-list">
            <a href="${pageContext.request.contextPath}/">홈</a>
            <a href="${pageContext.request.contextPath}/guide">민원유형</a>
            <a href="${pageContext.request.contextPath}/application-process">신청절차 안내</a>
            <a href="${pageContext.request.contextPath}/events">이벤트 및 소식</a>
            <a href="${pageContext.request.contextPath}/about">서비스 소개</a>
        </nav>
    </aside>

    <div id="sideOverlay" class="side-overlay" onclick="closeSideMenu()"></div>

    <main class="event-content-wrap">
        <section class="event-title-section">
            <h2>진행 중인 이벤트</h2>
        </section>

        <section class="festival-list">

            <a class="festival-link" href="${pageContext.request.contextPath}/events/1">
                <article class="festival-card">
                    <div class="festival-image-wrap">
                        <img src="${pageContext.request.contextPath}/images/1.jpg" alt="광주 추억의 충장축제">
                        <span class="festival-badge">축제</span>
                    </div>

                    <div class="festival-info">
                        <span class="festival-category">지역 축제</span>
                        <h3>광주 추억의 충장축제</h3>
                        <p>2025.10.15 ~ 10.19</p>
                    </div>
                </article>
            </a>

            <a class="festival-link" href="${pageContext.request.contextPath}/events/2">
                <article class="festival-card">
                    <div class="festival-image-wrap">
                        <img src="${pageContext.request.contextPath}/images/2.jpg" alt="광주 비엔날레">
                        <span class="festival-badge">전시</span>
                    </div>

                    <div class="festival-info">
                        <span class="festival-category">예술 전시</span>
                        <h3>광주 비엔날레</h3>
                        <p>2025.08.30 ~ 11.02</p>
                    </div>
                </article>
            </a>

            <a class="festival-link" href="${pageContext.request.contextPath}/events/3">
                <article class="festival-card">
                    <div class="festival-image-wrap">
                        <img src="${pageContext.request.contextPath}/images/3.jpg" alt="광주 세계 김치 축제">
                        <span class="festival-badge">음식</span>
                    </div>

                    <div class="festival-info">
                        <span class="festival-category">음식 축제</span>
                        <h3>광주 세계 김치 축제</h3>
                        <p>2024.10.18 ~ 10.20</p>
                    </div>
                </article>
            </a>

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

    function openSideMenu() {
        document.getElementById("sideMenu").classList.add("open");
        document.getElementById("sideOverlay").classList.add("show");
    }

    function closeSideMenu() {
        document.getElementById("sideMenu").classList.remove("open");
        document.getElementById("sideOverlay").classList.remove("show");
    }
</script>

</body>
</html>