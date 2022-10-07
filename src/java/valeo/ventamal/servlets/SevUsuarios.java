package valeo.ventamal.servlets;

import valeo.ventamal.entidades.Usuario;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @author Valeo
 */
@WebServlet(name = "SevUsuarios", urlPatterns = {"/iniciar-sesion", "/alta",
    "/login", "/comprobar-email", "/comprobar-tlf", "/registrar", "/logout"})
public class SevUsuarios extends HttpServlet {

    @PersistenceContext(unitName = "ventamalPU")
    private EntityManager em;
    @Resource
    private javax.transaction.UserTransaction utx;
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String accion = request.getServletPath();
        String vista;
        
        TypedQuery<Usuario> query;
        List<Usuario> lr;
        Usuario u;
        HttpSession session = request.getSession();
        boolean inicioCorrecto = false;
        
        switch(accion) {
            case "/iniciar-sesion": // Mostrar página para iniciar de sesión
                vista = "/WEB-INF/paginas/iniciar-sesion.jsp";
                break;
            case "/alta": // Mostrar página para registrarse
                vista = "/WEB-INF/paginas/registrar.jsp";
                break;
            case "/login": // Iniciar sesión
                // Obtenemos los campos del formulario
                inicioCorrecto = false;
                String logEmail = request.getParameter("email");
                String logRawPass = request.getParameter("pass"), logPass;
                
                // Hacer hash a la contraseña
                logPass = hashPassword(logRawPass);
                
                // Intentamos iniciar sesión con los datos del usuario
                if (logPass != null && logEmail != null && !logEmail.equals("")) {
                    query = em.createNamedQuery("Usuario.findByEmailAndPass", Usuario.class);
                    query.setParameter("email", logEmail);
                    query.setParameter("pass", logPass);
                    lr = query.getResultList();
                    
                    if (lr.size() > 0) {
                        u = lr.get(0);
                        session.setAttribute("usuario", u.getNombre());
                        session.setAttribute("id-usuario", u.getId());
                        inicioCorrecto = true;
                    }
                }
                
                // Si hay un error al iniciar sesión
                if (!inicioCorrecto) {
                    request.setAttribute("email", logEmail);
                    request.setAttribute("error", true);
                    vista = "/WEB-INF/paginas/iniciar-sesion.jsp";
                } else vista = "/index.jsp";
                
                break;
            case "/comprobar-email": // Comprobar si un email ya está registrado
                String emailComprobar = request.getParameter("email");
                query = em.createNamedQuery("Usuario.findByEmail", Usuario.class);
                query.setParameter("email", emailComprobar);
                lr = query.getResultList();
                
                String emailValido = (lr.size() > 0) ? "NO" : "SI";
                request.setAttribute("email-valido", emailValido);
                response.setIntHeader("email-disponible", 
                        (emailValido.equals("NO")) ? 0 : 1);
                
                vista = "/WEB-INF/jspf/email-valido.jsp";
                break;
            case "/comprobar-tlf": // Comprobar si un telefono ya está registrado
                String tlfComprobar = request.getParameter("tlf");
                query = em.createNamedQuery("Usuario.findByTlf", Usuario.class);
                query.setParameter("tlf", tlfComprobar);
                lr = query.getResultList();
                
                String tlfValido = (lr.size() > 0) ? "NO" : "SI";
                request.setAttribute("tlf-valido", tlfValido);
                response.setIntHeader("tlf-disponible", 
                        (tlfValido.equals("NO")) ? 0 : 1);
                
                vista = "/WEB-INF/jspf/tlf-valido.jsp";
                break;
            case "/registrar": // Registrar usuario
                // Obtenemos los campos del formulario de registro
                String regEmail = request.getParameter("email");
                String regRawPass = request.getParameter("pass"), regPass;
                String regNombre = request.getParameter("nombre");
                String regDireccion = request.getParameter("direccion");
                int regCp;
                try {
                    regCp = Integer.parseInt(request.getParameter("cp"));
                } catch (NumberFormatException e) {
                    regCp = -1;
                }
                String regFacebook = request.getParameter("facebook");
                String regTwitter = request.getParameter("twitter");
                String regTlf = request.getParameter("telefono");
                
                // Hacer hash a la contraseña
                regPass = hashPassword(regRawPass);
                
                // Intentamos registrar al usuario
                boolean errorReg = false, registrado = false;
                String msjError = "Comprueba los campos.";
                if (regPass != null && regEmail != null && !regEmail.equals("")
                        && regNombre != null && !regNombre.equals("") 
                        && regCp >= 0 && regTlf != null && !regTlf.equals("")) {
                    query = em.createNamedQuery("Usuario.findByEmail", Usuario.class);
                    query.setParameter("email", regEmail);
                    lr = query.getResultList();
                    errorReg = (lr.size() > 0);
                    
                    if (!errorReg) {
                        query = em.createNamedQuery("Usuario.findByTlf", Usuario.class);
                        query.setParameter("tlf", regTlf);
                        lr = query.getResultList();
                        errorReg = (lr.size() > 0);
                        if (errorReg)
                            msjError = "Phone already registered in Ventamal";
                    } else msjError = "Email already registered in Ventamal";
                    
                    if (!errorReg) {
                        u = new Usuario();
                        u.setCorreo(regEmail);
                        u.setPass(regPass);
                        u.setNombre(regNombre);
                        u.setCp(regCp);
                        u.setTelefono(regTlf);
                        u.setDireccion(regDireccion);
                        u.setFacebook(regFacebook);
                        u.setTwitter(regTwitter);

                        persist(u);
                        registrado = true;
                    }
                }
                
                if (!errorReg && registrado) {
                    // Si se registra exitosamente el usuario,
                    // mostrar una vista que lo indique
                    vista = "/WEB-INF/paginas/registrado.jsp";
                } else {
                    // En caso contrario, remitir al formulario de nuevo
                    // indicando los errores que se hayan dado
                    request.setAttribute("email", regEmail);
                    request.setAttribute("nombre", regNombre);
                    request.setAttribute("cp", "" + (regCp==-1 ? "" : regCp));
                    request.setAttribute("tlf", regTlf);
                    request.setAttribute("direccion", regDireccion);
                    request.setAttribute("facebook", regFacebook);
                    request.setAttribute("twitter", regTwitter);
                      
                    request.setAttribute("error", true);
                    request.setAttribute("msj", msjError);
                    vista = "/WEB-INF/paginas/registrar.jsp";
                }
                break;
            case "/logout": // Cerrar sesión
                if (session.getAttribute("usuario") != null)
                    session.invalidate();
                vista = "/index.jsp";
                break;
            default:
                vista = "/index.jsp";
                break;
        }
        
