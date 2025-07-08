package com.dotuandat.utils;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.List;

import javax.imageio.ImageIO;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.dotuandat.exceptions.AppException;
import com.dotuandat.exceptions.ErrorCode;

import boofcv.alg.fiducial.qrcode.QrCode;
import boofcv.factory.fiducial.FactoryFiducial;
import boofcv.io.image.ConvertBufferedImage;
import boofcv.struct.image.GrayU8;

@Component
public class QRInventoryHelper {

    public String readQRFromImage(MultipartFile file) {
        try {
            BufferedImage bufferedImage = ImageIO.read(file.getInputStream());
            GrayU8 gray = ConvertBufferedImage.convertFrom(bufferedImage, (GrayU8) null);

            boofcv.abst.fiducial.QrCodeDetector<GrayU8> detector = FactoryFiducial.qrcode(null, GrayU8.class);

            detector.process(gray);

            List<QrCode> detections = detector.getDetections();
            if (!detections.isEmpty()) {
                QrCode qrCode = detections.get(0);
                if (qrCode.message != null) {
                    return qrCode.message;
                }
            }
            return null;
        } catch (IOException e) {
            throw new AppException(ErrorCode.FILE_READ_QR_ERROR);
        }
    }
}
