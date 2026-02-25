<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>TRAFFIC:ON - 서비스 소개</title>
        <link rel="stylesheet" href="/css/AboutPage.css">
        <script src="https://unpkg.com/lucide@latest"></script>
    </head>

    <body>
        <div class="about-container">
            <!-- 상단 헤더 (나중에 include로 분리 가능) -->
            <header class="about-header">
                <button class="back-btn" onclick="history.back()">
                    <i data-lucide="chevron-left"></i>
                </button>
                <h2>서비스 소개</h2>
                <div class="header-spacer"></div>
            </header>

            <div class="about-body">
                <div class="about-title-section">
                    <h2>TRAFFIC:ON은 어떤 곳인가요?</h2>
                    <p>교통 불편, 어디에 말해야 할지 헷갈릴 때 <strong>TRAFFIC:ON</strong>을 찾아주세요!</p>
                </div>

                <!-- 펭리미 소개 섹션 -->
                <div class="about-bubble-section">
                    <div class="character-img-area">
                        <img src="/images/character.png" alt="펭리미" style="transform: scaleX(-1);">
                    </div>
                    <div class="speech-bubble">
                        <h3><span class="icon">➡️</span> 안녕하세요!</h3>
                        <p>저는 TRAFFIC:ON에서 교통 길을 안내해주는 <strong>펭리미</strong>에요! 🚦</p>
                        <p class="sub">교통 불편을 겪었을 때, 어디에 말해야 할지 고민되신 적 있나요?</p>
                    </div>
                </div>

                <div class="about-help-card">
                    <h3>이런 상황에서 TRAFFIC:ON이 도와드려요!</h3>
                    <ul class="help-list">
                        <li>✔️ 지하철 자전거 반입 기준이 궁금할 때</li>
                        <li>✔️ 불법 주정차 신고 방법을 알고 싶을 때</li>
                        <li>✔️ 교통 관련 축제 정보를 찾고 싶을 때</li>
                    </ul>
                </div>

                <div class="about-bubble-section reverse">
                    <div class="speech-bubble warning-bubble">
                        <h3><span class="icon">❌</span> TRAFFIC:ON은 민원을 대신 접수해주지는 않아요.</h3>
                        <p>대신, 시민이 혼란 없이 <strong>올바른 선택</strong>을 할 수 있도록 정확한 정보와 방향을 안내해요.</p>
                    </div>
                </div>
            </div>
        </div>
        <script>lucide.createIcons();</script>
    </body>

    </html>