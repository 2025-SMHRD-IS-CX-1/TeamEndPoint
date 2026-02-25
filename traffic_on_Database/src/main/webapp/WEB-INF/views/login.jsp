<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>TRAFFIC:ON - Login</title>
  <link rel="stylesheet" href="<%=ctx%>/resources/css/Login.css" />
</head>
<body>
System.out.println("Hello Team!");
<div class="login-container">

  <header class="login-header">
    <!-- 이미지 경로는 프로젝트에 맞게 조정 -->
    <img src="<%=ctx%>/resources/assets/mascot.png" alt="Mascot" class="mascot-img-login" />
    <h1 class="login-logo-text">TRAFFIC:ON</h1>
  </header>

  <main class="login-main">
    <div class="login-card">

      <!-- Tabs -->
      <div class="login-tabs">
        <button type="button" class="tab active" id="tabUser">
          <span class="tab-icon">➜</span>
          ID
        </button>
        <button type="button" class="tab" id="tabAdmin">
          <span class="tab-icon">⚙️</span>
          관리자
        </button>
      </div>

      <!-- Form Area -->
      <div class="login-form-area user" id="formArea">
        <form action="<%=ctx%>/login" method="post">
          <!-- user/admin 구분 -->
          <input type="hidden" name="loginType" id="loginType" value="user" />

          <div class="input-group">
            <input type="text" name="username" placeholder="아이디" />
          </div>

          <div class="input-group">
            <input type="password" name="password" placeholder="비밀번호" />
          </div>

          <!-- 로그인 상태 유지: 일단 UI만 (원하면 name 유지해서 서버로 보내도 됨) -->
          <div class="checkbox-group" id="keepBox">
            <label>
              <input type="checkbox" name="keepLoggedIn" value="Y" />
              <span class="checkmark start">✔</span>
              로그인 상태 유지
            </label>
          </div>

          <button class="login-btn" type="submit">로그인</button>
        </form>

        <div class="login-links">
          <a href="<%=ctx%>/findPassword.jsp">비밀번호 찾기</a>
          <span class="divider">|</span>
          <a href="<%=ctx%>/findId.jsp">아이디 찾기</a>
          <span class="divider">|</span>
          <a href="<%=ctx%>/signup.jsp">회원가입</a>
        </div>
      </div>

    </div>
  </main>

</div>

<script>
  const tabUser = document.getElementById('tabUser');
  const tabAdmin = document.getElementById('tabAdmin');
  const formArea = document.getElementById('formArea');
  const loginType = document.getElementById('loginType');
  const keepBox = document.getElementById('keepBox');

  function setTab(type) {
    if (type === 'user') {
      tabUser.classList.add('active');
      tabAdmin.classList.remove('active');
      formArea.classList.remove('admin');
      formArea.classList.add('user');
      loginType.value = 'user';
      keepBox.style.display = '';
    } else {
      tabAdmin.classList.add('active');
      tabUser.classList.remove('active');
      formArea.classList.remove('user');
      formArea.classList.add('admin');
      loginType.value = 'admin';
      keepBox.style.display = 'none';
    }
  }

  tabUser.addEventListener('click', () => setTab('user'));
  tabAdmin.addEventListener('click', () => setTab('admin'));
</script>

</body>
</html>
