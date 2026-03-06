<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>TRAFFIC:ON - 마이페이지</title>
    <%@ include file="common/head.jsp" %>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/MyPage.css">
</head>

<body>
    <div class="mobile-layout-container">
        <div class="mobile-layout-content mypage-page">

            <%@ include file="common/header.jsp" %>
			<%@ include file="/WEB-INF/views/common/sideMenu.jsp" %>

            <main class="mypage-container">
                <!-- 상단 -->
				<div class="mypage-top">

				    <h1 class="mypage-title">마이페이지</h1>	    
				</div>

                <p class="header-subtext">내 정보와 활동 내역을 확인할 수 있어요.</p>

                <!-- 프로필 카드 -->
                <section class="profile-card">
                    <div class="profile-avatar">
						<img src="${pageContext.request.contextPath}/images/mascot.png" 
						     alt="프로필" 
						     class="profile-character-img" />
                    </div>

                    <div class="profile-main-info">
                        <div class="profile-name-row">
                            <span class="profile-name">${member.memName}</span>
                            <span class="profile-id">@${member.memID}</span>
                        </div>
                    </div>
                </section>

                <!-- 기본 정보 -->
                <section class="settings-section">
                    <div class="section-header">
                        <i data-lucide="user-round" class="section-icon"></i>
                        <h3>기본 정보</h3>
                    </div>

                    <div class="settings-card info-card">
                        <div class="info-row">
                            <span class="info-label">이름</span>
                            <span class="info-value">${member.memName} (${member.memID})</span>
                        </div>

                        <div class="info-row">
                            <span class="info-label">전화번호</span>
                            <span class="info-value">${member.memPhone}</span>
                        </div>

                        <button type="button" class="outline-action-btn">
                            기본 정보 수정
                        </button>
                    </div>
                </section>

                <!-- 개인 설정 -->
                <section class="settings-section">
                    <div class="section-header">
                        <i data-lucide="settings" class="section-icon"></i>
                        <h3>개인 설정</h3>
                    </div>

                    <div class="settings-card">
                        <form action="${pageContext.request.contextPath}/mypage/update-preferences" method="post" class="preferences-form">
                            <!-- 거주 지역 -->
                            <div class="form-group">
                                <label class="group-label">거주 지역</label>
                                <div class="checkbox-grid">
                                    <label class="checkbox-item">
                                        <input type="checkbox" name="regions" value="동구">
                                        <span>동구</span>
                                    </label>

                                    <label class="checkbox-item">
                                        <input type="checkbox" name="regions" value="서구">
                                        <span>서구</span>
                                    </label>

                                    <label class="checkbox-item">
                                        <input type="checkbox" name="regions" value="남구">
                                        <span>남구</span>
                                    </label>

                                    <label class="checkbox-item">
                                        <input type="checkbox" name="regions" value="북구">
                                        <span>북구</span>
                                    </label>

                                    <label class="checkbox-item">
                                        <input type="checkbox" name="regions" value="광산구">
                                        <span>광산구</span>
                                    </label>
                                </div>

                                <div class="region-guide-box">
                                    선택한 지역 기준으로 정보를 더 정확히 안내해요.
                                </div>
                            </div>

                            <button type="submit" class="save-btn">변경사항 저장</button>
                        </form>
                    </div>
                </section>

                <!-- 보안 -->
                <section class="settings-section">
                    <div class="section-header">
                        <i data-lucide="lock" class="section-icon"></i>
                        <h3>보안</h3>
                    </div>

                    <div class="settings-card password-card">
                        <button class="password-change-btn" type="button">
                            <span>비밀번호 변경하기</span>
                            <i data-lucide="chevron-right"></i>
                        </button>
                    </div>
                </section>

				<!-- 내 게시글 -->
				<section class="settings-section">
				    <div class="section-header posts-header">
				        <div class="posts-title-wrap">
				            <i data-lucide="file-text" class="section-icon"></i>
				            <h3>내 게시글</h3>
				        </div>

				        <a class="view-all" href="${pageContext.request.contextPath}/my-posts">
				            전체 보기 &gt;
				        </a>
				    </div>

				    <div class="posts-card">
				        <div class="posts-table-head">
				            <span>제목</span>
				            <span>작성일</span>
				        </div>

				        <c:if test="${empty myPostsPreview}">
				            <div class="posts-empty">작성한 게시글이 없습니다.</div>
				        </c:if>

				        <c:forEach var="p" items="${myPostsPreview}">
				            <div class="posts-table-row" onclick="location.href='${pageContext.request.contextPath}/my-posts'">
				                <span class="title">${p.title}</span>
				                <span class="date">${p.createdAt.toString().substring(0,10)}</span>
				            </div>
				        </c:forEach>
				    </div>
				</section>

                <!-- 하단 로그아웃 -->
                <div class="bottom-actions">
                    <button class="logout-footer-btn" type="button" onclick="handleLogout()">
                        <i data-lucide="log-out"></i>
                        <span>로그아웃</span>
                    </button>
                </div>
            </main>

           <!-- <%@ include file="common/bottomNav.jsp" %> -->
        </div>
    </div>

    <script>
        lucide.createIcons();

        function handleLogout() {
            if (confirm('로그아웃 하시겠습니까?')) {
                location.href = '${pageContext.request.contextPath}/logout';
            }
        }
    </script>
</body>
</html>