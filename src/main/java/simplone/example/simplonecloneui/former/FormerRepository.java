package simplone.example.simplonecloneui.former;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import simplone.example.simplonecloneui.config.Config;

import java.util.List;

public class FormerRepository {

    public static List all() {
        List users = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        users = em.createQuery("SELECT F.id, F.nom, F.prenom, F.email, F.role, F.promosByIdpr.id FROM Formateurs F").getResultList();
        em.getTransaction().commit();
        em.close();
        return users;
    }

    public static List learnersWithoutPromo() {
        List learners = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT A.id, A.nom, A.prenom, A.email, A.role FROM Apprenants A where A.idpr is null ");
        learners = query.getResultList();
        em.getTransaction().commit();
        em.close();
        return learners;
    }

    public static List findMyLearners(int id, String name) {
        List learners = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT A.id, A.nom, A.prenom, A.email, A.role FROM Apprenants A where A.idpr = :id and A.prenom = :name");
        query.setParameter("id", id);
        query.setParameter("name", name);
        learners = query.getResultList();
        em.getTransaction().commit();
        em.close();
        return learners;
    }

    public static List launchBreifToLearners(int id) {
        List learners = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT A FROM Apprenants A where A.idpr = :id");
        query.setParameter("id", id);
        learners = query.getResultList();
        em.getTransaction().commit();
        em.close();
        return learners;
    }
    public static List allMyLearners(int id) {
        List learners = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT A.id, A.nom, A.prenom, A.email, A.role FROM Apprenants A where A.idpr = :id");
        query.setParameter("id", id);
        learners = query.getResultList();
        em.getTransaction().commit();
        em.close();
        return learners;
    }

    public static boolean addLearnerToPromo(int idPromo, int id) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery("UPDATE Apprenants A SET A.idpr = :idPromo WHERE A.id = :id");
            query.setParameter("id",id);
            query.setParameter("idPromo",idPromo);
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

    public static List getDetails(int id) {
        List former = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT F.id, F.nom, F.prenom, F.email FROM Formateurs F where F.id =:id");
        query.setParameter("id", id);
        former = query.getResultList();
        em.getTransaction().commit();
        em.close();
        return former;
    }

    public static List getOne(int id) {
        List former = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT F FROM Formateurs F where F.id =:id");
        query.setParameter("id", id);
        former = query.getResultList();
        em.getTransaction().commit();
        em.close();
        return former;
    }

    public static boolean save(Formateurs formateurs) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(formateurs);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }

    public static boolean update(Formateurs formateurs) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            if(formateurs.getPassword().equals("")) {
                Formateurs formateur = em.find(Formateurs.class, formateurs.getId());
                formateurs.setPassword(formateur.getPassword());
            }
            em.getTransaction().begin();
            Query query = em.createQuery("UPDATE Formateurs f SET f.prenom = :prenom, f.nom = :nom, f.email = :email, f.password = :password WHERE f.id = :id");
            query.setParameter("prenom",formateurs.getPrenom());
            query.setParameter("nom",formateurs.getNom());
            query.setParameter("email",formateurs.getEmail());
            query.setParameter("password",formateurs.getPassword());
            query.setParameter("id",formateurs.getId());
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

    public static void updateIdPromo(int fomerId, int idPromo) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery("UPDATE Formateurs f SET f.promosByIdpr.id = :promo WHERE f.id = :id");
            if(idPromo == 0)
            query.setParameter("promo",null);
            if(idPromo != 0)
            query.setParameter("promo",idPromo);
            query.setParameter("id",fomerId);
            query.executeUpdate();
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
        } finally {
            em.close();
        }
    }

    public static boolean deleteMyLearner(int id) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery("UPDATE Apprenants A SET A.idpr = null WHERE A.id = :id");
            query.setParameter("id",id);
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

    public static boolean delete(int id) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            Formateurs formateurs = em.find(Formateurs.class, id);
            em.getTransaction().begin();
            em.remove(formateurs);
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
