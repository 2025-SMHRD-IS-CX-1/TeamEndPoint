<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>TRAFFIC:ON - 내 게시글</title>
  <%@ include file="common/head.jsp" %>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/MyPostsPage.css">
</head>

<body>
  <div class="myposts-container">
    <header class="myposts-header">
      <button class="back-btn" onclick="history.back()">
        <i data-lucide="chevron-left"></i>
      </button>
      <h1>내 게시글</h1>
      <div class="header-spacer"></div>
    </header>

    <div class="posts-list-area">

      <c:if test="${empty posts}">
        <p style="text-align:center; padding:20px;">작성한 게시글이 없습니다.</p>
      </c:if>

     <c:forEach var="post" items="${posts}">
    <div class="post-item-card" onclick="location.href='${pageContext.request.contextPath}/board/${post.boardId}'" style="cursor:pointer;">
        <div class="post-info">
            <h3>${post.title}</h3>
            <p class="post-meta">${post.createdAt.toString().substring(0,10)}</p>
        </div>
        <i data-lucide="chevron-right"></i>
    </div>
</c:forEach>

    </div>
  </div>

  <%@ include file="common/bottomNav.jsp" %>
  <script>lucide.createIcons();</script>
</body>
</html>