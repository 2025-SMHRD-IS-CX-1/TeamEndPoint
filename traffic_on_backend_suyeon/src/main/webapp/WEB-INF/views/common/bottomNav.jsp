<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="https://unpkg.com/lucide@latest"></script>

<c:set var="uri" value="${pageContext.request.requestURI}" />

<nav class="bottom-nav">
  <a class="nav-item ${uri == '/' or fn:endsWith(uri, '/index') or fn:endsWith(uri, '/index.jsp') ? 'active' : ''}"
     href="${pageContext.request.contextPath}/">
    <i data-lucide="search"></i>
    <span>사전해결 가이드</span>
  </a>

  <div class="nav-divider"></div>

  <a class="nav-item ${fn:endsWith(uri, '/guide') ? 'active' : ''}"
     href="${pageContext.request.contextPath}/guide">
    <i data-lucide="layout-grid"></i>
    <span>민원유형</span>
  </a>

  <div class="nav-divider"></div>

  <a class="nav-item ${fn:endsWith(uri, '/application-process') ? 'active' : ''}"
     href="${pageContext.request.contextPath}/application-process">
    <i data-lucide="file-check"></i>
    <span>신청절차 안내</span>
  </a>
</nav>

<script>
  lucide.createIcons();
</script>