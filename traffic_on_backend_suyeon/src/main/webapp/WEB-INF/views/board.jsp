<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="/WEB-INF/views/common/head.jsp" />
    <title>TRAFFIC:ON - ON! 교통 정보</title>
    <link rel="stylesheet" href="/css/BoardPage.css">
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
            table-layout: fixed;
        }
        .board-table-refined thead tr {
            background: #f7f9fc;
            border-bottom: 1px solid #eee;
        }
        .board-table-refined th {
            padding: 12px 4px;
            font-size: 12px;
            font-weight: 700;
            color: #888;
            text-align: center;
        }
        .board-table-refined td {
            padding: 12px 4px;
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
        .col-no       { width: 30px; }
        .col-category { width: 68px; }
        .col-title    { width: 90px; }
        .col-id       { width: 60px; }
        .col-date     { width: 78px; }
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
            padding: 2px 6px;
            white-space: nowrap;
        }
        .title-cell {
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            text-align: left;
        }
        .id-cell {
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            font-size: 12px;
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

    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <jsp:include page="/WEB-INF/views/common/sideMenu.jsp" />

    <div class="board-wrap">
        <div class="board-title-section">
            <h1>ON! 교통 정보</h1>
            <span class="post-count">${boards.size()}</span>
        </div>

        <div style="position:relative;">
            <div class="board-table-wrapper" id="boardTableWrapper">
                <table class="board-table-refined">
                    <colgroup>
                        <col class="col-no">
                        <col class="col-category">
                        <col class="col-title">
                        <col class="col-id">
                        <col class="col-date">
                    </colgroup>
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
                                <td>${boards.size() - status.index}</td>
                                <td><span class="category-badge">${board.category}</span></td>
                                <td class="title-cell">${board.title}</td>
                                <td class="id-cell">${board.memId}</td>
                                <td class="date-text">
                                    ${board.createdAt.toString().substring(0, 10)}
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

    <jsp:include page="/WEB-INF/views/common/bottomNav.jsp" />

</div>

<script>
    let isLoggedIn = "${isLoggedIn}" === "true";
    if (isLoggedIn) {
        document.getElementById('boardTableWrapper').classList.remove('is-blurred');
    } else {
        document.getElementById('boardTableWrapper').classList.add('is-blurred');
    }
</script>
</body>
</html>