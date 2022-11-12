package simplone.example.simplonecloneui.breif;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import simplone.example.simplonecloneui.config.Config;
import simplone.example.simplonecloneui.former.Formateurs;
import simplone.example.simplonecloneui.promotion.Promos;

import java.util.List;

public class BreifRepository {

    public static List getByIdPromo(int id) {
        List breifs = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT B.id, B.nom, B.description, B.status, B.image FROM Briefs B where B.promosByIdpr.id = :id");
        query.setParameter("id", id);
        breifs = query.getResultList();
        em.getTransaction().commit();
        em.close();
        return breifs;
    }

    public static boolean launch(int id, boolean status) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery("UPDATE Briefs B SET B.status = :status WHERE B.id = :id");
            query.setParameter("status", status);
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

    public static List findBreifs(int idPromo, String name) {
        List breifs = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT B.id, B.nom, B.description, B.status FROM Briefs B where B.promosByIdpr.id = :idPromo and B.nom = :name ");
        query.setParameter("idPromo", idPromo);
        query.setParameter("name", name);
        breifs = query.getResultList();
        em.getTransaction().commit();
        em.close();
        return breifs;
    }


    public static boolean delete(int id) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            Briefs brief = em.find(Briefs.class, id);
            em.getTransaction().begin();
            em.remove(brief);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }

    public static boolean update(Briefs brief) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery("UPDATE Briefs B SET B.nom = :nom, B.description = :description, B.image = :image WHERE B.id = :id");
            query.setParameter("nom",brief.getNom());
            query.setParameter("description",brief.getDescription());
            query.setParameter("image",brief.getImage());
            query.setParameter("id",brief.getId());
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

    public static List<Briefs> getLast() {
        List<Briefs> breif = null;
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery("SELECT B FROM Briefs B ORDER BY B.id DESC");
            breif = query.setMaxResults(1).getResultList();
            em.getTransaction().commit();
        } catch (Exception e) {
        } finally {
            em.close();
        }
        return breif;
    }

    public static List allMyBreifs(int idPromo) {
        List breifs = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT B.id, B.nom, B.description, B.status FROM Briefs B where B.promosByIdpr.id = :idPromo");
        query.setParameter("idPromo", idPromo);
        breifs = query.getResultList();
        em.getTransaction().commit();
        em.close();
        return breifs;
    }

    public static List getOne(int id) {
        List breifs = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT B FROM Briefs B where B.id = :id");
        query.setParameter("id", id);
        breifs = query.getResultList();
        em.getTransaction().commit();
        em.close();
        return breifs;
    }

    public static List getById(int id) {
        List breifs = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT B.id, B.nom, B.description, B.status, B.image FROM Briefs B where B.id = :id");
        query.setParameter("id", id);
        breifs = query.getResultList();
        em.getTransaction().commit();
        em.close();
        return breifs;
    }

    public static boolean save(Briefs briefs) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(briefs);
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
