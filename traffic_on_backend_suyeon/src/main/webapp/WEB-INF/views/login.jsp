<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>Login</title>
  <link rel="stylesheet" href="/css/Login.css" />
</head>

<body>
  <div class="login-container">

    <!-- Header -->
    <header class="login-header">
      <!-- 이미지 경로는 일단 임시. 나중에 mascot.png 위치 맞추면 됨 -->
      <img src="/images/mascot.png" alt="Mascot" class="mascot-img-login" />
      <h1 class="login-logo-text">TRAFFIC:ON</h1>
    </header>

    <!-- Main Content -->
    <main class="login-main">
      <div class="login-card">

        <!-- Tabs -->
        <div class="login-tabs">
          <button type="button" class="tab active" id="tab-user" onclick="setTab('user')">
            <span class="tab-icon">➜</span>
            ID
          </button>

          <button type="button" class="tab" id="tab-admin" onclick="setTab('admin')">
            <span class="tab-icon">⚙️</span>
            관리자
          </button>
        </div>

        <!-- Form Area -->
        <!-- form submit 방식으로 만들었고, hidden으로 activeTab 같이 보냄 -->
        <form class="login-form-area user" id="loginForm" method="post" action="${pageContext.request.contextPath}/login">
          <input type="hidden" name="activeTab" id="activeTab" value="user" />

          <div class="input-group">
            <input type="text" name="id" id="id" placeholder="아이디" required />
          </div>

          <div class="input-group">
            <input type="password" name="password" id="password" placeholder="비밀번호" required />
          </div>

          <!-- user 탭에서만 보이기 -->
          <div class="checkbox-group" id="keepBox">
            <label>
              <input type="checkbox" name="keepLoggedIn" id="keepLoggedIn" />
              <span class="checkmark start">✔</span>
              로그인 상태 유지
            </label>
          </div>

          <button class="login-btn" type="submit">
            로그인
          </button>

          <div class="login-links">
            <a href="${pageContext.request.contextPath}/find-password">비밀번호 찾기</a>
            <span class="divider">|</span>
            <a href="${pageContext.request.contextPath}/find-id">아이디 찾기</a>
            <span class="divider">|</span>
            <a href="${pageContext.request.contextPath}/signup">회원가입</a>
          </div>

          <!-- 서버에서 에러 메시지 내려줄 때 -->
          <c:if test="${not empty error}">
            <p style="color:red; text-align:center; margin-top:10px;">${error}</p>
          </c:if>
        </form>

      </div>
    </main>
  </div>

  <script>
    function setTab(tab) {
      const tabUser = document.getElementById("tab-user");
      const tabAdmin = document.getElementById("tab-admin");
      const form = document.getElementById("loginForm");
      const activeTabInput = document.getElementById("activeTab");
      const keepBox = document.getElementById("keepBox");

      if (tab === "user") {
        tabUser.classList.add("active");
        tabAdmin.classList.remove("active");
        form.classList.remove("admin");
        form.classList.add("user");
        keepBox.style.display = "block";
      } else {
        tabAdmin.classList.add("active");
        tabUser.classList.remove("active");
        form.classList.remove("user");
        form.classList.add("admin");
        keepBox.style.display = "none";
        document.getElementById("keepLoggedIn").checked = false;
      }

      // 탭 값 서버로 전송
      activeTabInput.value = tab;

      // 입력값 초기화(원래 JSX 동작 그대로)
      document.getElementById("id").value = "";
      document.getElementById("password").value = "";
    }
  </script>
</body>
</html>
