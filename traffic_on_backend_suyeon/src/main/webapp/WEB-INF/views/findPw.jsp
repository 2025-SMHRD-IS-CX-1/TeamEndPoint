<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>비밀번호 찾기</title>

  <link rel="stylesheet" href="/css/common.css" />
  <link rel="stylesheet" href="/css/findPw.css" />
</head>
<body>
  <div class="find-pw-container">
    <header class="find-pw-header">
      <div class="logo-area">
        <img src="/images/mascot.png" alt="Mascot" class="mascot-img-header" />
        <span class="logo-text">TRAFFIC:ON</span>
      </div>
    </header>

      <div class="find-pw-stage">
    <main class="find-pw-main">
		<div class="find-pw-card">

        <!-- STEP 1~2 -->
        <section id="step12">
          <h2 class="find-pw-title">비밀번호 찾기</h2>

          <div class="description-container">
            <p class="find-pw-description">
              아이디를 입력해 주세요.
              <span class="info-icon" id="infoIcon">?</span>
            </p>

            <div class="tooltip-bubble" id="tooltip" style="display:none;">
              <button type="button" class="tooltip-close" id="tooltipClose">✕</button>
              <p>가입된 아이디를 입력해 주세요.</p>
            </div>
          </div>

          <div class="input-group">
            <div class="input-wrapper">
              <input type="text" id="user-id" name="username" placeholder=" " class="floating-input" />
              <label for="user-id" class="floating-label">아이디</label>
            </div>

            <!-- STEP 2에서만 보이게 -->
            <div class="input-wrapper fade-in" id="contactBlock" style="display:none;">
              <input type="text" id="user-contact" name="contact" placeholder=" " class="floating-input" />
              <label for="user-contact" class="floating-label">전화번호 또는 본인확인 이메일</label>
            </div>
          </div>

          <div class="action-row">
            <a href="#" class="link-text">휴대폰 본인인증으로 찾기</a>
            <button type="button" class="next-btn" id="nextBtn12">다음</button>
          </div>
        </section>

        <!-- STEP 3 -->
        <section id="step3" class="verification-container fade-in" style="display:none;">
          <div class="verification-title">
            <h3>문자를 발송했어요</h3>
            <p class="verification-subtitle">인증번호를 입력해 주세요</p>
          </div>

          <div class="input-wrapper">
            <input
              type="text"
              id="verificationCode"
              name="verificationCode"
              placeholder=" "
              class="floating-input"
              maxlength="6"
            />
            <label class="floating-label center-label">인증번호 6자리</label>
          </div>

          <div class="timer-area">
            <span class="resend-link">재전송</span>
            <button type="button" class="next-btn" id="nextBtn3">다음</button>
          </div>

          <div class="timer-text">
            남은 시간 04:58 <span class="info-icon" style="margin:0 5px;">?</span>
            <a href="#" class="extend-time">시간연장</a>
          </div>
        </section>

        <!-- STEP 4 -->
        <section id="step4" class="new-password-container fade-in" style="display:none;">
          <h2 class="find-pw-title" style="margin-bottom:20px;">새 비밀번호를 입력해 주세요</h2>

          <div class="input-group">
            <div class="input-wrapper">
              <input type="password" id="newPassword" name="newPassword" placeholder=" " class="floating-input" />
              <label class="floating-label center-label">비밀번호</label>
            </div>

            <div class="input-wrapper">
              <input type="password" id="confirmPassword" name="confirmPassword" placeholder=" " class="floating-input" />
              <label class="floating-label center-label">비밀번호 확인</label>
            </div>
          </div>

          <p class="password-help-text">
            영문 대/소문자, 숫자, 특수문자를 사용하여 8~16자로 설정해 주세요. 쉬운 비밀번호나 다른 사이트에서 사용한 비밀번호, 도용된 비밀번호는 사용하지 않도록 주의해 주세요.
          </p>

          <div class="action-row right-align">
            <button type="button" class="next-btn full-width" id="confirmBtn">확인</button>
          </div>
        </section>

      </div>

      <!-- onBack() 대체: 로그인으로 링크 -->
      <a class="back-btn" href="/login">로그인으로 돌아가기</a>
    </main>
  </div>

  <script>
    // step: 1 -> 2 -> 3 -> 4
    let step = 1;

    const step12 = document.getElementById("step12");
    const step3 = document.getElementById("step3");
    const step4 = document.getElementById("step4");
    const contactBlock = document.getElementById("contactBlock");

    // tooltip
    const infoIcon = document.getElementById("infoIcon");
    const tooltip = document.getElementById("tooltip");
    const tooltipClose = document.getElementById("tooltipClose");

    infoIcon.addEventListener("click", () => {
      tooltip.style.display = (tooltip.style.display === "none") ? "block" : "none";
    });
    tooltipClose.addEventListener("click", () => {
      tooltip.style.display = "none";
    });

    function goToStep(next) {
      step = next;

      // reset visibility
      step12.style.display = "none";
      step3.style.display = "none";
      step4.style.display = "none";
      contactBlock.style.display = "none";

      if (step === 1) {
        step12.style.display = "block";
        document.getElementById("user-id").focus();
      } else if (step === 2) {
        step12.style.display = "block";
        contactBlock.style.display = "block";
        document.getElementById("user-contact").focus();
      } else if (step === 3) {
        step3.style.display = "block";
        document.getElementById("verificationCode").focus();
      } else if (step === 4) {
        step4.style.display = "block";
        document.getElementById("newPassword").focus();
      }
    }

    document.getElementById("nextBtn12").addEventListener("click", () => {
      if (step === 1) goToStep(2);
      else if (step === 2) goToStep(3);
    });

    document.getElementById("nextBtn3").addEventListener("click", () => {
      goToStep(4);
    });

    document.getElementById("confirmBtn").addEventListener("click", () => {
      const newPw = document.getElementById("newPassword").value;
      const confirmPw = document.getElementById("confirmPassword").value;

      if (newPw !== confirmPw) {
        alert("비밀번호가 일치하지 않습니다.");
        return;
      }

      alert("비밀번호가 변경되었습니다.");
      window.location.href = "/login";
    });

    // start at step1
    goToStep(1);
  </script>
</body>
</html>