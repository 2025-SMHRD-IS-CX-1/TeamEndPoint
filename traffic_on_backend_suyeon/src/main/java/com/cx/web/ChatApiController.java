package com.cx.web;
//주석
import java.io.IOException;
import java.util.Map;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.*;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api")
public class ChatApiController {

    // ✅ FastAPI 서버 주소 (텍스트 채팅)
    private static final String FASTAPI_CHAT_URL = "http://localhost:8000/api/chat";

    // ✅ FastAPI 이미지 분석 엔드포인트 (네 FastAPI docs 스샷 기준)
    // POST /api/media/image
    private static final String FASTAPI_IMAGE_URL = "http://localhost:8000/api/media/image";

    private final RestTemplate restTemplate = new RestTemplate();

    /**
     * ✅ 텍스트 채팅 -> FastAPI /api/chat
     */
    @PostMapping("/chat")
    public ResponseEntity<?> chat(@RequestBody Map<String, Object> body) {

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Map<String, Object>> request = new HttpEntity<>(body, headers);

        try {
            ResponseEntity<String> resp =
                    restTemplate.exchange(FASTAPI_CHAT_URL, HttpMethod.POST, request, String.class);

            return ResponseEntity.status(resp.getStatusCode())
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(resp.getBody());

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.BAD_GATEWAY)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body("{\"error\":\"FastAPI 연결 실패\"}");
        }
    }

    /**
     * ✅ 이미지 업로드/분석 -> Spring(/api/chat/image) -> FastAPI(/api/media/image)
     *
     * FastAPI docs에 multipart/form-data 필드가:
     * - file (required)
     * - croom_idx (Integer)
     * - text (String)
     *
     * 이걸 그대로 맞춰서 전달함.
     */
    @PostMapping(value = "/chat/image", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> analyzeImage(
            @RequestPart("file") MultipartFile file,
            @RequestPart(value = "croom_idx", required = false) Integer croomIdx,
            @RequestPart(value = "text", required = false) String text
    ) {

        if (file == null || file.isEmpty()) {
            return ResponseEntity.badRequest()
                    .contentType(MediaType.APPLICATION_JSON)
                    .body("{\"error\":\"업로드된 파일이 없습니다.\"}");
        }

        try {
            // ✅ FastAPI로 multipart 전달용 body 구성
            MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();

            ByteArrayResource fileAsResource = new ByteArrayResource(file.getBytes()) {
                @Override
                public String getFilename() {
                    // FastAPI에서 filename이 필요할 때 대비
                    return file.getOriginalFilename();
                }
            };

            // ✅ FastAPI에서도 key 이름이 "file" 이어야 함
            body.add("file", fileAsResource);

            // ✅ FastAPI 스펙에 맞춰 추가 필드도 같이 전달 (없으면 생략)
            if (croomIdx != null) body.add("croom_idx", String.valueOf(croomIdx));
            if (text != null && !text.trim().isEmpty()) body.add("text", text.trim());

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.MULTIPART_FORM_DATA);

            HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);

            ResponseEntity<String> resp =
                    restTemplate.postForEntity(FASTAPI_IMAGE_URL, requestEntity, String.class);

            return ResponseEntity.status(resp.getStatusCode())
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(resp.getBody());

        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body("{\"error\":\"파일 처리 실패\"}");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.BAD_GATEWAY)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body("{\"error\":\"FastAPI 이미지 분석 연결 실패\"}");
        }
    }
}