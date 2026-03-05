<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TRAFFIC:ON - 챗봇가이드</title>
    <link rel="stylesheet" href="/css/ChatPage.css">
    <script src="https://unpkg.com/lucide@latest"></script>
    <!-- ✅ 마크다운 렌더링 -->
    <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>

    <!-- ✅ 사진.. 확대 모달용 최소 CSS (ChatPage.css로 옮겨도 됨) -->
    <style>
        .image-modal-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.65);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 100000;
            padding: 18px;
        }
        .image-modal-overlay.open { display: flex; }

        .image-modal {
            max-width: min(920px, 96vw);
            max-height: 92vh;
            position: relative;
        }
        .image-modal img {
            display: block;
            max-width: 100%;
            max-height: 92vh;
            border-radius: 14px;
            background: #fff;
        }
        .image-modal-close {
            position: absolute;
            top: -12px;
            right: -12px;
            width: 40px;
            height: 40px;
            border-radius: 999px;
            border: none;
            cursor: pointer;
            background: rgba(255,255,255,0.92);
            box-shadow: 0 10px 26px rgba(0,0,0,0.22);
            font-size: 20px;
            line-height: 40px;
        }
    </style>
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

        <div class="chat-messages-area" id="messagesArea">
            <%
                boolean isLoggedInServer = (session.getAttribute("loginMember") != null);
            %>

            <% if (!isLoggedInServer) { %>
            <div class="keyword-dock" style="width:100%; display:flex; justify-content:center;">
                <div id="keywordSection" class="non-member-chat-keywords" style="width: fit-content; margin: 0 auto;">
                    <button class="chat-keyword-btn" onclick="handleKeywordClick('지하철 공사')">지하철 공사</button>
                    <button class="chat-keyword-btn" onclick="handleKeywordClick('불법주정차')">불법주정차</button>
                    <button class="chat-keyword-btn" onclick="handleKeywordClick('장애인주차')">장애인주차</button>
                </div>
            </div>
            <% } %>
        </div>
    </div>

    <!-- Bottom Input Area -->
    <div class="chat-input-wrapper" id="chatInputWrapper">
        <div class="chat-input-bar">
            <button class="chat-plus-btn" id="plusBtn" type="button">
                <i data-lucide="plus" size="24"></i>
            </button>

            <!-- ✅ 여러 장 업로드: multiple 추가 -->
            <input type="file" id="imageInput" accept="image/jpeg,image/jpg,image/png" multiple style="display:none"/>

            <input type="text" id="chatInput" placeholder="로그인 후 이용 가능합니다." disabled class="chat-main-input">

            <button class="chat-send-btn" disabled id="sendBtn" type="button">
                <i data-lucide="arrow-up" size="24" color="#ccc"></i>
            </button>
        </div>
    </div>
</div>

<!-- ✅ 이미지 확대 모달 -->
<div class="image-modal-overlay" id="imageModalOverlay" aria-hidden="true">
    <div class="image-modal" role="dialog" aria-modal="true">
        <button class="image-modal-close" id="imageModalClose" type="button" aria-label="close">×</button>
        <img id="imageModalImg" src="" alt="">
    </div>
</div>

