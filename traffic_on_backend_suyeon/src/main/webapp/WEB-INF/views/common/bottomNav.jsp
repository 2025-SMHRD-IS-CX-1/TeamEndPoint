<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!-- bottomNav.jsp -->
    <div class="v3-bottom-nav">
        <div class="nav-item-v3" onclick="location.href='/about'">
            <i data-lucide="search"></i>
            <span>사전해결 가이드</span>
        </div>
        <div class="nav-item-v3" onclick="location.href='/complaint-type'">
            <i data-lucide="layout-grid"></i>
            <span>민원유형</span>
        </div>
        <div class="nav-item-v3" onclick="location.href='/process'">
            <i data-lucide="file-check"></i>
            <span>신청절차 안내</span>
        </div>
    </div>
    <script>lucide.createIcons();</script>