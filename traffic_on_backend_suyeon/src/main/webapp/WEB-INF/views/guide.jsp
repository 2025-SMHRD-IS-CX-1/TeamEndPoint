<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>민원유형 가이드</title>

  <jsp:include page="/WEB-INF/views/common/head.jsp" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/guide.css" />
</head>

<body>
	<div class="mobile-wrap">
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<div class="main-layout">
	<div class="guide-container">

  <!-- 가로 아이콘 메뉴 -->
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


  <!-- =========================
       교통안전
  ========================== -->
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


  <!-- =========================
       도로시설관리
  ========================== -->
  <section class="guide-section" id="sec-road-facility">
    <h2 class="section-title">도로시설관리</h2>

    <h3 class="sub-title">노면·구조물 파손</h3>
    <div class="grid">
      <div class="card">
        <h4 class="card-title">포트홀</h4>
        <p class="card-desc">도로 노면이 움푹 파여 차량 파손이나 사고 위험이 있는 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/pothole.png" alt="pothole">
      </div>

      <div class="card">
        <h4 class="card-title">도로 균열·침하</h4>
        <p class="card-desc">노면에 균열이나 내려앉음 현상이 발생한 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/road_crack.png" alt="road_crack">
      </div>

      <div class="card">
        <h4 class="card-title">맨홀 돌출</h4>
        <p class="card-desc">맨홀이 도로 위로 튀어나와 주행 안전을 해치는 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/manhole_protrusion.png" alt="manhole_protrusion">
      </div>

      <div class="card">
        <h4 class="card-title">교량·가드레일 파손</h4>
        <p class="card-desc">교량이나 가드레일이 파손되어 안전 기능을 상실한 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/guardrail_damage.png" alt="guardrail_damage">
      </div>
    </div>

    <h3 class="sub-title">차선·표시 관리</h3>
    <div class="grid">
      <div class="card">
        <h4 class="card-title">차선 마모</h4>
        <p class="card-desc">차선이 지워지거나 희미해져 구분이 어려운 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/road_marking_unclear.png" alt="road_marking_unclear">
      </div>

      <div class="card">
        <h4 class="card-title">노면 표시 불명확</h4>
        <p class="card-desc">정지선·유도 표시 등이 잘 보이지 않는 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/road_marking_unclear.png" alt="road_marking_unclear2">
      </div>

      <div class="card">
        <h4 class="card-title">유도선 오류</h4>
        <p class="card-desc">실제 도로 흐름과 맞지 않는 유도선으로 혼란이 발생하는 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/guideline_error.png" alt="guideline_error">
      </div>
    </div>

    <h3 class="sub-title">배수·기상 대응</h3>
    <div class="grid">
      <div class="card">
        <h4 class="card-title">빗물 고임</h4>
        <p class="card-desc">비가 올 때 도로 일부에 물이 고여 통행에 불편을 주는 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/water_puddle.png" alt="water_puddle">
      </div>

      <div class="card">
        <h4 class="card-title">침수 위험 도로</h4>
        <p class="card-desc">집중호우 때마다 도로가 잠겨 통행이 제한되거나 위험한 구간인 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/road_flooding.png" alt="road_flooding">
      </div>

      <div class="card">
        <h4 class="card-title">제설 미흡</h4>
        <p class="card-desc">눈이나 얼음이 제때 제거되지 않아 통행이 불편하거나 위험한 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/snow_removal_issue.png" alt="snow_removal_issue">
      </div>

      <div class="card">
        <h4 class="card-title">결빙 구간 관리 요청</h4>
        <p class="card-desc">겨울철마다 도로가 반복적으로 얼어 미끄럼 사고 위험이 높은 구간인 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/road_icing.png" alt="road_icing">
      </div>
    </div>
  </section>


  <!-- =========================
       주정차/질서
  ========================== -->
  <section class="guide-section" id="sec-parking-order">
    <h2 class="section-title">주정차/질서</h2>

    <h3 class="sub-title">불법 주정차</h3>
    <div class="grid">
      <div class="card">
        <h4 class="card-title">인도·횡단보도 불법 주차</h4>
        <p class="card-desc">보행 공간을 침해하는 불법 주차 행위</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/illegal_parking_crosswalk.png" alt="illegal_parking_crosswalk">
      </div>

      <div class="card">
        <h4 class="card-title">이중주차</h4>
        <p class="card-desc">차로를 막아 교통 흐름을 방해하는 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/double_parking.png" alt="double_parking">
      </div>

      <div class="card">
        <h4 class="card-title">버스정류장 앞 주차</h4>
        <p class="card-desc">대중교통 이용에 불편을 주는 불법 주차</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/bus_stop_parking.png" alt="bus_stop_parking">
      </div>

      <div class="card">
        <h4 class="card-title">소방시설 주변 주차</h4>
        <p class="card-desc">화재 대응을 방해하는 위험한 주차 행위</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/fire_hydrant_parking.png" alt="fire_hydrant_parking">
      </div>
    </div>

    <h3 class="sub-title">교통법규 위반</h3>
    <div class="grid">
      <div class="card">
        <h4 class="card-title">불법 유턴·좌회전</h4>
        <p class="card-desc">허용되지 않은 방향 전환으로 사고 위험이 있는 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/illegal_u_turn.png" alt="illegal_u_turn">
      </div>

      <div class="card">
        <h4 class="card-title">신호위반</h4>
        <p class="card-desc">교차로 신호를 지키지 않는 차량으로 위험이 발생하는 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/signal_violation.png" alt="signal_violation">
      </div>

      <div class="card">
        <h4 class="card-title">과속</h4>
        <p class="card-desc">제한 속도를 초과해 주행하는 행위</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/speeding.png" alt="speeding">
      </div>

      <div class="card">
        <h4 class="card-title">버스전용차로 위반</h4>
        <p class="card-desc">일반 차량이 버스전용차로를 이용하는 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/bus_lane_violation.png" alt="bus_lane_violation">
      </div>
    </div>
  </section>


  <!-- =========================
       교통흐름
  ========================== -->
  <section class="guide-section" id="sec-traffic-flow">
    <h2 class="section-title">교통흐름</h2>

    <h3 class="sub-title">상습 정체</h3>
    <div class="grid">
      <div class="card">
        <h4 class="card-title">출퇴근 시간 혼잡</h4>
        <p class="card-desc">출퇴근 시간대 교통량 집중으로 교통 흐름 개선이 필요한 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/rush_hour_traffic.png" alt="rush_hour_traffic">
      </div>

      <div class="card">
        <h4 class="card-title">병목 구간</h4>
        <p class="card-desc">도로 구조로 인해 차량 흐름이 막히는 구간</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/bottleneck.png" alt="bottleneck">
      </div>

      <div class="card">
        <h4 class="card-title">공사로 인한 정체</h4>
        <p class="card-desc">도로 공사로 교통 혼잡이 발생하는 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/construction_traffic.png" alt="construction_traffic">
      </div>
    </div>

    <h3 class="sub-title">차로 운영 문제</h3>
    <div class="grid">
      <div class="card">
        <h4 class="card-title">좌·우회전 차로 부족</h4>
        <p class="card-desc">회전 차량을 수용할 충분한 차로가 확보되지 않은 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/turn_lane_shortage.png" alt="turn_lane_shortage">
      </div>

      <div class="card">
        <h4 class="card-title">유턴 차로 미흡</h4>
        <p class="card-desc">유턴 공간이 부족하거나 설계가 적절하지 않은 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/u_turn_lane_issue.png" alt="u_turn_lane_issue">
      </div>

      <div class="card">
        <h4 class="card-title">회전교차로 혼잡</h4>
        <p class="card-desc">회전교차로에서 차량 흐름이 원활하지 않은 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/roundabout_congestion.png" alt="roundabout_congestion">
      </div>
    </div>
  </section>


  <!-- =========================
       대중교통
  ========================== -->
  <section class="guide-section" id="sec-public-transport">
    <h2 class="section-title">대중교통</h2>

    <h3 class="sub-title">버스 관련</h3>
    <div class="grid">
      <div class="card">
        <h4 class="card-title">정류장 위치 부적절</h4>
        <p class="card-desc">이용 동선이나 교통 흐름에 맞지 않는 정류장 위치</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/bus_stop_location.png" alt="bus_stop_location">
      </div>

      <div class="card">
        <h4 class="card-title">버스전용차로 관리</h4>
        <p class="card-desc">전용차로 관리 미흡으로 버스 운행에 지장이 있는 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/bus_lane_management.png" alt="bus_lane_management">
      </div>

      <div class="card">
        <h4 class="card-title">버스 우회</h4>
        <p class="card-desc">공사·축제·행사 등으로 잦은 노선 변경이 발생하는 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/bus_detour.png" alt="bus_detour">
      </div>

      <div class="card">
        <h4 class="card-title">버스 우회</h4>
        <p class="card-desc">노선 변경 안내 부족 등으로 불편이 발생하는 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/bys_detour.png" alt="bys_detour">
      </div>
    </div>
  </section>


  <!-- =========================
       보행·약자
  ========================== -->
  <section class="guide-section" id="sec-pedestrian">
    <h2 class="section-title">보행·약자</h2>

    <h3 class="sub-title">보행환경</h3>
    <div class="grid">
      <div class="card">
        <h4 class="card-title">인도 폭 협소</h4>
        <p class="card-desc">보행자 통행에 필요한 폭이 확보되지 않은 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/narrow_sidewalk.png" alt="narrow_sidewalk">
      </div>

      <div class="card">
        <h4 class="card-title">보도블록 파손</h4>
        <p class="card-desc">보도블록이 깨지거나 들떠 보행 안전을 해치는 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/broken_pavement.png" alt="broken_pavement">
      </div>

      <div class="card">
        <h4 class="card-title">가로수·시설물 통행 방해</h4>
        <p class="card-desc">나무나 시설물로 인해 보행이 어려운 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/obstacle_on_sidewalk.png" alt="obstacle_on_sidewalk">
      </div>
    </div>

    <h3 class="sub-title">교통약자 배려</h3>
    <div class="grid">
      <div class="card">
        <h4 class="card-title">휠체어·유모차 이동 불가</h4>
        <p class="card-desc">단차·턱·구조물 등으로 통행이 어려운 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/wheelchair_access_issue.png" alt="wheelchair_access_issue">
      </div>

      <div class="card">
        <h4 class="card-title">점자블록 미설치·훼손</h4>
        <p class="card-desc">시각장애인을 위한 점자블록이 없거나 파손된 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/braille_block_issue.png" alt="braille_block_issue">
      </div>

      <div class="card">
        <h4 class="card-title">노약자 사고 위험 구간</h4>
        <p class="card-desc">노인 보행자 사고 위험이 높은 지역</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/elderly_safety_zone.png" alt="elderly_safety_zone">
      </div>
    </div>
  </section>


  <!-- =========================
       생활환경
  ========================== -->
  <section class="guide-section" id="sec-life">
    <h2 class="section-title">생활환경</h2>

    <h3 class="sub-title">소음·매연</h3>
    <div class="grid">
      <div class="card">
        <h4 class="card-title">차량 소음</h4>
        <p class="card-desc">차량 통행으로 지속적인 소음이 발생하는 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/vehicle_noise.png" alt="vehicle_noise">
      </div>

      <div class="card">
        <h4 class="card-title">오토바이 소음</h4>
        <p class="card-desc">이륜차 배기음 등으로 생활 소음 피해가 발생하는 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/motorcyle_noise.png" alt="motorcycle_noise">
      </div>

      <div class="card">
        <h4 class="card-title">배기가스</h4>
        <p class="card-desc">차량 매연으로 인한 냄새·시야 방해 등 시민 불편이 발생하는 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/vhicle_exhaust.png" alt="vehicle_exhaust">
      </div>
    </div>

    <h3 class="sub-title">공사·작업 불편</h3>
    <div class="grid">
      <div class="card">
        <h4 class="card-title">공사 차량 통행 불편</h4>
        <p class="card-desc">공사 차량 이동으로 교통 혼잡·통행 불편이 발생하는 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/construction_vehicle_issue.png" alt="construction_vehicle_issue">
      </div>

      <div class="card">
        <h4 class="card-title">먼지·소음</h4>
        <p class="card-desc">공사로 발생하는 분진과 소음으로 인해 주민 생활에 불편이 발생하는 경우</p>
        <img class="card-img" src="${pageContext.request.contextPath}/images/construction_dust_noise.png" alt="construction_dust_noise">
      </div>
    </div>
  </section>

</div>

<!-- ✅ 클릭 시 해당 유형만 보이게 -->
<script>
document.addEventListener("DOMContentLoaded", () => {
  const items = document.querySelectorAll(".category-item");
  const sections = document.querySelectorAll(".guide-section");

  function showSection(id){
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
</div>
<jsp:include page="/WEB-INF/views/common/bottomNav.jsp" />
</div>
</body>
</html>