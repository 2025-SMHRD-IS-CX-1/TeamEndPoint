<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TRAFFIC:ON - 게시글 상세</title>
    <link rel="stylesheet" href="/css/WriteBoard.css">
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
    <div class="write-container">

        <!-- 헤더 -->
        <header class="write-header">
            <button type="button" class="back-btn" onclick="history.back()">
                <i data-lucide="chevron-left"></i>
            </button>
            <h1>게시글 상세</h1>
            <div class="header-spacer"></div>
        </header>

        <!-- 본문 -->
        <div class="write-body">
            <div class="write-card">
                <div class="write-form-row">
                    <label>제목</label>
                    <div class="write-input">${board.title}</div>
                </div>
                <div class="divider"></div>
                <div class="write-form-row">
                    <label>작성자</label>
                    <div class="write-input">${board.memId}</div>
                </div>
                <div class="divider"></div>
                <div class="write-form-row">
                    <label>내용</label>
                    <div class="write-textarea">${board.content}</div>
                </div>
            </div>
        </div>

        <!-- 하단 버튼 -->
        <div class="write-footer">
            <button class="cancel-btn" onclick="location.href='/board'">목록으로</button>
            <!-- 삭제 버튼: 당사자 또는 admin만 표시 -->
            <c:if test="${canDelete}">
                <form action="/board/delete/${board.boardId}" method="post" style="flex:1;">
                    <button type="submit" class="submit-btn"
                        style="background:#ff4d4d; box-shadow: 0 8px 22px rgba(255,77,77,0.22); width:100%;"
                        onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
                </form>
            </c:if>
        </div>

    </div>

    <script>
        lucide.createIcons();
    </script>
</body>
</html>