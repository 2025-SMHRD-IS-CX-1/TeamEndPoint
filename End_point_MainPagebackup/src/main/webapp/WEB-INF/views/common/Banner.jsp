<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Banner.css" />
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>

<%-- 기본 축제 데이터 폴백 --%>
<c:if test="${empty festivalList}">
    <c:set var="festivalList" value='[
        {"title":"광주 추억의 충장축제","category":"지역 축제","subtitle":"Chungjang Festival of Recollection",
         "date":"2025.10.15 ~ 10.19","location":"광주 동구 충장로 일원","image":"/images/1.jpg",
         "description":"7080 세대의 추억을 되살리는 광주 대표 거리축제!"},
        {"title":"광주 비엔날레","category":"예술 전시","subtitle":"Gwangju Biennale",
         "date":"2025.08.30 ~ 11.02","location":"광주 비엔날레 전시관 일원","image":"/images/2.jpg",
         "description":"현대 미술의 정수를 보여주는 세계적인 시각 예술 축제!"},
        {"title":"광주 세계 김치 축제","category":"음식 축제","subtitle":"Gwangju Kimchi Festival",
         "date":"2024.10.18 ~ 10.20","location":"광주김치타운 일원","image":"/images/3.jpg",
         "description":"전통 김치의 맛과 정취를 느낄 수 있는 대한민국 대표 음식 축제!"}
    ]'/>
</c:if>


<section class="banner-section" id="bannerSection">

    <div class="banner-scroll-container" id="bannerScroll">
        <c:forEach var="fest" items="${festivalList}" varStatus="loop">
            <div class="banner-slide"
                 onclick="openBannerModal(${loop.index})"
                 data-index="${loop.index}">

                <div class="banner-image-wrapper"
                     style="background-image:url('<c:out value='${fest.image}'/>');">
                    <img src="<c:out value='${fest.image}'/>" alt="<c:out value='${fest.title}'/>" class="banner-img" />
                    <div class="banner-top-tag">
                        <c:choose>
                            <c:when test="${fn:contains(fest.category, '예술')}">전시</c:when>
                            <c:otherwise>축제</c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="banner-info-box">
                    <span class="banner-cat-label"><c:out value="${fest.category}"/></span>
                    <h3 class="banner-title-text"><c:out value="${fest.title}"/></h3>
                    <p class="banner-date-text"><c:out value="${fest.date}"/></p>
                </div>

            </div>
        </c:forEach>
    </div>

    <div class="banner-nav-arrows">
        <button class="nav-arrow prev" onclick="bannerNav('prev')" aria-label="이전">
            <i data-lucide="chevron-left" style="width:24px;height:24px;"></i>
        </button>
        <button class="nav-arrow next" onclick="bannerNav('next')" aria-label="다음">
            <i data-lucide="chevron-right" style="width:24px;height:24px;"></i>
        </button>
    </div>

    <div class="banner-indicator" id="bannerIndicator">
        1 / <c:out value="${fn:length(festivalList)}" />
    </div>

</section>

<div class="festival-modal-overlay" id="festivalModal"
     style="display:none;"
     onclick="closeBannerModal()">

    <div class="festival-modal-content" onclick="event.stopPropagation()">

        <button class="modal-close-btn" onclick="closeBannerModal()">&times;</button>

        <div class="modal-poster-top" id="modalPosterTop">
            <img src="" alt="" class="modal-top-img" id="modalImg" />
        </div>

        <div class="modal-header">
            <h2 id="modalTitle"></h2>
            <p class="modal-subtitle" id="modalSubtitle"></p>
            <div class="modal-info-tags">
                <span class="festival-info-tag" id="modalDate"></span>
                <span class="festival-info-tag" id="modalLocation"></span>
            </div>
        </div>

        <div class="modal-body">
            <p id="modalDesc"></p>
        </div>

        <div class="modal-footer">
            <button class="close-action-btn" onclick="closeBannerModal()">닫기</button>
        </div>

    </div>
</div>

<script>
(function () {
    lucide.createIcons();

    var festivals = [
        <c:forEach var="fest" items="${festivalList}" varStatus="loop">
        {
            title: "<c:out value='${fest.title}'/>",
            category: "<c:out value='${fest.category}'/>",
            subtitle: "<c:out value='${fest.subtitle}'/>",
            date: "<c:out value='${fest.date}'/>",
            location: "<c:out value='${fest.location}'/>",
            image: "<c:out value='${fest.image}'/>",
            description: "<c:out value='${fest.description}'/>"
        }<c:if test="${not loop.last}">,</c:if>
        </c:forEach>
    ];

    var activeIndex = 0;
    var scrollEl    = document.getElementById('bannerScroll');
    var indicator   = document.getElementById('bannerIndicator');

    scrollEl.addEventListener('scroll', function () {
        var newIndex = Math.round(scrollEl.scrollLeft / scrollEl.offsetWidth);
        if (newIndex !== activeIndex) {
            activeIndex = newIndex;
            indicator.textContent = (activeIndex + 1) + ' / ' + festivals.length;
        }
    });

    window.bannerNav = function (direction) {
        var width = scrollEl.offsetWidth;
        var target = direction === 'next'
            ? scrollEl.scrollLeft + width
            : scrollEl.scrollLeft - width;
        scrollEl.scrollTo({ left: target, behavior: 'smooth' });
    };

    window.openBannerModal = function (index) {
        var f = festivals[index];
        if (!f) return;

        var posterTop = document.getElementById('modalPosterTop');
        posterTop.style.backgroundImage = "url('" + f.image + "')";
        document.getElementById('modalImg').src         = f.image;
        document.getElementById('modalImg').alt         = f.title;
        document.getElementById('modalTitle').textContent    = f.title;
        document.getElementById('modalSubtitle').textContent = f.subtitle;
        document.getElementById('modalDate').textContent     = '📅 ' + f.date;
        document.getElementById('modalLocation').textContent = '📍 ' + f.location;
        document.getElementById('modalDesc').textContent     = f.description;

        document.getElementById('festivalModal').style.display = 'flex';
        document.body.style.overflow = 'hidden';
    };

    window.closeBannerModal = function () {
        document.getElementById('festivalModal').style.display = 'none';
        document.body.style.overflow = '';
    };
})();
</script>
