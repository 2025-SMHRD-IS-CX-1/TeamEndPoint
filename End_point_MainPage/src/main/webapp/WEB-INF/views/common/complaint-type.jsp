<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>TRAFFIC:ON - 민원 유형</title>
        <link rel="stylesheet" href="/css/ComplaintTypePage.css">
        <script src="https://unpkg.com/lucide@latest"></script>
    </head>

    <body>
        <div class="complaint-type-container">
            <header class="page-header">
                <button class="back-btn" onclick="history.back()">
                    <i data-lucide="chevron-left"></i>
                </button>
                <h2>민원 유형</h2>
                <div class="header-spacer"></div>
            </header>

            <div class="category-grid">
                <!-- 각 민원 유형 카드 -->
                <div class="category-card" onclick="location.href='/process?type=traffic'">
                    <div class="category-icon">🚗</div>
                    <h3>교통 민원</h3>
                    <p>불법주정차, 교통 시설물 신설/수리 등</p>
                </div>
                <div class="category-card" onclick="location.href='/process?type=complaint'">
                    <div class="category-icon">📄</div>
                    <h3>일반 민원</h3>
                    <p>대중교통 이용 불편, 도로 파손 등</p>
                </div>
                <div class="category-card" onclick="location.href='/process?type=safety'">
                    <div class="category-icon">⚠️</div>
                    <h3>안전 신고</h3>
                    <p>위험 상황 제보, 안전 시설 점검 요청</p>
                </div>
                <div class="category-card" onclick="location.href='/process?type=gwangju'">
                    <div class="category-icon">🏛️</div>
                    <h3>광주 소식/공고</h3>
                    <p>광주광역시교통공사 주요 소식 및 공고</p>
                </div>
            </div>
        </div>
        <script>lucide.createIcons();</script>
    </body>

    </html>