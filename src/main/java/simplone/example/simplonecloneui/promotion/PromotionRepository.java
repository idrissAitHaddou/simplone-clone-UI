package simplone.example.simplonecloneui.promotion;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import simplone.example.simplonecloneui.config.Config;
import simplone.example.simplonecloneui.former.Formateurs;

import java.util.List;

public class PromotionRepository {

    public static List all() {
        List promotions = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        promotions = em.createQuery("SELECT P.id, P.nom, P.annescolaire, P.niveau FROM Promos P").getResultList();
        em.getTransaction().commit();
        em.close();
        return promotions;
    }

    public static List findByName(String name) {
        List promotions = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT P.id, P.nom, P.annescolaire, P.niveau FROM Promos P where P.nom like :name");
        query.setParameter("name", name);
        promotions = query.getResultList();
        em.getTransaction().commit();
        em.close();
        return promotions;
    }

    public static boolean delete(int id) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            Promos promotion = em.find(Promos.class, id);
            em.getTransaction().begin();
            em.remove(promotion);
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
        List promotions = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT P.id, P.nom, P.annescolaire, P.niveau, P.image FROM Promos P where P.id = :id");
        query.setParameter("id", id);
        promotions = query.getResultList();
        em.getTransaction().commit();
        em.close();
        return promotions;
    }

    public static List getOne(int id) {
        List promotions = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT P FROM Promos P where P.id = :id");
        query.setParameter("id", id);
        promotions = query.getResultList();
        em.getTransaction().commit();
        em.close();
        return promotions;
    }

    public static boolean save(Promos promotion) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(promotion);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
          return false;
        } finally {
            em.close();
        }
    }

    public static List<Promos> getLast() {
        List<Promos> promotion = null;
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery("SELECT p FROM Promos p ORDER BY p.id DESC");
            promotion = query.setMaxResults(1).getResultList();
            em.getTransaction().commit();
        } catch (Exception e) {
        } finally {
            em.close();
        }
        return promotion;
    }

    public static boolean update(Promos promotion) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery("UPDATE Promos P SET P.nom = :nom, P.annescolaire = :year, P.niveau = :niveaux, P.image = :image WHERE P.id = :id");
            query.setParameter("nom",promotion.getNom());
            query.setParameter("year",promotion.getAnnescolaire());
            query.setParameter("niveaux",promotion.getNiveau());
            query.setParameter("image",promotion.getImage());
            query.setParameter("id",promotion.getId());
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