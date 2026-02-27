<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--
  Header.jsp
  Props(request attributes):
    - isLoggedIn (Boolean) : 로그인 여부
  Actions:
    - onMenuClick  → window.openSideMenu() 호출
    - onLogin      → window.openLoginModal() 호출
--%>

<%-- /chat 페이지에서는 헤더 숨김 --%>
<c:if test="${pageContext.request.requestURI ne '/chat'}">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Header.css" />

<header class="app-header">

    <%-- 햄버거 메뉴 버튼 --%>
    <button class="icon-btn" onclick="window.openSideMenu()" aria-label="메뉴 열기">
        <i data-lucide="menu" style="width:24px;height:24px;color:#333;"></i>
    </button>

    <%-- 로고 --%>
<div class="logo-container" onclick="window.location.href='${pageContext.request.contextPath}/'" style="cursor:pointer;">
    <img src="${pageContext.request.contextPath}/images/character.png"
         alt="로고"
         style="width:60px;height:60px;object-fit:contain;transform:scaleX(-1);" />
    <span class="logo-text">TRAFFIC:ON</span>
</div>


    </div>

    <%-- 로그인 상태에 따른 우측 버튼 --%>
    <c:choose>
        <c:when test="${isLoggedIn}">
            <button class="icon-btn"
                    onclick="window.location.href='${pageContext.request.contextPath}/mypage'"
                    aria-label="마이페이지">
                <i data-lucide="user" style="width:24px;height:24px;color:#333;"></i>
            </button>
        </c:when>
        <c:otherwise>
            <button class="icon-btn login-btn-header"
                    onclick="window.openLoginModal()"
                    aria-label="로그인">
                <i data-lucide="user-plus" style="width:24px;height:24px;color:#333;"></i>
            </button>
        </c:otherwise>
    </c:choose>

</header>

<%-- Lucide 아이콘 초기화 (페이지당 1회만 로드되도록 조건 처리 권장) --%>
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>
<script>lucide.createIcons();</script>

</c:if>
