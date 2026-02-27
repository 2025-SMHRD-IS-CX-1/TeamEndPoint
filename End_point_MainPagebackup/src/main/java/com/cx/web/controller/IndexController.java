package com.cx.web.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {

    @GetMapping("/")
    public String index(Model model) {
        List<Map<String, String>> festivals = new ArrayList<>();

        Map<String, String> f1 = new HashMap<>();
        f1.put("title", "광주 추억의 충장축제");
        f1.put("category", "지역 축제");
        f1.put("subtitle", "Chungjang Festival of Recollection");
        f1.put("date", "2025.10.15 ~ 10.19");
        f1.put("location", "광주 동구 충장로 일원");
        f1.put("image", "/images/1.jpg");
        f1.put("description", "7080 세대의 추억을 되살리는 광주 대표 거리축제!");
        festivals.add(f1);

        Map<String, String> f2 = new HashMap<>();
        f2.put("title", "광주 비엔날레");
        f2.put("category", "예술 전시");
        f2.put("subtitle", "Gwangju Biennale");
        f2.put("date", "2025.08.30 ~ 11.02");
        f2.put("location", "광주 비엔날레 전시관 일원");
        f2.put("image", "/images/2.jpg");
        f2.put("description", "현대 미술의 정수를 보여주는 세계적인 시각 예술 축제!");
        festivals.add(f2);

        Map<String, String> f3 = new HashMap<>();
        f3.put("title", "광주 세계 김치 축제");
        f3.put("category", "음식 축제");
        f3.put("subtitle", "Gwangju Kimchi Festival");
        f3.put("date", "2024.10.18 ~ 10.20");
        f3.put("location", "광주김치타운 일원");
        f3.put("image", "/images/3.jpg");
        f3.put("description", "전통 김치의 맛과 정취를 느낄 수 있는 대한민국 대표 음식 축제!");
        festivals.add(f3);

        // JSP에서 사용할 데이터 전달
        model.addAttribute("festivalList", festivals);

        // 본문으로 index.jsp를 쓰도록 지정
        model.addAttribute("contentPage", "/WEB-INF/views/common/index.jsp");

        // MobileLayout.jsp 반환
        return "common/MobileLayout";
    }

    @GetMapping("/application-process")
    public String applicationProcess(Model model) {
        // 본문으로 ApplicationProcessPage.jsp를 쓰도록 지정
        model.addAttribute("contentPage", "/WEB-INF/views/common/ApplicationProcessPage.jsp");

        // MobileLayout.jsp 반환 (공통 레이아웃 적용)
        return "common/MobileLayout";
    }
}
