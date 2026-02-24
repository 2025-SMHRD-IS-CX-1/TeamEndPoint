<%@ page contentType="text/html; charset=UTF-8" %>
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

          <div class="search-box">
            <input type="text" placeholder="게시글 검색" class="search-input" id="searchInput" />
            <button class="search-btn" type="button" id="searchBtn">검색</button>
          </div>
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
            <tr data-id="1">
              <td class="col-checkbox"><input type="checkbox" class="chkRow" /></td>
              <td class="col-number">1</td>
              <td class="col-title">도로 파손 신고합니다.</td>
              <td class="col-author">minsu01</td>
              <td class="col-date">2024.03.23</td>
              <td class="col-likes">238</td>
              <td class="col-action"></td>
            </tr>

            <tr data-id="2">
              <td class="col-checkbox"><input type="checkbox" class="chkRow" /></td>
              <td class="col-number">2</td>
              <td class="col-title">[신고] 불법 주차 해결 방안</td>
              <td class="col-author">soojin29</td>
              <td class="col-date">2024.03.22</td>
              <td class="col-likes">185</td>
              <td class="col-action"><span class="warn-badge">경고</span></td>
            </tr>

            <tr data-id="3">
              <td class="col-checkbox"><input type="checkbox" class="chkRow" /></td>
              <td class="col-number">3</td>
              <td class="col-title">신호등 고장 신고합니다.</td>
              <td class="col-author">junho45</td>
              <td class="col-date">2024.03.20</td>
              <td class="col-likes">162</td>
              <td class="col-action"><span class="warn-badge">경고</span></td>
            </tr>

            <tr data-id="4">
              <td class="col-checkbox"><input type="checkbox" class="chkRow" /></td>
              <td class="col-number">4</td>
              <td class="col-title">주민센터 앞 불법 신축물 투기 문제</td>
              <td class="col-author">jiwoo36</td>
              <td class="col-date">2024.03.18</td>
              <td class="col-likes">271</td>
              <td class="col-action"><span class="warn-badge">경고</span></td>
            </tr>

            <tr data-id="5">
              <td class="col-checkbox"><input type="checkbox" class="chkRow" /></td>
              <td class="col-number">5</td>
              <td class="col-title">[광산구] 그늘 신호 무시하는 운전자들</td>
              <td class="col-author">seokho41</td>
              <td class="col-date">2024.03.16</td>
              <td class="col-likes">364</td>
              <td class="col-action"></td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="pagination">
        <button class="page-btn" type="button">&lt;</button>
        <button class="page-number active" type="button">1</button>
        <button class="page-number" type="button">2</button>
        <button class="page-number" type="button">3</button>
        <button class="page-number" type="button">4</button>
        <button class="page-number" type="button">5</button>
        <button class="page-btn" type="button">&gt;</button>
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

  // 검색 버튼(임시)
  document.getElementById("searchBtn").addEventListener("click", () => {
    const q = document.getElementById("searchInput").value.trim();
    alert("검색어: " + (q || "(없음)") + " — 백엔드 연결은 나중에!");
  });
</script>

</body>
</html>