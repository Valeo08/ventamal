package valeo.ventamal.entidades;

import java.io.Serializable;
import java.util.Objects;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * @author Valeo
 */
@Entity
@Table(name = "USUARIOS")
@NamedQueries({
    @NamedQuery(name="Usuario.findById",
        query="SELECT u FROM Usuario u WHERE u.id = :id"),
    @NamedQuery(name="Usuario.findByEmailAndPass",
        query="SELECT u FROM Usuario u WHERE u.correo = :email AND u.pass = :pass"),
    @NamedQuery(name="Usuario.findByEmail",
        query="SELECT u FROM Usuario u WHERE u.correo = :email"),
    @NamedQuery(name="Usuario.findByTlf",
        query="SELECT u FROM Usuario u WHERE u.telefono = :tlf")
})
public class Usuario implements Serializable {

    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name="id")
    private Long id;
    
    @Column(name="email",unique=true,nullable=false)
    private String correo;
    
    @Column(name="pass",nullable=false)
    private String pass;
    
    @Column(name="nombre",nullable=false)
    private String nombre;
    
    @Column(name="direccion")
    private String direccion;
    
    @Column(name="cp",nullable=false)
    private int cp;
    
    @Column(name="facebook")
    private String facebook;
    
    @Column(name="twitter")
    private String twitter;
    
    @Column(name="tlf",unique=true,nullable=false)
    private String telefono;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public int getCp() {
        return cp;
    }

    public void setCp(int cp) {
        this.cp = cp;
    }

    public String getFacebook() {
        return facebook;
    }

    public void setFacebook(String facebook) {
        this.facebook = facebook;
    }

    public String getTwitter() {
        return twitter;
    }

    public void setTwitter(String twitter) {
        this.twitter = twitter;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 67 * hash + Objects.hashCode(this.id);
        hash = 67 * hash + Objects.hashCode(this.correo);
        hash = 67 * hash + Objects.hashCode(this.pass);
        hash = 67 * hash + Objects.hashCode(this.nombre);
        hash = 67 * hash + this.cp;
        hash = 67 * hash + Objects.hashCode(this.telefono);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null) return false;
        if (getClass() != obj.getClass()) return false;
        
        final Usuario other = (Usuario) obj;
        if (this.cp != other.cp) return false;
        if (!Objects.equals(this.correo, other.correo)) return false;
        if (!Objects.equals(this.pass, other.pass)) return false;
        if (!Objects.equals(this.nombre, other.nombre)) return false;
        if (!Objects.equals(this.telefono, other.telefono)) return false;
        if (!Objects.equals(this.id, other.id)) return false;
        return true;
    }

    @Override
    public String toString() {
        return "Usuario{" + "id=" + id + ", correo=" + correo + ", pass=" + pass
                + ", nombre=" + nombre + ", direccion=" + direccion + ", cp=" + cp 
                + ", facebook=" + facebook + ", twitter=" + twitter + ", telefono=" + telefono + '}';
    }

    

}
