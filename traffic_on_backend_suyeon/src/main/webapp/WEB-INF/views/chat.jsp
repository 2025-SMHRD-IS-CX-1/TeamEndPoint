<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TRAFFIC:ON - 챗봇가이드</title>
    <link rel="stylesheet" href="/css/ChatPage.css">
    <script src="https://unpkg.com/lucide@latest"></script>

    <!-- ✅ 마크다운(**, 리스트, 줄바꿈 등) 렌더링용 -->
    <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>
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

            <!-- ✅ 원래 화면 복구: display:none 제거 -->
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

            <div class="chat-messages-area" id="messagesArea">
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

                <!-- ✅ + 버튼 (이미지 업로드 트리거) -->
                <button class="chat-plus-btn" id="plusBtn" type="button">
                    <i data-lucide="plus" size="24"></i>
                </button>

                <!-- ✅ 숨김 파일 선택 input (이미지 업로드용) -->
                <input
                    type="file"
                    id="imageInput"
                    accept="image/jpeg,image/jpg,image/png"
                    style="display:none"
                />

                <input type="text" id="chatInput" placeholder="로그인 후 이용 가능합니다." disabled class="chat-main-input">

                <button class="chat-send-btn" disabled id="sendBtn" type="button">
                    <i data-lucide="arrow-up" size="24" color="#ccc"></i>
                </button>
            </div>
        </div>
    </div>

    <script>
        lucide.createIcons();

        // ✅ 세션 키는 loginMember
        const isLoggedIn = <%= (session.getAttribute("loginMember") != null) ? "true" : "false" %>;

        // ✅ marked 옵션(줄바꿈을 <br>로 반영)
        if (window.marked) {
            marked.setOptions({ breaks: true });
        }

        // ✅ 방(room) idx (텍스트와 이미지 둘 다 동일하게 보냄)
        const CROOM_IDX = 2;

        window.addEventListener('DOMContentLoaded', () => {
            const input = document.getElementById('chatInput');
            const sendBtn = document.getElementById('sendBtn');

            // ✅ 이미지 업로드 DOM
            const plusBtn = document.getElementById('plusBtn');
            const imageInput = document.getElementById('imageInput');

            // ✅ + 버튼 클릭 → 파일 선택창
            plusBtn.addEventListener('click', () => {
                if (!isLoggedIn) {
                    addMessage("이미지 분석 기능은 로그인 후 이용 가능합니다.", "bot");
                    showLoginNudge();
                    scrollToBottom();
                    return;
                }
                imageInput.value = ""; // 같은 파일 재선택 가능
                imageInput.click();
            });

            // ✅ 파일 선택 → 업로드/분석 요청
            imageInput.addEventListener('change', async (e) => {
                if (!isLoggedIn) return;

                const file = e.target.files && e.target.files[0];
                if (!file) return;

                // ✅ 타입 체크
                const okTypes = ["image/jpeg", "image/png"];
                if (!okTypes.includes(file.type)) {
                    addMessage("⚠️ JPG/PNG 이미지만 업로드할 수 있어요.", "bot");
                    scrollToBottom();
                    return;
                }

                // ✅ (선택) 너무 큰 파일 방지 (예: 10MB)
                const MAX_MB = 10;
                if (file.size > MAX_MB * 1024 * 1024) {
                    addMessage(`⚠️ 이미지 용량이 너무 커요. (${MAX_MB}MB 이하로 올려주세요)`, "bot");
                    scrollToBottom();
                    return;
                }

                await sendImage(file);
            });

            if (isLoggedIn) {
                input.disabled = false;
                input.placeholder = "교통 민원 내용을 입력해 주세요.";
                sendBtn.disabled = false;

                // 버튼 클릭 전송
                sendBtn.addEventListener('click', () => sendMessage());

                // Enter 전송 (한글 조합중이면 무시.)
                input.addEventListener('keydown', (e) => {
                    if (e.isComposing) return;
                    if (e.key === 'Enter') {
                        e.preventDefault();
                        sendMessage();
                    }
                });
            }
        });

        // ✅ 키워드 클릭
        function handleKeywordClick(keyword) {
            const keywordSection = document.getElementById('keywordSection');
            if (keywordSection) keywordSection.style.display = 'none';

            if (!isLoggedIn) {
                setTimeout(() => {
                    addMessage(`'${keyword}'에 대해 궁금하시군요! 로그인 후 더 자세히 안내해 드릴게요.`, 'bot');
                    showLoginNudge();
                    scrollToBottom();
                }, 200);
                return;
            }

            sendMessage(keyword);
        }

        // ✅ 실제 Spring API 호출 (텍스트)
        async function sendMessage(forcedText) {
            if (!isLoggedIn) return;

            const input = document.getElementById('chatInput');
            const text = (forcedText ?? input.value ?? "").trim();
            if (!text) return;

            const keywordSection = document.getElementById('keywordSection');
            if (keywordSection) keywordSection.style.display = 'none';

            // ✅ 유저 메시지는 여기서 "한 번만"
            addMessage(text, 'user');
            if (!forcedText) input.value = "";
            scrollToBottom();

            // ✅ 타이핑 표시
            const loadingEl = showTyping();
            scrollToBottom();

            try {
                const payload = { text, croom_idx: CROOM_IDX };

                const res = await fetch("/api/chat", {
                    method: "POST",
                    headers: { "Content-Type": "application/json" },
                    body: JSON.stringify(payload)
                });

                const raw = await res.text();

                if (!res.ok) {
                    replaceMessage(loadingEl, "❌ 서버 오류: " + raw, "bot");
                    scrollToBottom();
                    return;
                }

                let data;
                try { data = JSON.parse(raw); } catch { data = { answer: raw }; }

                const answer =
                    data.answer ??
                    data.response ??
                    data.message ??
                    data.result ??
                    data.analysis_result ??
                    (typeof data === "string" ? data : JSON.stringify(data));

                replaceMessage(loadingEl, answer, "bot");
                scrollToBottom();

            } catch (err) {
                console.error(err);
                replaceMessage(loadingEl, "❌ 챗봇 서버 연결 실패: " + err.message, "bot");
                scrollToBottom();
            }
        }

        // ✅ 이미지 업로드/분석 호출 (multipart/form-data)
        async function sendImage(file) {
            const keywordSection = document.getElementById('keywordSection');
            if (keywordSection) keywordSection.style.display = 'none';

            // ✅ 유저 이미지 버블(미리보기) 출력
            addImageMessage(file, 'user');
            scrollToBottom();

            // ✅ 타이핑 표시
            const loadingEl = showTyping();
            scrollToBottom();

            try {
                const formData = new FormData();

                // ✅ FastAPI docs 스펙: file(required), croom_idx(Integer), text(String)
                formData.append("file", file);
                formData.append("croom_idx", String(CROOM_IDX));

                // text는 선택값이지만 스펙에 있으니 같이 보냄 (원하면 빈값 유지)
                const input = document.getElementById('chatInput');
                formData.append("text", (input.value || "").trim()); // 또는 "" 로 고정해도 됨

                // ✅ Spring 이미지 업로드 API: POST /api/chat/image
                const res = await fetch("/api/chat/image", {
                    method: "POST",
                    body: formData
                });

                const raw = await res.text();

                if (!res.ok) {
                    replaceMessage(loadingEl, "❌ 이미지 분석 서버 오류: " + raw, "bot");
                    scrollToBottom();
                    return;
                }

                let data;
                try { data = JSON.parse(raw); } catch { data = { answer: raw }; }

                const answer =
                    data.analysis_result ??
                    data.answer ??
                    data.response ??
                    data.message ??
                    data.result ??
                    (typeof data === "string" ? data : JSON.stringify(data));

                replaceMessage(loadingEl, answer, "bot");
                scrollToBottom();

            } catch (err) {
                console.error(err);
                replaceMessage(loadingEl, "❌ 이미지 분석 요청 실패: " + err.message, "bot");
                scrollToBottom();
            }
        }

        function renderBotHtml(text) {
            if (!window.marked) return (text || "").replace(/\*\*/g, "");
            return marked.parse(text || "");
        }

        function addMessage(text, sender) {
            const messagesArea = document.getElementById('messagesArea');

            if (sender === "bot") {
                const wrapper = document.createElement('div');
                wrapper.className = "bot-wrapper";

                const content = document.createElement('div');
                content.className = "bot-content";

                const bubble = document.createElement('div');
                bubble.className = "message-bubble bot";
                bubble.innerHTML = renderBotHtml(text);

                content.appendChild(bubble);
                wrapper.appendChild(content);

                messagesArea.appendChild(wrapper);
                return bubble;
            }

            const bubble = document.createElement('div');
            bubble.className = "message-bubble user";
            bubble.innerText = text;
            messagesArea.appendChild(bubble);
            return bubble;
        }

        // ✅ 유저 이미지 메시지 추가
        function addImageMessage(file, sender) {
            const messagesArea = document.getElementById('messagesArea');
            const url = URL.createObjectURL(file);

            if (sender === "bot") {
                const wrapper = document.createElement('div');
                wrapper.className = "bot-wrapper";

                const content = document.createElement('div');
                content.className = "bot-content";

                const bubble = document.createElement('div');
                bubble.className = "message-bubble bot";
                bubble.innerHTML = `<img src="${url}" class="chat-image-preview" alt="uploaded image" />`;

                content.appendChild(bubble);
                wrapper.appendChild(content);

                messagesArea.appendChild(wrapper);
                return bubble;
            }

            const bubble = document.createElement('div');
            bubble.className = "message-bubble user";
            bubble.innerHTML = `<img src="${url}" class="chat-image-preview" alt="uploaded image" />`;
            messagesArea.appendChild(bubble);
            return bubble;
        }

        function showTyping() {
            const messagesArea = document.getElementById('messagesArea');

            const wrapper = document.createElement('div');
            wrapper.className = "bot-wrapper";

            const content = document.createElement('div');
            content.className = "bot-content";

            const bubble = document.createElement('div');
            bubble.className = "message-bubble bot";
            bubble.innerHTML = `
                <div class="typing-indicator">
                    <div class="typing-dot"></div>
                    <div class="typing-dot"></div>
                    <div class="typing-dot"></div>
                </div>
            `;

            content.appendChild(bubble);
            wrapper.appendChild(content);

            messagesArea.appendChild(wrapper);
            return bubble;
        }

        function replaceMessage(el, newText, sender) {
            if (!el) return;

            el.className = `message-bubble ${sender}`;

            if (sender === "bot") {
                el.innerHTML = renderBotHtml(newText);
            } else {
                el.innerText = newText;
            }
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

        function scrollToBottom() {
            const chatContent = document.getElementById('chatContent');
            chatContent.scrollTop = chatContent.scrollHeight;
        }
    </script>
</body>
</html>