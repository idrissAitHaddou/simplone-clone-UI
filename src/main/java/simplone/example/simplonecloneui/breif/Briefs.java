package simplone.example.simplonecloneui.entity;

import javax.persistence.*;

@Entity
public class Briefs {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id")
    private int id;
    @Basic
    @Column(name = "nom")
    private String nom;
    @Basic
    @Column(name = "description")
    private String description;
    @Basic
    @Column(name = "status")
    private Boolean status;
    @ManyToOne
    @JoinColumn(name = "idpr", referencedColumnName = "id")
    private Promos promosByIdpr;

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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Briefs briefs = (Briefs) o;

        if (id != briefs.id) return false;
        if (nom != null ? !nom.equals(briefs.nom) : briefs.nom != null) return false;
        if (description != null ? !description.equals(briefs.description) : briefs.description != null) return false;
        if (status != null ? !status.equals(briefs.status) : briefs.status != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (nom != null ? nom.hashCode() : 0);
        result = 31 * result + (description != null ? description.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        return result;
    }

    public Promos getPromosByIdpr() {
        return promosByIdpr;
    }

    public void setPromosByIdpr(Promos promosByIdpr) {
        this.promosByIdpr = promosByIdpr;
    }

    @Override
    public String toString() {
        return "Briefs{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", description='" + description + '\'' +
                ", status=" + status +
                ", promosByIdpr=" + promosByIdpr +
                '}';
    }
}
