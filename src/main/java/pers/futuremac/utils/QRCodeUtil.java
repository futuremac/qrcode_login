package pers.futuremac.utils;

/**
 * Created by 前程 on 2015/10/14.
 */

import net.glxn.qrgen.QRCode;
import net.glxn.qrgen.image.ImageType;
import org.apache.commons.codec.digest.DigestUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;


public class QRCodeUtil {

    private static final Logger logger = LoggerFactory.getLogger(QRCodeUtil.class);

    private final static String logoPath = "/usr/share/nginx/html/17neitui/img/qrcode/logo48.png";
    private final static String qrImgDir = "/usr/share/nginx/html/17neitui/img/qrcode/";

    private static final int size = 500;
    public static String generateQRCode(String content){
        try {
            File qrFile = QRCode.from(content).withSize(size, size).to(ImageType.PNG).file();
            String path = System.getProperty("user.dir");
            logger.info("current path:{}", path);
            String fileName = DigestUtils.md5Hex(content) + ".png";
            String fullName = qrImgDir + fileName;
            logger.info("current path:{},fullName:{}", path,fullName);
            File logoFile = new File(logoPath);

            addLogo2QRCode(qrFile, logoFile, fullName);
            return fileName;
        } catch (Exception e) {
            logger.error("生成二维码失败:{}", e.getMessage());
            return null;
        }
    }

    /*给二维码图片添加Logo*/
    private static void addLogo2QRCode(File qrPic, File logoPic,String qrFileName) {
        try {
            if (!qrPic.isFile() || !logoPic.isFile()) {
                logger.error("file not find !");
                return;
            }
            BufferedImage qrimage = ImageIO.read(qrPic);
            BufferedImage image = new BufferedImage(size,size,BufferedImage.TYPE_INT_RGB);
            Graphics2D g = image.createGraphics();
            g.drawImage(qrimage,0,0,size,size,null);

            /**
             * 读取Logo图片
             */
            BufferedImage logo = ImageIO.read(logoPic);
            int widthLogo = logo.getWidth(), heightLogo = logo.getHeight();

            // 计算图片放置位置
            int x = (image.getWidth() - widthLogo) / 2;
            int y = (image.getHeight() - logo.getHeight()) / 2;
            logger.info("x:{},y:{},width:{},height:{}" ,x ,y,widthLogo,heightLogo);

            //开始绘制图片
            g.drawRoundRect(x, y, widthLogo, heightLogo, 20, 20);
            g.setStroke(new BasicStroke(2));
            g.setColor(Color.white);
            g.drawRect(x, y, widthLogo, heightLogo);
            g.drawImage(logo, x, y,widthLogo,heightLogo, null);
            g.dispose();
            image.flush();

            ImageIO.write(image, "png", new File(qrFileName));
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }

    public static void main(String[] args) {
       generateQRCode("lalala");
    }

}
