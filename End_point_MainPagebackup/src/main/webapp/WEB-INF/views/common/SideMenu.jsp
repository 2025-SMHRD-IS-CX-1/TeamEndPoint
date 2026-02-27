<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--
  SideMenu.jsp
  좌측 슬라이드 사이드 메뉴

  Request attributes:
    - isLoggedIn  (Boolean) : 로그인 여부
    - userName    (String)  : 로그인된 사용자 이름 (선택, 미설정 시 "회원님" 표시)

  JavaScript API (전역 함수):
    - window.openSideMenu()  : 사이드 메뉴 열기
    - window.closeSideMenu() : 사이드 메뉴 닫기
    → Header.jsp 의 햄버거 버튼에서 openSideMenu() 호출
--%>

<link rel="stylesheet" href="<c:url value='/css/SideMenu.css'/>" />
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>

<%-- ── 사이드 메뉴 오버레이 (기본 숨김) ── --%>
<div class="sidemenu-overlay" id="sideMenuOverlay"
     style="display:none;"
     onclick="window.closeSideMenu()">

    <div class="sidemenu-content" onclick="event.stopPropagation()">

        <%-- 헤더: 사용자 상태 --%>
        <div class="sidemenu-header">
            <div class="user-status-section">

                <c:choose>
                    <c:when test="${isLoggedIn}">
                        <div class="user-logged-in">
                            <div class="user-avatar-small">
                                <i data-lucide="user" style="width:20px;height:20px;"></i>
                            </div>
                            <div class="user-info-text">
                                <span class="user-name">반가워요,
                                    <c:choose>
                                        <c:when test="${not empty userName}">${userName}님!</c:when>
                                        <c:otherwise>회원님!</c:otherwise>
                                    </c:choose>
                                </span>
                                <button class="logout-btn"
                                        onclick="window.location.href='${pageContext.request.contextPath}/logout'">
                                    로그아웃
                                </button>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="user-logged-out" onclick="window.openLoginModal()">
                            <div class="user-avatar-small gray">
                                <i data-lucide="user" style="width:20px;height:20px;"></i>
                            </div>
                            <div class="user-info-text">
                                <span class="user-name">로그인이 필요합니다</span>
                                <span class="login-hint">클릭하여 로그인하기</span>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>

            <button class="close-btn" onclick="window.closeSideMenu()" aria-label="메뉴 닫기">
                <i data-lucide="x" style="width:24px;height:24px;color:#333;"></i>
            </button>
        </div>

        <%-- 메뉴 목록 --%>
        <div class="sidemenu-list">

            <%-- HOME --%>
            <div class="menu-item section-home"
                 onclick="window.location.href='${pageContext.request.contextPath}/'; window.closeSideMenu();">
                <i data-lucide="home" class="menu-icon" style="width:20px;height:20px;margin-right:1.2rem;color:#333;"></i>
                <div class="menu-text">
                    <span class="menu-title">HOME</span>
                </div>
            </div>

            <div class="menu-divider"></div>

            <%-- ON! 교통 정보 --%>
            <div class="menu-item"
                 onclick="window.location.href='${pageContext.request.contextPath}/board'; window.closeSideMenu();">
                <i data-lucide="clipboard-list" class="menu-icon" style="width:20px;height:20px;margin-right:1.2rem;color:#333;"></i>
                <div class="menu-text">
                    <span class="menu-title">ON! 교통 정보</span>
                    <span class="menu-subtext">게시판</span>
                </div>
            </div>

            <%-- 이벤트 --%>
            <div class="menu-item"
                 onclick="window.location.href='${pageContext.request.contextPath}/events'; window.closeSideMenu();">
                <i data-lucide="gift" class="menu-icon" style="width:20px;height:20px;margin-right:1.2rem;color:#333;"></i>
                <div class="menu-text">
                    <span class="menu-title">이벤트</span>
                    <span class="menu-subtext">광주 축제, 이벤트</span>
                </div>
            </div>

            <%-- 서비스 소개 --%>
            <div class="menu-item"
                 onclick="window.location.href='${pageContext.request.contextPath}/about'; window.closeSideMenu();">
                <i data-lucide="info" class="menu-icon" style="width:20px;height:20px;margin-right:1.2rem;color:#333;"></i>
                <div class="menu-text">
                    <span class="menu-title">TRAFFIC:ON</span>
                    <span class="menu-subtext">우리 서비스는 · · ·</span>
                </div>
            </div>

            <%-- 마이페이지 (로그인 시만 표시) --%>
            <c:if test="${isLoggedIn}">
                <div class="menu-item"
                     onclick="window.location.href='${pageContext.request.contextPath}/mypage'; window.closeSideMenu();">
                    <i data-lucide="user" class="menu-icon" style="width:20px;height:20px;margin-right:1.2rem;color:#333;"></i>
                    <div class="menu-text">
                        <span class="menu-title">마이페이지</span>
                        <span class="menu-subtext">회원 정보</span>
                    </div>
                </div>
            </c:if>

        </div>

        <%-- 푸터 --%>
        <div class="sidemenu-footer">
            <p>© 2026 TRAFFIC:ON. All rights reserved.</p>
        </div>

    </div>
</div>

<script>
    lucide.createIcons();

    /* 전역 함수 등록 */
    window.openSideMenu = function () {
        document.getElementById('sideMenuOverlay').style.display = 'flex';
        document.body.style.overflow = 'hidden';
    };

    window.closeSideMenu = function () {
        document.getElementById('sideMenuOverlay').style.display = 'none';
        document.body.style.overflow = '';
    };

    /* 전역 로그인 모달 열기 함수 (실제 구현은 각 페이지에서 정의) */
    if (typeof window.openLoginModal === 'undefined') {
        window.openLoginModal = function () {
            window.location.href = '${pageContext.request.contextPath}/login';
        };
    }
</script>
