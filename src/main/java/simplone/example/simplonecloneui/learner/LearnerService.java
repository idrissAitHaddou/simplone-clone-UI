package simplone.example.simplonecloneui.learner;

import jakarta.servlet.http.HttpServletRequest;
import simplone.example.simplonecloneui.breif.BreifRepository;
import simplone.example.simplonecloneui.breif.BreifService;
import simplone.example.simplonecloneui.breif.Briefs;
import simplone.example.simplonecloneui.former.Formateurs;
import simplone.example.simplonecloneui.former.FormerRepository;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

public class LearnerService {

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

    public static List getMyBrefisService() {
        List<Apprenants> learners = LearnerRepository.getOne(1);
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
