<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%--
  KeywordList.jsp
  주요 교통불편 키워드 랭킹 목록

  Request attribute:
    - keywordList (List<Map>) : 키워드 목록
        각 항목: rank(int), text(String), count(int)
      → 없을 경우 아래 기본 데이터 사용
--%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/KeywordList.css" />
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>

<%-- 기본 데이터 (Servlet 에서 keywordList 를 설정하지 않은 경우 폴백) --%>
<c:if test="${empty keywordList}">
    <%
        java.util.List<java.util.Map<String,Object>> defaultKeywords = new java.util.ArrayList<>();
        String[] texts   = {"지하철 공사","불법주차","장애인주차","버스우회","충장축제"};
        int[]    counts  = {852, 530, 240, 190, 88};
        for (int i = 0; i < texts.length; i++) {
            java.util.Map<String,Object> m = new java.util.LinkedHashMap<>();
            m.put("rank",  i + 1);
            m.put("text",  texts[i]);
            m.put("count", counts[i]);
            defaultKeywords.add(m);
        }
        request.setAttribute("keywordList", defaultKeywords);
    %>
</c:if>

<section class="keyword-section">

    <div class="keyword-header">
        <span class="car-icon">🚗</span>
        <h2>주요 교통불편 키워드</h2>
    </div>

    <ul class="keyword-list">
        <c:forEach var="item" items="${keywordList}">
            <li class="keyword-item">
                <span class="keyword-rank">${item.rank}</span>
                <span class="keyword-text">${item.text}</span>
                <div class="keyword-stats">
                    <i data-lucide="arrow-up" style="width:16px;height:16px;color:red;"></i>
                    <span class="keyword-count">${item.count}</span>
                </div>
            </li>
        </c:forEach>
    </ul>

</section>

<script>lucide.createIcons();</script>
