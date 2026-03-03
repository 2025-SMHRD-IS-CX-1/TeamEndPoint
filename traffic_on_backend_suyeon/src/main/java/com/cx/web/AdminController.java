package com.cx.web;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cx.web.dto.AdminUserRowDto;
import com.cx.web.entity.Board;
import com.cx.web.entity.Member;
import com.cx.web.repository.AdminRepository;
import com.cx.web.repository.BoardRepository;
import com.cx.web.repository.MemberRepository;

import jakarta.transaction.Transactional;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final AdminRepository adminRepository;
    private final MemberRepository memberRepository;
    private final BoardRepository boardRepository;

    public AdminController(MemberRepository memberRepository, 
    					   AdminRepository adminRepository,
    					   BoardRepository boardRepository) {
        this.memberRepository = memberRepository;
        this.adminRepository = adminRepository;
        this.boardRepository = boardRepository;
    }

    @GetMapping("/dashboard")
    public String dashboard() {
        return "admin/dashboard";
    }
    
    @GetMapping("/boards")
    public String boards(
            @RequestParam(defaultValue = "") String keyword,
            @RequestParam(defaultValue = "0") int page,
            Model model
    ) {
        Pageable pageable = PageRequest.of(page, 10, Sort.by(Sort.Direction.DESC, "createdAt"));

        Page<Board> boardPage;

        if (keyword.trim().isEmpty()) {
            boardPage = boardRepository.findAll(pageable);
        } else {
            boardPage = boardRepository.findByTitleContainingOrMemIdContaining(
                    keyword.trim(), keyword.trim(), pageable
            );
        }

        model.addAttribute("page", boardPage);
        model.addAttribute("keyword", keyword);

        return "admin/boards";
    }

    // =========================
    // ✅ 화면 렌더링
    // =========================
    @GetMapping("/users")
    public String users(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String district,
            @RequestParam(required = false) String ageGroup,
            Model model
    ) {
        int size = 10;

        // 1) 검색/페이징 + DTO 변환까지 한 번에
        UsersPageResult result = fetchUsersPage(page, size, keyword, district, ageGroup);

        // 2) 페이징/선택값 유지
        model.addAttribute("page", result.page);
        model.addAttribute("totalPages", result.totalPages);
        model.addAttribute("startNo", (result.page - 1) * size);

        model.addAttribute("keyword", result.keyword);
        model.addAttribute("district", result.district);
        model.addAttribute("ageGroup", result.ageGroup);

        // 3) 테이블 데이터
        model.addAttribute("members", result.members);

        // 4) 통계 (기존 로직 유지)
        applyStats(model);

        return "admin/users";
    }

    // =========================
    // ✅ AJAX 데이터 응답
    // =========================
    @GetMapping("/users/data")
    @ResponseBody
    public Map<String, Object> usersData(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String district,
            @RequestParam(required = false) String ageGroup
    ) {
        int size = 10;

        UsersPageResult result = fetchUsersPage(page, size, keyword, district, ageGroup);

        Map<String, Object> res = new HashMap<>();
        res.put("members", result.members);     // ✅ DTO 그대로 JSON으로 내려감
        res.put("page", result.page);
        res.put("totalPages", result.totalPages);

        return res;
    }

    // =========================
    // ✅ 경고 토글
    // =========================
    @PostMapping("/users/warn-toggle")
    @ResponseBody
    @Transactional
    public Map<String, Object> warnToggle(@RequestParam String memID) {

        Member m = memberRepository.findById(memID).orElseThrow();

        if (m.getWarnCnt() != null && m.getWarnCnt() > 0) {
            m.setWarnCnt(0);
        } else {
            m.setWarnCnt(1);
        }

        memberRepository.save(m);

        Map<String, Object> res = new HashMap<>();
        res.put("warnCnt", m.getWarnCnt());
        return res;
    }

    // =========================
    // ✅ 차단 토글
    // =========================
    @PostMapping("/users/block-toggle")
    @ResponseBody
    @Transactional
    public Map<String, Object> blockToggle(@RequestParam String memID) {

        Member m = memberRepository.findById(memID).orElseThrow();

        String cur = (m.getStatus() == null) ? "ACTIVE" : m.getStatus();
        if ("BLOCK".equalsIgnoreCase(cur)) {
            m.setStatus("ACTIVE");
        } else {
            m.setStatus("BLOCK");
        }

        memberRepository.save(m);

        Map<String, Object> res = new HashMap<>();
        res.put("status", m.getStatus());
        return res;
    }

    // ============================================================
    // ====================== 아래는 내부 로직 ======================
    // ============================================================

    /**
     * ✅ users 화면/데이터 공용 로직
     * - 파라미터 정리
     * - 나이대 -> 생년월일 범위
     * - repository 조회(Page)
     * - Member -> AdminUserRowDto 변환
     */
    private UsersPageResult fetchUsersPage(
            int page,
            int size,
            String keyword,
            String district,
            String ageGroup
    ) {
        int pageIndex = Math.max(0, page - 1);

        String kw = safeTrim(keyword);
        String dist = safeTrim(district);
        String ag = safeTrim(ageGroup);

        LocalDate today = LocalDate.now();
        LocalDate[] range = birthRangeFromAgeGroup(ag, today);
        LocalDate startBirth = range[0];
        LocalDate endBirth = range[1];

        Page<Member> memberPage =
                memberRepository.searchUsers(
                        dist,
                        startBirth,
                        endBirth,
                        kw,
                        PageRequest.of(pageIndex, size)
                );

        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy.MM.dd");
        LocalDate now = LocalDate.now();

        List<AdminUserRowDto> memberViews =
                memberPage.getContent().stream()
                          .map(m -> toAdminUserRowDto(m, fmt, now))
                          .toList();

        UsersPageResult result = new UsersPageResult();
        result.page = page;
        result.totalPages = memberPage.getTotalPages();
        result.keyword = kw;
        result.district = dist;
        result.ageGroup = ag;
        result.members = memberViews;

        return result;
    }

    private void applyStats(Model model) {
        LocalDate today = LocalDate.now();

        long totalUsers = memberRepository.countByMemType("USER");

        // 이번달 가입 (전월 대비 %)
        LocalDateTime thisMonthStart = today.withDayOfMonth(1).atStartOfDay();
        LocalDateTime nextMonthStart = today.plusMonths(1).withDayOfMonth(1).atStartOfDay();
        LocalDateTime lastMonthStart = today.minusMonths(1).withDayOfMonth(1).atStartOfDay();

        long thisMonthUsers =
                memberRepository.countByTypeBetween("USER", thisMonthStart, nextMonthStart);

        long lastMonthUsers =
                memberRepository.countByTypeBetween("USER", lastMonthStart, thisMonthStart);

        double monthJoinRate = 0;
        boolean monthJoinUp = true;

        if (lastMonthUsers > 0) {
            monthJoinRate = ((thisMonthUsers - lastMonthUsers) * 100.0) / lastMonthUsers;
            monthJoinUp = monthJoinRate >= 0;
        }

        // 오늘 접속 (어제 대비 %)
        LocalDateTime todayStart = today.atStartOfDay();
        LocalDateTime tomorrowStart = today.plusDays(1).atStartOfDay();
        LocalDateTime yesterdayStart = today.minusDays(1).atStartOfDay();

        long todayLoginUsers =
                memberRepository.countLoginByTypeBetween("USER", todayStart, tomorrowStart);

        long yesterdayLoginUsers =
                memberRepository.countLoginByTypeBetween("USER", yesterdayStart, todayStart);

        double todayLoginRate = 0;
        boolean todayLoginUp = true;

        if (yesterdayLoginUsers > 0) {
            todayLoginRate = ((todayLoginUsers - yesterdayLoginUsers) * 100.0) / yesterdayLoginUsers;
            todayLoginUp = todayLoginRate >= 0;
        }

        // 총 사용자 (전월 대비 +명)
        long totalDelta = thisMonthUsers - lastMonthUsers;
        boolean totalDeltaUp = totalDelta >= 0;

        // 경고 대상 + 비율
        long warnUsers = memberRepository.countWarnUsers("USER");
        double warnRate = totalUsers == 0 ? 0 : (warnUsers * 100.0 / totalUsers);

        // model 담기
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalDelta", Math.abs(totalDelta));
        model.addAttribute("totalDeltaUp", totalDeltaUp);

        model.addAttribute("thisMonthUsers", thisMonthUsers);
        model.addAttribute("monthJoinRate", String.format("%.1f", Math.abs(monthJoinRate)));
        model.addAttribute("monthJoinUp", monthJoinUp);

        model.addAttribute("todayLoginUsers", todayLoginUsers);
        model.addAttribute("todayLoginRate", String.format("%.1f", Math.abs(todayLoginRate)));
        model.addAttribute("todayLoginUp", todayLoginUp);

        model.addAttribute("warnUsers", warnUsers);
        model.addAttribute("warnRate", String.format("%.1f", warnRate));
    }

    private String safeTrim(String s) {
        return (s == null) ? "" : s.trim();
    }

    /**
     * ageGroup: "20", "30" 같은 값
     * -> startBirth(포함), endBirth(포함) 반환
     */
    private LocalDate[] birthRangeFromAgeGroup(String ag, LocalDate today) {
        if (ag == null || ag.trim().isEmpty()) return new LocalDate[]{null, null};

        int decade = Integer.parseInt(ag.trim());
        int minAge = decade;
        int maxAge = decade + 9;

        LocalDate endBirthInclusive = today.minusYears(minAge);
        LocalDate startBirthInclusive = today.minusYears(maxAge + 1).plusDays(1);

        return new LocalDate[]{startBirthInclusive, endBirthInclusive};
    }

    private AdminUserRowDto toAdminUserRowDto(Member m, DateTimeFormatter fmt, LocalDate now) {
        AdminUserRowDto dto = new AdminUserRowDto();

        dto.setMemID(m.getMemID());
        dto.setMemName(m.getMemName());
        dto.setMemEmail(m.getMemEmail());
        dto.setMemPhone(m.getMemPhone());
        dto.setMemGender(m.getMemGender());
        dto.setWarnCnt(m.getWarnCnt());
        dto.setStatus(m.getStatus());

        dto.setJoinedAtStr(m.getJoinedAt() == null ? "-" : m.getJoinedAt().format(fmt));

        String addr = (m.getMemAddr() == null || m.getMemAddr().isBlank()) ? "-" : m.getMemAddr();
        dto.setMemAddr(addr);

        dto.setDistrict(extractDistrict(addr));

        if (m.getMemBirthdate() == null) {
            dto.setAgeGroup("-");
        } else {
            int age = java.time.Period.between(m.getMemBirthdate(), now).getYears();
            dto.setAgeGroup(age < 0 ? "-" : "만 " + age + "세");
        }

        return dto;
    }

    /**
     * "서울특별시 강남구 역삼동 ..." -> "강남구"
     * 없으면 "-"
     */
    private String extractDistrict(String addr) {
        if (addr == null || addr.isBlank() || "-".equals(addr)) return "-";

        for (String token : addr.split("\\s+")) {
            if (token.endsWith("구")) return token;
        }
        return "-";
    }

    // ✅ users 페이지 공용 결과 묶음 클래스 (컨트롤러 내부용)
    private static class UsersPageResult {
        int page;
        int totalPages;
        String keyword;
        String district;
        String ageGroup;
        List<AdminUserRowDto> members;
    }
    
    @GetMapping("/dashboard/stats")
    @ResponseBody
    public Map<String, Object> dashboardStats(@RequestParam String district) {

        List<Member> members = memberRepository.findByMemTypeAndMemAddr("USER", district);

        // 성별 퍼센트
        long maleCnt = members.stream().filter(m -> "M".equals(m.getMemGender())).count();
        long femaleCnt = members.stream().filter(m -> "F".equals(m.getMemGender())).count();
        long genderTotal = maleCnt + femaleCnt;

        int malePct = genderTotal == 0 ? 0 : (int) Math.round(maleCnt * 100.0 / genderTotal);
        int femalePct = 100 - malePct;

        Map<String, Object> gender = new HashMap<>();
        gender.put("male", malePct);
        gender.put("female", femalePct);

        // 연령대 퍼센트
        LocalDate today = LocalDate.now();

        List<Member> withBirth = members.stream()
                .filter(m -> m.getMemBirthdate() != null)
                .toList();

        int total = withBirth.size();
        int teen = 0, twenty = 0, thirty = 0, forty = 0, fiftyPlus = 0;

        for (Member m : withBirth) {
            int age = java.time.Period.between(m.getMemBirthdate(), today).getYears();
            if (age >= 10 && age <= 19) teen++;
            else if (age >= 20 && age <= 29) twenty++;
            else if (age >= 30 && age <= 39) thirty++;
            else if (age >= 40 && age <= 49) forty++;
            else if (age >= 50) fiftyPlus++;
        }

        int pTeen = total == 0 ? 0 : (int) Math.round(teen * 100.0 / total);
        int pTwenty = total == 0 ? 0 : (int) Math.round(twenty * 100.0 / total);
        int pThirty = total == 0 ? 0 : (int) Math.round(thirty * 100.0 / total);
        int pForty = total == 0 ? 0 : (int) Math.round(forty * 100.0 / total);
        int pFifty = total == 0 ? 0 : Math.max(0, 100 - (pTeen + pTwenty + pThirty + pForty)); // 남은값

        List<Map<String, Object>> age = List.of(
                new HashMap<>(Map.of("label", "10대", "value", pTeen)),
                new HashMap<>(Map.of("label", "20대", "value", pTwenty)),
                new HashMap<>(Map.of("label", "30대", "value", pThirty)),
                new HashMap<>(Map.of("label", "40대", "value", pForty)),
                new HashMap<>(Map.of("label", "50대 이상", "value", pFifty))
        );

        int max = age.stream().mapToInt(a -> (int) a.get("value")).max().orElse(0);
        for (Map<String, Object> a : age) {
            if (max > 0 && (int) a.get("value") == max) a.put("highlight", true);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("gender", gender);
        result.put("age", age);
        return result;
    }
   }