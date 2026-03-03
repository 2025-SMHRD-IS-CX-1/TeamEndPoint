<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>사용자 관리</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Dashboard.css" />
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

  <main class="dashboard-main" style="display:block;">
    <div class="user-management">
      <h1 class="view-title">사용자 관리</h1>

      <!-- ===== 통계 카드 ===== -->
      <div class="stats-grid">

        <div class="stat-card">
          <div class="stat-card-left">
            <div class="stat-info">
              <span class="stat-title">총 사용자</span>
              <div class="stat-value-row">
                <span class="stat-value">${totalUsers}</span>
                <span class="stat-unit">명</span>
              </div>
            </div>
          </div>

          <div class="stat-trend <c:choose><c:when test='${totalDeltaUp}'>up</c:when><c:otherwise>down</c:otherwise></c:choose>">
            <c:choose>
              <c:when test="${totalDeltaUp}">▲</c:when>
              <c:otherwise>▼</c:otherwise>
            </c:choose>
            ${totalDelta}명
          </div>
        </div>

        <div class="stat-card">
          <div class="stat-card-left">
            <div class="stat-info">
              <span class="stat-title">이번달 가입</span>
              <div class="stat-value-row">
                <span class="stat-value">${thisMonthUsers}</span>
                <span class="stat-unit">명</span>
              </div>
            </div>
          </div>

          <div class="stat-trend <c:choose><c:when test='${monthJoinUp}'>up</c:when><c:otherwise>down</c:otherwise></c:choose>">
            <c:choose>
              <c:when test="${monthJoinUp}">▲</c:when>
              <c:otherwise>▼</c:otherwise>
            </c:choose>
            ${monthJoinRate}%
          </div>
        </div>

        <div class="stat-card">
          <div class="stat-card-left">
            <div class="stat-info">
              <span class="stat-title">오늘 접속</span>
              <div class="stat-value-row">
                <span class="stat-value">${todayLoginUsers}</span>
                <span class="stat-unit">명</span>
              </div>
            </div>
          </div>

          <div class="stat-trend <c:choose><c:when test='${todayLoginUp}'>up</c:when><c:otherwise>down</c:otherwise></c:choose>">
            <c:choose>
              <c:when test="${todayLoginUp}">▲</c:when>
              <c:otherwise>▼</c:otherwise>
            </c:choose>
            ${todayLoginRate}%
          </div>
        </div>

        <div class="stat-card">
          <div class="stat-card-left">
            <div class="stat-info">
              <span class="stat-title">경고</span>
              <div class="stat-value-row">
                <span class="stat-value">${warnUsers}</span>
                <span class="stat-unit">명</span>
              </div>
            </div>
          </div>
          <div class="stat-sub">전체 대비 ${warnRate}%</div>
        </div>

      </div>

      <!-- ===== 필터/검색 (AJAX 전용) ===== -->
      <form id="filterForm" class="filter-bar" onsubmit="return false;">
        <div class="filter-group">
          <select class="filter-select" name="district" id="selDistrict">
            <option value="">구</option>
            <option value="광산구" <c:if test="${param.district eq '광산구'}">selected</c:if>>광산구</option>
            <option value="북구"   <c:if test="${param.district eq '북구'}">selected</c:if>>북구</option>
            <option value="서구"   <c:if test="${param.district eq '서구'}">selected</c:if>>서구</option>
            <option value="남구"   <c:if test="${param.district eq '남구'}">selected</c:if>>남구</option>
            <option value="동구"   <c:if test="${param.district eq '동구'}">selected</c:if>>동구</option>
          </select>

          <select class="filter-select" name="ageGroup" id="selAge">
            <option value="">연령</option>
            <option value="20" <c:if test="${param.ageGroup eq '20'}">selected</c:if>>20대</option>
            <option value="30" <c:if test="${param.ageGroup eq '30'}">selected</c:if>>30대</option>
            <option value="40" <c:if test="${param.ageGroup eq '40'}">selected</c:if>>40대</option>
            <option value="50" <c:if test="${param.ageGroup eq '50'}">selected</c:if>>50대</option>
            <option value="60" <c:if test="${param.ageGroup eq '60'}">selected</c:if>>60대</option>
          </select>
        </div>

        <div class="search-group">
          <input type="text"
                 name="keyword"
                 id="inpKeyword"
                 value="${param.keyword}"
                 placeholder="사용자 검색"
                 class="search-input" />
          <button class="search-btn" type="button" id="btnSearch">검색</button>
        </div>
      </form>

      <!-- ===== 테이블 ===== -->
      <div class="table-container table-scroll">
        <table class="user-table">
          <thead>
            <tr>
              <th>번호</th>
              <th>아이디</th>
              <th>이름</th>
              <th>구</th>
              <th>연령</th>
              <th>성별</th>
              <th>가입일</th>
              <th>상세</th>
              <th>관리</th>
            </tr>
          </thead>

          <tbody id="userTbody">
            <c:forEach var="m" items="${members}" varStatus="s">
              <tr data-email="${m.memEmail}" data-phone="${m.memPhone}" data-address="${m.memAddr}">
                <td>${s.count}</td>
                <td>${m.memID}</td>
                <td>${m.memName}</td>
                <td>${m.district}</td>
                <td>${m.ageGroup}</td>
                <td>${m.memGender}</td>
                <td>${m.joinedAtStr}</td>
                <td><button class="action-btn detail" type="button">상세보기</button></td>
                <td>
                  <div class="action-buttons">
                    <c:choose>
                      <c:when test="${m.warnCnt >= 1}">
                        <button class="action-btn warn active" type="button" data-memid="${m.memID}">경고 해제</button>
                      </c:when>
                      <c:otherwise>
                        <button class="action-btn warn" type="button" data-memid="${m.memID}">경고</button>
                      </c:otherwise>
                    </c:choose>

                    <c:choose>
                      <c:when test="${m.status eq 'BLOCK'}">
                        <button class="action-btn block active" type="button" data-memid="${m.memID}">정지 해제</button>
                      </c:when>
                      <c:otherwise>
                        <button class="action-btn block" type="button" data-memid="${m.memID}">정지</button>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </td>
              </tr>
            </c:forEach>
          </tbody>
        </table>
      </div>

      <!-- ===== 페이지네이션 ===== -->
      <div class="pagination" id="pagination">
        <c:if test="${page > 1}">
          <a class="page-nav" href="${pageContext.request.contextPath}/admin/users?page=${page-1}">&lt;</a>
        </c:if>

        <c:forEach var="p" begin="1" end="${totalPages}">
          <a class="page-num <c:if test='${p == page}'>active</c:if>"
             href="${pageContext.request.contextPath}/admin/users?page=${p}">${p}</a>
        </c:forEach>

        <c:if test="${page < totalPages}">
          <a class="page-nav" href="${pageContext.request.contextPath}/admin/users?page=${page+1}">&gt;</a>
        </c:if>
      </div>

    </div>
  </main>

  <!-- 상세 팝오버 -->
  <div id="userPopover" class="user-popover" style="display:none;">
    <div class="pop-row" id="popEmail">이메일 : -</div>
    <div class="pop-row" id="popPhone">연락처 : -</div>
    <button type="button" id="popClose" class="pop-close-btn">닫기</button>
  </div>

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
  // ===== 햄버거(사이드바) 토글 =====
  const btnMenu = document.getElementById("btnMenu");
  const sidebar = document.getElementById("sidebar");
  const overlay = document.getElementById("overlay");

  function openSidebar() {
    if (!sidebar || !overlay) return;
    sidebar.classList.add("open");
    overlay.style.display = "block";
  }
  function closeSidebar() {
    if (!sidebar || !overlay) return;
    sidebar.classList.remove("open");
    overlay.style.display = "none";
  }
  function toggleSidebar() {
    if (!sidebar) return;
    sidebar.classList.contains("open") ? closeSidebar() : openSidebar();
  }
  if (btnMenu) btnMenu.addEventListener("click", (e) => {
    e.preventDefault();
    e.stopPropagation();
    toggleSidebar();
  });
  if (overlay) overlay.addEventListener("click", closeSidebar);

  // ===== 상세 팝오버 =====
  const pop = document.getElementById("userPopover");
  const popEmail = document.getElementById("popEmail");
  const popPhone = document.getElementById("popPhone");
  const popClose = document.getElementById("popClose");

  function closePopover() {
    if (!pop) return;
    pop.style.display = "none";
  }
  if (popClose) popClose.addEventListener("click", closePopover);

  document.addEventListener("click", (e) => {
    const btn = e.target.closest(".action-btn.detail");
    if (!btn) return;
    if (!pop || !popEmail || !popPhone) return;

    e.preventDefault();
    e.stopPropagation();

    const tr = btn.closest("tr");
    const email = tr?.dataset.email || "-";
    const phone = tr?.dataset.phone || "-";

    popEmail.textContent = "이메일 : " + email;
    popPhone.textContent = "연락처 : " + phone;

    const rect = btn.getBoundingClientRect();
    pop.style.top = (rect.bottom + 10) + "px";
    pop.style.left = (rect.left - 120) + "px";
    pop.style.display = "block";
  });

  document.addEventListener("click", (e) => {
    if (!pop || pop.style.display === "none") return;
    const isDetailBtn = e.target.closest(".action-btn.detail");
    const isInsidePopover = e.target.closest("#userPopover");
    if (!isDetailBtn && !isInsidePopover) closePopover();
  });

  document.addEventListener("keydown", (e) => {
    if (e.key === "Escape") closePopover();
  });

  // ===== 경고/정지 토글 =====
  const ctx = "${pageContext.request.contextPath}";
  document.addEventListener("click", async (e) => {
    const warnBtn = e.target.closest(".action-btn.warn");
    const blockBtn = e.target.closest(".action-btn.block");

    if (warnBtn) {
      const memID = warnBtn.dataset.memid;
      const res = await fetch(ctx + "/admin/users/warn-toggle", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: new URLSearchParams({ memID })
      });
      const data = await res.json();

      if (data.warnCnt >= 1) {
        warnBtn.classList.add("active");
        warnBtn.textContent = "경고 해제";
      } else {
        warnBtn.classList.remove("active");
        warnBtn.textContent = "경고";
      }
      return;
    }

    if (blockBtn) {
      const memID = blockBtn.dataset.memid;
      const res = await fetch(ctx + "/admin/users/block-toggle", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: new URLSearchParams({ memID })
      });
      const data = await res.json();

      if (String(data.status).toUpperCase() === "BLOCK") {
        blockBtn.classList.add("active");
        blockBtn.textContent = "정지 해제";
      } else {
        blockBtn.classList.remove("active");
        blockBtn.textContent = "정지";
      }
      return;
    }
  });

  // ===== 비동기 필터/검색/페이지네이션 =====
  const filterForm = document.getElementById("filterForm");
  const tbody = document.getElementById("userTbody");
  const pagination = document.getElementById("pagination");
  const btnSearch = document.getElementById("btnSearch");

  // onclick="loadUsers(x)" 호출 가능하게
  window.loadUsers = loadUsers;

  if (filterForm) {
    filterForm.addEventListener("change", (e) => {
      if (e.target.matches("select[name='district'], select[name='ageGroup']")) {
        loadUsers(1);
      }
    });
  }

  if (btnSearch) {
    btnSearch.addEventListener("click", () => loadUsers(1));
  }

  async function loadUsers(page) {
     if (!filterForm) return;

     const formData = new FormData(filterForm);
     formData.set("page", page);

     const params = new URLSearchParams(formData);
     const res = await fetch(ctx + "/admin/users/data?" + params.toString());
     const data = await res.json();

     // tbody 비우기
     tbody.textContent = "";

     // 행 생성 함수
     const makeBtn = (className, text, memid) => {
       const b = document.createElement("button");
       b.type = "button";
       b.className = className;
       b.textContent = text;
       if (memid) b.dataset.memid = memid;
       return b;
     };

     data.members.forEach((m, idx) => {
       const tr = document.createElement("tr");
       tr.dataset.email = m.memEmail || "-";
       tr.dataset.phone = m.memPhone || "-";
       tr.dataset.address = m.memAddr || "-";

       const td = (text) => {
         const cell = document.createElement("td");
         cell.textContent = (text ?? "-");
         return cell;
       };

       tr.appendChild(td(idx + 1));
       tr.appendChild(td(m.memID));
       tr.appendChild(td(m.memName));
       tr.appendChild(td(m.district));
       tr.appendChild(td(m.ageGroup));
       tr.appendChild(td(m.memGender));
       tr.appendChild(td(m.joinedAtStr));

       // 상세보기 버튼
       const detailTd = document.createElement("td");
       detailTd.appendChild(makeBtn("action-btn detail", "상세보기"));
       tr.appendChild(detailTd);

       // 관리 버튼들
       const manageTd = document.createElement("td");
       const wrap = document.createElement("div");
       wrap.className = "action-buttons";

       const warnActive = (m.warnCnt >= 1);
       const warnBtn = makeBtn(
         "action-btn warn" + (warnActive ? " active" : ""),
         warnActive ? "경고 해제" : "경고",
         m.memID
       );

       const status = String(m.status || "").toUpperCase();
       const blockActive = (status === "BLOCK");
       const blockBtn = makeBtn(
         "action-btn block" + (blockActive ? " active" : ""),
         blockActive ? "정지 해제" : "정지",
         m.memID
       );

       wrap.appendChild(warnBtn);
       wrap.appendChild(blockBtn);
       manageTd.appendChild(wrap);
       tr.appendChild(manageTd);

       tbody.appendChild(tr);
     });

     // 페이지네이션 다시 만들기
     pagination.textContent = "";
     for (let p = 1; p <= data.totalPages; p++) {
       const btn = document.createElement("button");
       btn.type = "button";
       btn.className = "page-num" + (p === data.page ? " active" : "");
       btn.textContent = p;
       btn.addEventListener("click", () => loadUsers(p));
       pagination.appendChild(btn);
     }
   }
</script>

</body>
</html>