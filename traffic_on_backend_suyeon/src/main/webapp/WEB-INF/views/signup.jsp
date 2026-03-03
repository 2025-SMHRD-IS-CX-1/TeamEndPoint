<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <title>회원가입</title>

  <!-- CSS 연결 -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Signup.css" />
</head>
<body>
<div class="signup-container">

  <!-- Header -->
  <header class="signup-header">
    <div class="header-left">
      <button class="back-arrow-btn" type="button" onclick="handleBack()">
        <span class="arrow-icon">❮</span>
      </button>
    </div>

    <div class="logo-area">
      <img src="${pageContext.request.contextPath}/images/mascot.png" alt="Mascot" class="mascot-img-header" />
      <span class="logo-text">TRAFFIC:ON</span>
    </div>

    <div class="header-right"></div>
  </header>

  <main class="signup-main">

    <!-- ====== (1) Selection View ====== -->
    <div id="selectionView" class="selection-view fade-in">
      <div class="selection-card">
        <div class="icon-circle personal">👤</div>
        <button class="selection-btn" type="button" onclick="selectType('personal')">
          일반 회원가입 <span class="arrow">›</span>
        </button>
      </div>

      <div class="selection-card">
        <div class="icon-circle enterprise">🏢</div>
        <button class="selection-btn" type="button" onclick="selectType('enterprise')">
          관리자 회원가입 <span class="arrow">›</span>
        </button>
      </div>
    </div>

    <!-- ====== (2) Form View ====== -->
    <div id="formView" class="signup-card" style="display:none;">
      <h2 id="signupTitle" class="signup-title">일반 회원가입</h2>
      <p id="enterpriseHint" class="signup-hint" style="display:none;">
        (<span class="required-mark">*</span> 표시된 부분은 필수 입력 항목입니다.)
      </p>

      <form class="signup-form" method="post" action="${pageContext.request.contextPath}/signup" autocomplete="off">

        <!-- 🔥 관리자/일반 구분용 hidden -->
        <input type="hidden" name="activeTab" id="activeTab" value="user">
        <input type="hidden" name="memType" id="memType" value="USER">

        <div class="input-group">

          <!-- ===== enterprise-only : phone (관리자 휴대폰) ===== -->
          <div id="entTopPhoneBlock" style="display:none;">
            <div class="form-row-group">
              <div class="form-label-with-icon">
                <span class="label-icon">📱</span>
                <label>휴대전화번호 <span class="required-mark">*</span></label>
              </div>

              <div class="phone-input-row">
                <div class="input-with-clear">
                  <input type="text"
                         id="memPhoneEnt"
                         name="memPhone"
                         class="full-width-input phone-only"
                         maxlength="11"
                         inputmode="numeric"
                         pattern="[0-9]*"
                         disabled
                         placeholder="숫자만 입력"
                         oninput="this.value = this.value.replace(/[^0-9]/g, '')" />
                  <button type="button" class="clear-btn" onclick="clearById('memPhoneEnt')">×</button>
                </div>
              </div>
            </div>
          </div>

          <!-- ID -->
          <div class="form-row-group">
            <div class="form-label-with-icon">
              <span class="label-icon">🆔</span>
              <label>아이디 <span class="required-mark">*</span></label>
            </div>

            <div class="phone-input-row">
              <div class="input-with-clear">
                <input type="text"
                       name="memId"
                       class="full-width-input"
                       required autocomplete="off" readonly
                       onfocus="this.removeAttribute('readonly');"
                       oninput="resetIdCheck()" />
                <button type="button" class="clear-btn" onclick="clearValue('memId')">×</button>
              </div>

              <button type="button" class="id-check-btn" onclick="checkUsername()">중복확인</button>
            </div>

            <small id="usernameMsg" class="field-msg"></small>
          </div>

          <!-- 이름 -->
          <div class="form-row-group">
            <div class="form-label-with-icon">
              <span class="label-icon">👤</span>
              <label>이름 <span class="required-mark">*</span></label>
            </div>
            <div class="input-with-clear">
              <input type="text" name="memName" class="full-width-input" required />
              <button type="button" class="clear-btn" onclick="clearValue('memName')">×</button>
            </div>
          </div>

          <!-- Password -->
          <div class="form-row-group">
            <div class="form-label-with-icon">
              <span class="label-icon">🔒</span>
              <label>
                비밀번호 <span class="required-mark">*</span>
                <button type="button" class="help-icon-btn" onclick="togglePasswordHint()">?</button>
              </label>
            </div>

            <div class="pw-wrap" style="position:relative;">
              <input type="password"
                     name="memPw"
                     id="signupPw"
                     class="full-width-input"
                     required />

              <button type="button"
                      class="pw-toggle-btn"
                      onclick="togglePw('signupPw', this)">
                👁
              </button>

              <div id="passwordHint"
                   class="password-hint-tooltip"
                   style="display:none; top:-60px;">
                8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.
              </div>
            </div>
          </div>

          <!-- Password Confirm -->
          <div class="form-row-group">
            <div class="pw-wrap" style="position:relative;">
              <input type="password"
                     name="confirmPassword"
                     id="signupPw2"
                     class="full-width-input"
                     required />

              <button type="button"
                      class="pw-toggle-btn"
                      onclick="togglePw('signupPw2', this)">
                👁
              </button>
            </div>

            <small id="pwMatchMsg" class="field-msg"></small>
          </div>

          <!-- Email -->
          <div class="form-row-group">
            <div class="form-label-with-icon">
              <span class="label-icon">📧</span>
              <label>이메일 <span class="required-mark">*</span></label>
            </div>
            <div class="input-with-clear">
              <input type="email" name="memEmail" class="full-width-input" required />
              <button type="button" class="clear-btn" onclick="clearValue('memEmail')">×</button>
            </div>
          </div>

          <!-- ===== personal-only block ===== -->
          <div id="personalBlock">

            <!-- Birthdate -->
            <div class="form-row-group">
              <div class="form-label-with-icon">
                <span class="label-icon">📅</span>
                <label>생년월일 <span class="required-mark">*</span></label>
              </div>
              <div class="date-input-wrapper">
                <input type="date" name="memBirthdate" class="full-width-input date-picker-input" required />
              </div>
            </div>

            <!-- Gender -->
            <div class="form-row-group">
              <div class="form-label-with-icon">
                <span class="label-icon">🚻</span>
                <label>성별 <span class="required-mark">*</span></label>
              </div>

              <div class="gender-selection">
                <label class="gender-option active" onclick="setGender('male')">
                  <input type="radio" name="memGender" value="M" checked />
                  남성
                </label>
                <label class="gender-option" onclick="setGender('female')">
                  <input type="radio" name="memGender" value="F" />
                  여성
                </label>
              </div>
            </div>

            <!-- District -->
            <div class="form-row-group">
              <div class="form-label-with-icon">
                <span class="label-icon">📍</span>
                <label>거주 지역 <span class="required-mark">*</span></label>
              </div>

              <div class="district-options">
                <label><input type="radio" name="memAddr" value="광산구" required> 광산구</label>
                <label><input type="radio" name="memAddr" value="북구"> 북구</label>
                <label><input type="radio" name="memAddr" value="서구"> 서구</label>
                <label><input type="radio" name="memAddr" value="남구"> 남구</label>
                <label><input type="radio" name="memAddr" value="동구"> 동구</label>
              </div>
            </div>

            <!-- Phone (personal) -->
            <div class="form-row-group">
              <div class="form-label-with-icon">
                <span class="label-icon">📱</span>
                <label>휴대전화번호 <span class="required-mark">*</span></label>
              </div>

              <div class="phone-input-row">
                <div class="input-with-clear">
                  <input type="text"
                         id="memPhonePer"
                         name="memPhone"
                         class="full-width-input phone-only"
                         required
                         maxlength="11"
                         inputmode="numeric"
                         pattern="[0-9]*"
                         placeholder="숫자만 입력"
                         oninput="this.value = this.value.replace(/[^0-9]/g, '')" />
                  <button type="button" class="clear-btn" onclick="clearById('memPhonePer')">×</button>
                </div>
              </div>
            </div>

          </div>

          <!-- ===== enterprise-only : business section ===== -->
          <div id="enterpriseBlock" class="enterprise-section fade-in" style="display:none;">
            <h3 class="section-title">사업자정보 확인</h3>

            <div class="form-row-group">
              <div class="form-label-with-icon">
                <span class="label-icon">🏢</span>
                <label>사업자등록번호 <span class="required-mark">*</span></label>
              </div>

              <div class="business-num-inputs">
                <div class="input-with-clear">
                  <input type="text" name="businessNum1" placeholder="3자리" maxlength="3" />
                  <button type="button" class="clear-btn small" onclick="clearValue('businessNum1')">×</button>
                </div>
                <span class="dash">-</span>
                <div class="input-with-clear">
                  <input type="text" name="businessNum2" placeholder="2자리" maxlength="2" />
                  <button type="button" class="clear-btn small" onclick="clearValue('businessNum2')">×</button>
                </div>
                <span class="dash">-</span>
                <div class="input-with-clear">
                  <input type="text" name="businessNum3" placeholder="5자리" maxlength="5" />
                  <button type="button" class="clear-btn small" onclick="clearValue('businessNum3')">×</button>
                </div>
              </div>
            </div>

            <div class="form-row-group">
              <div class="form-label-with-icon">
                <span class="label-icon">🔒</span>
                <label>사무대행기관 번호 <span class="required-mark">*</span></label>
              </div>
              <div class="input-with-clear">
                <input type="text" name="agencyNum" class="full-width-input" placeholder="사무대행기관 번호 10자리를 입력해 주세요." maxlength="10" />
                <button type="button" class="clear-btn" onclick="clearValue('agencyNum')">×</button>
              </div>
            </div>

            <div class="form-row-group">
              <div class="form-label-with-icon">
                <span class="label-icon">👤</span>
                <label>대표자 성명 <span class="required-mark">*</span></label>
              </div>
              <div class="input-with-clear">
                <input type="text" name="ceoName" class="full-width-input" placeholder="사업자등록증 대표자 성명(공동대표인 경우 1명)을 입력하세요." />
                <button type="button" class="clear-btn" onclick="clearValue('ceoName')">×</button>
              </div>
            </div>

            <div class="form-row-group">
              <div class="form-label-with-icon">
                <span class="label-icon">📅</span>
                <label>개업일 <span class="required-mark">*</span></label>
              </div>
              <div class="date-input-wrapper">
                <input type="date" name="openDate" class="full-width-input date-picker-input" required />
              </div>
            </div>
          </div>

          <!-- Agreements -->
          <div class="agreements-section">
            <div class="agreement-item all-agree">
              <label class="checkbox-container">
                <input type="checkbox" id="agreeAll" />
                <span class="checkmark-circle"></span>
                <span class="agreement-text main">전체 동의하기</span>
              </label>
            </div>

            <div class="agreement-sub-text">
              이용약관, 위치기반서비스 이용약관(필수), 개인정보 수집 및 이용(필수) 동의를 포함합니다.
            </div>

            <div class="agreement-item">
              <label class="checkbox-container">
                <input type="checkbox" class="agreeItem" required />
                <span class="checkmark-circle"></span>
                <span class="agreement-text"><span class="req">[필수]</span> TRAFFIC:ON 이용약관</span>
              </label>
              <button type="button" class="view-link">보기</button>
            </div>

            <div class="agreement-item">
              <label class="checkbox-container">
                <input type="checkbox" class="agreeItem" required />
                <span class="checkmark-circle"></span>
                <span class="agreement-text"><span class="req">[필수]</span> 위치정보 서비스 이용약관</span>
              </label>
              <button type="button" class="view-link">보기</button>
            </div>

            <div class="agreement-item">
              <label class="checkbox-container">
                <input type="checkbox" class="agreeItem" required />
                <span class="checkmark-circle"></span>
                <span class="agreement-text"><span class="req">[필수]</span> 개인정보 수집 및 이용</span>
              </label>
              <button type="button" class="view-link">보기</button>
            </div>
          </div>

        </div>

        <div class="action-row-center">
          <button type="submit" class="signup-next-btn">가입하기</button>
        </div>
      </form>

    </div>
  </main>
