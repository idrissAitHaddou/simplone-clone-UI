package simplone.example.simplonecloneui.learner;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import simplone.example.simplonecloneui.breif.BreifRepository;
import simplone.example.simplonecloneui.breif.BreifService;
import simplone.example.simplonecloneui.breif.Briefs;
import simplone.example.simplonecloneui.promotion.Promos;
import simplone.example.simplonecloneui.promotion.PromotionService;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

public class LearnerService {
    public static List getPromoImageService(HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<Apprenants> learners = LearnerRepository.getOne((Integer)session.getAttribute("id"));
        List<Promos> promotion = null;
        for (Apprenants learner: learners) {
            promotion = PromotionService.getPromoByIdService(learner.getIdpr());
            break;
        }
        return promotion;
    }

    public static boolean loginService(HttpServletRequest request, String email, String passowrd) {
        String passwordHashing = passwordHashing(passowrd);
        Apprenants learner = null;
        learner = LearnerRepository.login(email, passwordHashing);
        if(learner != null) {
            HttpSession session = request.getSession();
            session.setAttribute("role", "learner");
            session.setAttribute("email", learner.getEmail());
            session.setAttribute("id", learner.getId());
            return true;
        }
        return false;
    }

    public static boolean changeLearnerPasswordService(String passowrd, int id) {
        String passwordHashing = passwordHashing(passowrd);
        return LearnerRepository.changePassowrd(passwordHashing, id);
    }

    public static boolean checkLearnerPasswordService(String passowrd, int id) {
        String passwordHashing = passwordHashing(passowrd);
        return LearnerRepository.checkPassword(passwordHashing, id);
    }

    public static boolean updateLearnerProfileService(HttpServletRequest request, int id) {
        Apprenants learner = new Apprenants();
        learner.setId(id);
        learner.setPrenom(request.getParameter("firstname"));
        learner.setNom(request.getParameter("lastname"));
        learner.setEmail(request.getParameter("email"));
        return LearnerRepository.updateProfile(learner);
    }

    public static List getBrefiDetailsService(int id) {
        return BreifRepository.getById(id);
    }

    public static List getMyBrefisService(HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<Apprenants> learners = LearnerRepository.getOne((Integer)session.getAttribute("id"));
        List<Briefs> breifs = null;
        for (Apprenants learner: learners) {
            breifs = BreifService.getByIdPromoService(learner.getIdpr());
            break;
        }
        return breifs;
    }
    public static List getAllLearnersService() {
        return LearnerRepository.all();
    }

    public static List getLearnerService(int id) {
        return LearnerRepository.getDetails(id);
    }

    public static boolean createLearnerService(Apprenants apprenants) {
        apprenants.setPassword(passwordHashing(apprenants.getPassword()));
        return LearnerRepository.save(apprenants);
    }

    public static boolean updateLearnerService(Apprenants apprenants) {
        if(!apprenants.getPassword().equals(""))
        apprenants.setPassword(passwordHashing(apprenants.getPassword()));
        return LearnerRepository.update(apprenants);
    }

    public static boolean deleteService(int id) {
       return LearnerRepository.delete(id);
    }

    public static String passwordHashing(String password) {
        MessageDigest messageDigest = null;
        try {
            messageDigest = MessageDigest.getInstance("MD5");
        } catch (NoSuchAlgorithmException e) {
            System.out.println(e.getMessage());
        }
        messageDigest.update(password.getBytes());
        byte[] resultByteArray = messageDigest.digest();
        StringBuilder sb = new StringBuilder();
        for(Byte res:resultByteArray) {
            sb.append(String.format("%02x", res));
        }
        return sb.toString();
    }
}
