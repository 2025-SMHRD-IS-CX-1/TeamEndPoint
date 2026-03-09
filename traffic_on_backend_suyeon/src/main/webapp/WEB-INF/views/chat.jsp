<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TRAFFIC:ON - 챗봇가이드</title>
    <link rel="stylesheet" href="/css/ChatPage.css">
    <script src="https://unpkg.com/lucide@latest"></script>
    <script src="https://cdn.jsdelivr.net/npm/marked/marked.min.js"></script>

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

        .user-image-bubble {
            align-self: flex-end;
            max-width: 75%;
            position: relative;
            padding: 0;
            margin: 6px 0;
            background: transparent;
        }
        .user-image-bubble .chat-image-preview {
            display: block;
            max-width: 260px;
            width: 100%;
            height: auto;
            border-radius: 14px;
            box-shadow: 0 10px 26px rgba(0,0,0,0.14);
            cursor: zoom-in;
        }
        .user-image-bubble .img-remove-btn {
            position: absolute;
            top: -10px;
            right: -10px;
            width: 34px;
            height: 34px;
            border-radius: 999px;
            border: none;
            cursor: pointer;
            background: rgba(255,255,255,0.95);
            box-shadow: 0 10px 26px rgba(0,0,0,0.20);
            font-size: 18px;
            line-height: 34px;
            font-weight: 900;
        }
        .user-image-bubble .img-remove-btn:active { transform: scale(0.98); }
        .user-image-bubble.sent .img-remove-btn { display: none; }
        .user-image-bubble.sending { opacity: 0.78; }

        /* ✅ 비로그인 답변 아래에 붙는 키워드 박스 */
        .guest-keyword-inline-wrap {
            width: 100%;
            display: flex;
            justify-content: center;
            margin: 10px 0 6px 0;
        }
        .guest-keyword-inline-box {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            justify-content: center;
            align-items: center;
            width: fit-content;
            max-width: 90%;
            padding: 10px 12px;
            border-radius: 18px;
            background: #dfe7ee;
            border: 1px solid #cfd8e3;
        }
    </style>
</head>
<body>
<div class="chat-page-container">
    <header class="chat-header">
        <button class="back-btn" onclick="history.back()">
            <i data-lucide="chevron-left"></i>
        </button>

        <div class="center">
            <img src="${pageContext.request.contextPath}/images/Pengrimi.png"
                 alt="logo"
                 class="header-logo">
            <span class="logo-text">TRAFFIC:ON</span>
        </div>

        <div class="header-spacer"></div>
    </header>

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

    <div class="chat-input-wrapper" id="chatInputWrapper">
        <div class="chat-input-bar">
            <button class="chat-plus-btn" id="plusBtn" type="button">
                <i data-lucide="plus" size="24"></i>
            </button>

            <input
                type="file"
                id="imageInput"
                accept="image/jpeg,image/jpg,image/png,image/webp,image/bmp,image/gif,.jfif,.jpeg,.jpg,.png,.webp,.bmp,.gif,.heic,.heif"
                multiple
                style="display:none"
            />

            <textarea id="chatInput" placeholder="로그인 후 이용 가능합니다." disabled class="chat-main-input" rows="1"></textarea>

            <button class="chat-send-btn" disabled id="sendBtn" type="button">
                <i data-lucide="arrow-up" size="24" color="#ccc"></i>
            </button>
        </div>
    </div>
</div>

<div class="image-modal-overlay" id="imageModalOverlay" aria-hidden="true">
    <div class="image-modal" role="dialog" aria-modal="true">
        <button class="image-modal-close" id="imageModalClose" type="button" aria-label="close">×</button>
        <img id="imageModalImg" src="" alt="">
    </div>
</div>

