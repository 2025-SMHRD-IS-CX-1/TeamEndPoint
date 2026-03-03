<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>게시판 관리</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Dashboard.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/boards.css?v=1" />
</head>

<body>
	
<div class="admin-dashboard">
  <header class="dashboard-header">
    <div class="header-left">
      <span class="menu-icon" id="btnMenu">☰</span>
    </div>

    <div class="dashboard-logo">
      <img src="${pageContext.request.contextPath}/images/mascot.png" alt="Mascot" class="mascot-img" />
      <span class="logo-text">TRAFFIC:ON</span>
    </div>

    <div class="header-right">
		<a href="${pageContext.request.contextPath}/login" class="logout-btn">
		  <span>로그아웃</span>
		</a>
    </div>
  </header>

  <main class="dashboard-main" style="display:block;">
    <div class="board-management">
      <div class="board-header">
        <h1 class="board-title">게시판 관리</h1>
      </div>

      <div class="board-controls">
        <div class="board-filters">
          <select class="filter-select" id="categorySelect">
            <option value="전체">전체</option>
            <option value="신고">신고/민원</option>
            <option value="정보/가이드">정보/가이드</option>
            <option value="후기/공유">후기/공유</option>
          </select>

          <select class="filter-select" id="dateSelect">
            <option value="작성일">작성일</option>
            <option value="최신순">최신순</option>
            <option value="오래된순">오래된순</option>
          </select>

		  <form method="get" action="${pageContext.request.contextPath}/admin/boards" class="search-box">
		      <input type="text"
		             name="keyword"
		             value="${keyword}"
		             placeholder="게시글 검색"
		             class="search-input" />

		      <button class="search-btn" type="submit">검색</button>
		  </form>
        </div>
      </div>

      <div class="board-table-container">
        <table class="board-table">
          <thead>
            <tr>
              <th class="col-checkbox">
                <input type="checkbox" id="chkAll" />
              </th>
              <th class="col-number">번호</th>
              <th class="col-title">게시물</th>
              <th class="col-author">아이디</th>
              <th class="col-date">작성일</th>
              <th class="col-likes">추천</th>
              <th class="col-action">경고</th>
            </tr>
          </thead>

		  <tbody id="boardTbody">
		    <c:forEach var="b" items="${page.content}">
		      <tr data-id="${b.boardId}">
		        <td class="col-checkbox">
		          <input type="checkbox" class="chkRow" value="${b.boardId}" />
		        </td>

		        <td class="col-number">${b.boardId}</td>
		        <td class="col-title">${b.title}</td>
		        <td class="col-author">${b.memId}</td>
		        <td class="col-date">${fn:replace(b.createdAt, "T", " ")}</td>
		        <td class="col-likes">-</td>
		        <td class="col-action"></td>
		      </tr>
		    </c:forEach>
		  </tbody>
        </table>
      </div>

	  <c:set var="baseUrl"
	         value="${pageContext.request.contextPath}/admin/boards?keyword=${keyword}" />

	  <div class="pagination">

	    <!-- 이전 -->
	    <c:if test="${page.number > 0}">
	      <a class="page-btn" href="${baseUrl}&page=${page.number-1}">&lt;</a>
	    </c:if>

	    <!-- 페이지 숫자 -->
	    <c:forEach begin="0" end="${page.totalPages-1}" var="i">
	      <a class="page-number ${i==page.number ? 'active' : ''}"
	         href="${baseUrl}&page=${i}">
	         ${i+1}
	      </a>
	    </c:forEach>

	    <!-- 다음 -->
	    <c:if test="${page.number < page.totalPages-1}">
	      <a class="page-btn" href="${baseUrl}&page=${page.number+1}">&gt;</a>
	    </c:if>

	  </div>
    </div>
  </main>

  <div class="sidebar-overlay" id="overlay" style="display:none;"></div>

  <aside class="dashboard-sidebar" id="sidebar">
    <div class="sidebar-header">
      <div class="sidebar-brand">
        <span class="sidebar-logo-text">TRAFFIC:ON</span>
      </div>
    </div>

    <div class="sidebar-profile">
      <div class="profile-avatar-circle">
        <svg class="profile-icon-svg" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
          <path d="M12 12C14.21 12 16 10.21 16 8C16 5.79 14.21 4 12 4C9.79 4 8 5.79 8 8C8 10.21 9.79 12 12 12ZM12 14C9.33 14 4 15.34 4 18V20H20V18C20 15.34 14.67 14 12 14Z" fill="white" />
        </svg>
      </div>

      <div class="profile-name-container">
        <span class="profile-name-text" id="userName">펭리미 관리자님</span>
        <div class="profile-name-underline"></div>
      </div>
    </div>

    <nav class="sidebar-nav">
      <ul>
        <li class="nav-item">
          <a href="${pageContext.request.contextPath}/admin/dashboard">
            <span class="nav-icon">⊞</span>
            <span class="nav-text">대시보드</span>
          </a>
        </li>

        <li class="nav-item">
          <a href="${pageContext.request.contextPath}/admin/users">
            <span class="nav-icon">👥</span>
            <span class="nav-text">사용자 관리</span>
          </a>
        </li>

        <li class="nav-item active">
          <a href="${pageContext.request.contextPath}/admin/boards">
            <span class="nav-icon">📝</span>
            <span class="nav-text">게시판 관리</span>
          </a>
        </li>
      </ul>
    </nav>

    <div class="sidebar-footer">
      <span class="globe-icon">🌐</span>
      <span class="lang-text">한국어</span>
    </div>
  </aside>
</div>

<script>
  // 사이드바 토글
  let isSidebarOpen = false;

  function openSidebar() {
    isSidebarOpen = true;
    document.getElementById("sidebar").classList.add("open");
    document.getElementById("overlay").style.display = "block";
  }
  function closeSidebar() {
    isSidebarOpen = false;
    document.getElementById("sidebar").classList.remove("open");
    document.getElementById("overlay").style.display = "none";
  }

  document.getElementById("btnMenu").addEventListener("click", () => {
    if (isSidebarOpen) closeSidebar(); else openSidebar();
  });
  document.getElementById("overlay").addEventListener("click", closeSidebar);

  // 체크박스 동작
  const chkAll = document.getElementById("chkAll");
  const rowChecks = () => Array.from(document.querySelectorAll(".chkRow"));

  function syncAllCheckbox() {
    const rows = rowChecks();
    const checkedCount = rows.filter(chk => chk.checked).length;
    chkAll.checked = rows.length > 0 && checkedCount === rows.length;
  }

  chkAll.addEventListener("change", (e) => {
    const checked = e.target.checked;
    rowChecks().forEach(chk => chk.checked = checked);
  });

  document.querySelectorAll(".chkRow").forEach(chk => {
    chk.addEventListener("change", syncAllCheckbox);
  });

</script>

</body>
</html>