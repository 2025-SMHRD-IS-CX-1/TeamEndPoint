<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 공통 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Header.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/BottomNav.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/QuickButton.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/SideMenu.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/MobileLayout.css" />

<div class="mobile-layout-container">
    <!-- 상단 헤더 -->
    <jsp:include page="/WEB-INF/views/common/Header.jsp" />

    <!-- 본문 -->
    <div class="mobile-layout-content">
        <!-- 배너: 메인 페이지에서만 표시 -->
        <c:if test="${contentPage eq '/WEB-INF/views/common/index.jsp'}">
            
        </c:if>

        <!-- 실제 본문 -->
        <jsp:include page="${contentPage}" />

        <!-- 퀵버튼 -->
        <jsp:include page="/WEB-INF/views/common/QuickButton.jsp" />
        
        <!-- 사이드 버튼 -->
        <jsp:include page="/WEB-INF/views/common/SideMenu.jsp" />
        
    </div>

    <!-- 하단 네비게이션 -->
    <jsp:include page="/WEB-INF/views/common/bottomNav.jsp" />
</div>
