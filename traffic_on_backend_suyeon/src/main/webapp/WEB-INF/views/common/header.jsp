<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Header.css">

<header class="to-header">
  <!-- ===== Top Bar ===== -->
  <div class="to-topbar">
    <button class="to-icon-btn"
      onclick="if(typeof openSideMenu === 'function') { openSideMenu(); }"
      aria-label="메뉴">
      <i data-lucide="menu" size="24" color="#333"></i>
    </button>

    <div class="to-brand"
         onclick="location.href='${pageContext.request.contextPath}/'"
         style="cursor:pointer;">
      <img src="${pageContext.request.contextPath}/images/Pengrimi.png"
           alt="로고"
           class="to-brand-logo" />
      <span class="to-brand-text">TRAFFIC:ON</span>
    </div>

    <%
      Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
      if (isLoggedIn != null && isLoggedIn) {
    %>
      <button class="to-icon-btn" onclick="location.href='${pageContext.request.contextPath}/mypage'" aria-label="마이페이지">
        <i data-lucide="user" size="24" color="#333"></i>
      </button>
    <%
      } else {
    %>
      <button class="to-icon-btn" onclick="location.href='${pageContext.request.contextPath}/login'" aria-label="로그인">
        <i data-lucide="user-plus" size="24" color="#333"></i>
      </button>
    <%
      }
    %>
  </div>

  <!-- ===== Icon Tabs (사진에 있던 4개 원형) ===== -->
  <nav class="to-tabs" aria-label="상단 바로가기">
    <a class="to-tab active" href="${pageContext.request.contextPath}/application-process">
      <span class="to-tab-circle">
        <img src="${pageContext.request.contextPath}/images/icon_traffic24.png" class="to-tab-img" alt="교통민원24">
      </span>
      <span class="to-tab-label">교통민원24</span>
    </a>

    <a class="to-tab" href="${pageContext.request.contextPath}/people">
      <span class="to-tab-circle">
        <img src="${pageContext.request.contextPath}/images/icon_people.png" class="to-tab-img" alt="국민신문고">
      </span>
      <span class="to-tab-label">국민신문고</span>
    </a>

    <a class="to-tab" href="${pageContext.request.contextPath}/safety">
      <span class="to-tab-circle">
        <img src="${pageContext.request.contextPath}/images/icon_safety.png" class="to-tab-img" alt="안전신문고">
      </span>
      <span class="to-tab-label">안전신문고</span>
    </a>

    <a class="to-tab" href="${pageContext.request.contextPath}/gwangju">
      <span class="to-tab-circle">
        <img src="${pageContext.request.contextPath}/images/icon_gwangju.png" class="to-tab-img" alt="광주광역시">
      </span>
      <span class="to-tab-label">광주광역시</span>
    </a>
  </nav>
</header>

<script>
  if (window.lucide) lucide.createIcons();
</script>