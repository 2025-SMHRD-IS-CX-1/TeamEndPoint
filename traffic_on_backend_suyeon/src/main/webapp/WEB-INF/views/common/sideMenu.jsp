<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<<<<<<< HEAD
<%@ page import="com.cx.web.entity.Member" %>
=======
>>>>>>> 0e086df37f3f3c6834bbb4a8b81fe813064b8dad
    <!-- sideMenu.jsp -->
    <link rel="stylesheet" href="/css/SideMenu.css">

    <div class="sidemenu-overlay" id="sidemenuOverlay">
        <div class="sidemenu-content">
            <div class="sidemenu-header">
                <div class="user-status-section">
<<<<<<< HEAD
                    <!-- isLoggedIn value should be passed from the host page or session --> 
					

					<%
					Member loginMember = (Member) session.getAttribute("loginMember");
					if (loginMember != null) {
					%>
=======
                    <!-- isLoggedIn value should be passed from the host page or session -->
                    <% Boolean isLoggedIn=(Boolean) session.getAttribute("isLoggedIn"); if (isLoggedIn !=null &&
                        isLoggedIn) { %>
>>>>>>> 0e086df37f3f3c6834bbb4a8b81fe813064b8dad
                        <div class="user-logged-in">
                            <div class="user-avatar-small">
                                <i data-lucide="user" size="20"></i>
                            </div>
                            <div class="user-info-text">
<<<<<<< HEAD
                                <span class="user-name">반가워요, <%= loginMember.getMemName() %>님!</span>
=======
                                <span class="user-name">반가워요, 회원님!</span>
>>>>>>> 0e086df37f3f3c6834bbb4a8b81fe813064b8dad
                                <form action="/logout" method="post" id="logoutForm">
                                    <button type="submit" class="logout-btn">로그아웃</button>
                                </form>
                            </div>
                        </div>
                        <% } else { %>
                            <div class="user-logged-out" onclick="location.href='/login'">
                                <div class="user-avatar-small gray">
                                    <i data-lucide="user" size="20"></i>
                                </div>
                                <div class="user-info-text">
                                    <span class="user-name">로그인이 필요합니다</span>
                                    <span class="login-hint">클릭하여 로그인하기</span>
                                </div>
                            </div>
                            <% } %>
                </div>
                <button class="close-btn" id="closeSideMenu">
                    <i data-lucide="x" size="24"></i>
                </button>
            </div>

            <div class="sidemenu-list">
                <a href="/" class="menu-item section-home">
                    <i data-lucide="home" size="20" class="menu-icon"></i>
                    <div class="menu-text">
                        <span class="menu-title">HOME</span>
                    </div>
                </a>

                <div class="menu-divider"></div>

                <a href="/board" class="menu-item">
                    <i data-lucide="clipboard-list" size="20" class="menu-icon"></i>
                    <div class="menu-text">
                        <span class="menu-title">ON! 교통 정보</span>
                        <span class="menu-subtext">게시판</span>
                    </div>
                </a>

                <a href="/events" class="menu-item">
                    <i data-lucide="gift" size="20" class="menu-icon"></i>
                    <div class="menu-text">
                        <span class="menu-title">이벤트</span>
                        <span class="menu-subtext">광주 축제, 이벤트</span>
                    </div>
                </a>

<<<<<<< HEAD
                <a href="/" class="menu-item">
=======
                <a href="/about" class="menu-item">
>>>>>>> 0e086df37f3f3c6834bbb4a8b81fe813064b8dad
                    <i data-lucide="info" size="20" class="menu-icon"></i>
                    <div class="menu-text">
                        <span class="menu-title">TRAFFIC:ON</span>
                        <span class="menu-subtext">우리 서비스는 · · ·</span>
                    </div>
                </a>

<<<<<<< HEAD
                <% if (loginMember != null) { %>
=======
                <% if (isLoggedIn !=null && isLoggedIn) { %>
>>>>>>> 0e086df37f3f3c6834bbb4a8b81fe813064b8dad
                    <a href="/mypage" class="menu-item">
                        <i data-lucide="user" size="20" class="menu-icon"></i>
                        <div class="menu-text">
                            <span class="menu-title">마이페이지</span>
                            <span class="menu-subtext">회원 정보</span>
                        </div>
                    </a>
                    <% } %>
            </div>

            <div class="sidemenu-footer">
                <p>© 2026 TRAFFIC:ON. All rights reserved.</p>
            </div>
        </div>
    </div>

    <script>
        // Side Menu Control Logic
        const sidemenuOverlay = document.getElementById('sidemenuOverlay');
        const closeSideMenu = document.getElementById('closeSideMenu');

        // Function to open menu (to be called from any page's header)
        function openSideMenu() {
            sidemenuOverlay.style.display = 'flex';
            // Add timeout for transition
            setTimeout(() => {
                sidemenuOverlay.classList.add('active');
            }, 10);
        }

        // Function to close menu
        function closeSideMenuFn() {
            sidemenuOverlay.classList.remove('active');
            setTimeout(() => {
                sidemenuOverlay.style.display = 'none';
            }, 300);
        }

        closeSideMenu.addEventListener('click', closeSideMenuFn);
        sidemenuOverlay.addEventListener('click', (e) => {
            if (e.target === sidemenuOverlay) {
                closeSideMenuFn();
            }
        });

        // Initialize icons
        if (window.lucide) {
            lucide.createIcons();
        }
    </script>