<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- head.jsp -->

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Fonts -->
<link rel="stylesheet" as="style" crossorigin
href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.css">

<!-- Global CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">

<!-- ✅ Header CSS 추가 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Header.css">

<!-- Lucide Icons -->
<script src="https://unpkg.com/lucide@latest"></script>

<!-- Lucide 실행 -->
<script>
window.addEventListener("DOMContentLoaded", function () {
    if (window.lucide) {
        lucide.createIcons();
    }
});
</script>