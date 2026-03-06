<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>TRAFFIC:ON - 서비스 소개</title>
    <%@ include file="common/head.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/AboutPage.css">
</head>

<body>
	<div class="about-layout-container">
	    <div class="about-layout-content">

            <%@ include file="common/header.jsp" %>

            <main class="about-container">
                <!-- 타이틀 -->
				<div class="about-title-section">
					<h1 class="about-main-title">
					  <span class="brand">TRAFFIC:ON</span>은<br>
					  어떤 곳인가요?
					</h1>

				    <p class="about-subtext">
				        교통 불편이 생겼을 때 어디에 말해야 할지 헷갈린다면<br>
				        <strong>TRAFFIC:ON</strong>에서 먼저 확인해보세요.
				    </p>

				</div>

                <!-- 펭리미 소개 -->
                <div class="about-bubble-section">
                    <div class="character-img-area">
                        <img src="${pageContext.request.contextPath}/images/mascot.png" alt="펭리미">
                    </div>
                    <div class="speech-bubble">
                        <h3><span class="icon">➡️</span> 안녕하세요!</h3>
                        <p>저는 TRAFFIC:ON에서 교통 길을 안내해주는 <strong>펭리미</strong>에요! 🚦</p>
                        <p class="sub">교통 불편을 겪었을 때, 어디에 말해야 할지 고민되신 적 있나요?</p>
                    </div>
                </div>

                <!-- 서비스 설명 -->
                <div class="about-info-card">
                    <h3><span class="badge yellow">ⓘ</span> Traffic ON은</h3>
                    <p>시민이 교통 불편 상황을 겪었을 때</p>
                    <p>이 문제가 민원 대상인지 스스로 판단할 수 있도록 돕는</p>
                    <p><strong>교통 민원 정보 가이드 서비스</strong>예요.</p>
                </div>

                <!-- 도움 주는 상황 -->
                <div class="about-help-card">
                    <h3><span class="badge green">✓</span> 이런 상황에서 TRAFFIC:ON이 도와드려요!</h3>
                    <ul class="help-list">
                        <li>🚦 불법주정차, 신호등 고장 같은 <strong>교통 불편 유형 안내</strong></li>
                        <li>📒 민원이 필요한 경우 <strong>신고 기관과 절차</strong>를 단계별로 안내</li>
                        <li>💬 교통 관련 질문과 정보를 나눌 수 있는 <strong>시민 게시판</strong> 제공</li>
                    </ul>
                </div>

                <!-- 안내 불가 -->
                <div class="about-bubble-section reverse">
                    <div class="character-img-area">
                        <img src="${pageContext.request.contextPath}/images/mascot.png" alt="펭리미">
                    </div>
                    <div class="speech-bubble warning-bubble">
                        <h3><span class="icon">❌</span> TRAFFIC:ON은 민원을 대신 접수해주지는 않아요.</h3>
                        <p>대신, 시민이 혼란 없이 <strong>올바른 선택</strong>을 할 수 있도록 정확한 정보와 방향을 안내해요.</p>
                    </div>
                </div>

                <!-- 하단 CTA -->
                <div class="about-cta-card">
                    <p class="cta-question">
                        <span class="badge blue">➜</span>
                        교통 불편이 생겼을 때 "이거 어디다 말해야 하지?"
                    </p>
                    <p class="cta-answer">
                        고민된다면 <strong>TRAFFIC:ON</strong>에서 먼저 확인해보세요!
                    </p>

                    <div class="cta-buttons">
                        <a href="${pageContext.request.contextPath}/guide" class="cta-btn blue-btn">교통 불편</a>
                        <a href="${pageContext.request.contextPath}/application-process" class="cta-btn mint-btn">민원 절차</a>
                        <a href="${pageContext.request.contextPath}/board" class="cta-btn green-btn">시민 게시판</a>
                    </div>
                </div>
            </main>

            <!-- AI 퀵버튼 -->
            <a href="${pageContext.request.contextPath}/chat" class="quick-ai-btn">
                <img src="${pageContext.request.contextPath}/images/mascot.png" alt="AI">
                <span class="ai-badge">AI</span>
            </a>

        </div>
    </div>

    <script>
        lucide.createIcons();
    </script>
</body>
</html>