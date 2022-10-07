package valeo.ventamal.entidades;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Objects;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * @author Valeo
 */
@Entity
@Table(name = "COMENTARIOS")
@NamedQueries({
    @NamedQuery(name="Comentario.findPublicos",
        query = "SELECT c FROM Comentario c WHERE c.articulo.id = :idArticulo AND c.visibilidad = 'publico'"),
    @NamedQuery(name="Comentario.findVisibles",
        query = "SELECT c FROM Comentario c WHERE c.articulo.id = :idArticulo AND (c.visibilidad = 'publico'"
            + " OR (c.visibilidad = 'privado' AND c.usuario.id = :idUsuario)"
            + " OR (c.visibilidad = 'vendedor' AND (c.articulo.usuario.id = :idUsuario OR c.usuario.id = :idUsuario)))")
})
public class Comentario implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="ID_usuario")
    private Usuario usuario;
    
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="ID_articulo")
    private Articulo articulo;
    
    @Column(name="visibilidad",nullable=false)
    private String visibilidad;
    
    @Column(name="texto",nullable=false)
    private String texto;
    
    @Column(name="fecha_publicacion",nullable=false)
    private Timestamp fechaPublicacion;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Articulo getArticulo() {
        return articulo;
    }

    public void setArticulo(Articulo articulo) {
        this.articulo = articulo;
    }

    public String getVisibilidad() {
        return visibilidad;
    }

    public void setVisibilidad(String visibilidad) {
        this.visibilidad = visibilidad;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public Timestamp getFechaPublicacion() {
        return fechaPublicacion;
    }

    public void setFechaPublicacion(Timestamp fechaPublicacion) {
        this.fechaPublicacion = fechaPublicacion;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 19 * hash + Objects.hashCode(this.id);
        hash = 19 * hash + Objects.hashCode(this.usuario);
        hash = 19 * hash + Objects.hashCode(this.articulo);
        hash = 19 * hash + Objects.hashCode(this.visibilidad);
        hash = 19 * hash + Objects.hashCode(this.texto);
        hash = 19 * hash + Objects.hashCode(this.fechaPublicacion);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        
        if (obj == null) return false;
        if (getClass() != obj.getClass()) return false;
        final Comentario other = (Comentario) obj;
        if (!Objects.equals(this.visibilidad, other.visibilidad)) return false;
        if (!Objects.equals(this.texto, other.texto)) return false;
        if (!Objects.equals(this.id, other.id)) return false;
        if (!Objects.equals(this.usuario, other.usuario)) return false;
        if (!Objects.equals(this.articulo, other.articulo)) return false;
        if (!Objects.equals(this.fechaPublicacion, other.fechaPublicacion)) return false;
        
        return true;
    }

    @Override
    public String toString() {
        return "Comentario{" + "id=" + id + ", usuario=" + usuario 
                + ", articulo=" + articulo 
                + ", visibilidad=" + visibilidad + ", texto=" + texto 
                + ", fecha_publicacion=" + fechaPublicacion + '}';
    }

}
