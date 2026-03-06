<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>TRAFFIC:ON - 민원유형 가이드</title>

  <jsp:include page="/WEB-INF/views/common/head.jsp" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/guide.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/QuickButton.css" />
</head>

<body>

  <!-- 퀵버튼 -->
  <div class="quick-btn-layer">
    <button class="v3-quick-btn-icon-only" onclick="location.href='${pageContext.request.contextPath}/chat'">
      <div class="v3-quick-icon-inner">
        <img
          src="${pageContext.request.contextPath}/images/Pengrimi.png"
          alt="펭리미"
          class="v3-quick-char-img-large"
        />
        <span class="v3-quick-badge-ai">AI</span>
      </div>
    </button>
  </div>

  <div class="mobile-wrap">

    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <div class="main-layout">
      <div class="guide-container">

        <div class="category-scroll">
          <button class="category-item active" type="button" data-target="sec-traffic-safety">
            <span class="circle">🛡️</span><span class="label">교통안전</span>
          </button>

          <button class="category-item" type="button" data-target="sec-road-facility">
            <span class="circle">🛣️</span><span class="label">도로시설관리</span>
          </button>

          <button class="category-item" type="button" data-target="sec-parking-order">
            <span class="circle">🅿️</span><span class="label">주정차/질서</span>
          </button>

          <button class="category-item" type="button" data-target="sec-traffic-flow">
            <span class="circle">🚗</span><span class="label">교통흐름</span>
          </button>

          <button class="category-item" type="button" data-target="sec-public-transport">
            <span class="circle">🚌</span><span class="label">대중교통</span>
          </button>

          <button class="category-item" type="button" data-target="sec-pedestrian">
            <span class="circle">🚶</span><span class="label">보행·약자</span>
          </button>

          <button class="category-item" type="button" data-target="sec-life">
            <span class="circle">🏠</span><span class="label">생활환경</span>
          </button>
        </div>

        <section class="guide-section" id="sec-traffic-safety">
          <h2 class="section-title">교통안전</h2>

          <h3 class="sub-title">신호·표지 안전</h3>
          <div class="grid">
            <div class="card">
              <h4 class="card-title">신호등 고장 / 점멸 오류</h4>
              <p class="card-desc">신호등이 작동하지 않거나 비정상적으로 점멸되어 교차로 안전을 위협하는 경우</p>
              <img class="card-img" src="${pageContext.request.contextPath}/images/traffic_light_error.png" alt="signal_error">
            </div>

            <div class="card">
              <h4 class="card-title">신호 주기 부적절</h4>
              <p class="card-desc">신호 변경 시간이 실제 교통량과 맞지 않아 혼잡이나 사고 위험이 발생하는 경우</p>
              <img class="card-img" src="${pageContext.request.contextPath}/images/signal_timing_issue.png" alt="signal_timing_issue">
            </div>

            <div class="card">
              <h4 class="card-title">교통표지판 훼손·가림</h4>
              <p class="card-desc">표지판이 파손되거나 나무·시설물에 가려 식별이 어려운 경우</p>
              <img class="card-img" src="${pageContext.request.contextPath}/images/traffic_sign_damaged.png" alt="traffic_sign_damaged">
            </div>

            <div class="card">
              <h4 class="card-title">횡단보도 신호 인지 어려움</h4>
              <p class="card-desc">보행 신호등이 잘 보이지 않거나 인식이 어려운 경우</p>
              <img class="card-img" src="${pageContext.request.contextPath}/images/crosswalk_signal_issue.jpg" alt="crosswalk_signal_issue">
            </div>
          </div>

          <h3 class="sub-title">보행자 안전</h3>
          <div class="grid">
            <div class="card">
              <h4 class="card-title">무단횡단 위험 구간</h4>
              <p class="card-desc">보행 환경 문제로 무단횡단이 잦아 사고 위험이 높은 구간인 경우</p>
              <img class="card-img" src="${pageContext.request.contextPath}/images/jaywalking_risk.png" alt="jaywalking_risk">
            </div>

            <div class="card">
              <h4 class="card-title">횡단보도 미설치</h4>
              <p class="card-desc">보행 수요는 많으나 횡단보도 등 공식적인 횡단 시설이 설치되지 않은 경우</p>
              <img class="card-img" src="${pageContext.request.contextPath}/images/no_crosswalk.png" alt="no_crosswalk">
            </div>

            <div class="card">
              <h4 class="card-title">어린이보호구역 안전시설 부족</h4>
              <p class="card-desc">스쿨존 내 안전표지·방지턱 등 보행자 보호 시설이 부족한 경우</p>
              <img class="card-img" src="${pageContext.request.contextPath}/images/school_zone_issue.png" alt="school_zone_issue">
            </div>

            <div class="card">
              <h4 class="card-title">스쿨존 과속 위험</h4>
              <p class="card-desc">어린이보호구역에서 차량 과속으로 사고 위험이 높은 경우</p>
              <img class="card-img" src="${pageContext.request.contextPath}/images/school_zone_speeding.png" alt="school_zone_speeding">
            </div>
          </div>

          <h3 class="sub-title">도로 구조 안전</h3>
          <div class="grid">
            <div class="card">
              <h4 class="card-title">과속방지턱 설치·개선 요청</h4>
              <p class="card-desc">차량 속도 저감을 위한 방지턱 설치 또는 개선이 필요한 경우</p>
              <img class="card-img" src="${pageContext.request.contextPath}/images/speed_bump_request.png" alt="speed_bump_request">
            </div>

            <div class="card">
              <h4 class="card-title">시야 방해 구조물</h4>
              <p class="card-desc">교차로나 도로 주변 구조물로 인해 운전자 시야가 제한되는 경우</p>
              <img class="card-img" src="${pageContext.request.contextPath}/images/view_obstruction.png" alt="view_obstruction">
            </div>

            <div class="card">
              <h4 class="card-title">급커브·급경사 위험</h4>
              <p class="card-desc">도로 구조상 급한 커브나 경사로 사고 위험이 높은 경우</p>
              <img class="card-img" src="${pageContext.request.contextPath}/images/steep_curve_risk.png" alt="steep_curve_risk">
            </div>
          </div>
        </section>

        <!-- 나머지 section들은 기존 코드 그대로 유지 -->

      </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/bottomNav.jsp" />
  </div>

  <script>
    document.addEventListener("DOMContentLoaded", () => {
      const items = document.querySelectorAll(".category-item");
      const sections = document.querySelectorAll(".guide-section");

      function showSection(id) {
        sections.forEach(sec => {
          sec.style.display = (sec.id === id ? "block" : "none");
        });
        window.scrollTo({ top: 0, behavior: "smooth" });
      }

      items.forEach(btn => {
        btn.addEventListener("click", () => {
          items.forEach(x => x.classList.remove("active"));
          btn.classList.add("active");
          showSection(btn.dataset.target);
        });
      });

      showSection("sec-traffic-safety");
    });
  </script>

</body>
</html>