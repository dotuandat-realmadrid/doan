package com.dotuandat.services.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.client.WebClient;

import com.dotuandat.dtos.request.ApiRequest;
import com.dotuandat.dtos.request.inventoryReceipt.InventoryReceiptDetailRequest;
import com.dotuandat.dtos.request.inventoryReceipt.InventoryReceiptRequest;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;
import com.dotuandat.repositories.ProductRepository;
import com.dotuandat.services.InventoryImportService;
import com.dotuandat.services.InventoryReceiptService;
import com.dotuandat.utils.ExcelInventoryHelper;
import com.dotuandat.utils.PdfInventoryHelper;
import com.dotuandat.utils.QRInventoryHelper;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.experimental.NonFinal;
import lombok.extern.slf4j.Slf4j;
import reactor.core.publisher.Mono;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class InventoryImportServiceImpl implements InventoryImportService {

    private static final String UNCHECKED = "unchecked";
    InventoryReceiptService inventoryReceiptService;
    ProductRepository productRepository;
    QRInventoryHelper qrInvHelper;
    ObjectMapper objectMapper;
    ExcelInventoryHelper excelInventoryHelper;
    PdfInventoryHelper pdfInventoryHelper;
    WebClient webClient;

    @NonFinal
    @Value("${ai.chatgpt.apiKey}")
    private String openAiApiKey;

    @NonFinal
    @Value("${ai.chatgpt.apiUrl}")
    private String openAiApiUrl;

    @NonFinal
    @Value("${ai.gemini.apiKey}")
    private String geminiApiKey;

    @NonFinal
    @Value("${ai.gemini.apiUrl}")
    private String geminiApiUrl;

    @Override
    @Async
    public void importFromExcel(MultipartFile file) {
        InventoryReceiptRequest request = excelInventoryHelper.parseExcel(file);
        asyncCreate(request);
    }

    @Override
    @Async
    public void importFromPdf(MultipartFile file) {
        InventoryReceiptRequest request = pdfInventoryHelper.parsePdf(file);
        asyncCreate(request);
    }

    @Override
    @Async
    public void importFromQR(MultipartFile file, String qrContent, String source) {
        try {
            List<InventoryReceiptRequest> requests = parseQRContent(file, qrContent, source);
            for (InventoryReceiptRequest request : requests) {
                asyncCreate(request);
            }
        } catch (Exception e) {
            log.error("Lỗi import QR: {}", e.getMessage());
            throw new RuntimeException("Lỗi import QR: " + e.getMessage());
        }
    }

    @Override
    @Async
    public void importFromAI(int quantity) {
        if (quantity < 1 || quantity > 100) {
            throw new AppException(ErrorCode.MIN_QUANTITY);
        }

        try {
            List<InventoryReceiptRequest> requests = generateInventoryDataByAI(quantity);
            for (InventoryReceiptRequest request : requests) {
                asyncCreate(request);
            }
            log.info("Đã sinh và tạo {} phiếu nhập thành công", quantity);
        } catch (Exception e) {
            log.error("Lỗi khi sinh phiếu nhập bằng AI: {}", e.getMessage());
            throw new RuntimeException("Lỗi khi sinh phiếu nhập bằng AI: " + e.getMessage());
        }
    }

    /*
     * Hàm móc tạo phiếu nhập kho
     */
    @Async
    private void asyncCreate(InventoryReceiptRequest request) {
        try {
            validateReceiptRequest(request);
            inventoryReceiptService.create(request);
            log.info("Thêm phiếu nhập kho với productCode {} thành công!", 
                request.getDetails().get(0).getProductCode());
        } catch (AppException e) {
            log.error("Lỗi khi thêm phiếu nhập kho với productCode {}: {}", 
                request.getDetails().get(0).getProductCode(), e.getErrorCode().getMessage());
        }
    }

    /*
     * Validate phiếu nhập kho
     */
    private void validateReceiptRequest(InventoryReceiptRequest request) {
        if (request.getDetails() == null || request.getDetails().isEmpty()) {
            throw new AppException(ErrorCode.PRODUCT_NOT_EXISTED);
        }
        if (request.getTotalAmount() == null || request.getTotalAmount() < 1) {
            throw new AppException(ErrorCode.MIN_QUANTITY);
        }
        List<String> validProductCodes = productRepository.findAll().stream()
                .map(product -> product.getCode())
                .collect(Collectors.toList());
        for (InventoryReceiptDetailRequest detail : request.getDetails()) {
            if (detail.getProductCode() == null || detail.getProductCode().trim().isEmpty()) {
                throw new AppException(ErrorCode.PRODUCT_ID_NOT_BLANK);
            }
            if (!validProductCodes.contains(detail.getProductCode())) {
                throw new AppException(ErrorCode.PRODUCT_NOT_EXISTED);
            }
            if (detail.getQuantity() == null || detail.getQuantity() < 1) {
                throw new AppException(ErrorCode.MIN_QUANTITY);
            }
            if (detail.getPrice() == null || detail.getPrice() < 1000) {
                throw new AppException(ErrorCode.MIN_PRICE);
            }
        }
        long calculatedTotal = request.getDetails().stream()
                .mapToLong(detail -> detail.getPrice() * detail.getQuantity())
                .sum();
        if (request.getTotalAmount() != calculatedTotal) {
            throw new AppException(ErrorCode.PRICE_NOT_NULL);
        }
    }

    @SuppressWarnings(UNCHECKED)
    private List<InventoryReceiptRequest> parseQRContent(MultipartFile file, String qrContent, String source) {
        String contentToProcess = qrContent != null && !qrContent.isEmpty() ? qrContent : "";
        
        if (file != null && !file.isEmpty()) {
            try {
                contentToProcess = qrInvHelper.readQRFromImage(file);
                log.info("Đọc nội dung QR từ file: {}", contentToProcess);
            } catch (Exception e) {
                throw new RuntimeException("Không thể đọc nội dung mã QR từ file: " + e.getMessage());
            }
        }
        
        if (contentToProcess.isEmpty()) {
            throw new RuntimeException("Nội dung mã QR trống");
        }

        log.info("Nội dung QR đầy đủ: {}", contentToProcess);
        
        List<InventoryReceiptRequest> receipts = smartParseContent(contentToProcess);
        log.info("Đã parse thành công {} phiếu nhập", receipts.size());
        return receipts;
    }

    @SuppressWarnings(UNCHECKED)
    private List<InventoryReceiptRequest> smartParseContent(String content) {
        log.info("Thử phát hiện tự động...");
        
        // Thử JSON
        try {
            log.info("Thử parse JSON...");
            return parseJsonToReceipts(content);
        } catch (Exception e) {
            log.debug("Không phải JSON: {}", e.getMessage());
        }
        
        // Thử CSV
        try {
            log.info("Thử parse CSV...");
            return parseCsvToReceipts(content);
        } catch (Exception e) {
            log.debug("Không phải CSV: {}", e.getMessage());
        }
        
        // Thử Multi-line
        try {
            log.info("Thử parse Multi-line...");
            return parseMultiLineToReceipts(content);
        } catch (Exception e) {
            log.debug("Không phải Multi-line: {}", e.getMessage());
        }
        
        // Thử Base64 (JSON)
        try {
            log.info("Thử parse Base64 JSON...");
            return handleBase64Content(content, "BASE64_JSON");
        } catch (Exception e) {
            log.debug("Không phải Base64 JSON: {}", e.getMessage());
        }
        
        // Thử Base64 (CSV)
        try {
            log.info("Thử parse Base64 CSV...");
            return handleBase64Content(content, "BASE64_CSV");
        } catch (Exception e) {
            log.debug("Không phải Base64 CSV: {}", e.getMessage());
        }
        
        // Thử Base64 (Multi-line)
        try {
            log.info("Thử parse Base64 Multi-line...");
            return handleBase64Content(content, "BASE64_MULTI_LINE");
        } catch (Exception e) {
            log.debug("Không phải Base64 Multi-line: {}", e.getMessage());
        }
        
        // Thử URL
        try {
            log.info("Thử parse URL...");
            return handleUrlContent(content);
        } catch (Exception e) {
            log.debug("Không phải URL: {}", e.getMessage());
        }
        
        throw new AppException(ErrorCode.INVALID_FILE_QR_FORMAT);
    }

    @SuppressWarnings(UNCHECKED)
    private List<InventoryReceiptRequest> parseJsonToReceipts(String content) {
        try {
            String data = content.contains("|data:") ? content.split("\\|data:")[1] : content;
            data = data.trim();
            
            if (!data.startsWith("[")) {
                throw new AppException(ErrorCode.INVALID_FILE_QR_FORMAT);
            }
            
            List<InventoryReceiptRequest> requests = objectMapper.readValue(data, new TypeReference<List<InventoryReceiptRequest>>() {});
            
            // Tính toán totalAmount cho mỗi request
            for (InventoryReceiptRequest request : requests) {
                if (request.getDetails() == null || request.getDetails().isEmpty()) {
                    throw new RuntimeException("Danh sách details trống trong JSON");
                }
                long calculatedTotal = request.getDetails().stream()
                        .mapToLong(detail -> detail.getPrice() * detail.getQuantity())
                        .sum();
                request.setTotalAmount(calculatedTotal);
            }
            
            log.info("Đã parse thành công {} phiếu nhập từ JSON", requests.size());
            return requests;
        } catch (Exception e) {
            throw new RuntimeException("Lỗi phân tích JSON: " + e.getMessage());
        }
    }

    @SuppressWarnings(UNCHECKED)
    private List<InventoryReceiptRequest> parseCsvToReceipts(String content) {
        List<InventoryReceiptDetailRequest> details = new ArrayList<>();
        String note = null;
        String data = content.contains("|data:") ? content.split("\\|data:")[1] : content;
        data = data.trim();
        
        if (!data.contains("=")) {
            throw new AppException(ErrorCode.INVALID_FILE_QR_FORMAT);
        }
        
        try {
            // Tách từng dòng
            String[] lines = data.split("\n");
            boolean hasHeader = false;
            if (lines.length > 0 && lines[0].trim().equalsIgnoreCase("productCode,quantity,price,note")) {
                hasHeader = true;
                log.info("Phát hiện header, bỏ qua dòng đầu");
            }
            
            int startIndex = hasHeader ? 1 : 0;
            
            for (int i = startIndex; i < lines.length; i++) {
                String line = lines[i].trim();
                if (line.isEmpty()) continue;
                
                // Parse các cặp key=value
                Map<String, String> map = Arrays.stream(line.split(","))
                        .map(s -> s.split("=", 2))
                        .filter(arr -> arr.length == 2)
                        .collect(Collectors.toMap(arr -> arr[0].trim(), arr -> arr[1].trim()));
                
                if (map.isEmpty() || !map.containsKey("productCode") || !map.containsKey("quantity") || !map.containsKey("price")) {
                    throw new RuntimeException("Dòng " + i + " không đủ các trường bắt buộc: productCode, quantity, price");
                }
                
                try {
                    InventoryReceiptDetailRequest detail = InventoryReceiptDetailRequest.builder()
                            .productCode(map.get("productCode"))
                            .quantity(Integer.parseInt(map.get("quantity")))
                            .price(Long.parseLong(map.get("price")))
                            .build();
                    details.add(detail);
                    // Lấy note từ dòng đầu tiên
                    if (note == null) {
                        note = map.getOrDefault("note", null);
                    }
                    log.debug("Đã thêm detail cho phiếu nhập với productCode: {}", map.get("productCode"));
                } catch (NumberFormatException e) {
                    throw new RuntimeException("Lỗi phân tích giá trị số ở dòng " + i + ": " + e.getMessage());
                }
            }
            
            if (details.isEmpty()) {
                throw new RuntimeException("Không có dữ liệu phiếu nhập hợp lệ trong CSV");
            }
            
            // Tính totalAmount từ tất cả details
            long totalAmount = details.stream()
                    .mapToLong(detail -> detail.getQuantity() * detail.getPrice())
                    .sum();
            
            // Tạo một InventoryReceiptRequest duy nhất
            InventoryReceiptRequest request = InventoryReceiptRequest.builder()
                    .details(details)
                    .note(note)
                    .totalAmount(totalAmount)
                    .build();
            
            log.info("Đã parse thành công 1 phiếu nhập với {} sản phẩm từ CSV", details.size());
            return List.of(request);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi phân tích CSV: " + e.getMessage());
        }
    }

    @SuppressWarnings(UNCHECKED)
    private List<InventoryReceiptRequest> parseMultiLineToReceipts(String content) {
        List<InventoryReceiptDetailRequest> details = new ArrayList<>();
        String note = null;
        String data = content.contains("|data:") ? content.split("\\|data:")[1] : content;
        data = data.trim();
        
        String[] lines = data.split("\n");
        boolean hasHeader = false;
        if (lines.length > 0 && lines[0].toLowerCase().contains("productcode")) {
            hasHeader = true;
            log.info("Phát hiện header, bỏ qua dòng đầu");
        }
        
        int startIndex = hasHeader ? 1 : 0;
        
        for (int i = startIndex; i < lines.length; i++) {
            String line = lines[i].trim();
            if (line.isEmpty()) continue;
            
            // Tách các giá trị bằng dấu phẩy
            String[] fields = line.split(",", 4);
            if (fields.length < 3) {
                throw new RuntimeException("Dòng " + i + " không đủ 3 cột: productCode, quantity, price");
            }
            
            try {
                InventoryReceiptDetailRequest detail = InventoryReceiptDetailRequest.builder()
                        .productCode(fields[0].trim())
                        .quantity(Integer.parseInt(fields[1].trim()))
                        .price(Long.parseLong(fields[2].trim()))
                        .build();
                details.add(detail);
                // Lấy note từ dòng đầu tiên
                if (note == null && fields.length > 3) {
                    note = fields[3].trim().replaceAll("^\"|\"$", "");
                }
                log.debug("Đã thêm detail cho phiếu nhập với productCode: {}", fields[0]);
            } catch (NumberFormatException e) {
                throw new RuntimeException("Lỗi phân tích giá trị số ở dòng " + i + ": " + e.getMessage());
            }
        }
        
        if (details.isEmpty()) {
            throw new RuntimeException("Không có dữ liệu phiếu nhập hợp lệ trong Multi-line");
        }
        
        // Tính totalAmount từ tất cả details
        long totalAmount = details.stream()
                .mapToLong(detail -> detail.getQuantity() * detail.getPrice())
                .sum();
        
        // Tạo một InventoryReceiptRequest duy nhất
        InventoryReceiptRequest request = InventoryReceiptRequest.builder()
                .details(details)
                .note(note)
                .totalAmount(totalAmount)
                .build();
        
        log.info("Đã parse thành công 1 phiếu nhập với {} sản phẩm từ Multi-line", details.size());
        return List.of(request);
    }

    @SuppressWarnings(UNCHECKED)
    private List<InventoryReceiptRequest> handleBase64Content(String content, String format) {
        try {
            String data = content.contains("|data:") ? content.split("\\|data:")[1] : content;
            data = data.trim();
            
            if (!isValidBase64(data)) {
                throw new AppException(ErrorCode.INVALID_FILE_QR_FORMAT);
            }
            
            byte[] decoded = Base64.getDecoder().decode(data);
            String decodedContent = new String(decoded);
            
            switch (format.toUpperCase()) {
                case "BASE64_JSON":
                    return parseJsonToReceipts(decodedContent);
                case "BASE64_CSV":
                    return parseCsvToReceipts(decodedContent);
                case "BASE64_MULTI_LINE":
                    return parseMultiLineToReceipts(decodedContent);
                default:
                    throw new AppException(ErrorCode.INVALID_FILE_QR_FORMAT);
            }
        } catch (IllegalArgumentException e) {
            throw new AppException(ErrorCode.INVALID_FILE_QR_FORMAT);
        } catch (Exception e) {
            throw new AppException(ErrorCode.INVALID_FILE_QR_FORMAT);
        }
    }

    @SuppressWarnings(UNCHECKED)
    private List<InventoryReceiptRequest> handleUrlContent(String content) {
        try {
            String url = content.contains("|data:") ? content.split("\\|data:")[1] : content;
            url = url.trim();
            
            if (!url.startsWith("http://") && !url.startsWith("https://")) {
                throw new RuntimeException("Không phải URL hợp lệ");
            }
            
            String response = webClient.get()
                    .uri(url)
                    .retrieve()
                    .bodyToMono(String.class)
                    .block();
                    
            if (response == null || response.isEmpty()) {
                throw new RuntimeException("Không nhận được phản hồi từ URL");
            }
            
            return smartParseContent(response);
        } catch (Exception e) {
            throw new RuntimeException("Lỗi xử lý URL: " + e.getMessage());
        }
    }

    private boolean isValidBase64(String str) {
        try {
            Base64.getDecoder().decode(str);
            return true;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    @Transactional
    private List<InventoryReceiptRequest> generateInventoryDataByAI(int quantity) {
        List<String> validProductCodes = null;
        try {
            validProductCodes = productRepository.findAllProductCodes();

            if (validProductCodes.isEmpty()) {
                throw new AppException(ErrorCode.PRODUCT_NOT_EXISTED);
            }
        } catch (AppException e) {
            throw new AppException(ErrorCode.UNCATEGORIZED_EXCEPTION);
        }

        Map<String, ApiRequest> apiRequests = new HashMap<>();
        apiRequests.put("ChatGPT", new ApiRequest(openAiApiUrl, openAiApiKey));
        apiRequests.put("Gemini", new ApiRequest(geminiApiUrl, geminiApiKey));
        List<String> availableApis = Arrays.asList("ChatGPT", "Gemini");

        if (availableApis.isEmpty()) {
            throw new RuntimeException("Không có API key nào được cấu hình");
        }

        List<InventoryReceiptRequest> requests = new ArrayList<>();
        String prompt = createDetailedPrompt(validProductCodes, quantity);

        for (String apiName : availableApis) {
            ApiRequest apiRequest = apiRequests.get(apiName);
            try {
                String aiResponse = callAIAPI(apiName, apiRequest, prompt).block();
                log.info("Phản hồi thô từ {} API: {}", apiName, aiResponse);

                String cleanedResponse = cleanResponse(aiResponse);
                log.info("Phản hồi đã làm sạch từ {} API: {}", apiName, cleanedResponse);

                List<InventoryReceiptRequest> apiRequestsList = objectMapper.readValue(cleanedResponse,
                    new TypeReference<List<InventoryReceiptRequest>>() {});

                validateGeneratedRequests(apiRequestsList, validProductCodes);
                requests.addAll(apiRequestsList);

                log.info("Đã sinh {} phiếu nhập từ {} API", apiRequestsList.size(), apiName);
                break;
            } catch (Exception e) {
                log.error("Lỗi khi gọi {} API: {}", apiName, e.getMessage());
            }
        }

        if (requests.isEmpty()) {
            throw new RuntimeException("Không thể sinh dữ liệu phiếu nhập từ bất kỳ API nào");
        }

        if (requests.size() < quantity) {
            throw new RuntimeException("API không sinh đủ số lượng phiếu nhập yêu cầu: " + quantity);
        }

        return requests.subList(0, quantity);
    }

    private String createDetailedPrompt(List<String> validProductCodes, int quantity) {
        return String.format(
            "Generate exactly %d inventory receipt data entries in pure JSON format (no markdown, no backticks, no extra text, just the JSON array). " +
            "Each receipt must have: " +
            "totalAmount (number > 0, calculated as price * quantity), " +
            "note (Vietnamese text, 20-50 characters, not null), " +
            "details (array with exactly one object containing: productCode (must be one of: %s), quantity (number between 1 and 100), price (number between 1000 and 10000000)). " +
            "Ensure all %d entries are included, complete, and valid with no missing fields. " +
            "Example: [{\"totalAmount\":2000000,\"note\":\"Nhập kho tháng 7\",\"details\":[{\"productCode\":\"%s\",\"quantity\":10,\"price\":200000}]}]",
            quantity,
            String.join(",", validProductCodes),
            quantity,
            validProductCodes.get(0)
        );
    }

    private Mono<String> callAIAPI(String apiName, ApiRequest apiRequest, String prompt) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        Map<String, Object> requestBody;

        if (apiName.equals("ChatGPT")) {
            headers.setBearerAuth(apiRequest.getApiKey());
            requestBody = new HashMap<>();
            requestBody.put("model", "gpt-3.5-turbo");
            requestBody.put("max_tokens", 4000);
            requestBody.put("temperature", 0.7);
            requestBody.put("messages", List.of(Map.of("role", "user", "content", prompt)));
        } else if (apiName.equals("Gemini")) {
            requestBody = new HashMap<>();
            requestBody.put("contents", List.of(Map.of(
                "parts", List.of(Map.of("text", prompt))
            )));
            requestBody.put("generationConfig", Map.of(
                "maxOutputTokens", 4000,
                "temperature", 0.7
            ));
        } else {
            throw new IllegalArgumentException("API không được hỗ trợ: " + apiName);
        }

        return webClient.post()
            .uri(apiName.equals("Gemini") ? apiRequest.getApiUrl() + "?key=" + apiRequest.getApiKey() : apiRequest.getApiUrl())
            .headers(h -> h.addAll(headers))
            .bodyValue(requestBody)
            .retrieve()
            .bodyToMono(String.class)
            .flatMap(body -> {
                try {
                    JsonNode root = objectMapper.readTree(body);
                    String content;
                    if (apiName.equals("ChatGPT")) {
                        content = root.path("choices").get(0).path("message").path("content").asText();
                    } else {
                        content = root.path("candidates").get(0).path("content").path("parts").get(0).path("text").asText();
                    }
                    return Mono.just(content);
                } catch (Exception e) {
                    return Mono.error(new RuntimeException("Lỗi parse phản hồi từ " + apiName + ": " + e.getMessage()));
                }
            });
    }

    private String cleanResponse(String rawResponse) {
        String cleaned = rawResponse.trim();
        cleaned = cleaned.replaceAll("^```[a-zA-Z]*\\s*", "").replaceAll("\\s*```$", "");
        cleaned = cleaned.replaceAll("^[\\s\\n]+", "").replaceAll("[\\s\\n]+$", "");
        return cleaned;
    }

    private void validateGeneratedRequests(List<InventoryReceiptRequest> requests, List<String> validProductCodes) {
        if (requests == null || requests.isEmpty()) {
            throw new AppException(ErrorCode.INVENTORY_NOT_ENOUGH);
        }
        for (InventoryReceiptRequest request : requests) {
            if (request.getDetails() == null || request.getDetails().isEmpty()) {
                throw new AppException(ErrorCode.PRODUCT_NOT_EXISTED);
            }
            if (request.getNote() == null || request.getNote().trim().isEmpty()) {
                throw new AppException(ErrorCode.UNCATEGORIZED_EXCEPTION);
            }
            for (InventoryReceiptDetailRequest detail : request.getDetails()) {
                if (detail.getProductCode() == null || !validProductCodes.contains(detail.getProductCode())) {
                    throw new AppException(ErrorCode.PRODUCT_NOT_EXISTED);
                }
                if (detail.getQuantity() < 1 || detail.getQuantity() > 100) {
                    throw new AppException(ErrorCode.MIN_QUANTITY);
                }
                if (detail.getPrice() < 1000 || detail.getPrice() > 10000000) {
                    throw new AppException(ErrorCode.MIN_PRICE);
                }
            }
            if (request.getTotalAmount() < 1) {
                throw new AppException(ErrorCode.MIN_QUANTITY);
            }
            long calculatedTotal = request.getDetails().stream()
                    .mapToLong(detail -> detail.getPrice() * detail.getQuantity())
                    .sum();
            if (request.getTotalAmount() != calculatedTotal) {
                throw new AppException(ErrorCode.UNCATEGORIZED_EXCEPTION);
            }
        }
    }
}