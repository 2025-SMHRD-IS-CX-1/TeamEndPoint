<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--
  ApplicationProcessPage.jsp
  민원 신청 절차 안내 페이지

  Request attributes:
    - isLoggedIn (Boolean) : 로그인 여부
--%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/ApplicationProcessPage.css" />
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>

<div class="v3-process-container${not isLoggedIn ? ' not-logged-in' : ''}" id="processContainer">

    <%-- 상단 탭바 --%>
    <div class="v3-tab-bar">
        <div class="v3-tab-item active" id="tab-police24"
             onclick="switchService('police24')" style="cursor:pointer;">
            <div class="v3-tab-icon-circle" id="circle-police24">
                <img src="${pageContext.request.contextPath}/images/logo_efines.png"
                     alt="교통민원24" class="v3-tab-logo-img" />
            </div>
            <span class="v3-tab-text">교통민원24</span>
        </div>
        <div class="v3-tab-item" id="tab-sinmungo"
             onclick="switchService('sinmungo')" style="cursor:pointer;">
            <div class="v3-tab-icon-circle" id="circle-sinmungo">
                <img src="${pageContext.request.contextPath}/images/logo_epeople.png"
                     alt="국민신문고" class="v3-tab-logo-img" />
            </div>
            <span class="v3-tab-text">국민신문고</span>
        </div>
        <div class="v3-tab-item" id="tab-safety"
             onclick="switchService('safety')" style="cursor:pointer;">
            <div class="v3-tab-icon-circle" id="circle-safety">
                <img src="${pageContext.request.contextPath}/images/logo_safety.png"
                     alt="안전신문고" class="v3-tab-logo-img" />
            </div>
            <span class="v3-tab-text">안전신문고</span>
        </div>
        <div class="v3-tab-item" id="tab-gwangju"
             onclick="switchService('gwangju')" style="cursor:pointer;">
            <div class="v3-tab-icon-circle" id="circle-gwangju">
                <img src="${pageContext.request.contextPath}/images/logo_gwangju.png"
                     alt="광주광역시" class="v3-tab-logo-img" />
            </div>
            <span class="v3-tab-text">광주광역시</span>
        </div>
    </div>

    <div class="v3-page-body">

        <%-- 인트로 --%>
        <div class="v3-intro-section">
            <img src="" alt="로고" class="v3-intro-logo-img" id="introLogo" />
            <span class="v3-intro-underline" id="introTitle">교통민원24 접수는 다음 절차에 따라 진행됩니다.</span>
        </div>

        <%-- 플로우 맵 --%>
        <div class="v3-flow-map" id="flowMap">
            <!-- JavaScript로 동적 렌더링 -->
        </div>

        <%-- 로그인 여부에 따른 하단 영역 --%>
        <c:choose>
            <c:when test="${isLoggedIn}">
                <div class="v3-external-section">
                    <a href="#" id="officialLink" class="v3-official-link"
                       target="_blank" rel="noopener noreferrer">
                        🔗 <u id="officialLinkText">교통민원24 공식 사이트 바로가기</u>
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="v3-login-invitation">
                    <div class="invitation-box">
                        <p>더욱 상세한 정보나<br />민원 사이트 연결은</p>
                        <h3>로그인 후</h3>
                        <p>이용 가능한 서비스 입니다 !</p>
                        <button class="v3-login-btn-process"
                                onclick="window.openLoginModal()">
                            로그인하러 가기
                        </button>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

    </div>
    <div class="v3-bottom-padding"></div>
</div>

