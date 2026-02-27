<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--
  ChatbotSection.jsp
  챗봇 소개 영역 + 게시판 미리보기

  Request attributes:
    - isLoggedIn  (Boolean) : 로그인 여부
    - boardPosts  (List<Map>) : 게시판 미리보기 목록 (선택)
        각 항목: title(String), date(String)
--%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ChatbotSection.css" />

<section class="chatbot-section">

    <%-- ── 챗봇 인트로 ── --%>
    <div class="chatbot-intro-wrapper">
        <div class="chatbot-intro"
             onclick="window.location.href='${pageContext.request.contextPath}/chat'"
             style="cursor:pointer;">

            <div class="chatbot-avatar">
                <img src="${pageContext.request.contextPath}/assets/character.png"
                     alt="펭리미"
                     style="width:100%;height:100%;object-fit:contain;transform:scaleX(-1);" />
            </div>

            <div class="chatbot-bubble">
                <p>안녕하세요~!</p>
                <p><strong>교통 길잡이 펭리미입니다 🐧</strong></p>
                <p>어떤 교통 불편 때문에 불편하셨나요?</p>
            </div>

        </div>
    </div>

    <%-- ── 게시판 미리보기 ── --%>
    <div class="board-preview-container ${not isLoggedIn ? 'not-logged-in' : ''}"
         <c:if test="${isLoggedIn}">
             onclick="window.location.href='${pageContext.request.contextPath}/board'"
             style="cursor:pointer;"
         </c:if>
         <c:if test="${not isLoggedIn}">
             style="cursor:default;"
         </c:if>
    >

        <div class="board-preview-header"
             onclick="<c:if test='${isLoggedIn}'>window.location.href='${pageContext.request.contextPath}/board'</c:if>">
            <h3>ON! 교통 정보</h3>
            <span class="more-text">전체보기 &gt;</span>
        </div>

        <div class="board-content-wrapper">

            <%-- 게시글 목록 --%>
            <ul class="board-preview-list ${not isLoggedIn ? 'is-blurred' : ''}">
                <c:choose>
                    <c:when test="${not empty boardPosts}">
                        <c:forEach var="post" items="${boardPosts}">
                            <li class="board-preview-item">
                                <span class="post-title">${post.title}</span>
                                <span class="post-date">${post.date}</span>
                            </li>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <li class="board-preview-empty">
                            등록된 게시물이 없습니다.
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>

            <%-- 비로그인 오버레이 --%>
            <c:if test="${not isLoggedIn}">
                <div class="board-login-overlay">
                    <button class="login-prompt-btn-v2"
                            onclick="event.stopPropagation(); window.openLoginModal();">
                        로그인하러 가기
                    </button>
                </div>
            </c:if>

        </div>
    </div>

</section>
