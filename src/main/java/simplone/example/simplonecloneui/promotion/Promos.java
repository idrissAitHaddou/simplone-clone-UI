package simplone.example.simplonecloneui.promotion;

import jakarta.persistence.*;
import simplone.example.simplonecloneui.breif.Briefs;
import simplone.example.simplonecloneui.former.Formateurs;
import simplone.example.simplonecloneui.learner.Apprenants;

import java.util.Collection;

@Entity
public class Promos {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id")
    private int id;
    @Basic
    @Column(name = "nom")
    private String nom;
    @Basic
    @Column(name = "annescolaire")
    private String annescolaire;

    public void setImage(String image) {
        this.image = image;
    }

    @Basic
    @Column(name = "niveau")
    private String niveau;

    public String getImage() {
        return image;
    }

    @Basic
    @Column(name = "image")
    private String image;
    @OneToMany(mappedBy = "idpr")
    private Collection<Apprenants> apprenantsById;
    @OneToMany(mappedBy = "promosByIdpr")
    private Collection<Briefs> briefsById;
    @OneToMany(mappedBy = "promosByIdpr")
    private Collection<Formateurs> formateursById;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getAnnescolaire() {
        return annescolaire;
    }

    public void setAnnescolaire(String annescolaire) {
        this.annescolaire = annescolaire;
    }

    public String getNiveau() {
        return niveau;
    }

    public void setNiveau(String niveau) {
        this.niveau = niveau;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Promos promos = (Promos) o;

        if (id != promos.id) return false;
        if (nom != null ? !nom.equals(promos.nom) : promos.nom != null) return false;
        if (annescolaire != null ? !annescolaire.equals(promos.annescolaire) : promos.annescolaire != null)
            return false;
        if (niveau != null ? !niveau.equals(promos.niveau) : promos.niveau != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (nom != null ? nom.hashCode() : 0);
        result = 31 * result + (annescolaire != null ? annescolaire.hashCode() : 0);
        result = 31 * result + (niveau != null ? niveau.hashCode() : 0);
        return result;
    }

    public Collection<Apprenants> getApprenantsById() {
        return apprenantsById;
    }

    public void setApprenantsById(Collection<Apprenants> apprenantsById) {
        this.apprenantsById = apprenantsById;
    }

    public Collection<Briefs> getBriefsById() {
        return briefsById;
    }

    public void setBriefsById(Collection<Briefs> briefsById) {
        this.briefsById = briefsById;
    }

    public Collection<Formateurs> getFormateursById() {
        return formateursById;
    }

    public void setFormateursById(Collection<Formateurs> formateursById) {
        this.formateursById = formateursById;
    }

    @Override
    public String toString() {
        return "Promos{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", annescolaire='" + annescolaire + '\'' +
                ", niveau='" + niveau + '\'' +
                '}';
    }
}
