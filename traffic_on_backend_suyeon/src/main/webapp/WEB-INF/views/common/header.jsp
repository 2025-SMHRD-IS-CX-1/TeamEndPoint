<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Header.css">

<header class="top-header">
  <button class="icon-btn"
    onclick="if(typeof openSideMenu === 'function') { openSideMenu(); }">
    <i data-lucide="menu" size="24" color="#333"></i>
  </button>

  <div class="logo-container"
       onclick="location.href='${pageContext.request.contextPath}/'"
       style="cursor:pointer;">
    <img src="${pageContext.request.contextPath}/images/Pengrimi.png"
         alt="로고"
         style="width:50px;height:50px;object-fit:contain;transform:scaleX(-1);" />
    <span class="logo-text">TRAFFIC:ON</span>
  </div>

  <%
    Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
    if (isLoggedIn != null && isLoggedIn) {
  %>
    <button class="icon-btn" onclick="location.href='${pageContext.request.contextPath}/mypage'">
      <i data-lucide="user" size="24" color="#333"></i>
    </button>
  <%
    } else {
  %>
    <button class="icon-btn login-btn-header" onclick="location.href='${pageContext.request.contextPath}/login'">
      <i data-lucide="user-plus" size="24" color="#333"></i>
    </button>
  <%
    }
  %>
</header>

<script>
  if (window.lucide) lucide.createIcons();
</script>