<script>
    lucide.createIcons();

    const isLoggedIn = <%= (session.getAttribute("loginMember") != null) ? "true" : "false" %>;

    if (window.marked) {
        marked.setOptions({ breaks: true, gfm: true });
    }

    const CROOM_IDX = 2;

    const GUEST_KEYWORD_ANSWERS = {
        "지하철 공사": `
**지하철 공사**
총 6개 공구로 진행 중입니다.

- 차량기지 ~ 운천저수지
- 금호지구 ~ 풍금사거리
- 월드컵경기장 ~ 무등시장
- 동아병원 ~ 양림휴먼시아
- 남광주역 ~ 지산사거리
- 두암지구 ~ 광주역

※ 더욱 자세한 안내와 서비스 이용은 로그인 후 이용 가능합니다.
        `.trim(),

        "불법주정차": `
**불법 주정차 신고 방법**

필요 정보:
- 위치
- 시간
- 차량정보
- 사진

신고 방법:
- 광주 교통민원 신고 앱
- 광주광역시 홈페이지 민원신고
- ☎ 062-120 (다산콜센터)

처리 절차:
- 접수 → 확인 → 조치

※ 더욱 자세한 안내와 서비스 이용은 로그인 후 이용 가능합니다.
        `.trim(),

        "장애인주차": `
**장애인 전용 주차구역 위반 신고**

확인 사항:
- 위반 위치
- 시간
- 차량번호
- 현장 사진 또는 영상

신고 경로:
- 모바일 신고 앱
- 광주광역시 민원신고
- ☎ 062-120

처리 절차:
- 접수 후 현장 확인
- 위반 여부에 따라 조치

※ 더욱 자세한 안내와 서비스 이용은 로그인 후 이용 가능합니다.
        `.trim()
    };

    window.addEventListener('DOMContentLoaded', () => {
        const input = document.getElementById('chatInput');
        const sendBtn = document.getElementById('sendBtn');
        const plusBtn = document.getElementById('plusBtn');
        const imageInput = document.getElementById('imageInput');

        // ✅ + 버튼 → file input 트리거
        plusBtn.addEventListener('click', () => {
            if (!isLoggedIn) {
                addMessage("이미지 분석 기능은 로그인 후 이용 가능합니다.", "bot");
                showLoginNudgeOnce();
                scrollToBottom();
                return;
            }
            imageInput.value = ""; // 같은 파일 재선택 가능하게
            imageInput.click();
        });

        // ✅ 여러 장 선택 처리
        imageInput.addEventListener('change', async (e) => {
            if (!isLoggedIn) return;

            const files = Array.from(e.target.files || []);
            if (!files.length) return;

            // ✅ 여러장: 순서대로 업로드/분석
            for (const file of files) {
                const okTypes = ["image/jpeg", "image/png"];
                if (!okTypes.includes(file.type)) {
                    addMessage("⚠️ JPG/PNG 이미지만 업로드할 수 있어요.", "bot");
                    scrollToBottom();
                    continue;
                }

                const MAX_MB = 10;
                if (file.size > MAX_MB * 1024 * 1024) {
                    addMessage(`⚠️ 이미지 용량이 너무 커요. (${MAX_MB}MB 이하로 올려주세요)`, "bot");
                    scrollToBottom();
                    continue;
                }

                await sendImage(file);
            }
        });

        if (isLoggedIn) {
            input.disabled = false;
            input.placeholder = "교통 민원 내용을 입력해 주세요.";
            sendBtn.disabled = false;

            sendBtn.addEventListener('click', () => sendMessage());

            input.addEventListener('keydown', (e) => {
                if (e.isComposing) return;
                if (e.key === 'Enter') {
                    e.preventDefault();
                    sendMessage();
                }
            });
        }

        window.addEventListener('resize', () => updateLoginNudgePosition());

        // ✅ 모달 이벤트
        setupImageModal();
    });

    function handleKeywordClick(keyword) {
        const keywordSection = document.getElementById('keywordSection');
        if (keywordSection) keywordSection.style.display = 'none';

        if (!isLoggedIn) {
            addMessage(keyword, 'user');
            scrollToBottom();

            setTimeout(() => {
                const answer = GUEST_KEYWORD_ANSWERS[keyword] || "안내 정보를 준비 중입니다.";
                addMessage(answer, 'bot');
                showLoginNudgeOnce();
                scrollToBottom();
            }, 150);
            return;
        }

        sendMessage(keyword);
    }

    async function sendMessage(forcedText) {
        if (!isLoggedIn) return;

        const input = document.getElementById('chatInput');
        const text = (forcedText ?? input.value ?? "").trim();
        if (!text) return;

        const keywordSection = document.getElementById('keywordSection');
        if (keywordSection) keywordSection.style.display = 'none';

        addMessage(text, 'user');
        if (!forcedText) input.value = "";
        scrollToBottom();

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

    async function sendImage(file) {
        const keywordSection = document.getElementById('keywordSection');
        if (keywordSection) keywordSection.style.display = 'none';

        // ✅ 텍스트(Uploaded image) 같은 거 없이, 유저 이미지 말풍선만 추가
        addUserImageBubble(file);
        scrollToBottom();

        const loadingEl = showTyping();
        scrollToBottom();

        try {
            const formData = new FormData();
            formData.append("file", file);
            formData.append("croom_idx", String(CROOM_IDX));

            const input = document.getElementById('chatInput');
            formData.append("text", (input.value || "").trim());

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

    // ✅ 텍스트 전처리: "DB 메타데이터" 제거 + (차량기지 건설공사 문단 제거)
    function normalizeBotText(text) {
        let t = (text || "");

        t = t.replace(/\r\n/g, "\n");
        t = t.replace(/(\S)~(\S)/g, "$1 ~ $2");

        // "또한, 광주도시철도2호선 차량기지 건설공사..." 문단 제거
        t = t.replace(
            /(^|\n)\s*또한,\s*광주도시철도\s*2\s*호선\s*차량기지\s*건설공사[\s\S]*?(?=\n{2,}|\n\s*[-*+]\s|\n\s*\d+\.|\n\s*※|$)/g,
            "\n"
        );
        t = t.replace(
            /(^|\n)\s*광주도시철도\s*2\s*호선\s*차량기지\s*건설공사[\s\S]*?(?=\n{2,}|\n\s*[-*+]\s|\n\s*\d+\.|\n\s*※|$)/g,
            "\n"
        );

        // (id=2, row_no=2) 제거
        t = t.replace(/\s*,?\s*\(id=\d+,\s*row_no=\d+\)/g, "");

        // 쉼표/공백 찌꺼기 정리
        t = t.replace(/,\s*,+/g, ", ");
        t = t.replace(/\s+,/g, ",");
        t = t.replace(/,\s*\n/g, "\n");
        t = t.replace(/,\s*$/g, "");

        // 공백 정리는 스페이스/탭만
        t = t.replace(/[ \t]{2,}/g, " ");

        // 빈 줄 폭발 제거
        t = t.replace(/\n{3,}/g, "\n\n");

        // "라벨:\n\n- " -> "라벨:\n- "
        t = t.replace(/:\n\n(?=[-*\+])/g, ":\n");

        // 리스트 앞 공백 정리
        t = t.replace(/\n[ \t]+([-*+])[ \t]+/g, "\n$1 ");

        return t.trim();
    }

    function renderBotHtml(text) {
        const normalized = normalizeBotText(text);
        if (!window.marked) return normalized.replace(/\*\*/g, "");
        return marked.parse(normalized);
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

    // ✅ 유저 이미지 말풍선: 파란 배경 없애려면 class에 "image" 추가가 핵심
    function addUserImageBubble(file) {
        const messagesArea = document.getElementById('messagesArea');

        const bubble = document.createElement('div');
        bubble.className = "message-bubble user image"; // ✅ 핵심

        const img = document.createElement('img');
        img.className = "chat-image-preview";
        img.alt = "";

        const url = URL.createObjectURL(file);
        img.src = url;

        // ✅ 클릭하면 확대
        img.addEventListener('click', () => openImageModal(url));

        img.onerror = () => {
            bubble.innerText = "⚠️ 이미지 미리보기를 불러오지 못했어요.";
            URL.revokeObjectURL(url);
        };

        // ✅ 모달에서 쓰는 url 때문에 여기서 revoke하면 안 됨.
        // 모달/버블이 제거될 일이 거의 없어서, 메모리 신경 쓰면 아래처럼 처리 가능:
        // img.onload = () => { /* no revoke here */ };

        bubble.appendChild(img);
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
        if (sender === "bot") el.innerHTML = renderBotHtml(newText);
        else el.innerText = newText;
    }

    function showLoginNudgeOnce() {
        if (document.getElementById('loginNudge')) {
            updateLoginNudgePosition();
            return;
        }

        const container = document.querySelector('.chat-page-container');
        const nudgeDiv = document.createElement('div');
        nudgeDiv.className = 'login-nudge-msg';
        nudgeDiv.id = 'loginNudge';
        nudgeDiv.innerHTML = `
            <button class="chat-login-nudge-btn" onclick="location.href='/login'">
                로그인 하러가기
            </button>
        `;
        container.appendChild(nudgeDiv);

        updateLoginNudgePosition();
    }

    function updateLoginNudgePosition() {
        const nudge = document.getElementById('loginNudge');
        if (!nudge) return;

        const inputWrapper = document.getElementById('chatInputWrapper');
        if (!inputWrapper) return;

        const rect = inputWrapper.getBoundingClientRect();
        const bottomFromViewport = window.innerHeight - rect.top;

        nudge.style.bottom = (bottomFromViewport + 10) + "px";
    }

    function scrollToBottom() {
        const chatContent = document.getElementById('chatContent');
        chatContent.scrollTop = chatContent.scrollHeight;
    }

    /* =========================
       ✅ 이미지 확대 모달
    ========================= */
    function setupImageModal() {
        const overlay = document.getElementById('imageModalOverlay');
        const closeBtn = document.getElementById('imageModalClose');

        closeBtn.addEventListener('click', closeImageModal);

        // 바깥 클릭 닫기
        overlay.addEventListener('click', (e) => {
            if (e.target === overlay) closeImageModal();
        });

        // ESC 닫기
        window.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') closeImageModal();
        });
    }

    function openImageModal(src) {
        const overlay = document.getElementById('imageModalOverlay');
        const img = document.getElementById('imageModalImg');
        img.src = src;
        overlay.classList.add('open');
        overlay.setAttribute('aria-hidden', 'false');
    }

    function closeImageModal() {
        const overlay = document.getElementById('imageModalOverlay');
        const img = document.getElementById('imageModalImg');
        if (!overlay.classList.contains('open')) return;
        overlay.classList.remove('open');
        overlay.setAttribute('aria-hidden', 'true');
        img.src = "";
    }
</script>
</body>
</html>