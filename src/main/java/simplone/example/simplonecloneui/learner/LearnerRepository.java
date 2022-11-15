package simplone.example.simplonecloneui.learner;

import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import simplone.example.simplonecloneui.config.Config;
import simplone.example.simplonecloneui.former.Formateurs;

import java.util.List;

public class LearnerRepository {

    public static Apprenants login(String email, String passowrd) {
        try{
            List<Apprenants> result = null;
            Apprenants learner = null;
            EntityManager em = Config.getConfig().getEntityManager();
            em.getTransaction().begin();
            Query query = em.createQuery("SELECT A FROM Apprenants A where A.email = :email and A.password = :password");
            query.setParameter("password", passowrd);
            query.setParameter("email", email);
            result = query.getResultList();
            em.getTransaction().commit();
            em.close();
            if(result.size() > 0) {
                for (Apprenants res: result) {
                    learner = res;break;
                }
            }
            return learner;
        }catch (Exception e) {
            System.out.println(e.getMessage());
            return null;
        }
    }

    public static boolean changePassowrd(String password, int id) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery("UPDATE Apprenants a SET a.password = :password WHERE a.id = :id");
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
        List laerner = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT A FROM Apprenants A where A.id = :id and A.password = :password");
        query.setParameter("password", passowrd);
        query.setParameter("id", id);
        laerner = query.getResultList();
        em.getTransaction().commit();
        em.close();
        if(laerner.size() > 0) check = true;
        return check;
    }

    public static boolean updateProfile(Apprenants apprenants) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            em.getTransaction().begin();
            Query query = em.createQuery("UPDATE Apprenants a SET a.prenom = :prenom, a.nom = :nom, a.email = :email WHERE a.id = :id");
            query.setParameter("prenom",apprenants.getPrenom());
            query.setParameter("nom",apprenants.getNom());
            query.setParameter("email",apprenants.getEmail());
            query.setParameter("id",apprenants.getId());
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

    public static List all() {
        List users = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        users = em.createQuery("SELECT A.id, A.nom, A.prenom, A.email, A.role FROM Apprenants A").getResultList();
        em.getTransaction().commit();
        em.close();
        return users;
    }

    public static List getDetails(int id) {
        List learner = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT A.id, A.nom, A.prenom, A.email FROM Apprenants A where A.id =:id");
        query.setParameter("id", id);
        learner = query.getResultList();
        em.getTransaction().commit();
        em.close();
        return learner;
    }

    public static List getOne(int id) {
        List learner = null;
        EntityManager em = Config.getConfig().getEntityManager();
        em.getTransaction().begin();
        Query query = em.createQuery("SELECT A FROM Apprenants A where A.id =:id");
        query.setParameter("id", id);
        learner = query.getResultList();
        em.getTransaction().commit();
        em.close();
        return learner;
    }

    public static boolean save(Apprenants apprenants) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(apprenants);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            em.getTransaction().rollback();
            return false;
        } finally {
            em.close();
        }
    }

    public static boolean update(Apprenants apprenants) {
        EntityManager em = Config.getConfig().getEntityManager();
        try {
            if(apprenants.getPassword().equals("")) {
                Apprenants apprenant = em.find(Apprenants.class, apprenants.getId());
                apprenants.setPassword(apprenant.getPassword());
            }
            em.getTransaction().begin();
            Query query = em.createQuery("UPDATE Apprenants a SET a.prenom = :prenom, a.nom = :nom, a.email = :email, a.password = :password WHERE a.id = :id");
            query.setParameter("prenom",apprenants.getPrenom());
            query.setParameter("nom",apprenants.getNom());
            query.setParameter("email",apprenants.getEmail());
            query.setParameter("password",apprenants.getPassword());
            query.setParameter("id",apprenants.getId());
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
            Apprenants apprenants = em.find(Apprenants.class, id);
            em.getTransaction().begin();
            em.remove(apprenants);
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
