<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>아이디 찾기</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/findId.css" />
</head>
<body>

<div class="find-id-container">
  <!-- Header -->
  <header class="find-id-header">
    <div class="logo-area">
      <img src="/images/mascot.png" alt="Mascot" class="mascot-img-header" />
      <span class="logo-text">TRAFFIC:ON</span>
    </div>
  </header>

  <main class="find-id-main">
    <div class="find-id-card">

      <!-- step < 3 -->
      <div id="step_lt_3">
        <h2 class="find-id-title">아이디 찾기</h2>

        <div class="description-container">
          <p class="find-id-description">
            전화번호나 이메일을 입력해 주세요.
            <span class="info-icon" id="infoIcon">?</span>
          </p>

          <!-- showTooltip -->
          <div class="tooltip-bubble" id="tooltipBubble" style="display:none;">
            <button type="button" class="tooltip-close" id="tooltipClose">✕</button>
            <p>가입 시 등록한 정보를 입력해 주세요.</p>
          </div>
        </div>

        <div class="input-group">
          <div class="input-wrapper">
            <input
              type="text"
              id="user-contact"
              placeholder=" "
              class="floating-input"
            />
            <label for="user-contact" class="floating-label">
              전화번호 또는 본인확인 이메일
            </label>
          </div>

          <!-- step === 2 -->
          <div class="input-wrapper fade-in" id="step_eq_2_name_wrapper" style="display:none;">
            <input
              type="text"
              id="user-name"
              placeholder=" "
              class="floating-input"
              autocomplete="off"
            />
            <label for="user-name" class="floating-label">
              이름 또는 관리자 명
            </label>
          </div>
        </div>

        <div class="action-row">
          <a href="#" class="link-text" onclick="return false;">휴대폰 본인인증으로 찾기</a>
          <button type="button" class="next-btn" id="btnNext12">다음</button>
        </div>
      </div>

      <!-- step === 3 -->
      <div class="verification-container fade-in" id="step_eq_3" style="display:none;">
        <div class="verification-title">
          <h3>문자를 발송했어요</h3>
          <p class="verification-subtitle">인증번호를 입력해 주세요</p>
        </div>

        <div class="input-wrapper">
          <input
            type="text"
            placeholder=" "
            class="floating-input"
            id="verificationCode"
            maxlength="6"
            autocomplete="one-time-code"
          />
          <label class="floating-label center-label">
            인증번호 6자리
          </label>
        </div>

        <div class="timer-area">
          <span class="resend-link">재전송</span>
          <button type="button" class="next-btn" id="btnNext3">다음</button>
        </div>

        <div class="timer-text">
          남은 시간 04:58
          <span class="info-icon" style="margin: 0 5px">?</span>
          <a href="#" class="extend-time" onclick="return false;">시간연장</a>
        </div>
      </div>

      <!-- step === 4 -->
      <div class="result-container fade-in" id="step_eq_4" style="display:none;">
        <div class="result-header">
          <h3 class="result-message">
            <span class="user-highlight" id="userHighlight">회원</span>님의 아이디는<br />
            <span class="id-highlight">bznav****</span>입니다.
          </h3>
        </div>

        <div class="info-box">
          <div class="info-content">
            <span class="info-bullet">ⓘ</span>
            <p>
              정보 보호를 위해 아이디의 일부만 보여줍니다. 가려지지 않은 전체 아이디는 홈텍스에서 추가 인증을 통해 확인할 수 있습니다.
            </p>
          </div>
        </div>

        <div class="action-row full-button">
          <button type="button" class="next-btn full-width" id="btnLoginGo">로그인 하기</button>
        </div>
      </div>

    </div>

    <!-- step !== 4 -->
    <button type="button" class="back-btn" id="btnBack">
      로그인으로 돌아가기
    </button>

  </main>
</div>

<script>
  // React state 대응
  let showTooltip = false;
  let step = 1;

  let verificationCode = '';
  let userName = '';

  // onBack 대응 (원하면 URL 바꾸기)
  function onBack() {
    window.location.href = "/login";
  }

  function setShowTooltip(next) {
    showTooltip = next;
    document.getElementById("tooltipBubble").style.display = showTooltip ? "block" : "none";
  }

  function setStep(nextStep) {
    step = nextStep;
    render();
  }

  function render() {
    // step < 3
    document.getElementById("step_lt_3").style.display = (step < 3) ? "block" : "none";

    // step === 2 (이름 입력 보이기)
    document.getElementById("step_eq_2_name_wrapper").style.display = (step === 2) ? "block" : "none";

    // step === 3
    document.getElementById("step_eq_3").style.display = (step === 3) ? "flex" : "none";

    // step === 4
    document.getElementById("step_eq_4").style.display = (step === 4) ? "flex" : "none";

    // step !== 4 → back 버튼 보이기
    document.getElementById("btnBack").style.display = (step !== 4) ? "block" : "none";

    // 결과 화면 이름 반영 (React: userName || '회원')
    document.getElementById("userHighlight").innerText = (userName && userName.trim() !== "") ? userName : "회원";

    // step 바뀔 때 tooltip은 닫아주는 게 자연스러움 (원하면 제거 가능)
    if (step >= 3) setShowTooltip(false);
  }

  function handleNext() {
    if (step === 1) {
      setStep(2);
      // React의 autoFocus 느낌
      setTimeout(() => document.getElementById("user-name")?.focus(), 0);
    } else if (step === 2) {
      setStep(3);
      setTimeout(() => document.getElementById("verificationCode")?.focus(), 0);
    } else if (step === 3) {
      setStep(4);
    } else {
      onBack();
    }
  }

  // 이벤트 바인딩
  document.getElementById("infoIcon").addEventListener("click", () => setShowTooltip(!showTooltip));
  document.getElementById("tooltipClose").addEventListener("click", () => setShowTooltip(false));

  document.getElementById("btnNext12").addEventListener("click", handleNext);
  document.getElementById("btnNext3").addEventListener("click", handleNext);

  document.getElementById("btnBack").addEventListener("click", onBack);
  document.getElementById("btnLoginGo").addEventListener("click", onBack);

  // userName state 동기화
  const userNameInput = document.getElementById("user-name");
  if (userNameInput) {
    userNameInput.addEventListener("input", (e) => {
      userName = e.target.value;
      // 결과 화면 미리 반영
      document.getElementById("userHighlight").innerText = (userName && userName.trim() !== "") ? userName : "회원";
    });
  }

  // verificationCode state 동기화
  document.getElementById("verificationCode").addEventListener("input", (e) => {
    verificationCode = e.target.value;
  });

  // 초기 렌더
  render();
</script>

</body>
</html>