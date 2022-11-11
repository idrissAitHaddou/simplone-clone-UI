package entity;

import javax.persistence.*;

@Entity
public class Rendu {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "id")
    private int id;
    @Basic
    @Column(name = "lien")
    private String lien;
    @Basic
    @Column(name = "status")
    private Boolean status;
    @ManyToOne
    @JoinColumn(name = "idbrief", referencedColumnName = "id")
    private Briefs briefsByIdbrief;
    @ManyToOne
    @JoinColumn(name = "idpr", referencedColumnName = "id")
    private Promos promosByIdpr;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLien() {
        return lien;
    }

    public void setLien(String lien) {
        this.lien = lien;
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

        Rendu rendu = (Rendu) o;

        if (id != rendu.id) return false;
        if (lien != null ? !lien.equals(rendu.lien) : rendu.lien != null) return false;
        if (status != null ? !status.equals(rendu.status) : rendu.status != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (lien != null ? lien.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        return result;
    }

    public Briefs getBriefsByIdbrief() {
        return briefsByIdbrief;
    }

    public void setBriefsByIdbrief(Briefs briefsByIdbrief) {
        this.briefsByIdbrief = briefsByIdbrief;
    }

    public Promos getPromosByIdpr() {
        return promosByIdpr;
    }

    public void setPromosByIdpr(Promos promosByIdpr) {
        this.promosByIdpr = promosByIdpr;
    }
}
