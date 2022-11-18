package simplone.example.simplonecloneui.mail;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Random;

public class ForgetPassword {
    // generate the code to validate email
    public static String getRandomNumberString() {
        // It will generate 6 digit random Number.
        // from 0 to 999999
        Random rnd = new Random();
        int number = rnd.nextInt(999999);

        // this will convert any number sequence into 6 character.
        return String.format("%06d", number);
    }
    public static void sendCodeValidateEmail(HttpServletRequest request, String recipient) {
        System.out.println("");
        System.out.println(" Preparing send code validate to email...");
        System.out.println("");
        // Properties
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP Host
        props.put("mail.smtp.port", "587"); //TLS Port
        props.put("mail.smtp.auth", "true"); //enable authentication
        props.put("mail.smtp.starttls.enable", "true");
        props.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");

        String adminEmail = "idrissaithadou@gmail.com";
        String adminPassword = "gthhrpjrawrvompu";

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(adminEmail, adminPassword);
            }
        });
        Message message = prepareMessage(request, session, adminEmail, recipient);
        try {
            Transport transport = session.getTransport("smtp");
            transport.connect("idrissaithadou@gmail.com", "gthhrpjrawrvompu");
            // Send message
            transport.sendMessage(message, message.getAllRecipients());
            System.out.println("Sent message successfully....");
            transport.close();
        } catch (Exception ex) {
            System.out.println(" Email doesn't sent !!!");
            System.out.println(ex.getMessage());
        }

    }

    public static Message prepareMessage(HttpServletRequest request, Session session, String adminEmail, String recipient) {
        try{
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(adminEmail));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
            // Set Subject: header field
            message.setSubject("validate email");
            // get code generated
            String code =  getRandomNumberString();
            addCodeToSession(request, code, recipient);
            message.setText(code);
            return message;
        } catch (Exception ex) {
            System.out.println(" error message");
        }
        return null;
    }

    public static void addCodeToSession(HttpServletRequest request, String code, String recipient) {
        HttpSession session = request.getSession();
        if(session.getAttribute("emailToValidate") != null) session.removeAttribute("emailToValidate");
        if(session.getAttribute("codeGenerate") != null) session.removeAttribute("codeGenerate");
        session.setAttribute("emailToValidate", recipient);
        session.setAttribute("codeGenerate", code);
    }
}
