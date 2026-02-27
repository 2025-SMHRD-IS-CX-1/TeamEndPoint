package com.cx.web;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cx.web.dto.AdminUserRowDto;
import com.cx.web.entity.Member;
import com.cx.web.repository.AdminRepository;
import com.cx.web.repository.MemberRepository;

import jakarta.transaction.Transactional;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private final AdminRepository adminRepository;

    private final MemberRepository memberRepository;

    // 🔥 생성자 주입
    public AdminController(MemberRepository memberRepository, AdminRepository adminRepository) {
        this.memberRepository = memberRepository;
        this.adminRepository = adminRepository;
    }

    @GetMapping("/dashboard")
    public String dashboard() {
        return "admin/dashboard";
    }

    @GetMapping("/users")
    public String users(
    		@RequestParam(defaultValue = "1") int page, 
    		@RequestParam(required = false) String keyword,
    		@RequestParam(required = false) String district,
    		@RequestParam(required = false) String ageGroup,
    		Model model) {

    	int size = 10;
    	int pageIndex = Math.max(0, page - 1);

    	// ====== 파라미터 trim ======
    	String kw = (keyword == null) ? "" : keyword.trim();
    	String dist = (district == null) ? "" : district.trim();
    	String ag = (ageGroup == null) ? "" : ageGroup.trim();

    	// ====== 연령대(20/30...) -> birthdate 범위 ======
    	LocalDate today = LocalDate.now();
    	LocalDate startBirth = null;
    	LocalDate endBirth = null;

    	if (!ag.isEmpty()) {
    	    int decade = Integer.parseInt(ag);
    	    int minAge = decade;
    	    int maxAge = decade + 9;

    	    LocalDate maxBirthInclusive = today.minusYears(minAge);
    	    LocalDate minBirthInclusive = today.minusYears(maxAge + 1).plusDays(1);

    	    startBirth = minBirthInclusive;
    	    endBirth = maxBirthInclusive;
    	}

    	// ====== 조회(구/연령/검색 + 페이징) ======
    	org.springframework.data.domain.Page<Member> memberPage =
    	        memberRepository.searchUsers(
    	                dist,
    	                startBirth,
    	                endBirth,
    	                kw,
    	                org.springframework.data.domain.PageRequest.of(pageIndex, size)
    	        );

    	List<Member> members = memberPage.getContent();
    	int totalPages = memberPage.getTotalPages();

    	// ====== paging model ======
    	model.addAttribute("page", page);
    	model.addAttribute("totalPages", totalPages);
    	model.addAttribute("startNo", (page - 1) * size);

    	// ====== 선택값 유지용 ======
    	model.addAttribute("keyword", kw);
    	model.addAttribute("district", dist);
    	model.addAttribute("ageGroup", ag);
        long totalUsers = memberRepository.countByMemType("USER");

        // =========================
        // 📌 이번달 가입 (전월 대비 %)
        // =========================
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
            monthJoinRate =
                    ((thisMonthUsers - lastMonthUsers) * 100.0) / lastMonthUsers;
            monthJoinUp = monthJoinRate >= 0;
        }

        // =========================
        // 📌 오늘 접속 (어제 대비 %)
        // =========================

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
            todayLoginRate =
                    ((todayLoginUsers - yesterdayLoginUsers) * 100.0) / yesterdayLoginUsers;
            todayLoginUp = todayLoginRate >= 0;
        }

        // =========================
        // 📌 총 사용자 (전월 대비 +명)
        // =========================

        long totalDelta = thisMonthUsers - lastMonthUsers;
        boolean totalDeltaUp = totalDelta >= 0;

        // =========================
        // 📌 경고 대상 + 비율
        // =========================

        long warnUsers = memberRepository.countWarnUsers("USER");
        double warnRate =
                totalUsers == 0 ? 0 : (warnUsers * 100.0 / totalUsers);

        // =========================
        // 📌 테이블 데이터 가공
        // =========================

        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy.MM.dd");
        LocalDate now = LocalDate.now();

        List<AdminUserRowDto> memberViews = members.stream().map(m -> {

            AdminUserRowDto dto = new AdminUserRowDto();

            dto.setMemID(m.getMemID());
            dto.setMemName(m.getMemName());
            dto.setMemEmail(m.getMemEmail());
            dto.setMemPhone(m.getMemPhone());
            dto.setMemGender(m.getMemGender());
            dto.setWarnCnt(m.getWarnCnt());
            dto.setStatus(m.getStatus());

            dto.setJoinedAtStr(
                m.getJoinedAt() == null
                ? "-"
                : m.getJoinedAt().format(fmt)
            );

            dto.setDistrict(
                (m.getMemAddr() == null || m.getMemAddr().isBlank())
                ? "-"
                : m.getMemAddr()
            );

            dto.setMemAddr(
                (m.getMemAddr() == null || m.getMemAddr().isBlank())
                ? "-"
                : m.getMemAddr()
            );

            if (m.getMemBirthdate() == null) {
                dto.setAgeGroup("-");
            } else {
                int age = java.time.Period.between(m.getMemBirthdate(), now).getYears();
                dto.setAgeGroup(age < 0 ? "-" : "만 " + age + "세");
            }

            return dto;

        }).toList();

        // =========================
        // 📌 model 담기
        // =========================

        model.addAttribute("members", memberViews);

        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalDelta", Math.abs(totalDelta));
        model.addAttribute("totalDeltaUp", totalDeltaUp);

        model.addAttribute("thisMonthUsers", thisMonthUsers);
        model.addAttribute("monthJoinRate",
                String.format("%.1f", Math.abs(monthJoinRate)));
        model.addAttribute("monthJoinUp", monthJoinUp);

        model.addAttribute("todayLoginUsers", todayLoginUsers);
        model.addAttribute("todayLoginRate",
                String.format("%.1f", Math.abs(todayLoginRate)));
        model.addAttribute("todayLoginUp", todayLoginUp);

        model.addAttribute("warnUsers", warnUsers);
        model.addAttribute("warnRate",
                String.format("%.1f", warnRate));

        return "admin/users";
    }
    
    @GetMapping("/users/data")
    @ResponseBody
    public Map<String, Object> usersData(
            @RequestParam(defaultValue = "1") int page,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String district,
            @RequestParam(required = false) String ageGroup
    ) {

        int size = 10;
        int pageIndex = Math.max(0, page - 1);

        String kw = (keyword == null) ? "" : keyword.trim();
        String dist = (district == null) ? "" : district.trim();
        String ag = (ageGroup == null) ? "" : ageGroup.trim();

        LocalDate today = LocalDate.now();
        LocalDate startBirth = null;
        LocalDate endBirth = null;

        if (!ag.isEmpty()) {
            int decade = Integer.parseInt(ag);
            int minAge = decade;
            int maxAge = decade + 9;

            LocalDate maxBirthInclusive = today.minusYears(minAge);
            LocalDate minBirthInclusive = today.minusYears(maxAge + 1).plusDays(1);

            startBirth = minBirthInclusive;
            endBirth = maxBirthInclusive;
        }

        org.springframework.data.domain.Page<Member> memberPage =
                memberRepository.searchUsers(
                        dist,
                        startBirth,
                        endBirth,
                        kw,
                        org.springframework.data.domain.PageRequest.of(pageIndex, size)
                );

        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("yyyy.MM.dd");
        LocalDate now = LocalDate.now();

        List<Map<String, Object>> memberViews = memberPage.getContent().stream().map(m -> {
            Map<String, Object> map = new HashMap<>();

            map.put("memID", m.getMemID());
            map.put("memName", m.getMemName());
            map.put("memGender", m.getMemGender());
            map.put("warnCnt", m.getWarnCnt());
            map.put("status", m.getStatus());
            map.put("joinedAtStr", m.getJoinedAt() == null ? "-" : m.getJoinedAt().format(fmt));
            map.put("district", (m.getMemAddr() == null || m.getMemAddr().isBlank()) ? "-" : m.getMemAddr());
            map.put("memEmail", m.getMemEmail());
            map.put("memPhone", m.getMemPhone());
            map.put("memAddr", (m.getMemAddr() == null || m.getMemAddr().isBlank()) ? "-" : m.getMemAddr());

            if (m.getMemBirthdate() == null) {
                map.put("ageGroup", "-");
            } else {
                int age = java.time.Period.between(m.getMemBirthdate(), now).getYears();
                map.put("ageGroup", (age < 0) ? "-" : "만 " + age + "세");
            }
            return map;
        }).toList();

        Map<String, Object> res = new HashMap<>();
        res.put("members", memberViews);
        res.put("page", page);
        res.put("totalPages", memberPage.getTotalPages());

        return res;
    }
    
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

    @PostMapping("/users/block-toggle")
    @ResponseBody
    @Transactional
    public Map<String, Object> blockToggle(@RequestParam String memID) {

        Member m = memberRepository.findById(memID).orElseThrow();

        // status: ACTIVE <-> BLOCK
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
 }