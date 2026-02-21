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

      <!-- 실제로 DB 연결 전이니까 action은 임시로 signup -->
      <form class="signup-form" method="post" action="${pageContext.request.contextPath}/signup" autocomplete="off">

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
                  <input type="text" name="phone" class="full-width-input" value="" />
                  <button type="button" class="clear-btn" onclick="clearValue('phone')">×</button>
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
			    <input type="text" name="username" class="full-width-input" required autocomplete="off" readonly onfocus="this.removeAttribute('readonly');"/>
			    <button type="button" class="clear-btn" onclick="clearValue('username')">×</button>
			  </div>
			  <button type="button" class="btn-small" onclick="checkUsername()">중복확인</button>
			</div>

			<p id="usernameMsg" class="field-msg"></p>
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
              <input type="password" name="password" class="full-width-input" required />
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
              <input type="email" name="email" class="full-width-input" required />
              <button type="button" class="clear-btn" onclick="clearValue('email')">×</button>
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
                <input type="date" name="birthDate" class="full-width-input date-picker-input" required />
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
                  <input type="radio" name="gender" value="male" checked />
                  남성
                </label>
                <label class="gender-option" onclick="setGender('female')">
                  <input type="radio" name="gender" value="female" />
                  여성
                </label>
              </div>
            </div>

            <!-- Address -->
            <div class="form-row-group">
              <div class="form-label-with-icon">
                <span class="label-icon">📍</span>
                <label>주소 <span class="required-mark">*</span></label>
              </div>

              <div class="address-zip-row">
                <input type="text" name="zipCode" class="full-width-input zip-input" placeholder="우편번호" readonly />
                <button type="button" class="btn-small search-btn">검색</button>
              </div>

              <input type="text" name="address" class="full-width-input address-main" placeholder="주소" readonly style="margin-top:8px;" />

              <div class="input-with-clear" style="margin-top:8px;">
                <input type="text" name="detailAddress" class="full-width-input" placeholder="상세주소" />
                <button type="button" class="clear-btn" onclick="clearValue('detailAddress')">×</button>
              </div>
            </div>

            <!-- Phone Verification (personal 아래쪽) -->
            <div class="form-row-group">
              <div class="form-label-with-icon">
                <span class="label-icon">📱</span>
                <label>휴대전화번호 <span class="required-mark">*</span></label>
              </div>

              <div class="phone-input-row">
                <div class="input-with-clear">
                  <input type="text" name="phone name" class="full-width-input" required />
                  <button type="button" class="clear-btn" onclick="clearValue('phone')">×</button>
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
  // 선택된 가입 타입 저장
  let currentType = 'personal';

  function handleBack() {
    // 폼 화면이면 selection으로, selection이면 login으로
    const formViewVisible = document.getElementById('formView').style.display !== 'none';
    if (formViewVisible) {
		resetForm();
      document.getElementById('formView').style.display = 'none';
      document.getElementById('selectionView').style.display = 'flex';
    } else {
      // 로그인으로 돌아가기
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

  function setGender(val) {
    const male = document.querySelector('input[name="gender"][value="male"]');
    const female = document.querySelector('input[name="gender"][value="female"]');

    male.checked = (val === 'male');
    female.checked = (val === 'female');

    const labels = document.querySelectorAll('.gender-option');
    labels.forEach(l => l.classList.remove('active'));
    if (val === 'male') labels[0].classList.add('active');
    else labels[1].classList.add('active');
  }

  // 전체동의 로직
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
  
  function togglePasswordHint() {
    const hint = document.getElementById("passwordHint");
    hint.style.display = hint.style.display === "block" ? "none" : "block";
  }

  document.addEventListener("click", function(e) {
    const hint = document.getElementById("passwordHint");
    const button = document.querySelector(".help-icon-btn");

    if (!button.contains(e.target) && !hint.contains(e.target)) {
      hint.style.display = "none";
    }
  });
  
  function checkUsername(){
    const v = document.querySelector('[name="username"]').value.trim();
    const msg = document.getElementById('usernameMsg');

    if(!v){
      msg.textContent = '아이디를 입력해 주세요.';
      msg.style.color = 'red';
      return;
    }

    const used = ['admin','test'];

    if(used.includes(v.toLowerCase())){
      msg.textContent = '이미 사용 중인 아이디입니다.';
      msg.style.color = 'red';
    } else {
      msg.textContent = '사용 가능한 아이디입니다.';
      msg.style.color = 'green';
    }
  }
  
  function selectType(type) {
    currentType = type;
	// 1) 먼저 지우기
	resetForm();
	
	// 2) 크롬 자동완성이 다시 넣는 타이밍이 있어서 "조금 뒤"에 또 지우기
	setTimeout(resetForm, 0);
	setTimeout(resetForm, 50);
	 
    // 3) 화면 토글
    document.getElementById('selectionView').style.display = 'none';
    document.getElementById('formView').style.display = 'flex';

    // 4) 제목 변경
    document.getElementById('signupTitle').innerText =
      (type === 'personal') ? '일반 회원가입' : '관리자 회원가입';

    // 5) 블록 토글
    document.getElementById('enterpriseHint').style.display =
      (type === 'enterprise') ? 'block' : 'none';

    document.getElementById('enterpriseBlock').style.display =
      (type === 'enterprise') ? 'block' : 'none';

    document.getElementById('personalBlock').style.display =
      (type === 'personal') ? 'block' : 'none';

    document.getElementById('entTopPhoneBlock').style.display =
      (type === 'enterprise') ? 'block' : 'none';
  }  
  
  function resetForm() {
    document.querySelectorAll('#formView input').forEach(i => {
      if (i.type === 'checkbox' || i.type === 'radio') return;
      i.value = '';
    });

    const msg = document.getElementById('usernameMsg');
    if (msg) msg.textContent = '';
  }
</script>

</body>
</html>