<script>
(function () {
    lucide.createIcons();

    var ctx = '${pageContext.request.contextPath}';

    var services = {
        police24: {
            name: '교통민원24', color: '#ff6b35',
            logo: ctx + '/assets/logos/logo_efines.png',
            url: 'https://www.efine.go.kr',
            steps: ['교통민원24 접속','로그인(본인인증)','신고할 민원 선택','상황 정보 입력','증빙 자료 업로드','신청 제출','접수 번호 확인','처리 결과 확인'],
            types: ['🚗 1. 불법 주정차','🚦 2. 교통 위협 행위','🏗️ 3. 도로·시설 불편','📝 4. 기타 교통 민원'],
            uploads: ['📷 현장 사진 / 영상','🏎️ 블랙박스 영상','🔢 차량 번호 식별 가능','📍 위치 확인 자료']
        },
        sinmungo: {
            name: '국민신문고', color: '#3b82f6',
            logo: ctx + '/assets/logos/logo_epeople.png',
            url: 'https://www.epeople.go.kr',
            steps: ['국민신문고 접속','로그인','신청서 작성','유사사례 검토','처리기관 선택 및 제출','접수','처리','만족도 조사'],
            types: ['📋 일반 민원','💡 제안/건의','⚖️ 부패/공익 신고','🛡️ 적극행정 국민신청'],
            uploads: ['📂 관련 서류','📸 현장 사진','🎬 참고 동영상','📄 기타 증빙']
        },
        safety: {
            name: '안전신문고', color: '#10b981',
            logo: ctx + '/assets/logos/logo_safety.png',
            url: 'https://www.safetyreport.go.kr',
            steps: ['안전신문고 접속','신고할 분류 선택','신고 유형 선택','증빙 사진·동영상','신고 내용 작성','처리기관 분류','위험해소','처리 결과 통보'],
            types: ['⚠️ 도로·시설 파손','⚡ 위험 구역','🔥 소방 시설 장애','🚲 기타 위험 요소'],
            uploads: ['🎥 동영상(필수권장)','📸 현장 사진','📍 주소지 확인 가능']
        },
        gwangju: {
            name: '광주광역시', color: '#f59e0b',
            logo: ctx + '/assets/logos/logo_gwangju.png',
            url: 'https://baroeungdab.gwangju.go.kr',
            steps: ['바로응답 접속','민원 작성 및 본인인증','신청서 작성','접수 번호 발급','주관 부서 및 담당자 배정','접수','처리','사후관리 및 만족도 평가'],
            types: ['🏙️ 시정 불편 사항','🛠️ 공공시설 보수','🌳 가로수/조경 관리','📢 정책 제안'],
            uploads: ['📷 위치 이미지','🎬 불편 상황 영상','🗺️ 지도 캡처본']
        }
    };

    var activeId = 'police24';
    var isLoggedIn = '${isLoggedIn}' === 'true';

    function makeArrowH(color, flip) {
        return '<div class="v3-arrow-horizontal' + (flip ? ' flip-h' : '') + '" style="color:' + color + '">'
            + '<div class="v3-h-lines" style="border-color:' + color + '">'
            + '<div class="v3-h-line-center" style="background-color:' + color + '"></div></div>'
            + '<div class="v3-h-triangle" style="border-left-color:' + color + '"></div>'
            + '</div>';
    }

    function makeArrowV(color, align) {
        return '<div class="v3-arrow-vertical-row ' + align + '">'
            + '<div class="v3-v-arrow-unit" style="color:' + color + '">'
            + '<div class="v3-v-lines" style="border-color:' + color + '">'
            + '<div class="v3-v-line-center" style="background-color:' + color + '"></div></div>'
            + '<div class="v3-v-triangle" style="border-top-color:' + color + '"></div>'
            + '</div></div>';
    }

    function makeStep(color, text) {
        return '<div class="v3-step-unit">'
            + '<div class="v3-step-box" style="border-color:' + color + '">' + text + '</div>'
            + '</div>';
    }

    function makeBubble(title, items, tailClass, sideClass, blurred) {
        var blurCls = blurred ? ' is-blurred' : '';
        var html = '<div class="v3-guide-bubble-v3 ' + sideClass + blurCls + '">'
            + '<div class="v3-bubble-header">' + title + '</div>'
            + '<ul class="v3-bubble-list">';
        items.forEach(function(i){ html += '<li>' + i + '</li>'; });
        html += '</ul><div class="v3-bubble-tail-v3 ' + tailClass + '"></div></div>';
        return html;
    }

    function renderFlow(svc) {
        var c = svc.color;
        var s = svc.steps;
        var blurred = !isLoggedIn;
        var html = '';

        // Row 1: Step 0 → Step 1
        html += '<div class="v3-flow-row">' + makeStep(c, s[0]) + makeArrowH(c, false) + makeStep(c, s[1]) + '</div>';
        // Arrow down right
        html += makeArrowV(c, 'align-right');
        // Row 2: Guide bubble + Step 2
        html += '<div class="v3-flow-row justify-end">'
            + makeBubble('📌 민원 유형 예시', svc.types, '', 'left-side', blurred)
            + makeStep(c, s[2]) + '</div>';
        // Arrow down left
        html += makeArrowV(c, 'align-left');
        // Row 3: Step 3 → Step 4
        html += '<div class="v3-flow-row">' + makeStep(c, s[3]) + makeArrowH(c, false) + makeStep(c, s[4]) + '</div>';
        // Upload guide bubble (no gap)
        html += '<div class="v3-flow-row justify-end no-gap">'
            + makeBubble('📎 업로드 가능 자료', svc.uploads, 'right', 'right-side', blurred)
            + '</div>';
        // Arrow down right
        html += makeArrowV(c, 'align-right');
        // Row 4: Step 5 & 6 (reverse)
        html += '<div class="v3-flow-row row-reverse">' + makeStep(c, s[5]) + makeArrowH(c, true) + makeStep(c, s[6]) + '</div>';
        // Arrow down left
        html += makeArrowV(c, 'align-left');
        // Row 5: Step 7
        html += '<div class="v3-flow-row justify-start">' + makeStep(c, s[7]) + '</div>';

        return html;
    }

    window.switchService = function (id) {
        var svc = services[id];
        if (!svc) return;
        activeId = id;

        // 탭 active 처리
        Object.keys(services).forEach(function(k) {
            var tab = document.getElementById('tab-' + k);
            var circle = document.getElementById('circle-' + k);
            if (tab) tab.classList.remove('active');
            if (circle) circle.style.borderColor = '';
        });
        var activeTab = document.getElementById('tab-' + id);
        var activeCircle = document.getElementById('circle-' + id);
        if (activeTab) activeTab.classList.add('active');
        if (activeCircle) activeCircle.style.borderColor = svc.color;

        // 인트로 로고/텍스트
        var introLogo = document.getElementById('introLogo');
        if (introLogo) { introLogo.src = svc.logo; introLogo.alt = svc.name; }
        var introTitle = document.getElementById('introTitle');
        if (introTitle) introTitle.textContent = svc.name + ' 접수는 다음 절차에 따라 진행됩니다.';

        // 플로우맵
        var flowMap = document.getElementById('flowMap');
        if (flowMap) flowMap.innerHTML = renderFlow(svc);

        // 공식링크 (로그인 시)
        var officialLink = document.getElementById('officialLink');
        var officialLinkText = document.getElementById('officialLinkText');
        if (officialLink) { officialLink.href = svc.url; officialLink.style.color = svc.color; }
        if (officialLinkText) officialLinkText.textContent = svc.name + ' 공식 사이트 바로가기';
    };

    // 초기 렌더
    switchService('police24');
})();
</script>
