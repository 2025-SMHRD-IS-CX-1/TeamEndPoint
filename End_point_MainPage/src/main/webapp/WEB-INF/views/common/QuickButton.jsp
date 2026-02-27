<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- QuickButton.jsp : 우하단 고정 AI 챗봇 버튼 --%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/QuickButton.css" />

<button class="v3-quick-btn-icon-only"
        onclick="window.location.href='${pageContext.request.contextPath}/chat'"
        aria-label="펭리미 AI 챗봇 열기">
    <div class="v3-quick-icon-inner">
        <img src="${pageContext.request.contextPath}/images/character.png"
             alt="펭리미"
             class="v3-quick-char-img-large" />
        <span class="v3-quick-badge-ai">AI</span>
    </div>
</button>
