<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>TRAFFIC:ON - 마이페이지</title>
        <%@ include file="head.jsp" %>
            <link rel="stylesheet" href="/css/MyPage.css">
    </head>

    <body>
        <div class="mypage-container">
            <!-- 상단 헤더 -->
            <div class="mypage-header">
                <button class="back-btn" onclick="history.back()">
                    <i data-lucide="chevron-left"></i>
                </button>
                <h1>마이페이지</h1>
                <button class="logout-top-btn" onclick="handleLogout()">로그아웃</button>
            </div>
            <p class="header-subtext">내 정보와 활동 내역을 확인할 수 있어요.</p>

            <!-- 프로필 섹션 -->
            <div class="profile-card">
                <div class="profile-image-container">
                    <div class="profile-avatar">
                        <img src="/images/character.png" alt="프로필" class="profile-character-img" />
                    </div>
                </div>
                <div class="profile-main-info">
                    <div class="profile-name-row">
                        <span class="profile-name">하라</span>
                        <span class="profile-id">@hara01</span>
                    </div>
                </div>
            </div>

            <!-- 기본 정보 -->
            <div class="settings-section">
                <div class="section-header">
                    <i data-lucide="user" class="section-icon"></i>
                    <h3>기본 정보</h3>
                </div>
                <div class="settings-card">
                    <div class="setting-item">
                        <label>이름</label>
                        <input type="text" value="하라 (hara01)" readonly />
                    </div>
                    <div class="setting-item no-border">
                        <label>전화번호</label>
                        <input type="text" value="010-1234-5678" readonly />
                    </div>
                </div>
            </div>

            <!-- 보안 설정 -->
            <div class="settings-section">
                <div class="section-header">
                    <i data-lucide="lock" class="section-icon"></i>
                    <h3>보안</h3>
                </div>
                <div class="settings-card password-card">
                    <button class="password-change-btn">
                        <span>비밀번호 변경하기</span>
                        <i data-lucide="chevron-right"></i>
                    </button>
                </div>
            </div>

            <!-- 하단 로그아웃 -->
            <div class="bottom-actions">
                <button class="logout-footer-btn" onclick="handleLogout()">
                    <i data-lucide="log-out"></i>
                    <span>로그아웃</span>
                </button>
            </div>
        </div>

        <!-- 하단 네비게이션 포함 -->
        <%@ include file="bottomNav.jsp" %>


            <script>
                lucide.createIcons();
                function handleLogout() {
                    if (confirm('로그아웃 하시겠습니까?')) {
                        location.href = '/logout';
                    }
                }
            </script>
    </body>

    </html>