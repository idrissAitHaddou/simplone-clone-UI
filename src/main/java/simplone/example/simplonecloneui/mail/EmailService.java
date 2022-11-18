package simplone.example.simplonecloneui.mail;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import simplone.example.simplonecloneui.learner.LearnerService;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class EmailService {
    // change password depend on role that have in session
    public static boolean changePasswordForgetService(HttpServletRequest request, String email, String password) {
        String passwordHashing = passwordHashing(password);
        HttpSession session = request.getSession();
        String role = (String)session.getAttribute("roleResetPassword");
        if(role.equals("learner")) return EmailRepository.changePasswordForLearner(email, passwordHashing);
        if(role.equals("former")) return EmailRepository.changePasswordForFormer(email, passwordHashing);
        if(role.equals("admin")) return EmailRepository.changePasswordForAdmin(email, passwordHashing);
        return false;
    }
    // hashing the password by MD5
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
