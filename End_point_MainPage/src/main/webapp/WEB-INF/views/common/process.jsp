<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>TRAFFIC:ON - 신청절차 안내</title>
        <link rel="stylesheet" href="/css/ApplicationProcessPage.css">
    </head>

    <body>
        <div class="v3-process-container" id="processContainer">
            <!-- 탭 및 상단 생략 (기존 CSS 활용 가능) -->

            <div class="v3-process-content">
                <!-- 펭리미 가이드 섹션 -->
                <div class="process-guide-section">
                    <!-- 로그인 상태에 따라 'is-blurred' 클래스 추가 -->
                    <div class="guide-bubble intro-bubble" id="bubble1">
                        <p>민원 신청 전, 어떤 서류가 필요한지 확인해보세요!</p>
                    </div>

                    <!-- 비회원용 로그인 유도 박스 -->
                    <div id="loginInvitationBox" class="v3-login-invitation">
                        <div class="invitation-box">
                            <p>상세 가이드 정보 확인은</p>
                            <h3>로그인 후</h3>
                            <p>이용 가능한 서비스 입니다 !</p>
                            <button class="v3-login-btn-process" onclick="location.href='/login'">
    로그인하러 가기
</button>

                            </button>
                        </div>
                    </div>
                </div>

                <!-- 하단 버튼 영역 -->
                <div class="process-action-footer">
                    <!-- 회원만 보이는 링크 (서버에서 제어 권장) -->
                    <% if(request.getAttribute("isLoggedIn") !=null && (Boolean)request.getAttribute("isLoggedIn")) { %>
                        <a href="https://safe.gwangju.go.kr" class="official-site-link">공식 사이트 바로가기</a>
                        <% } %>
                </div>
            </div>
        </div>

        <script>
            // 자바스크립트로 간단하게 블러 제어
            let isLoggedIn = false;
            if (!isLoggedIn) {
                document.getElementById('bubble1').classList.add('is-blurred');
                document.getElementById('processContainer').classList.add('not-logged-in');
            }
        </script>
    </body>

    </html>