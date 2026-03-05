<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TRAFFIC:ON - ON! 교통 정보</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/BoardPage.css">
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>
        .board-wrap {
            padding: 16px;
            padding-bottom: 90px;
        }
        .board-title-section {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 16px;
        }
        .board-title-section h1 {
            font-size: 20px;
            font-weight: 800;
            color: #111;
            margin: 0;
        }
        .post-count {
            background: #FF5722;
            color: #fff;
            font-size: 12px;
            font-weight: 700;
            border-radius: 20px;
            padding: 2px 10px;
        }
        .board-table-wrapper {
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            overflow: hidden;
        }
        .board-table-wrapper.is-blurred {
            filter: blur(4px);
            pointer-events: none;
            user-select: none;
        }
        .board-table-refined {
            width: 100%;
            border-collapse: collapse;
        }
        .board-table-refined thead tr {
            background: #f7f9fc;
            border-bottom: 1px solid #eee;
        }
        .board-table-refined th {
            padding: 12px 6px;
            font-size: 12px;
            font-weight: 700;
            color: #888;
            text-align: center;
        }
        .board-table-refined td {
            padding: 12px 6px;
            font-size: 13px;
            color: #222;
            text-align: center;
            border-bottom: 1px solid #f0f0f0;
        }
        .board-table-refined .text-left {
            text-align: left;
        }
        .board-table-refined tbody tr:last-child td {
            border-bottom: none;
        }
        .board-table-refined tbody tr:hover {
            background: #f7f9fc;
        }
        .empty-row {
            color: #aaa;
            font-size: 14px;
            padding: 30px 0 !important;
        }
        .category-badge {
            background: #fff3ee;
            color: #FF5722;
            font-size: 11px;
            font-weight: 700;
            border-radius: 20px;
            padding: 2px 8px;
            white-space: nowrap;
        }
        .date-text {
            font-size: 11px;
            color: #aaa;
            white-space: nowrap;
        }
        .board-footer-refined {
            margin-top: 16px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .write-btn {
            background: #FF5722;
            color: #fff;
            border: none;
            border-radius: 12px;
            padding: 10px 22px;
            font-size: 14px;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 4px 12px rgba(255,87,34,0.25);
        }
        .pagination {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .pagi-num {
            font-size: 14px;
            font-weight: 700;
            color: #111;
        }
        .pagi-num.active {
            color: #FF5722;
        }
        .pagi-arrow {
            width: 20px;
            height: 20px;
            color: #bbb;
        }
        .board-login-invitation {
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 10;
        }
        .board-invitation-box {
            background: #fff;
            border-radius: 20px;
            padding: 32px 24px;
            text-align: center;
            box-shadow: 0 8px 30px rgba(0,0,0,0.12);
        }
        .board-invitation-box p {
            color: #555;
            font-size: 14px;
            margin: 0 0 6px;
            line-height: 1.6;
        }
        .board-invitation-box h3 {
            font-size: 22px;
            font-weight: 800;
            color: #FF5722;
            margin: 8px 0;
        }
        .board-login-btn-process {
            margin-top: 16px;
            background: #FF5722;
            color: #fff;
            border: none;
            border-radius: 30px;
            padding: 12px 28px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 4px 12px rgba(255,87,34,0.25);
        }
    </style>
</head>
<body>
<div class="mobile-wrap">

    <header class="top-header">
        <div class="left"></div>
        <div class="logo-container">
            <span class="logo-text">TRAFFIC:ON</span>
        </div>
        <div class="right"></div>
    </header>

    <div class="board-wrap">
        <div class="board-title-section">
            <h1>ON! 교통 정보</h1>
            <span class="post-count">${boards.size()}</span>
        </div>

        <div style="position:relative;">
            <div class="board-table-wrapper" id="boardTableWrapper">
                <table class="board-table-refined">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>카테고리</th>
                            <th>제목</th>
                            <th>아이디</th>
                            <th>날짜</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="board" items="${boards}" varStatus="status">
                            <tr onclick="location.href='/board/${board.boardId}'" style="cursor:pointer;">
                                <td>${status.count}</td>
                                <td><span class="category-badge">${board.category}</span></td>
                                <td class="text-left">${board.title}</td>
                                <td>${board.memId}</td>
                                <td class="date-text">
                                    ${board.createdAt.toString().substring(0, 16).replace('T', ' ')}
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${boards.size() == 0}">
                            <tr>
                                <td colspan="5" class="empty-row">등록된 게시물이 없습니다.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <c:if test="${!isLoggedIn}">
                <div id="loginInvitation" class="board-login-invitation">
                    <div class="board-invitation-box">
                        <p>게시판의 상세 내용 확인과<br/>게시글 작성은</p>
                        <h3>로그인 후</h3>
                        <p>이용 가능한 서비스 입니다!</p>
                        <button class="board-login-btn-process" onclick="location.href='/login'">
                            로그인하러 가기
                        </button>
                    </div>
                </div>
            </c:if>
        </div>

        <c:if test="${isLoggedIn}">
            <div class="board-footer-refined">
                <div class="pagination">
                    <i data-lucide="chevron-left" class="pagi-arrow"></i>
                    <span class="pagi-num active">1</span>
                    <i data-lucide="chevron-right" class="pagi-arrow"></i>
                </div>
                <button class="write-btn" onclick="location.href='/board/write'">글쓰기</button>
            </div>
        </c:if>
    </div>

    <nav class="bottom-nav">
        <a class="nav-item" href="${pageContext.request.contextPath}/">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                 viewBox="0 0 24 24" fill="none" stroke="#888" stroke-width="2"
                 stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <path d="m21 21-4.34-4.34"></path>
                <circle cx="11" cy="11" r="8"></circle>
            </svg>
            <span>사전해결 가이드</span>
        </a>
        <div class="nav-divider"></div>
        <a class="nav-item" href="${pageContext.request.contextPath}/guide">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                 viewBox="0 0 24 24" fill="none" stroke="#888" stroke-width="2"
                 stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <rect width="7" height="7" x="3" y="3" rx="1"></rect>
                <rect width="7" height="7" x="14" y="3" rx="1"></rect>
                <rect width="7" height="7" x="14" y="14" rx="1"></rect>
                <rect width="7" height="7" x="3" y="14" rx="1"></rect>
            </svg>
            <span>민원유형</span>
        </a>
        <div class="nav-divider"></div>
        <a class="nav-item" href="${pageContext.request.contextPath}/application-process">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                 viewBox="0 0 24 24" fill="none" stroke="#888" stroke-width="2"
                 stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
                <path d="M6 22a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h8a2.4 2.4 0 0 1 1.704.706l3.588 3.588A2.4 2.4 0 0 1 20 8v12a2 2 0 0 1-2 2z"></path>
                <path d="M14 2v5a1 1 0 0 0 1 1h5"></path>
                <path d="m9 15 2 2 4-4"></path>
            </svg>
            <span>신청절차 안내</span>
        </a>
    </nav>

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