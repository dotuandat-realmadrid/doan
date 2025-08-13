package com.dotuandat.services;

import java.io.IOException;
import java.net.MalformedURLException;
import java.util.List;

import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartFile;

public interface FileService {
    List<String> uploadFiles(MultipartFile[] files) throws IOException;

    Resource loadFileAsResource(String fileName) throws MalformedURLException;
}
