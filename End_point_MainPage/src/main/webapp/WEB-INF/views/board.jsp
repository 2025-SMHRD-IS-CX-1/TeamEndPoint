<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>TRAFFIC:ON - ON! 교통 정보</title>
        <link rel="stylesheet" href="/css/BoardPage.css">
        <script src="https://unpkg.com/lucide@latest"></script>
    </head>

    <body>
        <div class="board-container" id="boardContainer">
            <div class="board-header-top">
                <div class="board-title-section">
                    <h1>ON! 교통 정보</h1>
                    <span class="post-count">0</span>
                </div>
            </div>

            <!-- 로그인 상태에 따라 'is-blurred' 클래스 추가 제어 -->
            <div class="board-table-wrapper" id="boardTableWrapper">
                <table class="board-table-refined">
                    <thead>
                        <tr>
                            <th class="col-no">No</th>
                            <th class="col-title">제목</th>
                            <th class="col-author">아이디</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colSpan="3" class="empty-row">
                                등록된 게시물이 없습니다.
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- 비회원 전용 로그인 유도 박스 -->
            <div id="loginInvitation" class="board-login-invitation">
                <div class="board-invitation-box">
                    <p>게시판의 상세 내용 확인과<br />게시글 작성은</p>
                    <h3>로그인 후</h3>
                    <p>이용 가능한 서비스 입니다 !</p>
                    <button class="board-login-btn-process" onclick="location.href='/login'">
                        로그인하러 가기
                    </button>
                </div>
            </div>

            <!-- 회원 전용 푸터 (초기에는 숨김 처리 가능) -->
            <div id="boardFooter" class="board-footer-refined" style="display: none;">
                <div class="board-footer-divider"></div>
                <button class="write-btn">글쓰기</button>
                <div class="pagination">
                    <i data-lucide="chevron-left" class="pagi-arrow disabled"></i>
                    <span class="pagi-num active">1</span>
                    <i data-lucide="chevron-right" class="pagi-arrow disabled"></i>
                </div>
            </div>
        </div>

        <script>
            lucide.createIcons();

            // 서버 세션 등을 통해 결정될 로그인 상태
            let isLoggedIn = false;

            if (isLoggedIn) {
                document.getElementById('boardTableWrapper').classList.remove('is-blurred');
                document.getElementById('loginInvitation').style.display = 'none';
                document.getElementById('boardFooter').style.display = 'flex';
                document.getElementById('boardContainer').classList.remove('not-logged-in');
            } else {
                document.getElementById('boardTableWrapper').classList.add('is-blurred');
                document.getElementById('boardContainer').classList.add('not-logged-in');
            }
        </script>
    </body>

    </html>