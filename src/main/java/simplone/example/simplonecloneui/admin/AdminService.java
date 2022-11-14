package simplone.example.simplonecloneui.admin;

import jakarta.servlet.http.HttpServletRequest;
import simplone.example.simplonecloneui.learner.LearnerRepository;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

public class AdminService {

    public static boolean changeAdminPasswordService(String passowrd, int id) {
        String passwordHashing = passwordHashing(passowrd);
        return AdminRepository.changePassowrd(passwordHashing, id);
    }

    public static boolean checkAdminPasswordService(String passowrd, int id) {
        String passwordHashing = passwordHashing(passowrd);
        return AdminRepository.checkPassword(passwordHashing, id);
    }

    public static boolean updateAdminService(HttpServletRequest request, int id) {
        Admin admin = new Admin();
        admin.setId(id);
        admin.setFirstname(request.getParameter("firstname"));
        admin.setLastname(request.getParameter("lastname"));
        admin.setEmail(request.getParameter("email"));
        return AdminRepository.updateProfile(admin);
    }

    public static List getProfileService(int id) {
        return AdminRepository.getDetails(id);
    }

    public static List getAllUsresService() {
        return AdminRepository.allUsers();
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
