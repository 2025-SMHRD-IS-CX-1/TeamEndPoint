<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
    <title>TRAFFIC:ON - 신청절차 안내</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ApplicationProcessPage.css">
</head>

<body>
    
    <%
    Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
    %>

<div class="mobile-layout-container">
<div class="mobile-layout-content">

<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="view-content">

<div class="v3-process-container">

    <div class="v3-page-body">

    <div class="v3-intro-section">
        <img src="/images/logo_efines.png" class="v3-intro-logo-img">
        <span class="v3-intro-underline">교통민원24 접수는 다음 절차에 따라 진행됩니다.</span>
    </div>

    <div class="v3-flow-map">

    <div class="v3-flow-row">
        <div class="v3-step-unit">
            <div class="v3-step-box">1 교통민원24 접속</div>
        </div>

        <div class="v3-arrow-horizontal">
            <div class="v3-h-lines">
                <div class="v3-h-line-center"></div>
            </div>
            <div class="v3-h-triangle"></div>
        </div>

        <div class="v3-step-unit">
            <div class="v3-step-box">2 로그인(본인인증)</div>
        </div>
    </div>

    <div class="v3-arrow-vertical-row align-right">
        <div class="v3-v-arrow-unit">
            <div class="v3-v-lines">
                <div class="v3-v-line-center"></div>
            </div>
            <div class="v3-v-triangle"></div>
        </div>
    </div>

    <div class="v3-flow-row justify-end">
        <div class="v3-step-unit">
            <div class="v3-step-box">3 신고할 민원 선택</div>
        </div>
    </div>

    <div class="v3-arrow-vertical-row align-left">
        <div class="v3-v-arrow-unit">
            <div class="v3-v-lines">
                <div class="v3-v-line-center"></div>
            </div>
            <div class="v3-v-triangle"></div>
        </div>
    </div>

    <div class="v3-flow-row">
        <div class="v3-step-unit">
            <div class="v3-step-box">4 상황 정보 입력</div>
        </div>

        <div class="v3-arrow-horizontal">
            <div class="v3-h-lines">
                <div class="v3-h-line-center"></div>
            </div>
            <div class="v3-h-triangle"></div>
        </div>

        <div class="v3-step-unit">
            <div class="v3-step-box">5 증빙 자료 업로드</div>
        </div>
    </div>

    <div class="v3-arrow-vertical-row align-right">
        <div class="v3-v-arrow-unit">
            <div class="v3-v-lines">
                <div class="v3-v-line-center"></div>
            </div>
            <div class="v3-v-triangle"></div>
        </div>
    </div>

    <div class="v3-flow-row row-reverse">
        <div class="v3-step-unit">
            <div class="v3-step-box">6 신청 제출</div>
        </div>

        <div class="v3-arrow-horizontal flip-h">
            <div class="v3-h-lines">
                <div class="v3-h-line-center"></div>
            </div>
            <div class="v3-h-triangle"></div>
        </div>

        <div class="v3-step-unit">
            <div class="v3-step-box">7 접수 번호 확인</div>
        </div>
    </div>

    <div class="v3-arrow-vertical-row align-left">
        <div class="v3-v-arrow-unit">
            <div class="v3-v-lines">
                <div class="v3-v-line-center"></div>
            </div>
            <div class="v3-v-triangle"></div>
        </div>
    </div>

    <div class="v3-flow-row justify-start">
        <div class="v3-step-unit">
            <div class="v3-step-box">8 처리 결과 확인</div>
        </div>
    </div>

    </div>
    </div>

<div class="v3-login-invitation">

<div class="invitation-box">

<p>더욱 상세한 정보나<br>민원 사이트 연결은</p>

<h3>로그인 후</h3>

<p>이용 가능한 서비스 입니다 !</p>

<button class="v3-login-btn-process"
onclick="location.href='/login'">
로그인하러 가기
</button>

</div>

</div>

</div>

</div>

</div>

<jsp:include page="/WEB-INF/views/common/bottomNav.jsp"/>

</div>
</div>

</body>
</html>