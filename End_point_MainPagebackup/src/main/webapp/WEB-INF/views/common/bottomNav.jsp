<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--
  bottomNav.jsp
  하단 고정 네비게이션
  현재 경로는 JavaScript로 판별하여 active 클래스 적용
--%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/BottomNav.css" />
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>

<nav class="bottom-nav" id="bottomNav">

    <a href="${pageContext.request.contextPath}/"
       class="nav-item"
       id="nav-home"
       aria-label="사전해결 가이드">
        <i data-lucide="search" style="width:24px;height:24px;"></i>
        <span>사전해결 가이드</span>
    </a>

    <div class="nav-divider"></div>

    <a href="${pageContext.request.contextPath}/complaint-type"
       class="nav-item"
       id="nav-complaint"
       aria-label="민원유형">
        <i data-lucide="layout-grid" style="width:24px;height:24px;"></i>
        <span>민원유형</span>
    </a>

    <div class="nav-divider"></div>

    <a href="${pageContext.request.contextPath}/application-process"
       class="nav-item"
       id="nav-process"
       aria-label="신청절차 안내">
        <i data-lucide="file-check" style="width:24px;height:24px;"></i>
        <span>신청절차 안내</span>
    </a>

</nav>

<script>
(function () {
    lucide.createIcons();

    /* 현재 경로에 맞는 nav-item 에 active 클래스 및 파란색 아이콘 적용 */
    var path = window.location.pathname;
    var ctx  = '${pageContext.request.contextPath}';

    var map = [
        { id: 'nav-home',      pattern: ctx + '/'                    },
        { id: 'nav-complaint', pattern: ctx + '/complaint-type'      },
        { id: 'nav-process',   pattern: ctx + '/application-process' }
    ];

    map.forEach(function (item) {
        var el = document.getElementById(item.id);
        if (!el) return;
        var icon = el.querySelector('i');
        if (path === item.pattern || path === item.pattern + '/') {
            el.classList.add('active');
            if (icon) icon.style.color = '#007bff';
        } else {
            if (icon) icon.style.color = '#888';
        }
    });
})();
</script>
