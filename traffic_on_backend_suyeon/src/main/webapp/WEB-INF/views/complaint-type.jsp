<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TRAFFIC:ON - 민원 유형</title>

    <!-- 공통 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ComplaintTypePage.css">

    <script src="https://unpkg.com/lucide@latest"></script>
</head>

<body>
<div class="complaint-type-container">

    <!-- 상단 헤더 -->
    <header class="page-header">
        <button type="button" class="back-btn" onclick="history.back()">
            <i data-lucide="chevron-left"></i>
        </button>

        <h2>민원 유형</h2>

        <div class="header-spacer"></div>
    </header>

    <!-- 카테고리 영역 -->
    <div class="category-grid">

        <div class="category-card"
             onclick="location.href='${pageContext.request.contextPath}/process?type=traffic'">
            <div class="category-icon">🚗</div>
            <h3>교통 민원</h3>
            <p>불법주정차, 교통 시설물 신설/수리 등</p>
        </div>

        <div class="category-card"
             onclick="location.href='${pageContext.request.contextPath}/process?type=complaint'">
            <div class="category-icon">📄</div>
            <h3>일반 민원</h3>
            <p>대중교통 이용 불편, 도로 파손 등</p>
        </div>

        <div class="category-card"
             onclick="location.href='${pageContext.request.contextPath}/process?type=safety'">
            <div class="category-icon">⚠️</div>
            <h3>안전 신고</h3>
            <p>위험 상황 제보, 안전 시설 점검 요청</p>
        </div>

        <div class="category-card"
             onclick="location.href='${pageContext.request.contextPath}/process?type=gwangju'">
            <div class="category-icon">🏛️</div>
            <h3>광주 소식/공고</h3>
            <p>광주광역시교통공사 주요 소식 및 공고</p>
        </div>

    </div>
</div>

<!-- 하단 네비 (팀 화면 스타일 맞추기용) -->
<nav class="bottom-nav">
    <button type="button" onclick="location.href='${pageContext.request.contextPath}/guide'">
        사전해결 가이드
    </button>

    <button type="button" class="active"
            onclick="location.href='${pageContext.request.contextPath}/complaint-type'">
        민원유형
    </button>

    <button type="button" onclick="location.href='${pageContext.request.contextPath}/procedure'">
        신청절차 안내
    </button>
</nav>

<script>
    lucide.createIcons();
</script>

</body>
</html>