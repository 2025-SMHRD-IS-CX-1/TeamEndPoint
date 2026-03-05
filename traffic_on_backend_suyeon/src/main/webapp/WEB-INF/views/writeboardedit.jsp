<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TRAFFIC:ON - 게시글 수정</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/WriteBoard.css">
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
<div class="mobile-wrap">

    <!-- 상단 헤더 -->
    <header class="top-header">
        <div class="left">
            <button class="icon-btn" onclick="history.back()">
                <i data-lucide="chevron-left"></i>
            </button>
        </div>
        <div class="logo-container">
            <span class="logo-text">게시글 수정</span>
        </div>
        <div class="right"></div>
    </header>

    <!-- 폼 본문 -->
    <div class="write-body">
        <form action="/board/edit/${board.boardId}" method="post">
            <div class="write-card">
                <div class="write-form-row">
                    <label for="title">제목</label>
                    <input type="text" id="title" name="title"
                        class="write-input" value="${board.title}" />
                </div>
                <div class="divider"></div>
                <div class="write-form-row">
                    <label for="content">내용</label>
                    <textarea id="content" name="content"
                        class="write-textarea">${board.content}</textarea>
                </div>
            </div>

            <div class="write-footer">
                <button type="button" class="cancel-btn" onclick="history.back()">취소</button>
                <button type="submit" class="submit-btn">수정 완료</button>
            </div>
        </form>
    </div>

</div>
<script>
    lucide.createIcons();
</script>
</body>
</html>