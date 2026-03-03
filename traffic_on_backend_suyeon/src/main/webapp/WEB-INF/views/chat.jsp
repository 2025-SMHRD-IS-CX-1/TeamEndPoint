<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<!--수정중-->
<head>
    <meta charset="UTF-8">
    <title>TRAFFIC:ON - 챗봇가이드</title>
    <!-- CSS 불러오기 (경로는 프로젝트 설정에 맞춰 조정 가능) -->
    <link rel="stylesheet" href="/css/ChatPage.css">
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
    <div class="chat-page-container">
        <!-- Header -->
        <header class="chat-header">
            <button class="back-btn" onclick="history.back()">
                <i data-lucide="chevron-left"></i>
            </button>
            <div class="chat-logo">
                <span class="logo-text">TRAFFIC:ON</span>
            </div>
            <div class="header-spacer"></div>
        </header>

        <!-- Content Area -->
        <div class="chat-content" id="chatContent">
            <div class="chat-intro">
                <div class="pengrimi-avatar">
                    <img src="/images/Pengrimi.png" alt="펭리미" style="width: 100%; height: 100%; object-fit: contain;">
                </div>
                <div class="pengrimi-message">
                    <p>안녕하세요~!</p>
                    <p><strong>교통 길잡이 펭리미입니다 🐧</strong></p>
                    <p>어떤 교통 불편 때문에 불편하셨나요?</p>
                </div>
            </div>

            <!-- 메시지가 추가될 영역 -->
            <div class="chat-messages-area" id="messagesArea">
                <!-- 비회원 메시지가 없을 때 키워드 표시 -->
                <div id="keywordSection" class="non-member-chat-keywords">
                    <button class="chat-keyword-btn" onclick="handleKeywordClick('지하철 공사')">지하철 공사</button>
                    <button class="chat-keyword-btn" onclick="handleKeywordClick('불법주정차')">불법주정차</button>
                    <button class="chat-keyword-btn" onclick="handleKeywordClick('장애인주차')">장애인주차</button>
                </div>
            </div>
        </div>

        <!-- Bottom Input Area -->
        <div class="chat-input-wrapper">
            <div class="chat-input-bar">
                <button class="chat-plus-btn">
                    <i data-lucide="plus" size="24"></i>
                </button>
                <input type="text" id="chatInput" placeholder="로그인 후 이용 가능합니다." disabled class="chat-main-input">
                <button class="chat-send-btn" disabled id="sendBtn">
                    <i data-lucide="arrow-up" size="24" color="#ccc"></i>
                </button>
            </div>
        </div>
    </div>

    <script>
        // 초기 아이콘 렌더링
        lucide.createIcons();

        // 현재 로그인 상태 (서버에서 전달받은 값으로 제어 가능 - 여기선 임시 false)
        let isLoggedIn = false;

        function handleKeywordClick(keyword) {
            if (isLoggedIn) return;

            const messagesArea = document.getElementById('messagesArea');
            const keywordSection = document.getElementById('keywordSection');

            // 1. 키워드 섹션 숨기기
            if (keywordSection) keywordSection.style.display = 'none';

            // 2. 유저 메시지 추가
            addMessage(keyword, 'user');

            // 3. 1초 뒤 펭리미 답변 메시지 추가
            setTimeout(() => {
                const response = `'${keyword}'에 대해 궁금하시군요! 해당 민원 유형은 [민원유형] 탭에서 더 자세히 안내해 드리고 있어요.`;
                addMessage(response, 'bot');

                // 4. 로그인 유도 버튼 추가
                showLoginNudge();
                
                // 스크롤 하단 이동
                const chatContent = document.getElementById('chatContent');
                chatContent.scrollTop = chatContent.scrollHeight;
            }, 800);
        }

        function addMessage(text, sender) {
            const messagesArea = document.getElementById('messagesArea');
            const bubble = document.createElement('div');
            bubble.className = `message-bubble ${sender}`;
            bubble.innerText = text;
            messagesArea.appendChild(bubble);
        }

        function showLoginNudge() {
            const messagesArea = document.getElementById('messagesArea');
            const nudgeDiv = document.createElement('div');
            nudgeDiv.className = 'login-nudge-msg';
            nudgeDiv.innerHTML = `
                <button class="chat-login-nudge-btn" onclick="location.href='/login'">
                    로그인하고 서비스 이용하기
                </button>
            `;
            messagesArea.appendChild(nudgeDiv);
        }
    </script>
</body>
</html>
