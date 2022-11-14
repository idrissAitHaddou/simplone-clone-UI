package simplone.example.simplonecloneui.admin;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import simplone.example.simplonecloneui.config.Config;
import simplone.example.simplonecloneui.learner.Apprenants;

import java.util.List;

public class AdminRepository {

    public static boolean changePassowrd(String password, int id) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery("UPDATE Admin a SET a.password = :password WHERE a.id = :id");
            query.setParameter("password", password);
            query.setParameter("id", id);
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

    public static boolean checkPassword(String passowrd, int id) {
        boolean check = false;
        List admin = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT A FROM Admin A where A.id = :id and A.password = :password");
        query.setParameter("password", passowrd);
        query.setParameter("id", id);
        admin = query.getResultList();
        em.getTransaction().commit();
        em.close();
        if(admin.size() > 0) check = true;
        return check;
    }

    public static boolean updateProfile(Admin admin) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery("UPDATE Admin a SET a.firstname = :prenom, a.lastname = :nom, a.email = :email WHERE a.id = :id");
            query.setParameter("prenom",admin.getFirstname());
            query.setParameter("nom",admin.getLastname());
            query.setParameter("email",admin.getEmail());
            query.setParameter("id",admin.getId());
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

    public static List getOne(int id) {
        List former = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT A FROM Admin A where A.id =:id");
        query.setParameter("id", id);
        former = query.getResultList();
        em.getTransaction().commit();
        em.close();
        return former;
    }
    public static List getDetails(int id) {
        List admin = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT A.id, A.lastname, A.firstname, A.email FROM Admin A where A.id =:id");
        query.setParameter("id", id);
        admin = query.getResultList();
        em.getTransaction().commit();
        em.close();
        return admin;
    }

    public static List allUsers() {
        List users = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        users = em.createQuery("SELECT DISTINCT A, F FROM Apprenants A, Formateurs F").getResultList();
        em.getTransaction().commit();
        em.close();
        return users;
    }
}
