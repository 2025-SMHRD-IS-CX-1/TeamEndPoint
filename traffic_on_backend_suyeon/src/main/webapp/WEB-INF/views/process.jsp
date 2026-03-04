<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>TRAFFIC:ON - 신청절차 안내</title>

<link rel="stylesheet" href="/css/common.css">
<link rel="stylesheet" href="/css/ApplicationProcessPage.css">

<!-- 메인과 동일 -->
<link rel="stylesheet" href="/css/QuickButton.css">

<script src="https://unpkg.com/lucide@latest"></script>
</head>

<body>

<div class="mobile-wrap">

  <!-- 퀵버튼 (메인과 동일) -->
  <button class="v3-quick-btn-icon-only" onclick="location.href='/chat'">
    <div class="v3-quick-icon-inner">
      <img src="/images/Pengrimi.png"
           alt="펭리미"
           class="v3-quick-char-img-large"
           style="width:100%;">
      <span class="v3-quick-badge-ai">AI</span>
    </div>
  </button>


  <!-- ✅ 상단 헤더 -->
  <header class="top-header">

    <div class="left">
      <button class="icon-btn" aria-label="menu">☰</button>
    </div>

    <div class="center">
      <img src="/images/Pengrimi.png" alt="logo" class="header-logo">
      <span class="logo-text">TRAFFIC:ON</span>
    </div>

    <div class="right">
      <button class="user-btn"
              onclick="location.href='${pageContext.request.contextPath}/login'"
              aria-label="사용자">
        <i data-lucide="user"></i>
      </button>
    </div>

  </header>


  <div class="v3-process-container <c:if test='${!isLoggedIn}'>not-logged-in</c:if>">

    <!-- ✅ 탭바 -->
    <div class="v3-tab-bar">
      <div class="v3-tab-item">
        <div class="v3-tab-icon-circle">
          <img src="/images/icon1.png" class="v3-tab-logo-img" alt="">
        </div>
        <div class="v3-tab-text">교통민원24</div>
      </div>

      <div class="v3-tab-item">
        <div class="v3-tab-icon-circle">
          <img src="/images/icon2.png" class="v3-tab-logo-img" alt="">
        </div>
        <div class="v3-tab-text">국민신문고</div>
      </div>

      <div class="v3-tab-item">
        <div class="v3-tab-icon-circle">
          <img src="/images/icon3.png" class="v3-tab-logo-img" alt="">
        </div>
        <div class="v3-tab-text">안전신문고</div>
      </div>

      <div class="v3-tab-item">
        <div class="v3-tab-icon-circle">
          <img src="/images/icon4.png" class="v3-tab-logo-img" alt="">
        </div>
        <div class="v3-tab-text">광주광역시</div>
      </div>
    </div>

    <div class="v3-page-body">

      <!-- 소개 문구 -->
      <div class="v3-intro-section">
        <p class="v3-intro-title">교통민원24 접수는 다음 절차에 따라 진행됩니다.</p>
      </div>

	  <!-- Flow Map (원본 느낌: 가로 점선 + 세로 화살표 포함) -->
	  <div class="v3-flow-map">

	    <!-- 1행: 좌 -> 우 -->
	    <div class="v3-flow-row justify-start">
	      <div class="v3-step-unit"><div class="v3-step-box">교통민원24 접속</div></div>

	      <div class="v3-arrow-horizontal">
	        <span class="v3-h-dot"></span><span class="v3-h-dot"></span><span class="v3-h-dot"></span>
	        <span class="v3-h-triangle"></span>
	      </div>

	      <div class="v3-step-unit"><div class="v3-step-box">로그인(본인인증)</div></div>
	    </div>

	    <!-- 세로 화살표(오른쪽) -->
	    <div class="v3-arrow-vertical-row align-right">
	      <div class="v3-v-arrow-unit">
	        <div class="v3-v-lines"></div>
	        <div class="v3-v-triangle"></div>
	      </div>
	    </div>

	    <!-- 2행: 우 -> 좌 (reverse 느낌) -->
	    <div class="v3-flow-row flow-reverse justify-end">
	      <div class="v3-step-unit"><div class="v3-step-box">신고할 민원 선택</div></div>

	      <div class="v3-arrow-horizontal reverse">
	        <span class="v3-h-triangle"></span>
	        <span class="v3-h-dot"></span><span class="v3-h-dot"></span><span class="v3-h-dot"></span>
	      </div>

	      <div class="v3-step-unit"><div class="v3-step-box">상황 정보 입력</div></div>
	    </div>

	    <!-- 세로 화살표(왼쪽) -->
	    <div class="v3-arrow-vertical-row align-left">
	      <div class="v3-v-arrow-unit">
	        <div class="v3-v-lines"></div>
	        <div class="v3-v-triangle"></div>
	      </div>
	    </div>

	    <!-- 3행: 좌 -> 우 -->
	    <div class="v3-flow-row justify-start">
	      <div class="v3-step-unit"><div class="v3-step-box">증빙 자료 업로드</div></div>

	      <div class="v3-arrow-horizontal">
	        <span class="v3-h-dot"></span><span class="v3-h-dot"></span><span class="v3-h-dot"></span>
	        <span class="v3-h-triangle"></span>
	      </div>

	      <div class="v3-step-unit"><div class="v3-step-box">접수 번호 확인</div></div>
	    </div>

	    <!-- 세로 화살표(오른쪽) -->
	    <div class="v3-arrow-vertical-row align-right">
	      <div class="v3-v-arrow-unit">
	        <div class="v3-v-lines"></div>
	        <div class="v3-v-triangle"></div>
	      </div>
	    </div>

	    <!-- 4행: 마지막 -->
		<div class="v3-flow-row justify-end">
		  <div class="v3-step-unit">
		    <div class="v3-step-box">신청 완료</div>
		  </div>
		</div>
	  

      <!-- ✅ 로그인 유도 카드 -->
      <div class="v3-login-invitation">
        <div class="invitation-box">
          <p>상세 가이드 정보 확인은</p>
          <h3>로그인 후</h3>
          <p>이용 가능한 서비스 입니다 !</p>
          <button class="invitation-login-btn"
                  onclick="location.href='${pageContext.request.contextPath}/login'">
            로그인하러 가기
          </button>
        </div>
      </div>

    </div>
  </div>


        <!-- 로그인 시 표시 -->
        <div class="process-action-footer">

        <% if(request.getAttribute("isLoggedIn") != null 
           && (Boolean)request.getAttribute("isLoggedIn")) { %>

          <a href="https://safe.gwangju.go.kr"
             class="official-site-link">
             공식 사이트 바로가기
          </a>

        <% } %>

        </div>

      </div>

    </div>

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

    <a class="nav-item" href="${pageContext.request.contextPath}/complaint-type">
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

</div>


<script>
lucide.createIcons();

/* 로그인 블러 */
let isLoggedIn = false;

if (!isLoggedIn) {
  const bubble = document.getElementById('bubble1');
  if (bubble) bubble.classList.add('is-blurred');
}
</script>

</body>
</html>