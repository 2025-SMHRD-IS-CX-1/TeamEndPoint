<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TRAFFIC:ON - 게시글 상세</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/WriteBoard.css">
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
<div class="mobile-wrap">

    <header class="top-header">
        <div class="left">
            <button class="icon-btn" onclick="history.back()">
                <i data-lucide="chevron-left"></i>
            </button>
        </div>
        <div class="logo-container">
            <span class="logo-text">게시글 상세</span>
        </div>
        <div class="right"></div>
    </header>

    <div class="write-body">
        <div class="write-card">
            <div class="write-form-row">
                <label>카테고리</label>
                <div class="write-input">${board.category}</div>
            </div>
            <div class="divider"></div>
            <div class="write-form-row">
                <label>제목</label>
                <div class="write-input">${board.title}</div>
            </div>
            <div class="divider"></div>
            <div class="write-form-row">
                <label>작성자</label>
                <div class="write-input">
                    <%-- ✅ 관리자가 쓴 글이면 '관리자'로 표시 --%>
                    <c:choose>
                        <c:when test="${isAdminPost}">관리자</c:when>
                        <c:otherwise>${board.memId}</c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="divider"></div>
            <div class="write-form-row">
                <label>작성일</label>
                <div class="write-input">
                    ${board.createdAt.toString().substring(0, 16).replace('T', ' ')}
                </div>
            </div>
            <div class="divider"></div>
            <div class="write-form-row">
                <label>내용</label>
                <div class="write-textarea">${board.content}</div>
            </div>
        </div>
    </div>

    <div class="write-footer">
        <button class="cancel-btn" onclick="location.href='/board'">목록으로</button>
        <c:if test="${canEdit}">
            <button class="submit-btn"
                onclick="location.href='/board/edit/${board.boardId}'"
                style="background:#2f6bff;">수정</button>
        </c:if>
        <c:if test="${canDelete}">
            <form action="/board/delete/${board.boardId}" method="post" style="flex:1;">
                <button type="submit" class="submit-btn"
                    style="background:#ff4d4d; box-shadow:0 8px 22px rgba(255,77,77,0.22); width:100%;"
                    onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
            </form>
        </c:if>
    </div>

</div>
<script>lucide.createIcons();</script>
</body>
</html>