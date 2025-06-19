package com.dotuandat.services.impl;

import com.dotuandat.dtos.request.product.ProductCreateRequest;
import com.dotuandat.dtos.request.product.ProductUpdateRequest;
import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;
import com.dotuandat.services.ProductImportService;
import com.dotuandat.services.ProductService;
import com.dotuandat.utils.ExcelProdHelper;
import com.dotuandat.utils.QRProdHelper;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.opencsv.CSVReader;
import com.opencsv.exceptions.CsvException;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.util.Pair;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.reactive.function.client.WebClient;

import java.io.IOException;
import java.io.StringReader;
import java.util.*;
import java.util.Base64;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
@Slf4j
public class ProductImportServiceImpl implements ProductImportService {

    ProductService productService;
    QRProdHelper qrProdHelper;
    ObjectMapper objectMapper;
    ExcelProdHelper excelProdHelper;
    WebClient webClient;

    @Override
    @Async
    public void importCreateFromExcel(MultipartFile file) {
        List<ProductCreateRequest> requests = excelProdHelper.parseCreateExcel(file);
        for (ProductCreateRequest request : requests) {
            asyncCreate(request);
        }
    }

    @Async
    public void asyncCreate(ProductCreateRequest request) {
        try {
            productService.create(request);
            log.info("Thêm sản phẩm {} thành công!", request.getCode());
        } catch (AppException e) {
            log.error("Lỗi khi thêm sản phẩm {}: {}", request.getCode(), e.getErrorCode().getMessage());
        }
    }

    @Override
    @Async
    public void importUpdateFromExcel(MultipartFile file) {
        List<Pair<String, ProductUpdateRequest>> requests = excelProdHelper.parseUpdateExcel(file);
        for (Pair<String, ProductUpdateRequest> pair : requests) {
            String code = pair.getFirst();
            ProductUpdateRequest request = pair.getSecond();
            asyncUpdate(code, request);
        }
    }

    @Async
    public void asyncUpdate(String code, ProductUpdateRequest request) {
        try {
            productService.updateImport(code, request);
            log.info("Cập nhật sản phẩm {} thành công!", code);
        } catch (AppException e) {
            log.error("Lỗi khi cập nhật sản phẩm {}: {}", code, e.getErrorCode().getMessage());
        }
    }

    @Override
    @Async
    public void importCreateFromQR(MultipartFile file, String qrContent, String source) {
        try {
            List<ProductCreateRequest> requests = parseQRContent(file, qrContent, source, "create");
            for (ProductCreateRequest request : requests) {
                asyncCreate(request);
            }
        } catch (Exception e) {
            throw new RuntimeException("Lỗi import QR: " + e.getMessage());
        }
    }

    @Override
    @Async
    public void importUpdateFromQR(MultipartFile file, String qrContent, String source) {
        try {
            List<Pair<String, ProductUpdateRequest>> requests = parseQRContent(file, qrContent, source, "update");
            for (Pair<String, ProductUpdateRequest> pair : requests) {
                String code = pair.getFirst();
                ProductUpdateRequest request = pair.getSecond();
                asyncUpdate(code, request);
            }
        } catch (Exception e) {
            throw new RuntimeException("Lỗi import QR: " + e.getMessage());
        }
    }

    @SuppressWarnings("unchecked")
    private <T> List<T> parseQRContent(MultipartFile file, String qrContent, String source, String action) {
        String contentToProcess = qrContent != null && !qrContent.isEmpty() ? qrContent : "";
        
        if (file != null && !file.isEmpty()) {
            try {
                contentToProcess = qrProdHelper.readQRFromImage(file);
                log.info("Đọc nội dung QR từ file: {}", contentToProcess);
            } catch (Exception e) {
                throw new RuntimeException("Không thể đọc nội dung mã QR từ file: " + e.getMessage());
            }
        }
        
        if (contentToProcess == null || contentToProcess.isEmpty()) {
            throw new RuntimeException("Nội dung mã QR trống");
        }

        log.info("Nội dung QR đầy đủ: {}", contentToProcess);
        
        if ("create".equalsIgnoreCase(action)) {
            List<ProductCreateRequest> products = smartParseContent(contentToProcess, action);
            log.info("Đã parse thành công {} sản phẩm", products.size());
            return (List<T>) products;
        } else {
            List<Pair<String, ProductUpdateRequest>> updateProducts = smartParseContent(contentToProcess, action);
            log.info("Đã parse thành công {} sản phẩm cập nhật", updateProducts.size());
            return (List<T>) updateProducts;
        }
    }

