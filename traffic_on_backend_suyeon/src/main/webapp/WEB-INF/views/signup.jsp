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

          <!-- ===== enterprise-only : phone + verification (위쪽에 있던 블록) ===== -->
          <div id="entTopPhoneBlock" style="display:none;">
            <div class="form-row-group">
              <div class="form-label-with-icon">
                <span class="label-icon">📱</span>
                <label>휴대전화번호 <span class="required-mark">*</span></label>
              </div>

              <div class="phone-input-row">
                <div class="input-with-clear">
                  <input type="text" name="memPhone" class="full-width-input" value="" />
                  <button type="button" class="clear-btn" onclick="clearValue('memPhone')">×</button>
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
				<input type="text" name="memId" class="full-width-input"
				  required autocomplete="off" readonly
				  onfocus="this.removeAttribute('readonly');"
				  oninput="resetIdCheck()" />
			    <button type="button" class="clear-btn" onclick="clearValue('memId')">×</button>
			  </div>

			  <button type="button" class="id-check-btn" onclick="checkUsername()">중복확인</button>
			</div>

			<!-- 🔥 여기로 빼기 -->
			<small id="usernameMsg" class="field-msg"></small>
			</div>

          <!-- ✅✅✅ 이름 (ID 바로 아래에 추가!!) -->
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

            <div style="position:relative;">
              <input type="password" name="memPw" class="full-width-input" required />
              <div id="passwordHint" class="password-hint-tooltip" style="display:none; top:-60px;">
                8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.
              </div>
            </div>
          </div>

          <!-- Password Confirm -->
          <div class="form-row-group">
            <div class="form-label-with-icon">
              <span class="label-icon">🔒</span>
              <label>비밀번호 확인 <span class="required-mark">*</span></label>
            </div>
            <input type="password" name="confirmPassword" class="full-width-input" required />
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

            <!-- Phone (personal 아래쪽) -->
            <div class="form-row-group">
              <div class="form-label-with-icon">
                <span class="label-icon">📱</span>
                <label>휴대전화번호 <span class="required-mark">*</span></label>
              </div>

              <div class="phone-input-row">
                <div class="input-with-clear">
                  <input type="text" name="memPhone" class="full-width-input" required />
                  <button type="button" class="clear-btn" onclick="clearValue('memPhone')">×</button>
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

    // 기본은 personal 기준으로 required 세팅
    applyRequiredByType("personal");
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

  function togglePasswordHint() {
    const hint = document.getElementById('passwordHint');
    hint.style.display = (hint.style.display === 'none' || hint.style.display === '') ? 'block' : 'none';
  }

  // ✅ memGender 기준
  function setGender(val) {
    const male = document.querySelector('input[name="memGender"][value="male"]');
    const female = document.querySelector('input[name="memGender"][value="female"]');

    if (male && female) {
      male.checked = (val === 'male');
      female.checked = (val === 'female');
    }

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
      idChecked = false;   // 🔥 추가
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
          idChecked = false;        // 🔥 추가
        } else {
          msg.textContent = '사용 가능한 아이디입니다!';
          msg.style.color = 'green';
          idChecked = true;         // 🔥 추가
          lastCheckedId = v;        // 🔥 추가
        }
      })
      .catch(err => {
        console.error(err);
        msg.textContent = '중복확인 중 오류가 발생했습니다.';
        msg.style.color = 'red';
        idChecked = false;          // 🔥 추가
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
  
  // ✅✅✅ 핵심: 타입별 required 토글
  function applyRequiredByType(type) {
    const personalBlock = document.getElementById("personalBlock");
    const enterpriseBlock = document.getElementById("enterpriseBlock");
    const entTopPhoneBlock = document.getElementById("entTopPhoneBlock");

    // 공통 필드(required 유지): memId, memName, memPw, confirmPassword, memEmail
    // => 개인/관리자 상관없이 회원가입 기본정보는 받으니까 그대로 둠

    // personal 관련 required 켜기/끄기
    toggleBlockRequired(personalBlock, type === "personal");

    // enterprise 관련 required 켜기/끄기
    toggleBlockRequired(enterpriseBlock, type === "enterprise");

    // enterprise 상단 phone block도 enterprise일 때만 required 켜기(지금은 required 없지만 안전)
    toggleBlockRequired(entTopPhoneBlock, type === "enterprise");

    // ⚠️ enterpriseBlock 안 openDate가 required라서 숨겨진 상태면 submit 막힘
    // => 위 토글로 해결됨
  }

  // block 내부에서 원래 required였던 애들만(required였던 것만) 켜고 끄기
  function toggleBlockRequired(blockEl, shouldRequire) {
    if (!blockEl) return;

    const fields = blockEl.querySelectorAll("input, select, textarea");
    fields.forEach(el => {
      // 원래 required였던 애들만 컨트롤(필요한 것만)
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

    // ✅ 여기서 required 토글 적용
    applyRequiredByType(type);
  }

  function resetForm() {
    document.querySelectorAll('#formView input').forEach(i => {
      if (i.type === 'checkbox' || i.type === 'radio' || i.type === 'hidden') return;
      i.value = '';
    });

    const msg = document.getElementById('usernameMsg');
    if (msg) msg.textContent = '';
  }
  
  // 🔥 가입 버튼 누를 때 hidden 값 최종 확정
  document.querySelector(".signup-form").addEventListener("submit", function (e) {

    const currentId = document.querySelector('[name="memId"]').value.trim();

    // ✅ 중복확인 안 했거나, 확인한 뒤 아이디 바뀌었으면 막기
    if (!idChecked || currentId !== lastCheckedId) {
      alert("아이디 중복확인을 먼저 해주세요!");
      e.preventDefault();
      return;
    }

    // 🔥 가입 버튼 누를 때 hidden 값 최종 확정
    document.getElementById("activeTab").value =
      (currentType === "enterprise") ? "admin" : "user";

    document.getElementById("memType").value =
      (currentType === "enterprise") ? "ADMIN" : "USER";

  });
</script>

</body>
</html>