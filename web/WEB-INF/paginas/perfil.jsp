<%@page import="valeo.ventamal.entidades.Usuario"%>
<%@page import="valeo.ventamal.util.DateManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

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
                <jsp:include page="/WEB-INF/plantillas/error-msg.jsp"/>
                
                <% if (usuarioPerfil != null) { %>
                <div class="col-sm-12 col-md-10 offset-md-1 col-xl-6 offset-xl-3">
                    <div id="header-perfil" class="row">
                        <div class="col-xl-9 col-lg-10 col-md-9 col-sm-12">
                           <h3 class="fs-3 fw-bolder"><%=usuarioPerfil.getNombre()%></h3>

                            <p class="small fst-italic fw-light mb-5">In Ventamal since 
                                <%=DateManager.getNombreMes(usuarioPerfil.getFechaRegistro())%>  
                                <%=DateManager.getAgno(usuarioPerfil.getFechaRegistro())%></p> 
                        </div>
                        
                        <% if (session.getAttribute("usuario") != null && session.getAttribute("id-usuario") == usuarioPerfil.getId()) { %>
                        <div class="col-xl-3 col-lg-2 col-md-3 col-sm-12 mb-4">
                            <button class="w-100 btn btn-primary" type="button" data-bs-toggle="modal"
                                data-bs-target="#info-contacto" aria-controls="info-contacto">Edit profile</button>

                            <div class="modal fade" id="info-contacto" tabindex="-1" aria-labelledby="info-contacto-label" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="info-contacto-label">Edit contact information</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>

                                        <div class="modal-body">
                                             Do you want to edit your contact information?
                                        </div>

                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cancel</button>
                                            <a class="btn btn-primary" href="#">Edit</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% } %>
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
                </div>
                <% } %>
                
                <%-- Barra lateral --%>
                <% if (session.getAttribute("usuario") == null) {%>
                <div class="col-sm-12 col-md-6 offset-md-3 col-xl-3 offset-xl-0 px-5 pt-5">
                    <jsp:include page="/WEB-INF/plantillas/lateral.jsp"/>
                </div>
                <% } %>
                <%-- Barra lateral --%>
            </div>
        </div>
        
        <jsp:include page="/WEB-INF/plantillas/footer.jsp"/>

        <script src="js/bootstrap.bundle.min.js" type="text/javascript"></script>
    </body>
</html>
