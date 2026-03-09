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
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/MainEventSection.css">

  <style>
    .board-preview-item {
        display: flex;
        flex-direction: column;
        gap: 4px;
        padding: 10px 12px;
        border-bottom: 1px solid #f0f0f0;
        cursor: pointer;
    }
    .board-preview-item:last-child {
        border-bottom: none;
    }
    .board-preview-item:hover {
        background: #f7f9fc;
    }
    .board-preview-top {
        display: flex;
        align-items: center;
        gap: 8px;
    }
    .preview-category {
        background: #fff3ee;
        color: #FF5722;
        font-size: 11px;
        font-weight: 700;
        border-radius: 20px;
        padding: 2px 8px;
        white-space: nowrap;
    }
    .preview-title {
        flex: 1;
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
        color: #222;
        font-size: 13px;
        font-weight: 600;
    }
    .preview-date {
        font-size: 11px;
        color: #aaa;
        white-space: nowrap;
        padding-left: 4px;
    }
  </style>
</head>

<body>

  <div class="quick-btn-layer">
    <button class="v3-quick-btn-icon-only" onclick="location.href='${pageContext.request.contextPath}/chat'">
      <div class="v3-quick-icon-inner">
        <img
          src="${pageContext.request.contextPath}/images/Pengrimi.png"
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
        <div class="chatbot-intro-wrapper" onclick="location.href='${pageContext.request.contextPath}/chat'" style="cursor: pointer;">
          <div class="chatbot-intro">
            <div class="chatbot-avatar">
              <img src="${pageContext.request.contextPath}/images/pon.png" alt="펭리미" class="chatbot-img" />
            </div>
            <div class="chatbot-bubble">
              <p>안녕하세요~!</p>
              <p><strong>교통 길잡이 펭리미입니다 🐧</strong></p>
            </div>
          </div>
        </div>

        <div class="board-preview-container">
          <div class="board-preview-header">
            <h3>ON! 교통 정보</h3>
            <span class="more-text"
                  onclick="location.href='${pageContext.request.contextPath}/board'"
                  style="cursor:pointer;">전체보기 &gt;</span>
          </div>

          <div class="board-content-wrapper">
            <ul class="board-preview-list ${isLoggedIn ? '' : 'is-blurred'}">
              <c:choose>
                <c:when test="${empty recentBoards}">
                  <li class="board-preview-empty">등록된 게시물이 없습니다.</li>
                </c:when>
                <c:otherwise>
                  <c:forEach var="b" items="${recentBoards}">
                    <li class="board-preview-item"
                        onclick="location.href='${pageContext.request.contextPath}/board/${b.boardId}'"
                        style="cursor:pointer;">
                      <div class="board-preview-top">
                        <span class="preview-category">${b.category}</span>
                        <span class="preview-title">${b.title}</span>
                      </div>
                      <span class="preview-date">${b.createdAt.toString().substring(0, 10)}</span>
                    </li>
                  </c:forEach>
                </c:otherwise>
              </c:choose>
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

      <!-- 이벤트 슬라이드 섹션 -->
      <section class="main-event-section">
        <div class="main-event-header">
          <h2 class="main-event-title">진행 중인 이벤트</h2>
          <a class="main-event-more" href="${pageContext.request.contextPath}/events">전체보기 &gt;</a>
        </div>

        <div class="main-event-slider-wrap">
          <div class="main-event-count" id="eventCountBadge">1 / 3</div>

          <button type="button" class="main-event-arrow left" onclick="moveEventSlide(-1)">
            <i data-lucide="chevron-left"></i>
          </button>

          <div class="main-event-slider" id="mainEventSlider">

            <a class="main-event-card" href="${pageContext.request.contextPath}/events/1">
              <div class="main-event-image-wrap">
                <img src="${pageContext.request.contextPath}/images/1.jpg" alt="광주 추억의 충장축제">
                <span class="main-event-badge">축제</span>
              </div>
              <div class="main-event-info">
                <span class="main-event-category">지역 축제</span>
                <h3>광주 추억의 충장축제</h3>
                <p class="main-event-date">2025.10.15 ~ 10.19</p>
              </div>
            </a>

            <a class="main-event-card" href="${pageContext.request.contextPath}/events/2">
              <div class="main-event-image-wrap">
                <img src="${pageContext.request.contextPath}/images/2.jpg" alt="광주 비엔날레">
                <span class="main-event-badge">전시</span>
              </div>
              <div class="main-event-info">
                <span class="main-event-category">예술 전시</span>
                <h3>광주 비엔날레</h3>
                <p class="main-event-date">2025.08.30 ~ 11.02</p>
              </div>
            </a>

            <a class="main-event-card" href="${pageContext.request.contextPath}/events/3">
              <div class="main-event-image-wrap">
                <img src="${pageContext.request.contextPath}/images/3.jpg" alt="광주 세계 김치 축제">
                <span class="main-event-badge">음식</span>
              </div>
              <div class="main-event-info">
                <span class="main-event-category">음식 축제</span>
                <h3>광주 세계 김치 축제</h3>
                <p class="main-event-date">2024.10.18 ~ 10.20</p>
              </div>
            </a>

          </div>

          <button type="button" class="main-event-arrow right" onclick="moveEventSlide(1)">
            <i data-lucide="chevron-right"></i>
          </button>
        </div>
      </section>

    </div>

    <jsp:include page="/WEB-INF/views/common/bottomNav.jsp"/>
    <%@ include file="/WEB-INF/views/common/sideMenu.jsp" %>

  </div>

  <script>
    lucide.createIcons();

    function moveEventSlide(direction) {
      const slider = document.getElementById("mainEventSlider");
      const card = slider.querySelector(".main-event-card");
      if (!card) return;

      const moveWidth = card.offsetWidth + 16;
      slider.scrollBy({
        left: moveWidth * direction,
        behavior: "smooth"
      });
    }

    const eventSlider = document.getElementById("mainEventSlider");
    const eventCountBadge = document.getElementById("eventCountBadge");

    if (eventSlider && eventCountBadge) {
      eventSlider.addEventListener("scroll", function () {
        const card = eventSlider.querySelector(".main-event-card");
        if (!card) return;

        const moveWidth = card.offsetWidth + 16;
        const currentIndex = Math.round(eventSlider.scrollLeft / moveWidth) + 1;
        const safeIndex = Math.max(1, Math.min(3, currentIndex));
        eventCountBadge.textContent = safeIndex + " / 3";
      });
    }
  </script>
</body>
</html>