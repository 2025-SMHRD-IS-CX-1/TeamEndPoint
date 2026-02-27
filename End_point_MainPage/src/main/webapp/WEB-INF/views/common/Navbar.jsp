<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--
  Navbar.jsp
  상단 네비게이션 바 (서비스소개 / 민원조회 / 민원신청)
--%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/Navbar.css" />

<nav class="navbar">

    <div class="navbar-logo">
        <a href="${pageContext.request.contextPath}/">Minwon Service</a>
    </div>

    <ul class="navbar-links">
        <li><a href="#service-intro">서비스소개</a></li>
        <li><a href="#inquiry">민원조회</a></li>
        <li><a href="#application">민원신청</a></li>
    </ul>

</nav>
