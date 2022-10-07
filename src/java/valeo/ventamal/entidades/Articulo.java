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
@Table(name = "ARTICULOS")
@NamedQueries({
    @NamedQuery(name="Articulo.findById",
        query ="SELECT a FROM Articulo a WHERE a.id = :id"),
    @NamedQuery(name="Articulo.findAllNuevosPrimero",
        query ="SELECT a FROM Articulo a ORDER BY a.fechaSubida DESC"),
    @NamedQuery(name="Articulo.findByCategoria",
        query="SELECT a FROM Articulo a WHERE a.categoria = :categoria"),
    @NamedQuery(name="Articulo.findByCp",
        query="SELECT a FROM Articulo a WHERE a.categoria = :categoria"),
    @NamedQuery(name="Articulo.findByPrecioMin",
        query="SELECT a FROM Articulo a WHERE a.precio >= :precioMin"),
    @NamedQuery(name="Articulo.findByPrecioMax",
        query="SELECT a FROM Articulo a WHERE a.precio <= :precioMax"),
    @NamedQuery(name="Articulo.findByRangoPrecios",
        query="SELECT a FROM Articulo a WHERE a.precio >= :precioMin AND a.precio <= :precioMax")
})
public class Articulo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    
    @ManyToOne(fetch=FetchType.LAZY)
    @JoinColumn(name="ID_usuario")
    private Usuario usuario;
    
    @Column(name="categoria",nullable=false)
    private String categoria;
    
    @Column(name="nombre",nullable=false)
    private String nombre;
    
    @Column(name="descripcion")
    private String descripcion;
    
    @Column(name="estado")
    private String estado;
    
    @Column(name="ano_adquisicion")
    private int anoAdquisicion;
    
    @Column(name="precio",nullable=false)
    private float precio;
    
    @Column(name="fecha_subida",nullable=false)
    private Timestamp fechaSubida;
    
    @Column(name="tiene_imagen")
    private boolean tieneImagen;

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

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public int getAnoAdquisicion() {
        return anoAdquisicion;
    }

    public void setAnoAdquisicion(int anoAdquision) {
        this.anoAdquisicion = anoAdquision;
    }

    public float getPrecio() {
        return precio;
    }

    public void setPrecio(float precio) {
        this.precio = precio;
    }

    public Timestamp getFechaSubida() {
        return fechaSubida;
    }

    public void setFechaSubida(Timestamp fechaSubida) {
        this.fechaSubida = fechaSubida;
    }

    public boolean tieneImagen() {
        return tieneImagen;
    }

    public void setTieneImagen(boolean tieneImagen) {
        this.tieneImagen = tieneImagen;
    }

    @Override
    public int hashCode() {
        int hash = 7;
        hash = 53 * hash + Objects.hashCode(this.id);
        hash = 53 * hash + Objects.hashCode(this.usuario);
        hash = 53 * hash + Objects.hashCode(this.categoria);
        hash = 53 * hash + Objects.hashCode(this.nombre);
        hash = 53 * hash + Float.floatToIntBits(this.precio);
        hash = 53 * hash + Objects.hashCode(this.fechaSubida);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        
        if (obj == null) return false;
        if (getClass() != obj.getClass()) return false;
        
        final Articulo other = (Articulo) obj;
        if (this.anoAdquisicion != other.anoAdquisicion) return false;
        if (Float.floatToIntBits(this.precio) != Float.floatToIntBits(other.precio))
            return false;
        if (!Objects.equals(this.categoria, other.categoria)) return false;
        if (!Objects.equals(this.nombre, other.nombre)) return false;
        if (!Objects.equals(this.descripcion, other.descripcion)) return false;
        if (!Objects.equals(this.estado, other.estado)) return false;
        if (!Objects.equals(this.id, other.id)) return false;
        if (!Objects.equals(this.usuario, other.usuario)) return false;
        if (!Objects.equals(this.fechaSubida, other.fechaSubida)) return false;
        if (!Objects.equals(this.tieneImagen, other.tieneImagen)) return false;
        
        return true;
    }

    @Override
    public String toString() {
        return "Articulo{" + "id=" + id + ", usuario=" + usuario 
                + ", categoria=" + categoria + ", nombre=" + nombre 
                + ", descripcion=" + descripcion + ", estado=" + estado 
                + ", anoAdquision=" + anoAdquisicion + ", precio=" + precio 
                + ", fechaSubida=" + fechaSubida 
                + ", tiene_imagen: " + tieneImagen + "}";
    }

}
