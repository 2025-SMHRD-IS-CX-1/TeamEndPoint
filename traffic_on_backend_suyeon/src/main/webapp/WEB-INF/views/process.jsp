<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>TRAFFIC:ON - 신청절차 안내</title>
    <jsp:include page="/WEB-INF/views/common/head.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ApplicationProcessPage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/QuickButton.css">

    <style>
        .clickable-step {
            cursor: pointer;
            transition: transform 0.15s ease, box-shadow 0.15s ease;
        }

        .clickable-step:active {
            transform: scale(0.98);
        }

        .toggle-detail {
            display: none;
        }

        .step-detail-box {
            width: 100%;
            margin: 10px 0 14px;
            background: #fff7ef;
            border: 1px solid #f3d8bf;
            border-radius: 18px;
            padding: 14px 16px;
            box-sizing: border-box;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }

        .step-detail-box h4 {
            margin: 0 0 10px;
            font-size: 14px;
            font-weight: 900;
            color: #222;
        }

        .step-detail-box ul {
            margin: 0;
            padding-left: 18px;
        }

        .step-detail-box li {
            font-size: 13px;
            font-weight: 700;
            color: #444;
            line-height: 1.6;
            margin-bottom: 2px;
        }
    </style>
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

    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="process-page-wrap">

        <!-- 상단 민원창구 아이콘바 -->
        <div class="process-portal-bar">
            <button type="button" class="portal-item active portal-traffic24" data-portal="traffic24">
                <div class="portal-icon-circle">
                    <img src="${pageContext.request.contextPath}/images/icon1.png" alt="교통민원24">
                </div>
                <span>교통민원24</span>
            </button>

            <button type="button" class="portal-item portal-epeople" data-portal="epeople">
                <div class="portal-icon-circle">
                    <img src="${pageContext.request.contextPath}/images/icon2.png" alt="국민신문고">
                </div>
                <span>국민신문고</span>
            </button>

            <button type="button" class="portal-item portal-safety" data-portal="safety">
                <div class="portal-icon-circle">
                    <img src="${pageContext.request.contextPath}/images/icon3.png" alt="안전신문고">
                </div>
                <span>안전신문고</span>
            </button>

            <button type="button" class="portal-item portal-gwangju" data-portal="gwangju">
                <div class="portal-icon-circle">
                    <img src="${pageContext.request.contextPath}/images/icon4.png" alt="광주광역시">
                </div>
                <span>광주광역시</span>
            </button>
        </div>

        <div class="process-content-area">

            <!-- =========================
                 1. 교통민원24
            ========================== -->
            <section class="portal-process active" id="traffic24">
                <div class="process-title-row traffic24">
                    <img src="${pageContext.request.contextPath}/images/icon1.png" alt="교통민원24">
                    <h2>교통민원24 접수는 다음 절차에 따라 진행됩니다.</h2>
                </div>

                <div class="process-flow traffic24">
                    <!-- 1줄 -->
                    <div class="flow-row">
                        <div class="step-box">교통민원24 접속</div>
                        <div class="arrow right"></div>
                        <div class="step-box">로그인(본인인증)</div>
                    </div>

                    <div class="arrow-down right-side"></div>

                    <!-- 2줄 -->
                    <div class="flow-row row-reverse">
                        <c:choose>
                            <c:when test="${isLoggedIn}">
                                <div class="step-box clickable-step"
                                     onclick="toggleDetail('traffic24ComplaintDetail', ['traffic24ComplaintDetail','traffic24UploadDetail'])">
                                    신고할 민원 선택
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="step-box">신고할 민원 선택</div>
                            </c:otherwise>
                        </c:choose>

                        <div class="arrow left"></div>
                        <div class="step-box">상황 정보 입력</div>
                    </div>

                    <c:if test="${isLoggedIn}">
                        <div id="traffic24ComplaintDetail" class="step-detail-box toggle-detail">
                            <h4>📌 민원 유형 예시</h4>
                            <ul>
                                <li>🚗 1. 불법 주정차</li>
                                <li>🚦 2. 교통 위험 행위</li>
                                <li>🎓 3. 도로 시설 불편</li>
                                <li>🛣️ 4. 기타 교통민원</li>
                            </ul>
                        </div>
                    </c:if>

                    <div class="arrow-down left-side"></div>

                    <!-- 3줄 -->
                    <div class="flow-row">
                        <c:choose>
                            <c:when test="${isLoggedIn}">
                                <div class="step-box clickable-step"
                                     onclick="toggleDetail('traffic24UploadDetail', ['traffic24ComplaintDetail','traffic24UploadDetail'])">
                                    증빙 자료 업로드
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="step-box">증빙 자료 업로드</div>
                            </c:otherwise>
                        </c:choose>

                        <div class="arrow right"></div>
                        <div class="step-box">신청 제출</div>
                    </div>

                    <c:if test="${isLoggedIn}">
                        <div id="traffic24UploadDetail" class="step-detail-box toggle-detail">
                            <h4>📎 업로드 가능 자료</h4>
                            <ul>
                                <li>📷 현장 사진 / 영상</li>
                                <li>🚘 블랙박스 영상</li>
                                <li>🔢 차량 번호 식별 가능</li>
                                <li>📍 위치 확인 자료</li>
                            </ul>
                        </div>
                    </c:if>

                    <div class="arrow-down right-side"></div>

                    <!-- 4줄 -->
                    <div class="flow-row row-reverse">
                        <div class="step-box">접수 번호 확인</div>
                        <div class="arrow left"></div>
                        <div class="step-box">처리 결과 확인</div>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${isLoggedIn}">
                        <div class="process-bottom-link traffic24">
                            <a href="https://www.efine.go.kr/" target="_blank" rel="noopener noreferrer">
                                🔗 교통민원24 공식 사이트 바로가기
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="process-login-box">
                            <p>더욱 상세한 정보나<br>민원 사이트 연결은</p>
                            <h3>로그인 후</h3>
                            <p>이용 가능한 서비스 입니다 !</p>
                            <button type="button" class="process-login-btn"
                                    onclick="location.href='${pageContext.request.contextPath}/login'">
                                로그인하러 가기
                            </button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

            <!-- =========================
                 2. 국민신문고
            ========================== -->
            <section class="portal-process" id="epeople">
                <div class="process-title-row epeople">
                    <img src="${pageContext.request.contextPath}/images/icon2.png" alt="국민신문고">
                    <h2>국민신문고 접수는 다음 절차에 따라 진행됩니다.</h2>
                </div>

                <div class="process-flow epeople">
                    <!-- 1줄 -->
                    <div class="flow-row">
                        <div class="step-box">국민신문고 접속</div>
                        <div class="arrow right"></div>
                        <div class="step-box">로그인</div>
                    </div>

                    <div class="arrow-down right-side"></div>

                    <!-- 2줄 -->
                    <div class="flow-row row-reverse">
                        <c:choose>
                            <c:when test="${isLoggedIn}">
                                <div class="step-box clickable-step"
                                     onclick="toggleDetail('epeopleComplaintDetail', ['epeopleComplaintDetail','epeopleUploadDetail'])">
                                    신청서 작성
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="step-box">신청서 작성</div>
                            </c:otherwise>
                        </c:choose>

                        <div class="arrow left"></div>
                        <div class="step-box">유사사례 검토</div>
                    </div>

                    <c:if test="${isLoggedIn}">
                        <div id="epeopleComplaintDetail" class="step-detail-box toggle-detail">
                            <h4>📌 민원 유형 예시</h4>
                            <ul>
                                <li>📄 일반 민원</li>
                                <li>💡 제안/건의</li>
                                <li>🐝 부패/공익 신고</li>
                                <li>🛡️ 적극행정 국민신청</li>
                            </ul>
                        </div>
                    </c:if>

                    <div class="arrow-down left-side"></div>

                    <!-- 3줄 -->
                    <div class="flow-row">
                        <c:choose>
                            <c:when test="${isLoggedIn}">
                                <div class="step-box clickable-step"
                                     onclick="toggleDetail('epeopleUploadDetail', ['epeopleComplaintDetail','epeopleUploadDetail'])">
                                    처리기관 선택 및 제출
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="step-box">처리기관 선택 및 제출</div>
                            </c:otherwise>
                        </c:choose>

                        <div class="arrow right"></div>
                        <div class="step-box">접수</div>
                    </div>

                    <c:if test="${isLoggedIn}">
                        <div id="epeopleUploadDetail" class="step-detail-box toggle-detail">
                            <h4>📎 업로드 가능 자료</h4>
                            <ul>
                                <li>📁 관련 서류</li>
                                <li>📷 현장 사진</li>
                                <li>🎬 참고 동영상</li>
                                <li>📄 기타 증빙</li>
                            </ul>
                        </div>
                    </c:if>

                    <div class="arrow-down right-side"></div>

                    <!-- 4줄 -->
                    <div class="flow-row row-reverse">
                        <div class="step-box">처리</div>
                        <div class="arrow left"></div>
                        <div class="step-box">만족도 조사</div>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${isLoggedIn}">
                        <div class="process-bottom-link epeople">
                            <a href="https://www.epeople.go.kr/" target="_blank" rel="noopener noreferrer">
                                🔗 국민신문고 공식 사이트 바로가기
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="process-login-box">
                            <p>더욱 상세한 정보나<br>민원 사이트 연결은</p>
                            <h3>로그인 후</h3>
                            <p>이용 가능한 서비스 입니다 !</p>
                            <button type="button" class="process-login-btn"
                                    onclick="location.href='${pageContext.request.contextPath}/login'">
                                로그인하러 가기
                            </button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

            <!-- =========================
                 3. 안전신문고
            ========================== -->
            <section class="portal-process" id="safety">
                <div class="process-title-row safety">
                    <img src="${pageContext.request.contextPath}/images/icon3.png" alt="안전신문고">
                    <h2>안전신문고 접수는 다음 절차에 따라 진행됩니다.</h2>
                </div>

                <div class="process-flow safety">
                    <!-- 1줄 -->
                    <div class="flow-row">
                        <div class="step-box">안전신문고 접속</div>
                        <div class="arrow right"></div>
                        <div class="step-box">신고할 분류 선택</div>
                    </div>

                    <div class="arrow-down right-side"></div>

                    <!-- 2줄 -->
                    <div class="flow-row row-reverse">
                        <c:choose>
                            <c:when test="${isLoggedIn}">
                                <div class="step-box clickable-step"
                                     onclick="toggleDetail('safetyComplaintDetail', ['safetyComplaintDetail','safetyUploadDetail'])">
                                    신고 유형 선택
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="step-box">신고 유형 선택</div>
                            </c:otherwise>
                        </c:choose>

                        <div class="arrow left"></div>
                        <div class="step-box">증빙 사진·동영상</div>
                    </div>

                    <c:if test="${isLoggedIn}">
                        <div id="safetyComplaintDetail" class="step-detail-box toggle-detail">
                            <h4>📌 민원 유형 예시</h4>
                            <ul>
                                <li>⚠️ 도로 · 시설 파손</li>
                                <li>⚡ 위험 구역</li>
                                <li>🔥 소방 시설 장애</li>
                                <li>🚴 기타 위험 요소</li>
                            </ul>
                        </div>
                    </c:if>

                    <div class="arrow-down left-side"></div>

                    <!-- 3줄 -->
                    <div class="flow-row">
                        <c:choose>
                            <c:when test="${isLoggedIn}">
                                <div class="step-box clickable-step"
                                     onclick="toggleDetail('safetyUploadDetail', ['safetyComplaintDetail','safetyUploadDetail'])">
                                    신고 내용 작성
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="step-box">신고 내용 작성</div>
                            </c:otherwise>
                        </c:choose>

                        <div class="arrow right"></div>
                        <div class="step-box">처리기관 분류</div>
                    </div>

                    <c:if test="${isLoggedIn}">
                        <div id="safetyUploadDetail" class="step-detail-box toggle-detail">
                            <h4>📎 업로드 가능 자료</h4>
                            <ul>
                                <li>🎥 동영상(필수권장)</li>
                                <li>📷 현장 사진</li>
                                <li>📍 주소지 확인 가능</li>
                            </ul>
                        </div>
                    </c:if>

                    <div class="arrow-down right-side"></div>

                    <!-- 4줄 -->
                    <div class="flow-row row-reverse">
                        <div class="step-box">위험해소</div>
                        <div class="arrow left"></div>
                        <div class="step-box">처리 결과 통보</div>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${isLoggedIn}">
                        <div class="process-bottom-link safety">
                            <a href="https://www.safetyreport.go.kr/" target="_blank" rel="noopener noreferrer">
                                🔗 안전신문고 공식 사이트 바로가기
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="process-login-box">
                            <p>더욱 상세한 정보나<br>민원 사이트 연결은</p>
                            <h3>로그인 후</h3>
                            <p>이용 가능한 서비스 입니다 !</p>
                            <button type="button" class="process-login-btn"
                                    onclick="location.href='${pageContext.request.contextPath}/login'">
                                로그인하러 가기
                            </button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

            <!-- =========================
                 4. 광주광역시
            ========================== -->
            <section class="portal-process" id="gwangju">
                <div class="process-title-row gwangju">
                    <img src="${pageContext.request.contextPath}/images/icon4.png" alt="광주광역시">
                    <h2>광주광역시 접수는 다음 절차에 따라 진행됩니다.</h2>
                </div>

                <div class="process-flow gwangju">
                    <!-- 1줄 -->
                    <div class="flow-row">
                        <div class="step-box">바로응답 접속</div>
                        <div class="arrow right"></div>
                        <div class="step-box">민원 작성 및 본인인증</div>
                    </div>

                    <div class="arrow-down right-side"></div>

                    <!-- 2줄 -->
                    <div class="flow-row row-reverse">
                        <c:choose>
                            <c:when test="${isLoggedIn}">
                                <div class="step-box clickable-step"
                                     onclick="toggleDetail('gwangjuComplaintDetail', ['gwangjuComplaintDetail','gwangjuUploadDetail'])">
                                    신청서 작성
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="step-box">신청서 작성</div>
                            </c:otherwise>
                        </c:choose>

                        <div class="arrow left"></div>
                        <div class="step-box">접수 번호 발급</div>
                    </div>

                    <c:if test="${isLoggedIn}">
                        <div id="gwangjuComplaintDetail" class="step-detail-box toggle-detail">
                            <h4>📌 민원 유형 예시</h4>
                            <ul>
                                <li>🏙️ 시정 불편 사항</li>
                                <li>🛠️ 공공시설 보수</li>
                                <li>🌳 가로수/조경 관리</li>
                                <li>📢 정책 제안</li>
                            </ul>
                        </div>
                    </c:if>

                    <div class="arrow-down left-side"></div>

                    <!-- 3줄 -->
                    <div class="flow-row">
                        <c:choose>
                            <c:when test="${isLoggedIn}">
                                <div class="step-box clickable-step"
                                     onclick="toggleDetail('gwangjuUploadDetail', ['gwangjuComplaintDetail','gwangjuUploadDetail'])">
                                    주관 부서 및 담당자 배정
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="step-box">주관 부서 및 담당자 배정</div>
                            </c:otherwise>
                        </c:choose>

                        <div class="arrow right"></div>
                        <div class="step-box">접수</div>
                    </div>

                    <c:if test="${isLoggedIn}">
                        <div id="gwangjuUploadDetail" class="step-detail-box toggle-detail">
                            <h4>📎 업로드 가능 자료</h4>
                            <ul>
                                <li>📷 위치 이미지</li>
                                <li>🎬 불편 상황 영상</li>
                                <li>🗺️ 지도 캡처본</li>
                            </ul>
                        </div>
                    </c:if>

                    <div class="arrow-down right-side"></div>

                    <!-- 4줄 -->
                    <div class="flow-row row-reverse">
                        <div class="step-box">처리</div>
                        <div class="arrow left"></div>
                        <div class="step-box">사후관리 및 만족도 평가</div>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${isLoggedIn}">
                        <div class="process-bottom-link gwangju">
                            <a href="https://www.gwangju.go.kr/" target="_blank" rel="noopener noreferrer">
                                🔗 광주광역시 공식 사이트 바로가기
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="process-login-box">
                            <p>더욱 상세한 정보나<br>민원 사이트 연결은</p>
                            <h3>로그인 후</h3>
                            <p>이용 가능한 서비스 입니다 !</p>
                            <button type="button" class="process-login-btn"
                                    onclick="location.href='${pageContext.request.contextPath}/login'">
                                로그인하러 가기
                            </button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>

        </div>
    </div>

    <jsp:include page="/WEB-INF/views/common/bottomNav.jsp"/>
    <%@ include file="/WEB-INF/views/common/sideMenu.jsp" %>
</div>

<script>
document.addEventListener("DOMContentLoaded", function () {
    const portalButtons = document.querySelectorAll(".portal-item");
    const portalSections = document.querySelectorAll(".portal-process");

    portalButtons.forEach(button => {
        button.addEventListener("click", function () {
            const target = this.dataset.portal;

            portalButtons.forEach(btn => btn.classList.remove("active"));
            this.classList.add("active");

            portalSections.forEach(section => section.classList.remove("active"));
            document.getElementById(target).classList.add("active");

            document.querySelectorAll(".toggle-detail").forEach(detail => {
                detail.style.display = "none";
            });

            window.scrollTo({ top: 0, behavior: "smooth" });
        });
    });
});

function toggleDetail(targetId, groupIds) {
    groupIds.forEach(id => {
        const el = document.getElementById(id);
        if (!el) return;

        if (id === targetId) {
            el.style.display = (el.style.display === "block") ? "none" : "block";
        } else {
            el.style.display = "none";
        }
    });
}
</script>

</body>
</html>