    @SuppressWarnings("unchecked")
    private <T> List<T> smartParseContent(String content, String action) {
        log.info("Thử phát hiện tự động...");
        
        // Thử JSON trước
        try {
            log.info("Thử parse JSON...");
            return parseJsonToProducts(content, action);
        } catch (Exception e) {
            log.debug("Không phải JSON: {}", e.getMessage());
        }
        
        // Thử CSV
        try {
            log.info("Thử parse CSV...");
            return parseCsvToProducts(content, action);
        } catch (Exception e) {
            log.debug("Không phải CSV: {}", e.getMessage());
        }
        
        // Thử Multi-line
        try {
            log.info("Thử parse Multi-line...");
            return parseMultiLineToProducts(content, action);
        } catch (Exception e) {
            log.debug("Không phải Multi-line: {}", e.getMessage());
        }
        
        // Thử Base64 (JSON)
        try {
            log.info("Thử parse Base64 JSON...");
            return handleBase64Content(content, "BASE64_JSON", action);
        } catch (Exception e) {
            log.debug("Không phải Base64 JSON: {}", e.getMessage());
        }
        
        // Thử Base64 (CSV)
        try {
            log.info("Thử parse Base64 CSV...");
            return handleBase64Content(content, "BASE64_CSV", action);
        } catch (Exception e) {
            log.debug("Không phải Base64 CSV: {}", e.getMessage());
        }
        
        // Thử Base64 (Multi-line)
        try {
            log.info("Thử parse Base64 Multi-line...");
            return handleBase64Content(content, "BASE64_MULTI_LINE", action);
        } catch (Exception e) {
            log.debug("Không phải Base64 Multi-line: {}", e.getMessage());
        }
        
        // Thử URL cuối cùng
        try {
            log.info("Thử parse URL...");
            return handleUrlContent(content, action);
        } catch (Exception e) {
            log.debug("Không phải URL: {}", e.getMessage());
        }
        
        throw new AppException(ErrorCode.INVALID_FILE_QR_FORMAT);
    }

    @SuppressWarnings("unchecked")
    private <T> List<T> parseJsonToProducts(String content, String action) {
        try {
            String data = content.contains("|data:") ? content.split("\\|data:")[1] : content;
            data = data.trim();
            
            if (!data.startsWith("[") && !data.startsWith("{")) {
                throw new AppException(ErrorCode.INVALID_FILE_QR_FORMAT);
            }
            
            if ("create".equalsIgnoreCase(action)) {
                return (List<T>) objectMapper.readValue(data, new TypeReference<List<ProductCreateRequest>>() {});
            } else {
                List<Map<String, Object>> rawList = objectMapper.readValue(data, new TypeReference<List<Map<String, Object>>>() {});
                List<Pair<String, ProductUpdateRequest>> updateRequests = rawList.stream().map(map -> {
                    String code = (String) map.get("code");
                    if (code == null || code.trim().isEmpty()) {
                        throw new RuntimeException("Mã sản phẩm không được để trống");
                    }
                    ProductUpdateRequest request = ProductUpdateRequest.builder()
                            .categoryCode((String) map.getOrDefault("categoryCode", ""))
                            .supplierCode((String) map.getOrDefault("supplierCode", ""))
                            .name((String) map.getOrDefault("name", ""))
                            .description((String) map.getOrDefault("description", ""))
                            .price(map.containsKey("price") ? Long.parseLong(map.get("price").toString()) : 0L)
                            .discountId((String) map.getOrDefault("discountId", null))
                            .build();
                    return Pair.of(code, request);
                }).collect(Collectors.toList());
                return (List<T>) updateRequests;
            }
        } catch (Exception e) {
            throw new RuntimeException("Lỗi phân tích JSON: " + e.getMessage());
        }
    }

    @SuppressWarnings("unchecked")
    private <T> List<T> parseCsvToProducts(String content, String action) {
        List<T> requests = new ArrayList<>();
        String data = content.contains("|data:") ? content.split("\\|data:")[1] : content;
        data = data.trim();
        
        if (!data.contains(",") || data.contains("{") || data.contains("[")) {
            throw new AppException(ErrorCode.INVALID_FILE_QR_FORMAT);
        }
        
        try (CSVReader csvReader = new CSVReader(new StringReader(data))) {
            List<String[]> lines = csvReader.readAll();
            if (lines.isEmpty()) {
                throw new RuntimeException("Không có dữ liệu trong CSV");
            }
            
            log.info("Tổng số dòng CSV: {}", lines.size());
            
            boolean hasHeader = false;
            if (lines.size() > 0) {
                String[] firstLine = lines.get(0);
                if (firstLine.length > 0 && 
                    (firstLine[0].toLowerCase().contains("category") || 
                     firstLine[0].toLowerCase().contains("supplier") ||
                     firstLine[0].toLowerCase().contains("code"))) {
                    hasHeader = true;
                    log.info("Phát hiện header, bỏ qua dòng đầu");
                }
            }
            
            int startIndex = hasHeader ? 1 : 0;
            
            for (int i = startIndex; i < lines.size(); i++) {
                String[] fields = lines.get(i);
                
                if ("create".equalsIgnoreCase(action)) {
                    if (fields.length >= 6) {
                        try {
                            ProductCreateRequest request = ProductCreateRequest.builder()
                                    .categoryCode(fields[0].trim())
                                    .supplierCode(fields[1].trim())
                                    .code(fields[2].trim())
                                    .name(fields[3].trim())
                                    .description(fields[4].trim())
                                    .price(Long.parseLong(fields[5].trim()))
                                    .build();
                            
                            requests.add((T) request);
                            log.debug("Đã tạo request cho sản phẩm: {}", request.getCode());
                        } catch (NumberFormatException e) {
                            throw new RuntimeException("Lỗi phân tích giá trị price thành số ở dòng " + i + ": " + e.getMessage());
                        }
                    } else {
                        throw new RuntimeException("Dòng " + i + " không đủ 6 cột: " + String.join(",", fields));
                    }
                } else {
                    if (fields.length >= 7) {
                        try {
                            String code = fields[2].trim();
                            if (code.isEmpty()) {
                                throw new RuntimeException("Mã sản phẩm không được để trống ở dòng " + i);
                            }
                            ProductUpdateRequest request = ProductUpdateRequest.builder()
                                    .categoryCode(fields[0].trim())
                                    .supplierCode(fields[1].trim())
                                    .name(fields[3].trim())
                                    .description(fields[4].trim())
                                    .price(Long.parseLong(fields[5].trim()))
                                    .discountId(fields[6].trim().isEmpty() ? null : fields[6].trim())
                                    .build();
                            
                            requests.add((T) Pair.of(code, request));
                            log.debug("Đã tạo request cập nhật cho sản phẩm: {}", code);
                        } catch (NumberFormatException e) {
                            throw new RuntimeException("Lỗi phân tích giá trị price thành số ở dòng " + i + ": " + e.getMessage());
                        }
                    } else {
                        throw new RuntimeException("Dòng " + i + " không đủ 7 cột: " + String.join(",", fields));
                    }
                }
            }
            
            if (requests.isEmpty()) {
                throw new RuntimeException("Không có dữ liệu sản phẩm hợp lệ trong CSV");
            }
            
            log.info("Đã parse thành công {} sản phẩm từ CSV", requests.size());
            
        } catch (IOException | CsvException e) {
            throw new RuntimeException("Lỗi phân tích CSV: " + e.getMessage());
        }
        
        return requests;
    }

