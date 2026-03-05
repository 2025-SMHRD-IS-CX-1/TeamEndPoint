<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<!-- 수정중 -->
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>TRAFFIC:ON - 메인</title>

  <link rel="stylesheet" href="/css/common.css" />
  <link rel="stylesheet" href="/css/Banner.css" />
  <link rel="stylesheet" href="/css/ChatbotSection.css" />
  <link rel="stylesheet" href="/css/QuickButton.css" />

  <!-- Lucide Icons -->
  <script src="https://unpkg.com/lucide@latest"></script>
</head>

<body>
  <!-- ✅ 모바일 화면 래퍼 -->
  <div class="mobile-wrap">

    <!-- ✅ 퀵버튼 -->
    <button class="v3-quick-btn-icon-only" onclick="location.href='/chat'">
      <div class="v3-quick-icon-inner">
        <img
          src="/images/Pengrimi.png"
          alt="펭리미"
          class="v3-quick-char-img-large"
          style="width: 100%;"
        />
        <span class="v3-quick-badge-ai">AI</span>
      </div>
    </button>

    <!-- ✅ 상단 헤더 -->
    <header class="top-header">
      <div class="left">
		<button class="icon-btn" aria-label="menu" onclick="openSideMenu()">
		  <i data-lucide="menu"></i>
		</button>
      </div>

      <div class="center">
        <img src="/images/Pengrimi.png" alt="logo" class="header-logo">
        <span class="logo-text">TRAFFIC:ON</span>
      </div>

      <div class="right">
		<button class="user-btn" onclick="location.href='/login'" aria-label="사용자">
		  <i data-lucide="user"></i>
		</button>
      </div>
    </header>

    <!-- ✅ 메인 콘텐츠 -->
    <div class="main-layout">

      <!-- 2. Chatbot Section -->
      <section class="chatbot-section">
        <div class="chatbot-intro-wrapper" onclick="location.href='/chat'" style="cursor: pointer;">
          <div class="chatbot-intro">
            <div class="chatbot-avatar">
				<img
				  src="/images/Pengrimi.png"
				  alt="펭리미"
				  class="v3-quick-char-img-large"
				  style="width: 100%;"
				/>
            </div>
            <div class="chatbot-bubble">
              <p>안녕하세요~!</p>
              <p><strong>교통 길잡이 펭리미입니다 🐧</strong></p>
            </div>
          </div>
        </div>

        <!-- 게시판 미리보기 (모자이크 적용) -->
        <div class="board-preview-container not-logged-in">
          <div class="board-preview-header">
            <h3>ON! 교통 정보</h3>
            <span class="more-text">전체보기 &gt;</span>
          </div>

		  <div class="board-content-wrapper">

		      <!-- ✅ 로그인 상태면 is-blurred 제거 / 비로그인 상태면 is-blurred 적용 -->
		      <ul class="board-preview-list ${isLoggedIn ? '' : 'is-blurred'}">
		          <li class="board-preview-empty">등록된 게시물이 없습니다.</li>
		      </ul>

		      <!-- ✅ 비로그인일 때만 로그인 유도 오버레이 보이기 -->
		      <c:if test="${!isLoggedIn}">
		          <div class="board-login-overlay">
		              <button class="login-prompt-btn-v2" onclick="location.href='${pageContext.request.contextPath}/login'">
		                  로그인하러 가기
		              </button>
		          </div>
		      </c:if>
		  </div>
		  
        </div>
      </section>

      <!-- Banner Section -->
      <section class="banner-section">
        <div class="banner-scroll-container">
          <!-- 0번 슬라이드: 충장축제 -->
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

    <!-- ✅ 하단 네비게이션 -->
    <nav class="bottom-nav">
      <a class="nav-item active" href="${pageContext.request.contextPath}/">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
             viewBox="0 0 24 24" fill="none" stroke="#007bff" stroke-width="2"
             stroke-linecap="round" stroke-linejoin="round"
             class="lucide lucide-search" aria-hidden="true">
          <path d="m21 21-4.34-4.34"></path>
          <circle cx="11" cy="11" r="8"></circle>
        </svg>
        <span>사전해결 가이드</span>
      </a>

      <div class="nav-divider"></div>

      <a class="nav-item" href="${pageContext.request.contextPath}/guide">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
             viewBox="0 0 24 24" fill="none" stroke="#888" stroke-width="2"
             stroke-linecap="round" stroke-linejoin="round"
             class="lucide lucide-layout-grid" aria-hidden="true">
          <rect width="7" height="7" x="3" y="3" rx="1"></rect>
          <rect width="7" height="7" x="14" y="3" rx="1"></rect>
          <rect width="7" height="7" x="14" y="14" rx="1"></rect>
          <rect width="7" height="7" x="3" y="14" rx="1"></rect>
        </svg>
        <span>민원유형</span>
      </a>

      <div class="nav-divider"></div>

      <a class="nav-item" href="${pageContext.request.contextPath}/application-process">
        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
             viewBox="0 0 24 24" fill="none" stroke="#888" stroke-width="2"
             stroke-linecap="round" stroke-linejoin="round"
             class="lucide lucide-file-check" aria-hidden="true">
          <path d="M6 22a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h8a2.4 2.4 0 0 1 1.704.706l3.588 3.588A2.4 2.4 0 0 1 20 8v12a2 2 0 0 1-2 2z"></path>
          <path d="M14 2v5a1 1 0 0 0 1 1h5"></path>
          <path d="m9 15 2 2 4-4"></path>
        </svg>
        <span>신청절차 안내</span>
      </a>
    </nav>
	  <%@ include file="/WEB-INF/views/common/sideMenu.jsp" %>

  </div>
  <!-- ✅ 모바일 화면 래퍼 끝 -->

  <script>
    lucide.createIcons();
  </script>

</body>
</html>