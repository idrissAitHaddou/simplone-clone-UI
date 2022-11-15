package simplone.example.simplonecloneui.former;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import simplone.example.simplonecloneui.admin.Admin;
import simplone.example.simplonecloneui.admin.AdminRepository;
import simplone.example.simplonecloneui.learner.Apprenants;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

public class FormerService {

    public static boolean loginService(HttpServletRequest request, String email, String passowrd) {
        String passwordHashing = passwordHashing(passowrd);
        Formateurs former = null;
        former = FormerRepository.login(email, passwordHashing);
        if(former != null) {
            HttpSession session = request.getSession();
            session.setAttribute("role", "former");
            session.setAttribute("email", former.getEmail());
            session.setAttribute("id", former.getId());
            return true;
        }
        return false;
    }

    public static boolean changeFormerPasswordService(String passowrd, int id) {
        String passwordHashing = passwordHashing(passowrd);
        return FormerRepository.changePassowrd(passwordHashing, id);
    }

    public static boolean checkFormerPasswordService(String passowrd, int id) {
        String passwordHashing = passwordHashing(passowrd);
        return FormerRepository.checkPassword(passwordHashing, id);
    }

    public static boolean updateFormerProfileService(HttpServletRequest request, int id) {
        Formateurs former = new Formateurs();
        former.setId(id);
        former.setPrenom(request.getParameter("firstname"));
        former.setNom(request.getParameter("lastname"));
        former.setEmail(request.getParameter("email"));
        return FormerRepository.updateProfile(former);
    }

    public static List getAllFormersService() {
        return FormerRepository.all();
    }

    public static List learnersWithoutPromoService() {
        return FormerRepository.learnersWithoutPromo();
    }

    public static boolean deleteMyLearnerService(int id) {
        return FormerRepository.deleteMyLearner(id);
    }

    public static boolean addLearnerToPromoService(HttpServletRequest request, int id) {
        HttpSession session = request.getSession();
        List<Formateurs> formers = FormerRepository.getOne((Integer) session.getAttribute("id"));
        for (Formateurs former: formers) {
            return FormerRepository.addLearnerToPromo(former.getPromosByIdpr().getId(), id);
        }
        return false;
    }

    public static List searchLearnersService(HttpServletRequest request, String name) {
        HttpSession session = request.getSession();
        List<Formateurs> formers = FormerRepository.getOne((Integer) session.getAttribute("id"));
        List<Apprenants> learners = null;
        for (Formateurs former: formers) {
            learners = FormerRepository.findMyLearners(former.getPromosByIdpr().getId(), name);
            break;
        }
        System.out.println(learners.toString());
        return learners;
    }

    public static List launchBreifToLearnersService(HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<Formateurs> formers = FormerRepository.getOne((Integer)session.getAttribute("id"));
        List<Apprenants> learners = null;
        for (Formateurs former: formers) {
            learners = FormerRepository.launchBreifToLearners(former.getPromosByIdpr().getId());
            break;
        }
        return learners;
    }

    public static List getMyLearnersService(HttpServletRequest request) {
        HttpSession session = request.getSession();
        List<Formateurs> formers = FormerRepository.getOne((Integer) session.getAttribute("id"));
        List<Apprenants> learners = null;
        for (Formateurs former: formers) {
            learners = FormerRepository.allMyLearners(former.getPromosByIdpr().getId());
            break;
        }
        return learners;
    }

    public static List getFormerService(int id) {
        return FormerRepository.getDetails(id);
    }

    public static void updateIdPromoService(int idFormer, int idPromo) {
        FormerRepository.updateIdPromo(idFormer, idPromo);
    }
    public static boolean createFormerService(Formateurs formateurs) {
        formateurs.setPassword(passwordHashing(formateurs.getPassword()));
        return FormerRepository.save(formateurs);
    }

    public static boolean updateFormerService(Formateurs formateurs) {
        if(!formateurs.getPassword().equals(""))
        formateurs.setPassword(passwordHashing(formateurs.getPassword()));
        return FormerRepository.update(formateurs);
    }

    public static boolean deleteService(int id) {
        return FormerRepository.delete(id);
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
