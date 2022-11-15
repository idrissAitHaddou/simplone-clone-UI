package simplone.example.simplonecloneui.breif;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import simplone.example.simplonecloneui.former.Formateurs;
import simplone.example.simplonecloneui.former.FormerRepository;
import simplone.example.simplonecloneui.former.FormerService;
import simplone.example.simplonecloneui.learner.Apprenants;
import simplone.example.simplonecloneui.mail.SendEmail;
import simplone.example.simplonecloneui.promotion.Promos;

import java.io.File;
import java.io.IOException;
import java.util.List;

public class BreifService {

    public static List getByIdPromoService(int id) {
        return BreifRepository.getByIdPromo(id);
    }

    public static boolean launchBriefService(HttpServletRequest request, int id) {
       try {
           List<Briefs> breifs = BreifRepository.getOne(id);
           boolean status = false;
           String name = "";
           String description = "";
           for (Briefs breif: breifs) {
               if(breif.getStatus() == true) {
                   BreifRepository.launch(id, false);
               } else if(breif.getStatus() == false) {
                   BreifRepository.launch(id, true);
                   status = true;
                   name = breif.getNom();
                   description = breif.getDescription();
               }
               break;
           }

           if(status == true) {
               List<Apprenants> learners = FormerService.launchBreifToLearnersService(request);
               for (Apprenants learner: learners) {
                   SendEmail.sendEmail(learner.getEmail(), name, description);
               }
           }
           return true;
       }catch (Exception e) {
           return false;
       }
    }

    public static List searchBreifService(HttpServletRequest request, String name) {
        HttpSession session = request.getSession();
        List<Formateurs> formers = FormerRepository.getOne((Integer)session.getAttribute("id"));
        for (Formateurs fromer: formers) {
            return BreifRepository.findBreifs(fromer.getPromosByIdpr().getId(), name);
        }
        return null;
    }

    public static boolean deleteBriefService(int id, String uploadPath) {
        List<Briefs> breifs = BreifRepository.getOne(id);
        for (Briefs breif: breifs) {
            File file = new File(uploadPath + File.separator + breif.getImage());
            if (file.exists()) {
                file.delete();
            }
            break;
        }
        return BreifRepository.delete(id);
    }

    public static List getMyBreifsService(HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<Formateurs> formers = FormerRepository.getOne((Integer)session.getAttribute("id"));
        for (Formateurs fromer: formers) {
            return BreifRepository.allMyBreifs(fromer.getPromosByIdpr().getId());
        }
        return null;
    }

    public static List getbreifByIdService(int id) {
        return BreifRepository.getById(id);
    }

    public static boolean updateBriefService(HttpServletRequest request, Part file, String uploadPath) throws ServletException, IOException {
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
            HttpSession session = request.getSession();
            List<Formateurs> formers = FormerRepository.getOne((Integer)session.getAttribute("id"));
            for (Formateurs former: formers) {
                Promos promo = new Promos();
                Briefs briefs = new Briefs();
                briefs.setNom(request.getParameter("name"));
                briefs.setDescription(request.getParameter("description"));
                briefs.setId(Integer.parseInt(request.getParameter("id")));
                if(newName.equals("")) {
                    List<Briefs> allBreifs = BreifRepository.getOne(Integer.parseInt(request.getParameter("id")));
                    for (Briefs isBreif: allBreifs) {
                        briefs.setImage(isBreif.getImage());
                        break;
                    }
                }else {
                    briefs.setImage(newName);
                }
                promo.setId(former.getPromosByIdpr().getId());
                briefs.setPromosByIdpr(promo);
                BreifRepository.update(briefs);
                break;
            }
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean createBriefService(HttpServletRequest request, String uploadPath) throws ServletException, IOException {
        String newFileName = "";
        long unixTime = System.currentTimeMillis() / 1000L;
        String fileName = "";
        Part file = request.getPart("file");
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
            HttpSession session = request.getSession();
            List<Formateurs> formers = FormerRepository.getOne(Integer.parseInt(request.getParameter("id")));
            for (Formateurs former: formers) {
                Promos promo = new Promos();
                Briefs briefs = new Briefs();
                briefs.setNom(request.getParameter("name"));
                briefs.setDescription(request.getParameter("description"));
                briefs.setStatus(false);
                briefs.setImage(newName);

                promo.setId(former.getPromosByIdpr().getId());
                briefs.setPromosByIdpr(promo);
                BreifRepository.save(briefs);
            }
            return true;
        } catch (Exception e) {
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
