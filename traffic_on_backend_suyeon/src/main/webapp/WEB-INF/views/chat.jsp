<!--하라 수정중-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
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
				<c:if test="${!isLoggedIn}">
				    <div id="keywordSection" class="non-member-chat-keywords">
				        <button class="chat-keyword-btn" onclick="handleKeywordClick('지하철 공사')">지하철 공사</button>
				        <button class="chat-keyword-btn" onclick="handleKeywordClick('불법주정차')">불법주정차</button>
				        <button class="chat-keyword-btn" onclick="handleKeywordClick('장애인주차')">장애인주차</button>
				    </div>
				</c:if>
            </div>
        </div>

        <!-- Bottom Input Area -->
        <div class="chat-input-wrapper">
			  <div class="chat-input-bar">
			    <button class="chat-plus-btn" type="button">
			      <i data-lucide="plus" size="24"></i>
			    </button>

			    <input
			      type="text"
			      id="chatInput"
			      class="chat-main-input"
			      placeholder="<c:choose><c:when test='${isLoggedIn}'>무엇이든 물어보세요.</c:when><c:otherwise>로그인 후 이용 가능합니다.</c:otherwise></c:choose>"
			      <c:if test="${!isLoggedIn}">disabled="disabled"</c:if>
			    />

			    <button
			      class="chat-send-btn"
			      id="sendBtn"
			      type="button"
			      <c:if test="${!isLoggedIn}">disabled="disabled"</c:if>
			    >
			      <i data-lucide="arrow-up" size="24"></i>
			    </button>
			  </div>
			</div>
			
        </div>
    </div>

    <script>
        // 초기 아이콘 렌더링
        lucide.createIcons();

        // ✅ FastAPI 챗봇 API (JSON 응답: {answer: "..."} )
        const API_URL = "http://localhost:8000/api/chat";
        const ROOM_IDX = 2;

		// ✅ 서버에서 내려준 로그인 상태 (HomeController에서 model.addAttribute("isLoggedIn", ...))
		const isLoggedIn = ${isLoggedIn ? "true" : "false"};

        // ✅ 로그인 상태에 따라 입력/전송 활성화
		const isLoggedIn = <c:out value="${isLoggedIn}" default="false" />;
		
        function applyLoginUI() {
            const input = document.getElementById("chatInput");
            const btn = document.getElementById("sendBtn");

            if (isLoggedIn) {
                input.disabled = false;
                input.placeholder = "메시지를 입력하세요...";
                btn.disabled = false;
            } else {
                input.disabled = true;
                input.placeholder = "로그인 후 이용 가능합니다.";
                btn.disabled = true;
            }
        }
        applyLoginUI();

        function scrollToBottom() {
            const chatContent = document.getElementById("chatContent");
            chatContent.scrollTop = chatContent.scrollHeight;
        }

        function addMessage(text, sender) {
            const messagesArea = document.getElementById('messagesArea');
            const bubble = document.createElement('div');
            bubble.className = `message-bubble ${sender}`;
            bubble.innerText = text;
            messagesArea.appendChild(bubble);
            scrollToBottom();
        }

        function showLoginNudge() {
            const messagesArea = document.getElementById('messagesArea');
            const nudgeDiv = document.createElement('div');
            nudgeDiv.className = 'login-nudge-msg';
            nudgeDiv.innerHTML = `
                <button class="chat-login-nudge-btn" onclick="location.href='${pageContext.request.contextPath}/login'">
                    로그인하고 서비스 이용하기
                </button>
            `;
            messagesArea.appendChild(nudgeDiv);
            scrollToBottom();
        }

        // ✅ FastAPI 호출
        async function sendToFastAPI(message) {
            const res = await fetch(API_URL, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                    text: message,
                    room_idx: ROOM_IDX
                })
            });

            if (!res.ok) {
                const err = await res.text();
                throw new Error(`API ${res.status}: ${err}`);
            }

            const data = await res.json(); // {answer: "..."}
            return data.answer ?? "⚠️ 응답이 비어있어.";
        }

        // ✅ 입력창 전송(로그인 상태에서만)
        async function sendChat() {
            if (!isLoggedIn) {
                // 로그인 안 했으면 안내만
                showLoginNudge();
                return;
            }

            const input = document.getElementById("chatInput");
            const text = (input.value || "").trim();
            if (!text) return;

            // 키워드 영역 숨김(필요 시)
            const keywordSection = document.getElementById("keywordSection");
            if (keywordSection) keywordSection.style.display = "none";

            addMessage(text, "user");
            input.value = "";

            try {
                const answer = await sendToFastAPI(text);
                addMessage(answer, "bot");
            } catch (e) {
                console.error(e);
                addMessage("⚠️ 챗봇 서버 호출 실패: " + e.message, "bot");
            }
        }

        // ✅ 키워드 클릭: 비로그인이어도 FastAPI로 테스트 가능하게 해둠
        // (원래 기획대로 "비회원은 로그인 유도만"으로 하고 싶으면, 아래 if 블록을 바꾸면 됨)
        async function handleKeywordClick(keyword) {
            const keywordSection = document.getElementById('keywordSection');
            if (keywordSection) keywordSection.style.display = 'none';

            addMessage(keyword, 'user');

            try {
                const answer = await sendToFastAPI(keyword);
                addMessage(answer, 'bot');

                if (!isLoggedIn) {
                    // 비로그인이면 아래 버튼도 같이 띄움(기획 유지)
                    showLoginNudge();
                }
            } catch (e) {
                console.error(e);
                addMessage("⚠️ 챗봇 서버 호출 실패: " + e.message, "bot");
                if (!isLoggedIn) showLoginNudge();
            }
        }
//주석
        // ✅ 전송 버튼 클릭
        document.getElementById("sendBtn").addEventListener("click", sendChat);

        // ✅ 엔터 전송
        document.getElementById("chatInput").addEventListener("keydown", (e) => {
            if (e.key === "Enter") sendChat();
        });

        // onclick에서 쓰는 함수 전역 노출
        window.handleKeywordClick = handleKeywordClick;
    </script>
	<script>
	  lucide.createIcons();
	</script>
</body>
</html>