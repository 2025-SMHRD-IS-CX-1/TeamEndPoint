<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TRAFFIC:ON - 메인</title>

    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/Banner.css">
    <link rel="stylesheet" href="/css/ChatbotSection.css">
    <link rel="stylesheet" href="/css/QuickButton.css">

    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
</head>

<body>
    <!-- ✅ 모바일 화면 래퍼 추가 -->
    <div class="mobile-wrap">
		<!-- 퀵버튼-->
		<button class="v3-quick-btn-icon-only" onclick="location.href='/chat'">
		    <div class="v3-quick-icon-inner">
		        <img src="/images/Pengrimi.png" alt="펭리미" class="v3-quick-char-img-large"
		             style="width: 100%;">
		        <span class="v3-quick-badge-ai">AI</span>
		    </div>
		</button>

		<header class="top-header">
		  <div class="left">
		    <button class="icon-btn" aria-label="menu">☰</button>
		  </div>

		  <div class="center">
		    <img src="/images/Pengrimi.jpg" alt="logo">
		    <span class="logo-text">TRAFFIC:ON</span>
		  </div>

		  <div class="right">
			<button class="user-btn" onclick="location.href='/login'">
			    <img src="/images/user.jpg" alt="사용자">
			</button>
		  </div>
		</header>
        <div class="main-layout">
            <!-- 1. Banner Section -->

            <!-- 2. Chatbot Section -->
            <section class="chatbot-section">
                <div class="chatbot-intro-wrapper" onclick="location.href='/chat'" style="cursor: pointer;">
                    <div class="chatbot-intro">
                        <div class="chatbot-avatar">
                            <img src="/images/Pengrimi.png" alt="펭리미" style="width: 100%">
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
                        <span class="more-text">전체보기 ></span>
                    </div>
                    <div class="board-content-wrapper">
                        <ul class="board-preview-list is-blurred">
                            <li class="board-preview-empty">등록된 게시물이 없습니다.</li>
                        </ul>
                        <div class="board-login-overlay">
                            <button class="login-prompt-btn-v2" onclick="location.href='/login'">로그인하러 가기</button>
                        </div>
                    </div>
                </div>
            </section>
            <section class="banner-section">
                <div class="banner-scroll-container">
                    <!-- 0번 슬라이드: 충장축제 -->
                    <div class="banner-slide">
                        <div class="banner-image-wrapper">
                            <img src="/images/1.jpg" alt="충장축제" class="banner-img">
                            <div class="banner-top-tag">축제</div>
                        </div>
                    </div>
                </div>
                <div class="banner-indicator">
                    <span>1 / 3</span>
                </div>
            </section>
        </div>
    </div>
    <!-- ✅ 모바일 화면 래퍼 닫기 -->

    <script>
        lucide.createIcons();
    </script>
</body>

</html>