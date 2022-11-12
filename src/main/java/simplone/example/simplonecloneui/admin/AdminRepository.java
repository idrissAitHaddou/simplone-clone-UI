package simplone.example.simplonecloneui.admin;

import jakarta.persistence.EntityManager;
import simplone.example.simplonecloneui.config.Config;

import java.util.List;

public class AdminRepository {
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
