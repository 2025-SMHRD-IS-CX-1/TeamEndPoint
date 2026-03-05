<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="https://unpkg.com/lucide@latest"></script>

<nav class="bottom-nav">
  <a class="nav-item" href="${pageContext.request.contextPath}/about">
    <i data-lucide="search"></i>
    <span>사전해결 가이드</span>
  </a>

  <div class="nav-divider"></div>

  <a class="nav-item active" href="${pageContext.request.contextPath}/guide">
    <i data-lucide="layout-grid"></i>
    <span>민원유형</span>
  </a>

  <div class="nav-divider"></div>

  <a class="nav-item" href="${pageContext.request.contextPath}/process">
    <i data-lucide="file-check"></i>
    <span>신청절차 안내</span>
  </a>
</nav>

<script>
  lucide.createIcons();
</script>