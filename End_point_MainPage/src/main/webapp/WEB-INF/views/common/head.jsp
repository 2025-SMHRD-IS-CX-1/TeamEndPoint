<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!-- head.jsp -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- 공통 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" />

<!-- 헤더 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Header.css" />

<!-- 레이아웃 CSS (마지막에 로드해야 덮어쓰기 가능) -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/MobileLayout.css" />

<!-- Lucide Icons -->
<script src="https://unpkg.com/lucide@latest"></script>
<script>
    window.isLoggedIn = false;
</script>
