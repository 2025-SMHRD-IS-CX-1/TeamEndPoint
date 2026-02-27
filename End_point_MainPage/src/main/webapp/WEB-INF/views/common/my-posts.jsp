<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>TRAFFIC:ON - 내 게시글</title>
        <%@ include file="head.jsp" %>
            <link rel="stylesheet" href="/css/MyPostsPage.css">
    </head>

    <body>
        <div class="myposts-container">
            <header class="myposts-header">
                <button class="back-btn" onclick="history.back()">
                    <i data-lucide="chevron-left"></i>
                </button>
                <h1>내 게시글</h1>
                <div class="header-spacer"></div>
            </header>

            <div class="posts-list-area">
                <!-- 임시 데이터 리스트 -->
                <div class="post-item-card">
                    <div class="post-info">
                        <h3>충장로 주변 불법주정차 단속 기준...</h3>
                        <p class="post-meta">2024-02-24 · 조회 38</p>
                    </div>
                    <i data-lucide="chevron-right"></i>
                </div>
                <div class="post-item-card">
                    <div class="post-info">
                        <h3>신호등 고장 신고는 어디로 해야...</h3>
                        <p class="post-meta">2024-02-22 · 조회 112</p>
                    </div>
                    <i data-lucide="chevron-right"></i>
                </div>
            </div>
        </div>

       <%@ include file="bottomNav.jsp" %>

            <script>lucide.createIcons();</script>
    </body>

    </html>