<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TRAFFIC:ON - 글쓰기</title>
    <link rel="stylesheet" href="/css/common.css">
    <link rel="stylesheet" href="/css/WriteBoard.css">
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
<div class="mobile-wrap">

    <header class="top-header">
        <div class="left">
            <button class="icon-btn" onclick="history.back()">
                <i data-lucide="chevron-left"></i>
            </button>
        </div>
        <div class="logo-container">
            <span class="logo-text">글쓰기</span>
        </div>
        <div class="right"></div>
    </header>

    <div class="write-body">
        <form id="writeForm" action="/board/write" method="post">
            <div class="write-card">

                <div class="write-form-row">
                    <label for="category">카테고리</label>
                    <select id="category" name="category" class="write-input">
                        <option value="신고/민원">신고/민원</option>
                        <option value="정보/가이드">정보/가이드</option>
                        <option value="후기/공유">후기/공유</option>
                    </select>
                </div>

                <div class="divider"></div>

                <div class="write-form-row">
                    <label for="title">제목</label>
                    <input type="text" id="title" name="title"
                        class="write-input" placeholder="제목을 입력하세요" />
                </div>

                <div class="divider"></div>

                <div class="write-form-row">
                    <label for="content">내용</label>
                    <%-- ✅ 관리자 여부에 따라 placeholder 변경 --%>
                    <c:choose>
                        <c:when test="${sessionScope.loginMember.memType == 'ADMIN'}">
                            <textarea id="content" name="content"
                                class="write-textarea"
                                placeholder="공지사항을 작성하실 경우 제목에 '공지사항' 이라고 작성해 주세요"></textarea>
                        </c:when>
                        <c:otherwise>
                            <textarea id="content" name="content"
                                class="write-textarea"
                                placeholder="내용을 입력하세요"></textarea>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>

            <div class="write-footer">
                <button type="button" class="cancel-btn" onclick="location.href='/board'">취소</button>
                <button type="submit" class="submit-btn">등록</button>
            </div>
        </form>
    </div>

</div>

<script>
    lucide.createIcons();

    const badWords = [
      "시발","씨발","씹","좆","병신","개새끼","꺼져","죽어","닥쳐","지랄",
      "미친놈","또라이","정신병자","쓰레기","멍청이","바보","등신","후레자식",
      "개년","걸레","창녀","니미","염병","쌍놈","개자식","개같은","개소리",
      "개망신","개똥","개판","개돼지"
    ];

    const badPatterns = badWords.map(word => {
        const regex = word.split("").map(ch => ch + "[\\W_]*").join("");
        return new RegExp(regex, "i");
    });

    document.getElementById("writeForm").addEventListener("submit", function(e) {
        const content = document.getElementById("content").value;
        for (const pattern of badPatterns) {
            if (pattern.test(content)) {
                e.preventDefault();
                alert("금칙어가 포함되어 있어 글을 등록할 수 없습니다.");
                return;
            }
        }
    });
</script>
</body>
</html>