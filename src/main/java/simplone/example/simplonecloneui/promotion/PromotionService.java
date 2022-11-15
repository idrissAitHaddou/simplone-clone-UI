package simplone.example.simplonecloneui.promotion;


import jakarta.servlet.http.Part;
import simplone.example.simplonecloneui.former.FormerRepository;
import simplone.example.simplonecloneui.former.FormerService;

import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.List;

public class PromotionService {

    public static List getPromoByIdService(int id) {
        return PromotionRepository.getDetails(id);
    }

    public static List getAllPromotionsService() {
        return PromotionRepository.all();
    }

    public static List getPromotionService(int id) {
        return PromotionRepository.getDetails(id);
    }

    public static List searchPromotionsService(String name) {
        return PromotionRepository.findByName(name);
    }

    public static boolean updatePromotionService(Promos promotion, Part file,int oldFormer, int newFormer, String uploadPath) {
        String newFileName = "";
        long unixTime = System.currentTimeMillis() / 1000L;
        String fileName = "";
        if(file != null) { fileName = getFileName( file ); }
        String newName = "";
        try {
            if(!fileName.equals("Default.file") && fileName != null && file != null) {
                unixTime = System.currentTimeMillis() / 1000L;
                String fullPath = uploadPath + File.separator + fileName;
                String extension = fileName.substring(fileName.lastIndexOf('.') + 1);
                String name = fileName.substring(0,fileName.lastIndexOf('.') - 1);
                newName = name + unixTime + "." + extension;
                newFileName = uploadPath + File.separator + newName;
                file.write(fullPath);
                File file1 = new File(fullPath);
                File file2 = new File(newFileName);
                file1.renameTo(file2);
            }
            if(newFormer != 0) FormerRepository.updateIdPromo(newFormer, promotion.getId());
            if(oldFormer != 0 && newFormer != 0) FormerRepository.updateIdPromo(oldFormer, 0);
            if(newName.equals("")) {
                List<Promos> promotions = PromotionRepository.getOne(promotion.getId());
                for(Promos promo: promotions) {
                    newName = promo.getImage();
                    break;
                }
            }
            promotion.setImage(newName);
            PromotionRepository.update(promotion);
            return true;
        }catch (Exception e) {
            return false;
        }
    }

    public static boolean deletePromotionService(int idPromo, int idFormer, String uploadPath) {
       try {
           List<Promos> promotions = PromotionRepository.getOne(idPromo);
           for(Promos promotion: promotions ){
               if (promotion.getId() == idPromo) {
                   File file = new File(uploadPath + File.separator + promotion.getImage());
                   if (file.exists()) {
                       file.delete();
                   }
               }
           }
           PromotionRepository.delete(idPromo);
           FormerService.updateIdPromoService(idFormer, 0);
           return true;
       } catch (Exception e) {
           return false;
       }
    }

    public static boolean creatPromotionService(Part file, Promos promotion,int formerId, String uploadPath) throws IOException {
        String newFileName = "";
        long unixTime = System.currentTimeMillis() / 1000L;
        String fileName = "";
        if(file != null) { fileName = getFileName( file ); }
        String newName = "";
        try {
            if(!fileName.equals("Default.file") && fileName != null && file != null) {
                unixTime = System.currentTimeMillis() / 1000L;
                String fullPath = uploadPath + File.separator + fileName;
                String extension = fileName.substring(fileName.lastIndexOf('.') + 1);
                String name = fileName.substring(0,fileName.lastIndexOf('.') - 1);
                newName = name + unixTime + "." + extension;
                newFileName = uploadPath + File.separator + newName;
                file.write(fullPath);
                File file1 = new File(fullPath);
                File file2 = new File(newFileName);
                file1.renameTo(file2);
            }
            promotion.setImage(newName);
            PromotionRepository.save(promotion);
            if(formerId != 0) {
                List<Promos> lastPromotion = PromotionRepository.getLast();
                for (Promos promo: lastPromotion) {
                    FormerService.updateIdPromoService(formerId, promo.getId());
                    break;
                }
            }
            return true;
        } catch (IOException e) {
            return false;
        }
    }

    public static String getFileName( Part part ) {
        for ( String content : part.getHeader( "content-disposition" ).split( ";" ) ) {
            if ( content.trim().startsWith( "filename" ) )
                return content.substring( content.indexOf( "=" ) + 2, content.length() - 1 );
        }
        return "Default.file";
    }
}
