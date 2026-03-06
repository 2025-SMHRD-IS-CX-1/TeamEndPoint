<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TRAFFIC:ON - 글쓰기</title>
<<<<<<< HEAD
    <link rel="stylesheet" href="/css/common.css">
=======
>>>>>>> 0e086df37f3f3c6834bbb4a8b81fe813064b8dad
    <link rel="stylesheet" href="/css/WriteBoard.css">
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
<<<<<<< HEAD
<div class="mobile-wrap">

    <header class="top-header">
        <div class="left">
            <button class="icon-btn" onclick="history.back()">
                <i data-lucide="chevron-left"></i>
            </button>
        </div>
        <div class="logo-container">
            <span class="logo-text">글쓰기</span>
        </div>
        <div class="right"></div>
    </header>

    <div class="write-body">
        <form action="/board/write" method="post">
            <div class="write-card">
                <div class="write-form-row">
                    <label for="category">카테고리</label>
                 <select id="category" name="category" class="write-input">
    <option value="신고/민원">신고/민원</option>
    <option value="정보/가이드">정보/가이드</option>
    <option value="후기/공유">후기/공유</option>
</select>
                </div>
                <div class="divider"></div>
                <div class="write-form-row">
                    <label for="title">제목</label>
                    <input type="text" id="title" name="title"
                        class="write-input" placeholder="제목을 입력하세요" />
                </div>
                <div class="divider"></div>
                <div class="write-form-row">
                    <label for="content">내용</label>
                    <textarea id="content" name="content"
                        class="write-textarea" placeholder="내용을 입력하세요"></textarea>
                </div>
            </div>

            <div class="write-footer">
                <button type="button" class="cancel-btn" onclick="location.href='/board'">취소</button>
                <button type="submit" class="submit-btn">등록</button>
            </div>
        </form>
    </div>

</div>
<script>lucide.createIcons();</script>
=======
    <div class="write-container">

        <!-- 헤더 -->
        <header class="write-header">
            <button type="button" class="back-btn" onclick="history.back()">
                <i data-lucide="chevron-left"></i>
            </button>
            <h1>글쓰기</h1>
            <div class="header-spacer"></div>
        </header>

        <!-- 폼 본문 -->
        <div class="write-body">
            <form action="/board/write" method="post">
                <div class="write-card">
                    <div class="write-form-row">
                        <label for="title">제목</label>
                        <input type="text" id="title" name="title" class="write-input" placeholder="제목을 입력하세요" />
                    </div>
                    <div class="divider"></div>
                    <div class="write-form-row">
                        <label for="content">내용</label>
                        <textarea id="content" name="content" class="write-textarea" placeholder="내용을 입력하세요"></textarea>
                    </div>
                </div>

                <div class="write-footer">
                    <button type="button" class="cancel-btn" onclick="location.href='/board'">취소</button>
                    <button type="submit" class="submit-btn">등록</button>
                </div>
            </form>
        </div>

    </div>

    <script>
        lucide.createIcons();
    </script>
>>>>>>> 0e086df37f3f3c6834bbb4a8b81fe813064b8dad
</body>
</html>