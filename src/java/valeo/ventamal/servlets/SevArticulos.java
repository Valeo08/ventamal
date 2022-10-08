package valeo.ventamal.servlets;

import com.google.gson.Gson;
import valeo.ventamal.entidades.Articulo;
import valeo.ventamal.entidades.Comentario;
import valeo.ventamal.entidades.Usuario;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 * @author Valeo
 */
@WebServlet(name = "SevArticulos", urlPatterns = {"/articulos", "/articulo",
    "/publicar", "/interes", "/agregar-articulo", "/filtro", "/comentar",
    "/articulos-interes"})
@MultipartConfig
public class SevArticulos extends HttpServlet {

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
        HttpSession session = request.getSession();
        String vista = null;
        
        TypedQuery<Articulo> query;
        List<Articulo> lr;
        Articulo a;
        TypedQuery<Usuario> queryUsuario;
        List<Usuario> lu;
        Usuario u;
        TypedQuery<Comentario> queryComentario;
        List<Comentario> lc;
        Comentario c;
        
        switch (accion) {
            case "/articulos":
                query = em.createNamedQuery("Articulo.findAllNuevosPrimero", Articulo.class);
                lr = query.getResultList();
                request.setAttribute("articulos", lr);
                vista = "/WEB-INF/paginas/articulos.jsp";
                break;
            case "/filtro":
                String clFiltro = "";
                
                // Leer los campos del filtro
                String filNombre = request.getParameter("nombre");
                String filCategoria = request.getParameter("categoria");
                int filCp;
                try {
                    filCp = Integer.parseInt(request.getParameter("cp"));
                } catch (NumberFormatException e) {
                    filCp = -1;
                }
                Float filPrecioMenor, filPrecioMayor;
                try {
                    filPrecioMenor = Float.parseFloat(request.getParameter("pmenor"));
                } catch (NumberFormatException | NullPointerException e) {
                    filPrecioMenor = -1f;
                }
                try {
                    filPrecioMayor = Float.parseFloat(request.getParameter("pmayor"));
                } catch (NumberFormatException | NullPointerException e) {
                    filPrecioMayor = -1f;
                }
                
                // Preparar la consulta en base a los filtro establecidos
                int numFiltros = 0;
                
                if (filNombre != null && !filNombre.equals("")) {
                    clFiltro += "LOWER(a.nombre) LIKE '%" + filNombre.toLowerCase() + "%'";
                    numFiltros++;
                }
                
                if (filCategoria != null && !filCategoria.equals("")) {
                    if (numFiltros > 0) clFiltro += " AND ";
                    clFiltro += "a.categoria = '" + filCategoria + "'";
                    numFiltros++;
                }
                
                if (filCp != -1) {
                    if (numFiltros > 0) clFiltro += " AND ";
                    clFiltro += "a.usuario.cp = " + filCp;
                    numFiltros++;
                }
                
                if (filPrecioMenor != -1f) {
                    if (numFiltros > 0) clFiltro += " AND ";
                    clFiltro += "a.precio >= " + filPrecioMenor;
                    numFiltros++;
                }
                
                if (filPrecioMayor != -1f) {
                    if (numFiltros > 0) clFiltro += " AND ";
                    clFiltro += "a.precio <= " + filPrecioMayor;
                    numFiltros++;
                }
                
                String cl = "SELECT a FROM Articulo a";
                String order = " ORDER BY a.fechaSubida DESC";
                query = em.createQuery(cl 
                        + (clFiltro.equals("") ? "" : " WHERE " + clFiltro) + order,
                        Articulo.class);
                
                lr = query.getResultList();
                request.setAttribute("articulos", lr);
                
                vista = "/WEB-INF/jspf/articulos-filtrados.jsp";
                break;
            case "/articulo":
                String detId = request.getParameter("id");
                boolean artCorrecto = false;
                
                if (detId != null && !detId.equals("")) {
                    query = em.createNamedQuery("Articulo.findById", Articulo.class);
                    query.setParameter("id", Integer.parseInt(detId));
                    lr = query.getResultList();
                    
                    if (lr.size() > 0) {
                        a = lr.get(0);
                        request.setAttribute("articulo", a);

                        if (session.getAttribute("id-usuario") != null) {
                            Long detIdUsuario = (Long)session.getAttribute("id-usuario");
                            queryComentario = em.createNamedQuery(
                                    "Comentario.findVisibles", Comentario.class);
                            queryComentario.setParameter("idArticulo", a.getId());
                            queryComentario.setParameter("idUsuario", detIdUsuario);
                            lc = queryComentario.getResultList();
                        } else {
                            queryComentario = em.createNamedQuery(
                                    "Comentario.findPublicos", Comentario.class);
                            queryComentario.setParameter("idArticulo", a.getId());
                            lc = queryComentario.getResultList();
                        }
                        request.setAttribute("comentarios", lc);
                        artCorrecto = true;
                    }
                }
                
                if (!artCorrecto) request.setAttribute("msj", "Product not found.");
                vista = "/WEB-INF/paginas/detalle.jsp";
                break;
            case "/comentar":
                // Leemos los campos para el comentario a publicar y los validamos
                Long comIdUsuario, comIdArticulo;
                try {
                    comIdUsuario = (Long)session.getAttribute("id-usuario");
                    comIdArticulo = Long.parseLong(request.getParameter("idarticulo"));
                } catch (NumberFormatException e) {
                    comIdUsuario = comIdArticulo = -1L;
                }
                String comTexto = request.getParameter("texto");
                String comVisibilidad = request.getParameter("visibilidad");
                if (comVisibilidad == null || comVisibilidad.trim().equals(""))
                    comVisibilidad = null;
                else {
                    String[] comOpcionesVis = new String[]{"publico", "vendedor", "privado"};
                    boolean comOptValida = false;
                    int comi = 0;
                    while (!comOptValida && comi < comOpcionesVis.length) {
                        if (comVisibilidad.equals(comOpcionesVis[comi]))
                            comOptValida = true;
                        comi++;
                    }
                    if (!comOptValida) comVisibilidad = null;
                }
                Timestamp comFechaPublicacion = new Timestamp(new Date().getTime());
                
                // Intentamos publicar el comentario
                boolean comValido = false;
                if (comIdUsuario != -1L && comIdArticulo != -1L 
                        && comVisibilidad != null
                        && comTexto != null && !comTexto.trim().equals("")) {
                    queryUsuario = em.createNamedQuery("Usuario.findById", Usuario.class);
                    queryUsuario.setParameter("id", comIdUsuario);
                    lu = queryUsuario.getResultList();
                    
                    if (lu.size() > 0) {
                        u = lu.get(0);
                        
                        query = em.createNamedQuery("Articulo.findById", Articulo.class);
                        query.setParameter("id", comIdArticulo);
                        lr = query.getResultList();
                        
                        if (lr.size() > 0) {
                            a = lr.get(0);
                            
                            c = new Comentario();
                            c.setUsuario(u);
                            c.setArticulo(a);
                            c.setTexto(comTexto);
                            c.setFechaPublicacion(comFechaPublicacion);
                            c.setVisibilidad(comVisibilidad);
                            persist(c);
                            comValido = true;
                        }
                    }
                }
                
                if (!comValido)
                    request.setAttribute("msj", "Invalid comment.");
                
                if (comIdArticulo != -1L) {
                    if (session.getAttribute("id-usuario") != null) {
                        Long detIdUsuario = (Long)session.getAttribute("id-usuario");
                        queryComentario = em.createNamedQuery(
                                "Comentario.findVisibles", Comentario.class);
                        queryComentario.setParameter("idArticulo", comIdArticulo);
                        queryComentario.setParameter("idUsuario", detIdUsuario);
                        lc = queryComentario.getResultList();
                    } else {
                        queryComentario = em.createNamedQuery(
                                "Comentario.findPublicos", Comentario.class);
                        lc = queryComentario.getResultList();
                    }
                    request.setAttribute("comentarios", lc);
                }
                    
                vista = "/WEB-INF/jspf/comentarios.jsp";
                break;
            case "/publicar":
                vista = "/WEB-INF/paginas/publicar.jsp";
                break;
            case "/agregar-articulo":
                // Obtenemos todos los campos del formulario
                String AgNombreArt = request.getParameter("nombre-art");
                String AgCategoria = request.getParameter("categoria");
                String AgDescripcion = request.getParameter("descripcion");
                String AgEstado = request.getParameter("estado");
                final Part AgImg = request.getPart("imagen");
                
                System.out.println(AgImg.toString());
                
                int AgAnoAdquision;
                try {
                    AgAnoAdquision = Integer.parseInt(request.getParameter("ano-adquisicion"));
                } catch (NumberFormatException e) {
                    AgAnoAdquision = -1;
                }
                float AgPrecio;
                try {
                    AgPrecio = Float.parseFloat(request.getParameter("precio"));
                } catch (NumberFormatException e) {
                    AgPrecio = -1f;
                }
                Timestamp AgFechaSubida = new Timestamp(new Date().getTime());
                
                // Comprobamos que los campos obligatorios se han rellenado
                if (AgNombreArt != null && !AgNombreArt.equals("") 
                        && AgCategoria != null && !AgCategoria.equals("")
                        && AgPrecio != -1f) {
                    a = new Articulo();
                    a.setNombre(AgNombreArt);
                    a.setCategoria(AgCategoria);
                    a.setDescripcion(AgDescripcion);
                    a.setEstado(AgEstado);
                    a.setAnoAdquisicion(AgAnoAdquision);
                    a.setPrecio(AgPrecio);
                    a.setFechaSubida(AgFechaSubida);
                    a.setTieneImagen((AgImg.getSize() > 0));
                    
                    queryUsuario = em.createNamedQuery("Usuario.findById", Usuario.class);
                    queryUsuario.setParameter("id", (Long)session.getAttribute("id-usuario"));
                    lu = queryUsuario.getResultList();
                    a.setUsuario(lu.get(0));
                    
                    persist(a);
                    
                    System.out.println("Articulo agregado:");
                    System.out.println(a.toString());
                    
                    // Obtener todos los artículos, con los más nuevos antes
                    query = em.createNamedQuery("Articulo.findAllNuevosPrimero", Articulo.class);
                    lr = query.getResultList();
                    
                    // Si se ha subido una imagen, guardarla
                    if (AgImg.getSize() > 0) {
                        String relativePathFolder = "img";
                        String absolutePathFolder = getServletContext().getRealPath(relativePathFolder);

                        File folder = new File(absolutePathFolder);
                        if (!folder.exists()) folder.mkdir();         

                        // La imagen tendrá como nombre su ID
                        long AgCod = 0;
                        if (lr.size() > 0) AgCod = lr.get(0).getId();
                        
                        //System.out.println(absolutePathFolder + File.separator + AgCod + ".jpg");
                        File f = new File(absolutePathFolder + File.separator + AgCod + ".jpg");

                        InputStream filecontent;
                        try (OutputStream p = new FileOutputStream(f)) {
                            filecontent = AgImg.getInputStream();
                            //System.out.println("Tam: " +  filePart.getSize());
                            
                            int read;
                            final byte[] bytes = new byte[1024];
                            while ((read = filecontent.read(bytes)) != -1) {
                                p.write(bytes, 0, read);
                            }
                        }
                        filecontent.close();
                    }
                    
                    // Mostrar la vista con todos los artículos
                    request.setAttribute("articulos", lr);
                    vista = "/WEB-INF/paginas/articulos.jsp";
                } else {
                    request.setAttribute("error", true);
                    vista = "/WEB-INF/paginas/publicar.jsp";
                }
                break;
            case "/interes":
                vista = "/WEB-INF/paginas/interes.jsp";
                break;
            case "/articulos-interes":
                String artIntString = request.getParameter("articulos");
                
                if (artIntString != null && !artIntString.equals("") 
                        && !artIntString.equals("[]")) {
                    int[] aid = new Gson().fromJson(artIntString, int[].class);
                    List<Integer> lid = new ArrayList<>();
                    for (int i : aid) lid.add(i);
                    
                    query = em.createQuery(
                            "SELECT a FROM Articulo a WHERE a.id IN :lid", Articulo.class);
                    query.setParameter("lid", lid);
                    lr = query.getResultList();
                    request.setAttribute("articulos", lr);
                }
                
                vista = "/WEB-INF/jspf/articulos-filtrados.jsp";
                break;
        }
        
        if (vista == null) vista = "index.jsp";
        
        RequestDispatcher rd = request.getRequestDispatcher(vista);
        rd.forward(request, response);
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