<script>
    lucide.createIcons();

    const isLoggedIn = <%= (session.getAttribute("loginMember") != null) ? "true" : "false" %>;
    const CROOM_IDX = 2;
    let pendingImages = [];

    if (window.marked) {
        marked.setOptions({ breaks: true, gfm: true });
    }

    const FIXED_RESPONSES = [
        {
            keys: ["안녕", "안녕하세요", "hi", "hello", "반가워", "반갑"],
            text: `
안녕하세요! 저는 교통 길잡이 펭리미예요.

교통 민원(VOC) 데이터를 바탕으로  
불편했던 상황을 **쉽게 정리**하고, **민원 접수 전에 필요한 절차를 한눈에** 볼 수 있게 도와드리는  
**교통 민원·정보 가이드 서비스**랍니다 🙂

지금 겪으신 상황을 편하게 말씀해 주세요!
            `.trim()
        },
        {
            keys: ["너는 누구야", "넌 누구야", "너 누구야", "누구세요", "누구야", "정체", "소개해줘", "너 뭐야"],
            text: `
저는 교통 길잡이 펭리미예요!

교통 민원(VOC) 데이터를 활용해서  
시민분들이 교통 불편을 더 **쉽게 이해**하고,  
민원 접수 전에 **필요한 절차/준비물**을 **빠르게 정리**할 수 있게 도와드리고 있어요 🙂

원하시면 “불법주정차 / 장애인주차 / 지하철 공사” 같은 주제로 바로 안내해드릴게요!
            `.trim()
        },
        {
            keys: ["도움말", "사용법", "어떻게 써", "어떻게 사용", "할 수 있는", "뭐 할 수", "기능", "가능한"],
            text: `
좋아요! 펭리미 이렇게 쓰면 편해요 🐧

**1) 글로 질문하기**
- 예) “불법주정차 신고는 어떻게 해요?”
- 예) “버스정류장 앞에 주차했는데 신고 가능해요?”

**2) 사진으로 물어보기**
- 사진 올리고, 바로 아래에 상황을 한 줄로 적어주세요.
- 예) “여기 장애인구역 위반인가요?” / “이 표지판 무슨 뜻이에요?”

**3) 안내 받을 수 있는 것**
- 상황에 맞는 **민원 유형 정리**
- **신고 방법/절차**, 준비해야 할 정보(시간/장소/사진 등)
- 관련 **연락처/경로** 안내

편하게 상황만 말해주시면 제가 알아서 정리해드릴게요 🙂
            `.trim()
        }
    ];

    const GUEST_KEYWORDS = ["지하철 공사", "불법주정차", "장애인주차"];

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

	function renderGuestKeywordButtons() {
	    const messagesArea = document.getElementById('messagesArea');

	    // ✅ 기존에 생성된 키워드 박스 전부 제거
	    const oldKeywordWraps = messagesArea.querySelectorAll('.guest-keyword-inline-wrap');
	    oldKeywordWraps.forEach(el => el.remove());

	    const wrap = document.createElement('div');
	    wrap.className = 'guest-keyword-inline-wrap';

	    const box = document.createElement('div');
	    box.className = 'guest-keyword-inline-box';

	    GUEST_KEYWORDS.forEach(keyword => {
	        const btn = document.createElement('button');
	        btn.className = 'chat-keyword-btn';
	        btn.textContent = keyword;
	        btn.type = 'button';
	        btn.onclick = () => handleKeywordClick(keyword);
	        box.appendChild(btn);
	    });

	    wrap.appendChild(box);
	    messagesArea.appendChild(wrap);
	}

    function getSafeErrorMessage(err, fallback = "알 수 없는 오류가 발생했어요.") {
        if (!err) return fallback;
        if (typeof err === "string") return err;
        if (err.message && String(err.message).trim()) return err.message;
        return fallback;
    }

    function parseApiPayload(raw) {
        let data;
        try {
            data = JSON.parse(raw);
        } catch {
            data = { answer: raw };
        }

        const answer =
            data.answer ??
            data.analysis_result ??
            data.response ??
            data.message ??
            data.result ??
            data.error ??
            (typeof data === "string" ? data : JSON.stringify(data));

        return { data, answer };
    }

    window.addEventListener('DOMContentLoaded', () => {
        const input = document.getElementById('chatInput');
        const sendBtn = document.getElementById('sendBtn');
        const plusBtn = document.getElementById('plusBtn');
        const imageInput = document.getElementById('imageInput');

        plusBtn.addEventListener('click', () => {
            if (!isLoggedIn) {
                addMessage("이미지 분석 기능은 로그인 후 이용 가능합니다.", "bot");
                showLoginNudgeOnce();
                scrollToBottom();
                return;
            }
            imageInput.value = "";
            imageInput.click();
        });

        imageInput.addEventListener('change', (e) => {
            if (!isLoggedIn) return;

            const files = Array.from(e.target.files || []);
            if (!files.length) return;

            imageInput.value = "";

            const okTypes = [
                "image/jpeg",
                "image/jpg",
                "image/png",
                "image/webp",
                "image/bmp",
                "image/gif",
                "image/heic",
                "image/heif"
            ];

            const okExts = [".jpg", ".jpeg", ".png", ".webp", ".bmp", ".gif", ".jfif", ".heic", ".heif"];
            const MAX_MB = 15;

            for (const file of files) {
                const lowerName = (file.name || "").toLowerCase();
                const extOk = okExts.some(ext => lowerName.endsWith(ext));
                const typeOk = okTypes.includes(file.type);

                if (!typeOk && !extOk) {
                    addMessage("⚠️ JPG/PNG/WEBP/BMP/GIF/JFIF 이미지만 업로드할 수 있어요.", "bot");
                    continue;
                }

                if (file.size > MAX_MB * 1024 * 1024) {
                    addMessage(`⚠️ 이미지 용량이 너무 커요. (${MAX_MB}MB 이하로 올려주세요)`, "bot");
                    continue;
                }

                addPendingImageBubble(file);
            }

            scrollToBottom();
        });

        if (isLoggedIn) {
            input.disabled = false;
            input.placeholder = "교통 민원 내용을 입력해 주세요.";
            sendBtn.disabled = false;

            input.addEventListener("focus", () => {
                input.dataset.ph = input.placeholder || "";
                input.placeholder = "";
            });

            input.addEventListener("blur", () => {
                if (!input.value.trim()) {
                    input.placeholder = input.dataset.ph || "교통 민원 내용을 입력해 주세요.";
                }
            });

			input.addEventListener('keydown', (e) => {
			    if (e.isComposing) return;

			    // Shift + Enter → 줄바꿈
			    if (e.key === 'Enter' && e.shiftKey) {
			        return;
			    }

			    // Enter → 메시지 전송
			    if (e.key === 'Enter') {
			        e.preventDefault();
			        sendMessage();
			    }
			});
        }

        window.addEventListener('resize', () => updateLoginNudgePosition());
        setupImageModal();
    });

    function handleKeywordClick(keyword) {
        if (!isLoggedIn) {
            const keywordSection = document.getElementById('keywordSection');

            // 처음 상단 키워드 영역만 숨김
            if (keywordSection) {
                keywordSection.style.display = 'none';
            }

            addMessage(keyword, 'user');
            scrollToBottom();

            setTimeout(() => {
                const answer = GUEST_KEYWORD_ANSWERS[keyword] || "안내 정보를 준비 중입니다.";
                addMessage(answer, 'bot');

                // ✅ 항상 3개 전부 다시 출력
                renderGuestKeywordButtons();

                showLoginNudgeOnce();
                scrollToBottom();
            }, 150);

            return;
        }

        sendMessage(keyword);
    }

    function matchFixedResponse(text) {
        const t = (text || "").trim().toLowerCase();
        if (!t) return null;

        for (const item of FIXED_RESPONSES) {
            const hit = item.keys.some(k => t.includes(String(k).toLowerCase()));
            if (hit) return item.text;
        }
        return null;
    }

    async function sendMessage(forcedText) {
        if (!isLoggedIn) return;

        const input = document.getElementById('chatInput');
        const text = (forcedText ?? input.value ?? "").trim();

        if (!text && pendingImages.length === 0) return;

        const keywordSection = document.getElementById('keywordSection');
        if (keywordSection) keywordSection.style.display = 'none';

        const fixed = matchFixedResponse(text);
        if (fixed) {
            if (text) addMessage(text, "user");
            if (!forcedText) input.value = "";
            const t = showTyping();
            replaceMessage(t, fixed, "bot");
            scrollToBottom();
            return;
        }

        if (text) addMessage(text, 'user');
        if (!forcedText) input.value = "";
        scrollToBottom();

        if (pendingImages.length > 0) {
            let typingEl = showTyping();
            scrollToBottom();

            const queue = pendingImages.slice();

            queue.forEach(item => {
                if (item?.bubbleEl) item.bubbleEl.classList.add('sending');
                if (item?.removeBtnEl) item.removeBtnEl.disabled = true;
            });

            pendingImages = pendingImages.filter(x => !queue.includes(x));

            try {
                for (let i = 0; i < queue.length; i++) {
                    const item = queue[i];
                    const answer = await sendImageOnlyAPI(item.file, text);

                    if (i === 0) {
                        replaceMessage(typingEl, answer, "bot");
                    } else {
                        const t2 = showTyping();
                        replaceMessage(t2, answer, "bot");
                    }
                    scrollToBottom();
                }

                queue.forEach(item => {
                    if (item?.bubbleEl) {
                        item.bubbleEl.classList.remove('sending');
                        item.bubbleEl.classList.add('sent');
                    }
                    if (item?.removeBtnEl) item.removeBtnEl.style.display = "none";
                });

            } catch (err) {
                console.error(err);
                const msg = getSafeErrorMessage(err, "이미지 분석 중 오류가 발생했어요.");
                replaceMessage(typingEl, "❌ 이미지 분석 요청 실패: " + msg, "bot");
                scrollToBottom();

                pendingImages = queue.concat(pendingImages);
                queue.forEach(item => {
                    if (item?.bubbleEl) item.bubbleEl.classList.remove('sending');
                    if (item?.removeBtnEl) item.removeBtnEl.disabled = false;
                });
            }
            return;
        }

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
            const { answer } = parseApiPayload(raw);

            if (!res.ok) {
                replaceMessage(loadingEl, "❌ 서버 오류: " + answer, "bot");
                scrollToBottom();
                return;
            }

            replaceMessage(loadingEl, answer, "bot");
            scrollToBottom();

        } catch (err) {
            console.error(err);
            replaceMessage(loadingEl, "❌ 챗봇 서버 연결 실패: " + getSafeErrorMessage(err), "bot");
            scrollToBottom();
        }
    }

    async function sendImageOnlyAPI(file, text) {
        const formData = new FormData();
        formData.append("file", file);
        formData.append("croom_idx", String(CROOM_IDX));
        formData.append("text", (text || "").trim());

        const res = await fetch("/api/chat/image", {
            method: "POST",
            body: formData
        });

        const raw = await res.text();
        console.log("IMAGE API raw =", raw);

        const { answer } = parseApiPayload(raw);

        if (!res.ok) {
            throw new Error(answer || "이미지 분석 응답을 받지 못했어요.");
        }

        if (!answer || !String(answer).trim()) {
            throw new Error("이미지 분석 결과가 비어 있어요.");
        }

        return answer;
    }

    function normalizeBotText(text) {
        let t = (text || "");

        t = t.replace(/\r\n/g, "\n");
        t = t.replace(/(\S)~(\S)/g, "$1 ~ $2");

        t = t.replace(
            /(^|\n)\s*또한,\s*광주도시철도\s*2\s*호선\s*차량기지\s*건설공사[\s\S]*?(?=\n{2,}|\n\s*[-*+]\s|\n\s*\d+\.|\n\s*※|$)/g,
            "\n"
        );
        t = t.replace(
            /(^|\n)\s*광주도시철도\s*2\s*호선\s*차량기지\s*건설공사[\s\S]*?(?=\n{2,}|\n\s*[-*+]\s|\n\s*\d+\.|\n\s*※|$)/g,
            "\n"
        );

        t = t.replace(/\s*,?\s*\(id=\d+,\s*row_no=\d+\)/g, "");
        t = t.replace(/,\s*,+/g, ", ");
        t = t.replace(/\s+,/g, ",");
        t = t.replace(/,\s*\n/g, "\n");
        t = t.replace(/,\s*$/g, "");
        t = t.replace(/[ \t]{2,}/g, " ");
        t = t.replace(/\n{3,}/g, "\n\n");
        t = t.replace(/:\n\n(?=[-*\+])/g, ":\n");
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

    function addPendingImageBubble(file) {
        const messagesArea = document.getElementById('messagesArea');
        const id = (crypto && crypto.randomUUID) ? crypto.randomUUID() : String(Date.now() + Math.random());

        const bubble = document.createElement('div');
        bubble.className = "user-image-bubble";
        bubble.dataset.pid = id;

        const img = document.createElement('img');
        img.className = "chat-image-preview";
        img.alt = "";

        const url = URL.createObjectURL(file);
        img.src = url;
        img.addEventListener('click', () => openImageModal(url));

        const removeBtn = document.createElement('button');
        removeBtn.type = "button";
        removeBtn.className = "img-remove-btn";
        removeBtn.setAttribute("aria-label", "remove image");
        removeBtn.textContent = "×";

        removeBtn.addEventListener('click', (e) => {
            e.preventDefault();
            e.stopPropagation();

            pendingImages = pendingImages.filter(x => x.id !== id);

            if (bubble.parentNode) bubble.parentNode.removeChild(bubble);

            try { URL.revokeObjectURL(url); } catch (err) {}
            scrollToBottom();
        });

        bubble.appendChild(img);
        bubble.appendChild(removeBtn);
        messagesArea.appendChild(bubble);

        pendingImages.push({ id, file, url, bubbleEl: bubble, removeBtnEl: removeBtn });
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

    function setupImageModal() {
        const overlay = document.getElementById('imageModalOverlay');
        const closeBtn = document.getElementById('imageModalClose');

        closeBtn.addEventListener('click', closeImageModal);

        overlay.addEventListener('click', (e) => {
            if (e.target === overlay) closeImageModal();
        });

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