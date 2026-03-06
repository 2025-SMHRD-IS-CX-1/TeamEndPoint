<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Event 수정중 -->
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

<script>
    if (window.lucide) {
        lucide.createIcons();
    }
</script>