    @SuppressWarnings("unchecked")
    private <T> List<T> parseMultiLineToProducts(String content, String action) {
        List<T> requests = new ArrayList<>();
        String data = content.contains("|data:") ? content.split("\\|data:")[1] : content;
        data = data.trim();
        
        if (!data.contains("=") || !data.contains("\n")) {
            throw new AppException(ErrorCode.INVALID_FILE_QR_FORMAT);
        }
        
        String[] lines = data.split("\n");
        for (String line : lines) {
            if (line == null || line.trim().isEmpty()) continue;
            
            Map<String, String> map = Arrays.stream(line.split(","))
                    .map(s -> s.split("=", 2))
                    .filter(arr -> arr.length == 2)
                    .collect(Collectors.toMap(arr -> arr[0].trim(), arr -> arr[1].trim()));
            
            if (map.isEmpty()) {
                continue;
            }
            
            if ("create".equalsIgnoreCase(action)) {
                ProductCreateRequest request = ProductCreateRequest.builder()
                        .code(map.getOrDefault("code", ""))
                        .categoryCode(map.getOrDefault("categoryCode", ""))
                        .supplierCode(map.getOrDefault("supplierCode", ""))
                        .name(map.getOrDefault("name", ""))
                        .description(map.getOrDefault("description", ""))
                        .price(map.containsKey("price") ? Long.parseLong(map.get("price").trim()) : 0L)
                        .build();
                requests.add((T) request);
            } else {
                String code = map.getOrDefault("code", "");
                if (code.isEmpty()) {
                    throw new RuntimeException("Mã sản phẩm không được để trống");
                }
                ProductUpdateRequest request = ProductUpdateRequest.builder()
                        .categoryCode(map.getOrDefault("categoryCode", ""))
                        .supplierCode(map.getOrDefault("supplierCode", ""))
                        .name(map.getOrDefault("name", ""))
                        .description(map.getOrDefault("description", ""))
                        .price(map.containsKey("price") ? Long.parseLong(map.get("price").trim()) : 0L)
                        .discountId(map.getOrDefault("discountId", null))
                        .build();
                requests.add((T) Pair.of(code, request));
            }
        }
        
        if (requests.isEmpty()) {
            throw new RuntimeException("Không có dữ liệu sản phẩm hợp lệ trong Multi-line");
        }
        
        return requests;
    }

    @SuppressWarnings("unchecked")
    private <T> List<T> handleBase64Content(String content, String format, String action) {
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
                    return parseJsonToProducts(decodedContent, action);
                case "BASE64_CSV":
                    return parseCsvToProducts(decodedContent, action);
                case "BASE64_MULTI_LINE":
                    return parseMultiLineToProducts(decodedContent, action);
                default:
                    throw new AppException(ErrorCode.INVALID_FILE_QR_FORMAT);
            }
        } catch (IllegalArgumentException e) {
            throw new AppException(ErrorCode.INVALID_FILE_QR_FORMAT);
        } catch (Exception e) {
            throw new AppException(ErrorCode.INVALID_FILE_QR_FORMAT);
        }
    }

    @SuppressWarnings("unchecked")
    private <T> List<T> handleUrlContent(String content, String action) {
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
            
            return (List<T>) smartParseContent(response, action);
            
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
}