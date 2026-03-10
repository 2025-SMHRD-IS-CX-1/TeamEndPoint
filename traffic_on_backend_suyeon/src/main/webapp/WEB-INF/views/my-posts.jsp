<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>TRAFFIC:ON - 내 게시글</title>
  <%@ include file="common/head.jsp" %>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/MyPostsPage.css">
  <style>
    .posts-list-area {
      padding: 16px;
      padding-bottom: 90px;
      display: flex;
      flex-direction: column;
      gap: 12px;
    }
    .post-item-card {
      background: #fff;
      border-radius: 16px;
      box-shadow: 0 2px 12px rgba(0,0,0,0.06);
      padding: 16px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      cursor: pointer;
      transition: background 0.15s;
    }
    .post-item-card:hover {
      background: #f7f9fc;
    }
    .post-info {
      display: flex;
      flex-direction: column;
      gap: 6px;
      flex: 1;
      min-width: 0;
    }
    .post-info h3 {
      margin: 0;
      font-size: 14px;
      font-weight: 700;
      color: #111;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    .post-meta {
      margin: 0;
      font-size: 12px;
      color: #aaa;
    }
    .myposts-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      padding: 12px 16px;
      background: #fff;
      border-bottom: 1px solid #eef0f3;
      position: sticky;
      top: 0;
      z-index: 100;
    }
    .myposts-header h1 {
      margin: 0;
      font-size: 18px;
      font-weight: 800;
      color: #111;
    }
    .back-btn {
      width: 40px;
      height: 40px;
      border: none;
      background: transparent;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      border-radius: 12px;
    }
    .back-btn:hover {
      background: #f4f6f8;
    }
    .header-spacer {
      width: 40px;
    }
    .empty-msg {
      text-align: center;
      padding: 40px 20px;
      color: #aaa;
      font-size: 14px;
    }
  </style>
</head>

<body>
  <div class="mobile-wrap">

    <%@ include file="common/header.jsp" %>
    <%@ include file="/WEB-INF/views/common/sideMenu.jsp" %>

    <div class="posts-list-area">

      <c:if test="${empty posts}">
        <p class="empty-msg">작성한 게시글이 없습니다.</p>
      </c:if>

      <c:forEach var="post" items="${posts}">
        <div class="post-item-card"
             onclick="location.href='${pageContext.request.contextPath}/board/${post.boardId}'">
          <div class="post-info">
            <h3>${post.title}</h3>
            <p class="post-meta">${post.createdAt.toString().substring(0,10)}</p>
          </div>
          <i data-lucide="chevron-right"></i>
        </div>
      </c:forEach>

    </div>

    <%@ include file="common/bottomNav.jsp" %>
  </div>

  <script>lucide.createIcons();</script>
</body>
</html>