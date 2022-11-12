package simplone.example.simplonecloneui.mail;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class SendEmail {
    public static void sendEmail(String recipient, String name, String description) {
        System.out.println("");
        System.out.println(" Preparing send email...");
        System.out.println("");
        // Properties
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP Host
        props.put("mail.smtp.port", "587"); //TLS Port
        props.put("mail.smtp.auth", "true"); //enable authentication
        props.put("mail.smtp.starttls.enable", "true");
        props.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");

        String adminEmail = "idrissaithadou@gmail.com";
        String adminPassword = "2000@3@3driss";

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(adminEmail, adminPassword);
            }
        });
        Message message = prepareMessage(session, adminEmail, recipient, name, description);
        try {
            Transport transport = session.getTransport("smtp");
            transport.connect("idrissaithadou@gmail.com", "gyribnelqvmglgzc");
            transport.sendMessage(message, message.getAllRecipients());
            System.out.println("Sent message successfully....");
            transport.close();
        } catch (Exception ex) {
            System.out.println(" Email doesn't sent !!!");
            System.out.println(ex.getMessage());
        }

    }

    public static Message prepareMessage(Session session, String adminEmail, String recipient, String name, String description) {
        try{
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(adminEmail));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
            message.setSubject("New breif");
            message.setSubject(name);
            message.setText(description);
            return message;
        } catch (Exception ex) {
            System.out.println(" error message");
        }
        return null;
    }
}
