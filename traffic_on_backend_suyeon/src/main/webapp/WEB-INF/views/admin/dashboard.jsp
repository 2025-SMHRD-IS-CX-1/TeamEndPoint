<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>관리자 대시보드</title>

  <!-- 너가 가지고 있는 Dashboard.css를 여기로 옮겨서 연결 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Dashboard.css" />
</head>

<body>
<div class="admin-dashboard">
  <header class="dashboard-header">
    <div class="header-left">
      <span class="menu-icon" id="btnMenu">☰</span>
    </div>

    <div class="dashboard-logo">
      <!-- mascot.png: src/main/resources/static/images/mascot.png -->
      <img src="${pageContext.request.contextPath}/images/mascot.png" alt="Mascot" class="mascot-img" />
      <span class="logo-text">TRAFFIC:ON</span>
    </div>

    <div class="header-right">
      <!-- TODO: 너네 로그아웃 URL에 맞게 바꾸기 -->
	  <a href="${pageContext.request.contextPath}/login" class="logout-btn">
	    <span>로그아웃</span>
	  </a>
    </div>
  </header>

  <main class="dashboard-main">
    <!-- LEFT: 지도 -->
    <div class="dashboard-card heatmap-card">
      <h2 class="card-title">📍 광주광역시 교통민원 분포</h2>

      <div class="map-container">
        <div class="gwangju-map-wrapper">
          <svg viewBox="0 0 500 480" class="gwangju-map-svg">
            <g class="districts">
              <path id="p-gwangsan"
                class="district-path gwangsan"
                d="M167.3,73.1 l15.7,2.2 l14.2,21.9 l-10.4,32.8 l30.6,41 c0,0,10.4,19.4,3.7,28.3 s-17.9,13.4-17.9,13.4 l-1.5,15.7 l-50.7,56 l-44,48.5 l-34.3,-4.5 l-11.2,-25.4 l32.8,-115.7 l29.9,-104.5 Z"
                data-district="광산구"
              />
              <path id="p-buk"
                class="district-path buk"
                d="M197.6,97.2 l48.5,-59.7 l106,35.1 l50.7,78.3 l4,56.7 l-62.7,42.5 l-8.2,35.1 l-58.2,-28.3 l-47.8,20.9 l-42.5,-38.8 l11.9,-132.8 Z"
                data-district="북구"
              />
              <path id="p-seo"
                class="district-path seo"
                d="M239.3,246.3 l47,40.3 l-29.8,71.6 l-82,18.6 l-20.9,-15.7 l28.4,-57.4 l-11.9,-41 l69.2,-16.4 Z"
                data-district="서구"
              />
              <path id="p-nam"
                class="district-path nam"
                d="M174,376.8 l82,-18.6 l35.8,51.5 l14.9,42.5 l-63,22.4 l-86,-25.4 l-32.8,-53.7 l49.1,-18.7 Z"
                data-district="남구"
              />
              <path id="p-dong"
                class="district-path dong"
                d="M286.3,286.6 l58.2,28.3 l17.9,-35.1 l62.7,-42.5 l40.3,123.8 l-48.5,88 l-104.5,-28.4 l-26.1,-134.1 Z"
                data-district="동구"
              />
            </g>

            <g class="district-labels" pointer-events="none">
              <text x="130" y="220" class="map-label">광산구</text>
              <text x="320" y="150" class="map-label">북구</text>
              <text x="235" y="325" class="map-label-sm">서구</text>
              <text x="230" y="420" class="map-label-sm">남구</text>
              <text x="360" y="350" class="map-label-sm">동구</text>
            </g>
          </svg>
        </div>
      </div>

      <div class="map-legend">
        <div class="legend-title">민원 발생 현황</div>
        <div class="legend-item">
          <span class="color-box color-high"></span><span>높음</span>
        </div>
        <div class="legend-item">
          <span class="color-box color-medium"></span><span>보통</span>
        </div>
        <div class="legend-item">
          <span class="color-box color-low"></span><span>낮음</span>
        </div>
      </div>
    </div>

    <!-- RIGHT: 키워드 + 통계 -->
    <div class="right-column">
      <div class="dashboard-card">
        <h2 class="card-title" id="kwTitle">📍 광산구 주요 교통불편 키워드</h2>
        <div class="keywords-list" id="keywordsList"></div>
      </div>

      <div class="dashboard-card">
        <div class="stats-container">
          <div class="stat-sub-card">
            <h3 class="sub-title">성별 비율</h3>

            <div class="pie-chart-wrapper">
              <div class="pie-chart" id="pieChart">
                <div class="pie-inner"></div>
              </div>

              <div>
                <div class="label-item male"><span>남</span><span id="malePct">0%</span></div>
                <div class="label-item female"><span>여</span><span id="femalePct">0%</span></div>
              </div>
            </div>
          </div>

          <div class="stat-sub-card">
            <h3 class="sub-title">연령대 분포</h3>
            <div class="bar-chart" id="ageChart"></div>
          </div>
        </div>
      </div>
    </div>
  </main>

  <!-- 사이드바 오버레이/사이드바 -->
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
        <li class="nav-item active" onclick="alert('지금은 대시보드부터! 사용자/게시판은 다음 단계에서 URL 연결하자 😎')">
          <span class="nav-icon">⊞</span>
          <span class="nav-text">대시보드</span>
        </li>
		<li class="nav-item">
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
  let selectedDistrict = "광산구";
  let isSidebarOpen = false;

  const districtData = {
    "광산구": {
      keywords: [
        { id: 1, text: "지하철 공사" }, { id: 6, text: "국토교통부" },
        { id: 2, text: "불법주차" }, { id: 7, text: "킥보드헬멧" },
        { id: 3, text: "장애인주차" }, { id: 8, text: "주차장" },
        { id: 4, text: "버스우회" }, { id: 9, text: "보도블럭" },
        { id: 5, text: "충장축제" }, { id: 10, text: "맨홀" }
      ],
      age: [
        { label: "10대", value: 5 }, { label: "20대", value: 23 },
        { label: "30대", value: 57 }, { label: "40대", value: 71, highlight: true },
        { label: "50대 이상", value: 39 }
      ],
      gender: { male: 25, female: 75 }
    },
    "북구": {
      keywords: [
        { id: 1, text: "어린이 보호구역" }, { id: 6, text: "신호등 미작동" },
        { id: 2, text: "과속 방지턱" }, { id: 7, text: "야간 도로 조명" },
        { id: 3, text: "버스 전용 차로" }, { id: 8, text: "화물차 주차" },
        { id: 4, text: "교량 보수" }, { id: 9, text: "중앙 분리대" },
        { id: 5, text: "우회전 사고" }, { id: 10, text: "버스 정류장" }
      ],
      age: [
        { label: "10대", value: 8 }, { label: "20대", value: 35, highlight: true },
        { label: "30대", value: 42 }, { label: "40대", value: 45 },
        { label: "50대 이상", value: 52 }
      ],
      gender: { male: 48, female: 52 }
    },
    "서구": {
      keywords: [
        { id: 1, text: "백화점 주변 정체" }, { id: 6, text: "유턴 구역 확보" },
        { id: 2, text: "터미널 혼잡" }, { id: 7, text: "이륜차 폭주" },
        { id: 3, text: "도로 파손" }, { id: 8, text: "가로수 정비" },
        { id: 4, text: "빗물받이 막힘" }, { id: 9, text: "스마트 횡단보도" },
        { id: 5, text: "택시 승강장" }, { id: 10, text: "좌회전 신호" }
      ],
      age: [
        { label: "10대", value: 12 }, { label: "20대", value: 28 },
        { label: "30대", value: 65, highlight: true }, { label: "40대", value: 52 },
        { label: "50대 이상", value: 31 }
      ],
      gender: { male: 55, female: 45 }
    },
    "남구": {
      keywords: [
        { id: 1, text: "양림동 주차난" }, { id: 6, text: "일방통행 해제" },
        { id: 2, text: "골목길 과속" }, { id: 7, text: "고령자 보호구역" },
        { id: 3, text: "원룸촌 불법투기" }, { id: 8, text: "자전거 도로" },
        { id: 4, text: "언덕길 낙상위험" }, { id: 9, text: "교통 안내판" },
        { id: 5, text: "등굣길 안전" }, { id: 10, text: "CCTV 확충" }
      ],
      age: [
        { label: "10대", value: 15 }, { label: "20대", value: 18 },
        { label: "30대", value: 25 }, { label: "40대", value: 38 },
        { label: "50대 이상", value: 68, highlight: true }
      ],
      gender: { male: 42, female: 58 }
    },
    "동구": {
      keywords: [
        { id: 1, text: "국립아시아문화전당" }, { id: 6, text: "대중교통 환승" },
        { id: 2, text: "로터리 진입" }, { id: 7, text: "금남로 차 없는 거리" },
        { id: 3, text: "지하상가 환기" }, { id: 8, text: "관광버스 주차" },
        { id: 4, text: "보행자 우선도로" }, { id: 9, text: "전기차 충전소" },
        { id: 5, text: "불법 적치물" }, { id: 10, text: "포트홀 신고" }
      ],
      age: [
        { label: "10대", value: 4 }, { label: "20대", value: 52, highlight: true },
        { label: "30대", value: 38 }, { label: "40대", value: 25 },
        { label: "50대 이상", value: 21 }
      ],
      gender: { male: 50, female: 50 }
    }
  };

  function setActiveDistrictPath(district) {
    document.querySelectorAll(".district-path").forEach(p => p.classList.remove("active"));
    const map = { "광산구":"p-gwangsan", "북구":"p-buk", "서구":"p-seo", "남구":"p-nam", "동구":"p-dong" };
    const id = map[district];
    if (id) document.getElementById(id).classList.add("active");
  }

  function renderKeywords(data) {
    const el = document.getElementById("keywordsList");
    el.innerHTML = "";
    data.keywords.forEach((kw, idx) => {
      const item = document.createElement("div");
      item.className = "keyword-item";
      item.innerHTML = `
        <div class="kw-left">
          <span class="rank-num">${idx + 1}</span>
          <span class="kw-text">${kw.text}</span>
        </div>
      `;
      el.appendChild(item);
    });
  }

  function renderGender(data) {
    const male = data.gender.male;
    const female = data.gender.female;
    document.getElementById("malePct").textContent = male + "%";
    document.getElementById("femalePct").textContent = female + "%";

    const pie = document.getElementById("pieChart");
    // 기존 CSS에서 conic-gradient 색상 쓰는 경우 이 부분만 유지하면 됨
    pie.style.background = `conic-gradient(#5c85fd 0% ${male}%, #ff8a65 ${male}% 100%)`;
  }

  function renderAge(data) {
    const el = document.getElementById("ageChart");
    el.innerHTML = "";
    data.age.forEach(d => {
      const wrap = document.createElement("div");
      wrap.className = "bar-wrapper";

      const bar = document.createElement("div");
      bar.className = "bar" + (d.highlight ? " highlight" : "");
      bar.style.height = (d.value * 2.5) + "px";
      bar.innerHTML = `<span class="bar-percent">${d.value}%</span>`;

      const label = document.createElement("span");
      label.className = "bar-label";
      label.textContent = d.label;

      wrap.appendChild(bar);
      wrap.appendChild(label);
      el.appendChild(wrap);
    });
  }

  function renderAll() {
    const data = districtData[selectedDistrict];
    document.getElementById("kwTitle").textContent = `📍 ${selectedDistrict} 주요 교통불편 키워드`;
    setActiveDistrictPath(selectedDistrict);
    renderKeywords(data);
    renderGender(data);
    renderAge(data);
  }

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

  document.querySelectorAll(".district-path").forEach(path => {
    path.addEventListener("click", (e) => {
      selectedDistrict = e.target.dataset.district;
      renderAll();
    });
  });

  renderAll();
</script>
</body>
</html>