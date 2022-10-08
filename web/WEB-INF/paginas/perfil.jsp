<%@page import="valeo.ventamal.entidades.Usuario"%>
<%@page import="valeo.ventamal.util.DateManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

String msj = (String)request.getAttribute("msj");
Usuario usuarioPerfil = (Usuario)request.getAttribute("usuario-perfil");

%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/ico" href="img/favicon.ico">
        
        <title>
            <%=(usuarioPerfil != null) ? usuarioPerfil.getNombre() : "User not found"%>
        </title>
        
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
        <link href="css/estilos.css" rel="stylesheet" type="text/css"/>
    </head>
    
    <body>
        <jsp:include page="/WEB-INF/plantillas/navbar.jsp"/>
        
        <div class="container-fluid" id="main-wrapper">
            <div class="row">
                <div class="col-sm-12 col-md-10 offset-md-1 col-xl-6 offset-xl-3">
                    <% if (msj != null) {%>
                    <div id="perfil-error" class="mt-2 alert alert-danger" role="alert">
                        <span class="fw-bold">Error</span>: <%=msj%>
                    </div>
                    <%}%>
                    
                    <% if (usuarioPerfil != null) { %>
                    <div id="titulo">
                        <h3 class="fs-3 fw-bolder"><%=usuarioPerfil.getNombre()%></h3>

                        <p class="small fst-italic fw-light mb-5">In Ventamal since 
                            <%=DateManager.getNombreMes(usuarioPerfil.getFechaRegistro())%>  
                            <%=DateManager.getAgno(usuarioPerfil.getFechaRegistro())%></p>
                    </div>
                    
                    <div id="contacto" class="mb-5">
                        <h4 class="fw-bold fs-5 mb-3">Contact information</h4>
                        <% if (session.getAttribute("usuario") != null) {%>
                        <p class="mb-2">Email: <a class="fw-bold text-decoration-none link-primary" 
                                    href="mailto:<%=usuarioPerfil.getCorreo()%>?Subject=Ventamal"><%=usuarioPerfil.getCorreo()%></a></p>
                        <p class="mb-2">Phone number: <a class="fw-bold phone-number text-decoration-none link-primary" 
                                    href="tel:<%=usuarioPerfil.getTelefono()%>"><%=usuarioPerfil.getTelefono()%></a></p>
                        <% } else { %>
                        <p>Please <a class="link-primary" href="iniciar-sesion">login</a> or 
                            <a class="link-primary" href="alta">sign up</a> to view contact information.</p>
                        <% } %>
                    </div>
                    
                    <div id="productos-perfil">
                        <h3 class="fw-bold fs-5 mb-3">Published products</h3>
                        <div class="row row-cols-xl-3 row-cols-md-2 row-cols-1 mb-3" id="lista-articulos">
                            <jsp:include page="/WEB-INF/jspf/articulos-filtrados.jsp"/>
                        </div>
                    </div>
                        
                    <% } %>
                </div>
            </div>
        </div>
        
        <jsp:include page="/WEB-INF/plantillas/footer.jsp"/>

        <script src="js/bootstrap.bundle.min.js" type="text/javascript"></script>
    </body>
</html>
