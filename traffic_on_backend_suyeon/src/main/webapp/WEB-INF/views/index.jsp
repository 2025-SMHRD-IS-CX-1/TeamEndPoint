<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>TRAFFIC:ON - 메인</title>

  <jsp:include page="/WEB-INF/views/common/head.jsp"/>

  <link rel="stylesheet" href="/css/Banner.css" />
  <link rel="stylesheet" href="/css/ChatbotSection.css" />
  <link rel="stylesheet" href="/css/QuickButton.css" />
</head>

<body>

  <!-- ✅ mobile-wrap와 같은 폭으로 가운데 고정되는 레이어 -->
  <div class="quick-btn-layer">
    <button class="v3-quick-btn-icon-only" onclick="location.href='/chat'">
      <div class="v3-quick-icon-inner">
        <img
          src="/images/Pengrimi.png"
          alt="펭리미"
          class="v3-quick-char-img-large"
        />
        <span class="v3-quick-badge-ai">AI</span>
      </div>
    </button>
  </div>

  <div class="mobile-wrap">

    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="main-layout">

      <section class="chatbot-section">
        <div class="chatbot-intro-wrapper" onclick="location.href='/chat'" style="cursor: pointer;">
          <div class="chatbot-intro">
            <div class="chatbot-avatar">
              <img src="/images/Pengrimi.png" alt="펭리미" class="v3-quick-char-img-large" />
            </div>
            <div class="chatbot-bubble">
              <p>안녕하세요~!</p>
              <p><strong>교통 길잡이 펭리미입니다 🐧</strong></p>
            </div>
          </div>
        </div>

        <div class="board-preview-container not-logged-in">
          <div class="board-preview-header">
            <h3>ON! 교통 정보</h3>
            <span class="more-text">전체보기 &gt;</span>
          </div>

          <div class="board-content-wrapper">
            <ul class="board-preview-list ${isLoggedIn ? '' : 'is-blurred'}">
              <li class="board-preview-empty">등록된 게시물이 없습니다.</li>
            </ul>

            <c:if test="${!isLoggedIn}">
              <div class="board-login-overlay">
                <button class="login-prompt-btn-v2"
                        onclick="location.href='${pageContext.request.contextPath}/login'">
                  로그인하러 가기
                </button>
              </div>
            </c:if>
          </div>
        </div>
      </section>

      <section class="banner-section">
        <div class="banner-scroll-container">
          <div
            class="banner-slide"
            onclick="location.href='${pageContext.request.contextPath}/events'"
            style="cursor: pointer;"
          >
            <div class="banner-image-wrapper">
              <img src="/images/1.jpg" alt="충장축제" class="banner-img" />
              <div class="banner-top-tag">축제</div>
            </div>
          </div>
        </div>

        <div class="banner-indicator">
          <span>1 / 3</span>
        </div>
      </section>

    </div>

    <jsp:include page="/WEB-INF/views/common/bottomNav.jsp"/>
    <%@ include file="/WEB-INF/views/common/sideMenu.jsp" %>

  </div>

  <script>
    lucide.createIcons();
  </script>
</body>
</html>