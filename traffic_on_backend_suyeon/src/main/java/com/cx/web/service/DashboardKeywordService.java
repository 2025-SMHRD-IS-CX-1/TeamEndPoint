package com.cx.web.service;

import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.*;

@Service
public class DashboardKeywordService {

    private final Map<String, List<Map<String, Object>>> keywordMap = new HashMap<>();

    @PostConstruct
    public void loadCsv() {
        try {
            ClassPathResource resource =
                    new ClassPathResource("gwangju_gu_top_keywords_road_mock.csv");

            BufferedReader reader = new BufferedReader(
                    new InputStreamReader(resource.getInputStream(), StandardCharsets.UTF_8)
            );

            String line;
            reader.readLine(); // 헤더 제거

            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");

                String gu = parts[0].trim();
                int rank = Integer.parseInt(parts[1].trim());
                String keyword = parts[2].trim();
                int count = Integer.parseInt(parts[3].trim());

                Map<String, Object> item = new HashMap<>();
                item.put("rank", rank);
                item.put("keyword", keyword);
                item.put("count", count);

                keywordMap
                        .computeIfAbsent(gu, k -> new ArrayList<>())
                        .add(item);
            }

            reader.close();
            System.out.println("✅ CSV 로딩 완료");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Map<String, Object>> getKeywordsByDistrict(String district) {
        return keywordMap.getOrDefault(district, Collections.emptyList());
    }
}