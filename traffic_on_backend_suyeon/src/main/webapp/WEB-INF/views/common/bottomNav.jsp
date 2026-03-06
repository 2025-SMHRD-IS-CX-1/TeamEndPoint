<%@ page contentType="text/html; charset=UTF-8" %>
<<<<<<< HEAD
<script src="https://unpkg.com/lucide@latest"></script>

<nav class="bottom-nav">
  <a class="nav-item ${pageContext.request.requestURI.contains('/about') ? 'active' : ''}"
     href="${pageContext.request.contextPath}/about">
=======

<script src="https://unpkg.com/lucide@latest"></script>

<nav class="bottom-nav">
	<a class="nav-item ${pageContext.request.requestURI.contains('/about') ? 'active' : ''}"
	   href="${pageContext.request.contextPath}/about">
>>>>>>> 0e086df37f3f3c6834bbb4a8b81fe813064b8dad
    <i data-lucide="search"></i>
    <span>사전해결 가이드</span>
  </a>

  <div class="nav-divider"></div>

  <a class="nav-item ${pageContext.request.requestURI.contains('/guide') ? 'active' : ''}"
     href="${pageContext.request.contextPath}/guide">
    <i data-lucide="layout-grid"></i>
    <span>민원유형</span>
  </a>

  <div class="nav-divider"></div>

  <a class="nav-item ${pageContext.request.requestURI.contains('/application-process') ? 'active' : ''}"
     href="${pageContext.request.contextPath}/application-process">
    <i data-lucide="file-check"></i>
    <span>신청절차 안내</span>
  </a>
</nav>

<script>
  lucide.createIcons();
</script>