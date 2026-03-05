<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                <span class="post-count">${boards.size()}</span>
            </div>
        </div>

        <!-- 게시판 테이블 (데스크톱용) -->
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
                    <c:forEach var="board" items="${boards}">
                        <tr>
                            <td>${board.boardId}</td>
                            <td class="text-left">${board.title}</td>
                            <td>${board.memId}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${boards.size() == 0}">
                        <tr>
                            <td colSpan="3" class="empty-row">등록된 게시물이 없습니다.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- 로그인 여부에 따라 조건부 렌더링 -->
        <c:if test="${!isLoggedIn}">
            <!-- 비회원 전용 로그인 유도 박스 (게시판 위에 덮임) -->
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
        </c:if>

        <c:if test="${isLoggedIn}">
            <!-- 회원 전용 푸터 -->
            <div id="boardFooter" class="board-footer-refined">
                <div class="board-footer-divider"></div>
                <button class="write-btn" onclick="location.href='/board/write'">글쓰기</button>
                <div class="pagination">
                    <i data-lucide="chevron-left" class="pagi-arrow disabled"></i>
                    <span class="pagi-num active">1</span>
                    <i data-lucide="chevron-right" class="pagi-arrow disabled"></i>
                </div>
            </div>
        </c:if>
    </div>

    <script>
        lucide.createIcons();

        let isLoggedIn = "${isLoggedIn}" === "true";

        if (isLoggedIn) {
            document.getElementById('boardTableWrapper').classList.remove('is-blurred');
        } else {
            document.getElementById('boardTableWrapper').classList.add('is-blurred');
        }
    </script>
</body>
</html>