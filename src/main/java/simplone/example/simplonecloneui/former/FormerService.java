package simplone.example.simplonecloneui.former;

import simplone.example.simplonecloneui.learner.Apprenants;
import simplone.example.simplonecloneui.learner.LearnerRepository;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

public class FormerService {

    public static List getAllFormersService() {
        return FormerRepository.all();
    }

    public static List learnersWithoutPromoService() {
        return FormerRepository.learnersWithoutPromo();
    }

    public static boolean deleteMyLearnerService(int id) {
        return FormerRepository.deleteMyLearner(id);
    }

    public static boolean addLearnerToPromoService(int id) {
        List<Formateurs> formers = FormerRepository.getOne(25);
        for (Formateurs former: formers) {
            return FormerRepository.addLearnerToPromo(former.getPromosByIdpr().getId(), id);
        }
        return false;
    }

    public static List searchLearnersService(String name) {
        List<Formateurs> formers = FormerRepository.getOne(25);
        List<Apprenants> learners = null;
        for (Formateurs former: formers) {
            learners = FormerRepository.findMyLearners(former.getPromosByIdpr().getId(), name);
            break;
        }
        System.out.println(learners.toString());
        return learners;
    }

    public static List launchBreifToLearnersService() {
        List<Formateurs> formers = FormerRepository.getOne(25);
        List<Apprenants> learners = null;
        for (Formateurs former: formers) {
            learners = FormerRepository.launchBreifToLearners(former.getPromosByIdpr().getId());
            break;
        }
        return learners;
    }

    public static List getMyLearnersService() {
        List<Formateurs> formers = FormerRepository.getOne(25);
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
