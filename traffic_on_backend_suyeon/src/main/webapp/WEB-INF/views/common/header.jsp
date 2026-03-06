<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Header.css">

<header class="top-header">

  <!-- 메뉴 버튼 -->
  <button class="icon-btn"
      onclick="if(typeof openSideMenu === 'function'){ openSideMenu(); }">
      <i data-lucide="menu"></i>
  </button>

  <!-- 로고 -->
  <div class="logo-container"
      onclick="location.href='${pageContext.request.contextPath}/'"
      style="cursor:pointer;">

      <img src="${pageContext.request.contextPath}/images/Pengrimi.png"
          class="logo-img"
          alt="logo">

      <span class="logo-text">TRAFFIC:ON</span>

  </div>

  <!-- 로그인 상태 -->
  <%
      Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");

      if(isLoggedIn != null && isLoggedIn){
  %>

      <button class="icon-btn"
          onclick="location.href='${pageContext.request.contextPath}/mypage'">
          <i data-lucide="user"></i>
      </button>

  <%
      } else {
  %>

      <button class="icon-btn"
          onclick="location.href='${pageContext.request.contextPath}/login'">
          <i data-lucide="user-plus"></i>
      </button>

  <%
      }
  %>

</header>

<script>
  if (window.lucide) {
    lucide.createIcons();
  }
</script>