        if (accion.equals("/logout") || (accion.equals("/login") && inicioCorrecto)) {
            response.sendRedirect("inicio");
        } else {
            RequestDispatcher rd = request.getRequestDispatcher(vista);
            rd.forward(request, response);
        }
    }
    
    // Para hacer hash a las contraseñas de los formularios
    private String hashPassword(final String rawPass) {
        String pass = null;
        MessageDigest digest;
        
        if (rawPass != null) {
            try {
                digest = MessageDigest.getInstance("SHA-256");
                byte[] encodedhash = digest.digest(rawPass.getBytes(StandardCharsets.UTF_8));
                StringBuilder hexString = new StringBuilder(2 * encodedhash.length);
                for (int i = 0; i < encodedhash.length; i++) {
                    String hex = Integer.toHexString(0xff & encodedhash[i]);
                    if(hex.length() == 1) hexString.append('0');
                    hexString.append(hex);
                }
                pass = hexString.toString();
            } catch (NoSuchAlgorithmException ex) {
                Logger.getLogger(SevUsuarios.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        return pass;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public void persist(Object object) {
        try {
            utx.begin();
            em.persist(object);
            utx.commit();
        } catch (Exception e) {
            Logger.getLogger(getClass().getName()).log(Level.SEVERE, "exception caught", e);
            throw new RuntimeException(e);
        }
    }

}