</div>

<script>
  let currentType = 'personal';

  // ✅ 처음 로딩될 때, required였던 애들 표시(원복용)
  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll("#formView [required]").forEach(el => {
      el.dataset.req = "1";
    });

    // 기본은 personal 기준
    applyRequiredByType("personal");

    // ✅ 비번 재확인: 재확인칸 입력 시작할 때만 표시
    const pw1El = document.getElementById("signupPw");
    const pw2El = document.getElementById("signupPw2");
    if (pw2El) pw2El.addEventListener("input", checkPwMatch);
    if (pw1El) pw1El.addEventListener("input", checkPwMatch);
  });

  function handleBack() {
    const formViewVisible = document.getElementById('formView').style.display !== 'none';
    if (formViewVisible) {
      resetForm();
      document.getElementById('formView').style.display = 'none';
      document.getElementById('selectionView').style.display = 'flex';
    } else {
      location.href = '${pageContext.request.contextPath}/login';
    }
  }

  function clearValue(name) {
    const el = document.querySelector('[name="' + name + '"]');
    if (el) el.value = '';
  }

  function clearById(id) {
    const el = document.getElementById(id);
    if (el) el.value = '';
  }

  function togglePasswordHint() {
    const hint = document.getElementById('passwordHint');
    hint.style.display = (hint.style.display === 'none' || hint.style.display === '') ? 'block' : 'none';
  }

  // ✅ memGender 기준 (라벨 active만)
  function setGender(val) {
    const labels = document.querySelectorAll('.gender-option');
    labels.forEach(l => l.classList.remove('active'));
    if (val === 'male') labels[0].classList.add('active');
    else labels[1].classList.add('active');
  }

  // 전체동의
  const agreeAll = document.getElementById('agreeAll');
  const items = document.querySelectorAll('.agreeItem');

  agreeAll.addEventListener('change', function() {
    items.forEach(ch => ch.checked = agreeAll.checked);
  });

  items.forEach(ch => {
    ch.addEventListener('change', function() {
      agreeAll.checked = Array.from(items).every(x => x.checked);
    });
  });

  document.addEventListener("click", function(e) {
    const hint = document.getElementById("passwordHint");
    const button = document.querySelector(".help-icon-btn");
    if (hint && button && !button.contains(e.target) && !hint.contains(e.target)) {
      hint.style.display = "none";
    }
  });

  // ✅ memId 기준 (DB로 중복확인)
  let idChecked = false;
  let lastCheckedId = "";

  function checkUsername() {
    const v = document.querySelector('[name="memId"]').value.trim();
    const msg = document.getElementById('usernameMsg');

    if (!v) {
      msg.textContent = '아이디를 입력해 주세요.';
      msg.style.color = 'red';
      idChecked = false;
      return;
    }

    // 영문 소문자 + 숫자만 허용 (4~16자)
    const idRegex = /^[a-z0-9]{4,16}$/;
    if (!idRegex.test(v)) {
      msg.textContent = "아이디는 영문 소문자와 숫자 4~16자만 가능합니다.";
      msg.style.color = "red";
      idChecked = false;
      return;
    }

    const ctx = '${pageContext.request.contextPath}';

    fetch(`${ctx}/api/member/check-id?memId=` + encodeURIComponent(v))
      .then(res => res.json())
      .then(isDuplicated => {
        if (isDuplicated) {
          msg.textContent = '이미 사용 중인 아이디입니다.';
          msg.style.color = 'red';
          idChecked = false;
        } else {
          msg.textContent = '사용 가능한 아이디입니다!';
          msg.style.color = 'green';
          idChecked = true;
          lastCheckedId = v;
        }
      })
      .catch(err => {
        console.error(err);
        msg.textContent = '중복확인 중 오류가 발생했습니다.';
        msg.style.color = 'red';
        idChecked = false;
      });
  }

  function resetIdCheck() {
    idChecked = false;
    lastCheckedId = "";
    const msg = document.getElementById('usernameMsg');
    if (msg) {
      msg.textContent = '아이디 중복확인을 해주세요.';
      msg.style.color = '#999';
    }
  }

  // ✅✅✅ 핵심: 타입별 required 토글 + (중요) 폰 disabled 토글
  function applyRequiredByType(type) {
    const personalBlock = document.getElementById("personalBlock");
    const enterpriseBlock = document.getElementById("enterpriseBlock");
    const entTopPhoneBlock = document.getElementById("entTopPhoneBlock");

    toggleBlockRequired(personalBlock, type === "personal");
    toggleBlockRequired(enterpriseBlock, type === "enterprise");
    toggleBlockRequired(entTopPhoneBlock, type === "enterprise");

    // ✅ 폰 input은 name이 같아서 "선택된 것만 submit" 되게 disabled 처리
    const perPhone = document.getElementById("memPhonePer");
    const entPhone = document.getElementById("memPhoneEnt");

    if (type === "personal") {
      if (perPhone) { perPhone.disabled = false; perPhone.required = true; }
      if (entPhone) { entPhone.disabled = true;  entPhone.required = false; entPhone.value = ""; }
    } else {
      if (entPhone) { entPhone.disabled = false; entPhone.required = true; }
      if (perPhone) { perPhone.disabled = true;  perPhone.required = false; perPhone.value = ""; }
    }
  }

  function toggleBlockRequired(blockEl, shouldRequire) {
    if (!blockEl) return;

    const fields = blockEl.querySelectorAll("input, select, textarea");
    fields.forEach(el => {
      if (el.dataset.req === "1") {
        if (shouldRequire) el.setAttribute("required", "");
        else el.removeAttribute("required");
      }
    });
  }

  function selectType(type) {
    currentType = type;

    resetForm();
    setTimeout(resetForm, 0);
    setTimeout(resetForm, 50);

    document.getElementById('selectionView').style.display = 'none';
    document.getElementById('formView').style.display = 'flex';

    document.getElementById('signupTitle').innerText =
      (type === 'personal') ? '일반 회원가입' : '관리자 회원가입';

    document.getElementById('enterpriseHint').style.display =
      (type === 'enterprise') ? 'block' : 'none';

    document.getElementById('enterpriseBlock').style.display =
      (type === 'enterprise') ? 'block' : 'none';

    document.getElementById('personalBlock').style.display =
      (type === 'personal') ? 'block' : 'none';

    document.getElementById('entTopPhoneBlock').style.display =
      (type === 'enterprise') ? 'block' : 'none';

    document.getElementById('activeTab').value =
      (type === 'enterprise') ? 'admin' : 'user';

    document.getElementById('memType').value =
      (type === 'enterprise') ? 'ADMIN' : 'USER';

    applyRequiredByType(type);
  }

  function resetForm() {
    document.querySelectorAll('#formView input').forEach(i => {
      if (i.type === 'checkbox' || i.type === 'radio' || i.type === 'hidden') return;
      i.value = '';
    });

    const msg = document.getElementById('usernameMsg');
    if (msg) msg.textContent = '';

    const pwMsg = document.getElementById('pwMatchMsg');
    if (pwMsg) pwMsg.textContent = '';
  }

  // 🔥 가입 버튼 누를 때 검증
  document.querySelector(".signup-form").addEventListener("submit", function (e) {

    const currentId = document.querySelector('[name="memId"]').value.trim();

    if (!idChecked || currentId !== lastCheckedId) {
      alert("아이디 중복확인을 먼저 해주세요!");
      e.preventDefault();
      return;
    }

    const pw1 = document.getElementById("signupPw")?.value || "";
    const pw2 = document.getElementById("signupPw2")?.value || "";

    if (pw1 !== pw2) {
      alert("비밀번호가 일치하지 않습니다.");
      e.preventDefault();
      return;
    }

    // hidden 최종 확정
    document.getElementById("activeTab").value =
      (currentType === "enterprise") ? "admin" : "user";

    document.getElementById("memType").value =
      (currentType === "enterprise") ? "ADMIN" : "USER";
  });

  // 👁 비번 보기
  function togglePw(inputId, btn) {
    const input = document.getElementById(inputId);
    if (!input) return;

    const isPw = input.type === "password";
    input.type = isPw ? "text" : "password";
    btn.textContent = isPw ? "🙈" : "👁";
  }

  // ✅ 재확인칸 입력 시작할 때만 메시지
  function checkPwMatch() {
    const pw1El = document.getElementById("signupPw");
    const pw2El = document.getElementById("signupPw2");
    const msg = document.getElementById("pwMatchMsg");

    if (!pw1El || !pw2El || !msg) return;

    const v1 = pw1El.value || "";
    const v2 = pw2El.value || "";

    if (!v2) {
      msg.textContent = "";
      return;
    }

    if (v1 === v2) {
      msg.textContent = "비밀번호가 일치합니다.";
      msg.style.color = "green";
    } else {
      msg.textContent = "비밀번호가 일치하지 않습니다.";
      msg.style.color = "red";
    }
  }
</script>

</body>
</html>