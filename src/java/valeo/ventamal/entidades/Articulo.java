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
    @NamedQuery(name = "Articulo.findById",
            query = "SELECT a FROM Articulo a WHERE a.id = :id"),
    @NamedQuery(name = "Articulo.findAllNuevosPrimero",
            query = "SELECT a FROM Articulo a WHERE a.visible = true AND a.vendido = false ORDER BY a.fechaSubida DESC"),
    @NamedQuery(name = "Articulo.findByCategoria",
            query = "SELECT a FROM Articulo a WHERE a.visible = true AND a.categoria = :categoria"),
    @NamedQuery(name = "Articulo.findByCp",
            query = "SELECT a FROM Articulo a WHERE a.visible = true AND a.usuario.cp = :cp"),
    @NamedQuery(name = "Articulo.findByPrecioMin",
            query = "SELECT a FROM Articulo a WHERE a.visible = true AND a.precio >= :precioMin"),
    @NamedQuery(name = "Articulo.findByPrecioMax",
            query = "SELECT a FROM Articulo a WHERE a.visible = true AND a.precio <= :precioMax"),
    @NamedQuery(name = "Articulo.findByRangoPrecios",
            query = "SELECT a FROM Articulo a WHERE a.visible = true AND a.precio >= :precioMin AND a.precio <= :precioMax"),
    @NamedQuery(name = "Articulo.findByVendedor",
            query = "SELECT a FROM Articulo a WHERE a.visible = true AND a.usuario.id = :uid")
})
public class Articulo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ID_usuario")
    private Usuario usuario;

    @Column(name = "categoria", nullable = false)
    private String categoria;

    @Column(name = "nombre", nullable = false)
    private String nombre;

    @Column(name = "descripcion")
    private String descripcion;

    @Column(name = "estado")
    private String estado;

    @Column(name = "ano_adquisicion")
    private int anoAdquisicion;

    @Column(name = "precio", nullable = false)
    private float precio;

    @Column(name = "fecha_subida", nullable = false)
    private Timestamp fechaSubida;

    @Column(name = "tiene_imagen")
    private boolean tieneImagen;

    @Column(name = "visible")
    private boolean visible;

    @Column(name = "vendido")
    private boolean vendido;

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

    public boolean isVisible() {
        return visible;
    }

    public void setVisible(boolean visible) {
        this.visible = visible;
    }

    public boolean isVendido() {
        return vendido;
    }

    public void setVendido(boolean vendido) {
        this.vendido = vendido;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 23 * hash + Objects.hashCode(this.id);
        hash = 23 * hash + Objects.hashCode(this.usuario);
        hash = 23 * hash + Objects.hashCode(this.categoria);
        hash = 23 * hash + Objects.hashCode(this.nombre);
        hash = 23 * hash + Objects.hashCode(this.descripcion);
        hash = 23 * hash + Objects.hashCode(this.estado);
        hash = 23 * hash + this.anoAdquisicion;
        hash = 23 * hash + Float.floatToIntBits(this.precio);
        hash = 23 * hash + Objects.hashCode(this.fechaSubida);
        hash = 23 * hash + (this.tieneImagen ? 1 : 0);
        hash = 23 * hash + (this.visible ? 1 : 0);
        hash = 23 * hash + (this.vendido ? 1 : 0);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null) return false;
        
        if (getClass() != obj.getClass()) return false;
        final Articulo other = (Articulo) obj;
        if (this.anoAdquisicion != other.anoAdquisicion) return false;
        if (Float.floatToIntBits(this.precio) 
                != Float.floatToIntBits(other.precio)) return false;
        if (this.tieneImagen != other.tieneImagen) return false;
        if (this.visible != other.visible) return false;
        if (this.vendido != other.vendido) return false;
        if (!Objects.equals(this.categoria, other.categoria)) return false;
        if (!Objects.equals(this.nombre, other.nombre)) return false;
        if (!Objects.equals(this.descripcion, other.descripcion)) return false;
        if (!Objects.equals(this.estado, other.estado)) return false;
        if (!Objects.equals(this.id, other.id)) return false;
        if (!Objects.equals(this.usuario, other.usuario)) return false;
        return Objects.equals(this.fechaSubida, other.fechaSubida);
    }

    @Override
    public String toString() {
        return "Articulo{" + "id=" + id + ", usuario=" + usuario
                + ", categoria=" + categoria + ", nombre=" + nombre
                + ", descripcion=" + descripcion + ", estado=" + estado
                + ", anoAdquision=" + anoAdquisicion + ", precio=" + precio
                + ", fechaSubida=" + fechaSubida
                + ", tiene_imagen: " + tieneImagen 
                + ", visible: " + visible
                + ", vendido: " + vendido
                + "}";
    }

}
