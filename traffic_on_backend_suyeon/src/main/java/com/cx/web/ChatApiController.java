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

    // ✅ FastAPI 이미지 분석 엔드포인트 (FastAPI docs 기준)
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
     * ✅ 400 invalid_image_format (Invalid MIME type) 해결 핵심:
     * - FastAPI로 보낼 때 file 파트에 Content-Type(image/jpeg, image/png) + filename을 명확히 붙여서 전달
     * - @RequestParam 사용 (415 이슈 방지)
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
            MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();

            // ✅ 파일 파트 헤더(콘텐츠 타입 / 파일명) 강제 세팅
            HttpHeaders fileHeaders = new HttpHeaders();

            MediaType fileContentType = MediaType.APPLICATION_OCTET_STREAM;
            if (file.getContentType() != null && !file.getContentType().isBlank()) {
                fileContentType = MediaType.parseMediaType(file.getContentType());
            } else {
                // contentType이 비어있을 때 fallback
                fileContentType = MediaType.IMAGE_JPEG;
            }
            fileHeaders.setContentType(fileContentType);

            String filename = (file.getOriginalFilename() == null || file.getOriginalFilename().isBlank())
                    ? "upload.jpg"
                    : file.getOriginalFilename();

            ContentDisposition cd = ContentDisposition.builder("form-data")
                    .name("file")
                    .filename(filename)
                    .build();
            fileHeaders.setContentDisposition(cd);

            ByteArrayResource fileResource = new ByteArrayResource(file.getBytes()) {
                @Override
                public String getFilename() {
                    return filename;
                }
            };

            // ✅ "file" 파트를 HttpEntity로 감싸서 multipart에 넣기. (중요)
            HttpEntity<ByteArrayResource> filePart = new HttpEntity<>(fileResource, fileHeaders);
            body.add("file", filePart);

            // ✅ FastAPI 스펙 필드들도 전달
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