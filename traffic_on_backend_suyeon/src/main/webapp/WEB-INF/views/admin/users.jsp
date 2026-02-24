<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>사용자 관리</title>

  <!-- 대시보드 레이아웃 CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Dashboard.css" />

  <!-- 사용자 관리 CSS (너 파일명: users.css) -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/users.css" />
</head>

<body>
<div class="admin-dashboard">

  <!-- ✅ 상단 헤더 -->
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

  <!-- ✅ 메인: 여기서부터 사용자관리 컨텐츠 -->
  <main class="dashboard-main" style="display:block;">
    <!-- dashboard-main이 grid일 수도 있어서, 사용자관리 페이지는 block로 강제 -->
    <!-- 필요하면 이 style은 빼고, CSS에서 별도로 처리해도 됨 -->

    <!-- ✅ 사용자관리 컨텐츠 -->
    <div class="user-management">
      <h1 class="view-title">사용자 관리</h1>

      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-card-left">
            <div class="stat-info">
              <span class="stat-title">총 사용자</span>
              <div class="stat-value-row">
                <span class="stat-value">2,154</span>
                <span class="stat-unit">명</span>
              </div>
            </div>
          </div>
          <div class="stat-trend up">▲+8.2%</div>
        </div>

        <div class="stat-card">
          <div class="stat-card-left">
            <div class="stat-info">
              <span class="stat-title">이번달 가입</span>
              <div class="stat-value-row">
                <span class="stat-value">312</span>
                <span class="stat-unit">명</span>
              </div>
            </div>
          </div>
          <div class="stat-trend up">▲+12%</div>
        </div>

        <div class="stat-card">
          <div class="stat-card-left">
            <div class="stat-info">
              <span class="stat-title">오늘 접속</span>
              <div class="stat-value-row">
                <span class="stat-value">87</span>
                <span class="stat-unit">명</span>
              </div>
            </div>
          </div>
          <div class="stat-trend up">▲+21%</div>
        </div>

        <div class="stat-card">
          <div class="stat-card-left">
            <div class="stat-info">
              <span class="stat-title">경고</span>
              <div class="stat-value-row">
                <span class="stat-value">64</span>
                <span class="stat-unit">명</span>
              </div>
            </div>
          </div>
          <div class="stat-trend down">▼-2.5%</div>
        </div>
      </div>

      <div class="filter-bar">
        <div class="filter-group">
          <select class="filter-select">
            <option>지역</option>
            <option>광산구</option>
            <option>북구</option>
            <option>서구</option>
            <option>남구</option>
            <option>동구</option>
          </select>

          <select class="filter-select">
            <option>연령</option>
            <option>20대</option>
            <option>30대</option>
            <option>40대</option>
            <option>50대</option>
            <option>60대</option>
          </select>
        </div>

        <div class="search-group">
          <input type="text" placeholder="사용자 검색" class="search-input" />
          <button class="search-btn" type="button">검색</button>
        </div>
      </div>

      <div class="table-container">
        <table class="user-table">
          <thead>
            <tr>
              <th>번호</th>
              <th>아이디</th>
              <th>이름</th>
              <th>지역</th>
              <th>연령</th>
              <th>성별</th>
              <th>가입일</th>
              <th>상세</th>
              <th>관리</th>
            </tr>
          </thead>
          <tbody>
            <tr data-email="minsu01@naver.com" data-phone="010-1234-5678" data-address="광주 광산구 첨단로 12">
              <td>1</td><td>minsu01</td><td>김민수</td><td>광산구</td><td>34</td><td>남</td><td>2024.03.01</td>
              <td><button class="action-btn detail" type="button">상세보기</button></td>
              <td>
                <div class="action-buttons">
                  <button class="action-btn warn" type="button">경고</button>
                  <button class="action-btn block" type="button">정지</button>
                </div>
              </td>
            </tr>

            <tr data-email="soojin29@naver.com" data-phone="010-1234-5555" data-address="광주 북구 첨단로 12">
              <td>2</td><td>soojin29</td><td>이수진</td><td>북구</td><td>29</td><td>여</td><td>2024.02.21</td>
              <td><button class="action-btn detail" type="button">상세보기</button></td>
              <td>
                <div class="action-buttons">
                  <button class="action-btn warn active" type="button">경고 해제</button>
                  <button class="action-btn block" type="button">정지</button>
                </div>
              </td>
            </tr>

            <tr data-email="junho45@naver.com" data-phone="010-1111-5578" data-address="광주 서구 첨단로 12">
              <td>3</td><td>junho45</td><td>박준호</td><td>서구</td><td>45</td><td>남</td><td>2024.01.15</td>
              <td><button class="action-btn detail" type="button">상세보기</button></td>
              <td>
                <div class="action-buttons">
                  <button class="action-btn warn active" type="button">경고 해제</button>
                  <button class="action-btn block" type="button">정지</button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="pagination">
        <button class="page-nav" type="button">&lt;</button>
        <button class="page-num active" type="button">1</button>
        <button class="page-num" type="button">2</button>
        <button class="page-num" type="button">3</button>
        <button class="page-nav" type="button">&gt;</button>
      </div>
    </div>
  </main>

  <!-- ✅ 오버레이/사이드바 -->
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

        <li class="nav-item active">
          <a href="${pageContext.request.contextPath}/admin/users">
            <span class="nav-icon">👥</span>
            <span class="nav-text">사용자 관리</span>
          </a>
        </li>

        <li class="nav-item">
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
  let isSidebarOpen = false;

  function openSidebar() {
    isSidebarOpen = true;
    document.getElementById("sidebar").classList.add("open");
    const overlay = document.getElementById("overlay");
    overlay.style.display = "block";
  }
  function closeSidebar() {
    isSidebarOpen = false;
    document.getElementById("sidebar").classList.remove("open");
    const overlay = document.getElementById("overlay");
    overlay.style.display = "none";
  }

  document.getElementById("btnMenu").addEventListener("click", () => {
    if (isSidebarOpen) closeSidebar(); else openSidebar();
  });
  document.getElementById("overlay").addEventListener("click", closeSidebar);
