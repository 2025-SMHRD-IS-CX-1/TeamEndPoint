<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Login.css" />
</head>

<body>
  <div class="login-container">
    <div id="toast" class="toast"></div>

    <!-- Header -->
    <header class="login-header">
      <img src="${pageContext.request.contextPath}/images/Pengrimi.png"
           alt="Mascot"
           class="mascot-img-login" />
      <h1 class="login-logo-text">TRAFFIC:ON</h1>
    </header>

    <!-- Main -->
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

        <!-- Form -->
        <form class="login-form-area user"
              id="loginForm"
              method="post"
              action="${pageContext.request.contextPath}/login">

          <input type="hidden" name="activeTab" id="activeTab" value="user" />

          <div class="input-group">
            <input type="text" name="username" id="id" placeholder="아이디" required />
          </div>

          <div class="input-group">
            <div class="pw-wrap">
              <input type="password"
                     name="password"
                     id="password"
                     placeholder="비밀번호"
                     required />

              <button type="button"
                      class="pw-toggle-btn"
                      onclick="togglePw('password', this)">
                👁
              </button>
            </div>
          </div>

          <!-- user 탭에서만 -->
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
            <a href="${pageContext.request.contextPath}/findPw">비밀번호 찾기</a>
            <span class="divider">|</span>
            <a href="${pageContext.request.contextPath}/find-id">아이디 찾기</a>
            <span class="divider">|</span>
            <a href="${pageContext.request.contextPath}/signup">회원가입</a>
          </div>

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

      activeTabInput.value = tab;

      document.getElementById("id").value = "";
      document.getElementById("password").value = "";
    }

    function showToast(message){
      const t = document.getElementById("toast");
      t.textContent = message;
      t.classList.add("show");

      clearTimeout(window.__toastTimer);
      window.__toastTimer =
        setTimeout(() => t.classList.remove("show"), 2000);
    }

    window.addEventListener("DOMContentLoaded", () => {

      const error = "${param.error}";
      const tab = "${param.tab}";

      if (tab === "admin") setTab("admin");
      else setTab("user");

      if (error === "notAdmin") {
        showToast("관리자 계정이 아닙니다.");
        setTab("admin");
      } else if (error === "true") {
        showToast("아이디 또는 비밀번호가 올바르지 않습니다.");
      }

      const signup = "${param.signup}";
      if (signup === "success") {
        alert("회원가입이 완료되었습니다! 로그인 해주세요 😊");
      } else if (signup === "admin_success") {
        alert("관리자 회원가입이 완료되었습니다! 로그인 해주세요 😊");
      }

      const pwChanged = "${param.pwChanged}";
      if (pwChanged === "true") {
        alert("비밀번호가 변경되었습니다. 다시 로그인해 주세요.");
      }
    });

    function togglePw(inputId, btn) {
      const input = document.getElementById(inputId);
      const isPw = input.type === "password";
      input.type = isPw ? "text" : "password";
      btn.textContent = isPw ? "🙈" : "👁";
    }

  </script>

</body>
</html>