package com.cx.web;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Map;

import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.HttpStatusCodeException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api")
public class ChatApiController {

    /**
     * ✅ FastAPI 서버 Base URL
     */
	private static final String FASTAPI_BASE_URL =
	        System.getenv().getOrDefault("FASTAPI_BASE_URL", "http://127.0.0.1:8000");

    private static final String FASTAPI_CHAT_URL = FASTAPI_BASE_URL + "/api/chat";
    private static final String FASTAPI_IMAGE_URL = FASTAPI_BASE_URL + "/api/media/image";

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
            System.out.println("🟦 Spring -> FastAPI CHAT 요청: " + FASTAPI_CHAT_URL);
            System.out.println("🟨 요청 body = " + body);

            ResponseEntity<String> resp =
                    restTemplate.exchange(FASTAPI_CHAT_URL, HttpMethod.POST, request, String.class);

            System.out.println("🟩 FastAPI CHAT status = " + resp.getStatusCode());
            System.out.println("🟪 FastAPI CHAT body = " + resp.getBody());

            return ResponseEntity.status(resp.getStatusCode())
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(resp.getBody());

        } catch (HttpStatusCodeException e) {
            e.printStackTrace();
            System.out.println("🔥 FastAPI CHAT error body = " + e.getResponseBodyAsString());

            return ResponseEntity.status(e.getStatusCode())
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(e.getResponseBodyAsString());

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.BAD_GATEWAY)
                    .contentType(MediaType.APPLICATION_JSON)
                    .body("{\"error\":\"FastAPI 연결 실패\"}");
        }
    }

    /**
     * ✅ 이미지 업로드/분석
     * Spring(/api/chat/image) -> FastAPI(/api/media/image)
     */
    @PostMapping(value = "/chat/image", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> analyzeImage(
            @RequestParam("file") MultipartFile file,
            @RequestParam(value = "croom_idx", required = false) Integer croomIdx,
            @RequestParam(value = "text", required = false) String text
    ) {

        if (file == null || file.isEmpty()) {
            return ResponseEntity.badRequest()
                    .contentType(MediaType.APPLICATION_JSON)
                    .body("{\"error\":\"업로드된 파일이 없습니다.\"}");
        }

        try {
            System.out.println("============================================================");
            System.out.println("🖼️ Spring 이미지 업로드 시작");
            System.out.println("파일명 = " + file.getOriginalFilename());
            System.out.println("contentType = " + file.getContentType());
            System.out.println("size = " + file.getSize());
            System.out.println("croom_idx = " + croomIdx);
            System.out.println("text = " + text);

            MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();

            // ✅ 파일 파트 헤더 세팅.
            HttpHeaders fileHeaders = new HttpHeaders();

            MediaType fileContentType = MediaType.APPLICATION_OCTET_STREAM;
            try {
                if (file.getContentType() != null && !file.getContentType().isBlank()) {
                    fileContentType = MediaType.parseMediaType(file.getContentType());
                } else {
                    fileContentType = MediaType.IMAGE_JPEG;
                }
            } catch (Exception parseEx) {
                System.out.println("⚠️ contentType 파싱 실패, image/jpeg로 대체");
                fileContentType = MediaType.IMAGE_JPEG;
            }

            fileHeaders.setContentType(fileContentType);

            String filename = (file.getOriginalFilename() == null || file.getOriginalFilename().isBlank())
                    ? "upload.jpg"
                    : file.getOriginalFilename();

            ContentDisposition cd = ContentDisposition.builder("form-data")
                    .name("file")
                    .filename(filename, StandardCharsets.UTF_8)
                    .build();
            fileHeaders.setContentDisposition(cd);

            byte[] fileBytes = file.getBytes();

            ByteArrayResource fileResource = new ByteArrayResource(fileBytes) {
                @Override
                public String getFilename() {
                    return filename;
                }

                @Override
                public long contentLength() {
                    return fileBytes.length;
                }
            };

            HttpEntity<ByteArrayResource> filePart = new HttpEntity<>(fileResource, fileHeaders);
            body.add("file", filePart);

            if (croomIdx != null) body.add("croom_idx", String.valueOf(croomIdx));
            if (text != null && !text.trim().isEmpty()) body.add("text", text.trim());

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.MULTIPART_FORM_DATA);

            HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);

            System.out.println("🟦 Spring -> FastAPI IMAGE 요청: " + FASTAPI_IMAGE_URL);

            ResponseEntity<String> resp =
                    restTemplate.postForEntity(FASTAPI_IMAGE_URL, requestEntity, String.class);

            System.out.println("🟩 FastAPI IMAGE status = " + resp.getStatusCode());
            System.out.println("🟪 FastAPI IMAGE body = " + resp.getBody());

            return ResponseEntity.status(resp.getStatusCode())
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(resp.getBody());

        } catch (HttpStatusCodeException e) {
            e.printStackTrace();
            System.out.println("🔥 FastAPI IMAGE error status = " + e.getStatusCode());
            System.out.println("🔥 FastAPI IMAGE error body = " + e.getResponseBodyAsString());

            return ResponseEntity.status(e.getStatusCode())
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(e.getResponseBodyAsString());

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