</script>

<!-- ✅ 상세 팝오버 (처음엔 숨김) -->
<div class="popover" id="userPopover" style="display:none;">
  <p id="popEmail"></p>
  <p id="popPhone"></p>
  <p id="popAddr"></p>
  <button class="popover-close" type="button" id="popClose">닫기</button>
</div>

<script>
  // ===== 상세보기 팝오버 =====
  const pop = document.getElementById("userPopover");
  const popEmail = document.getElementById("popEmail");
  const popPhone = document.getElementById("popPhone");
  const popAddr = document.getElementById("popAddr");
  const popClose = document.getElementById("popClose");

  function closePopover() {
    pop.style.display = "none";
  }

  popClose.addEventListener("click", closePopover);

  // 바깥 클릭하면 닫기
  document.addEventListener("click", (e) => {
    if (pop.style.display === "none") return;
    const isDetailBtn = e.target.closest(".action-btn.detail");
    const isInsidePopover = e.target.closest("#userPopover");
    if (!isDetailBtn && !isInsidePopover) closePopover();
  });

  // 상세보기 버튼 클릭
  document.querySelectorAll(".action-btn.detail").forEach(btn => {
    btn.addEventListener("click", (e) => {
      e.preventDefault();
      e.stopPropagation();

      const tr = e.target.closest("tr");
      const email = tr.dataset.email || "-";
      const phone = tr.dataset.phone || "-";
      const address = tr.dataset.address || "-";

      popEmail.textContent = "이메일 : " + email;
      popPhone.textContent = "연락처 : " + phone;
      popAddr.textContent = "주소 : " + address;

      // 버튼 위치 기준으로 팝오버 위치 잡기 (CSS가 fixed라 viewport 기준)
      const rect = e.target.getBoundingClientRect();
      pop.style.top = (rect.bottom + 10) + "px";
      pop.style.left = (rect.left - 120) + "px";
      pop.style.display = "block";
    });
  });

  // ===== 경고/정지 토글 =====
  // 경고 버튼: warn active면 "경고 해제", 아니면 "경고"
  document.querySelectorAll(".action-btn.warn").forEach(btn => {
    btn.addEventListener("click", (e) => {
      e.preventDefault();
      btn.classList.toggle("active");
      btn.textContent = btn.classList.contains("active") ? "경고 해제" : "경고";
    });
  });

  // 정지 버튼: block active면 "정지 해제", 아니면 "정지"
  document.querySelectorAll(".action-btn.block").forEach(btn => {
    btn.addEventListener("click", (e) => {
      e.preventDefault();
      btn.classList.toggle("active");
      btn.textContent = btn.classList.contains("active") ? "정지 해제" : "정지";
    });
  });
</script>

</body>
</html>