package simplone.example.simplonecloneui.mail;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import simplone.example.simplonecloneui.config.Config;

public class EmailRepository {
    // change passowrd for learner
    public static boolean changePasswordForLearner(String email, String passowrd) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery("UPDATE Apprenants A SET A.password = :password WHERE A.email = :email");
            query.setParameter("password", passowrd);
            query.setParameter("email", email);
            query.executeUpdate();
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }
    // change passowrd for former
    public static boolean changePasswordForFormer(String email, String passowrd) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery("UPDATE Formateurs F SET F.password = :password WHERE F.email = :email");
            query.setParameter("password", passowrd);
            query.setParameter("email", email);
            query.executeUpdate();
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }
    // change passowrd for admin
    public static boolean changePasswordForAdmin(String email, String passowrd) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery("UPDATE Admin A SET A.password = :password WHERE A.email = :email");
            query.setParameter("password", passowrd);
            query.setParameter("email", email);
            query.executeUpdate();
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }
}
