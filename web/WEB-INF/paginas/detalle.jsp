<%@page import="java.util.List"%>
<%@page import="valeo.ventamal.entidades.Articulo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

String msj = (String)request.getAttribute("msj");
Articulo a = (Articulo)request.getAttribute("articulo");

%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/ico" href="img/favicon.ico">
        
        <title>
            <%if (a != null) {%>
            <%=a.getNombre()%>
            <% } else {%>
            Artículo
            <%}%>
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
                    <div id="articulo-error" class="mt-2 alert alert-danger" role="alert">
                        <%=msj%>
                    </div>
                    <%}%>
                    
                    <% if (a != null) {%>
                    <h3 class="fs-3 fw-bold"><%=a.getNombre()%></h3>
                    
                    <div class="row row-cols-xl-3 row-cols-md-2 row-cols-1 mb-3">
                        <div class="col-xl-4 col-md-4 offset-md-0 col-8 offset-2 mb-3">
                            <% if (a.tieneImagen()) {%>
                            <img class="card-img-top img-fluid rounded" src="img/<%=a.getId()%>.jpg" width="0.5em" height="0.5em"/>
                            <%} else {%>
                            <%-- Placeholder para cuando no hay imágenes --%>
                            <svg class="card-img-top img-fluid rounded" 
                                    width="0.5em" height="0.5em" xmlns="http://www.w3.org/2000/svg" role="img" 
                                    aria-label="Placeholder" preserveAspectRatio="xMidYMid slice" focusable="false">
                                <title>Placeholder</title>
                                <rect width="100%" height="100%" fill="#868e96"></rect>
                                <text x="35%" y="50%" fill="#dee2e6" dy=".3em">No image</text>
                            </svg>
                            <%}%>
                        </div>

                        <div class="col-xl-6 col-md-6 col-12 mb-3">
                            <p><strong>Published by: </strong><a class="link-primary" 
                                href="perfil?uid=<%=a.getUsuario().getId()%>"><%=a.getUsuario().getNombre()%></a></p>
                            <p><strong>Postal code: </strong><%=a.getUsuario().getCp()%></p>
                            <br>
                            <p><strong>Category: </strong><%=a.getCategoria()%></p>
                            <p><strong>Condition: </strong><%=(a.getEstado() != null && !a.getEstado().equals("")) ? a.getEstado() : "Unspecified"%></p>
                            <p><strong>Year of acquisition (approx.): </strong><%=(a.getAnoAdquisicion() > 0) ? a.getAnoAdquisicion() : "Unspecified"%></p>
                            <p><strong>Price </strong><%=a.getPrecio()%> &euro;</p>
                        </div>

                        <div class="col-xl-12 col-md-12 col-12 mb-4">
                            <p><strong>Description:</strong></p>
                            <p><%=(a.getDescripcion() != null && !a.getDescripcion().equals("")) ? a.getDescripcion() : "No product description was provided."%></p>
                            <% if (session.getAttribute("usuario") != null) {%>
                            
                            <div class="row justify-content-start">
                                <% if (session.getAttribute("id-usuario") == a.getUsuario().getId()) { %>
                                <div class="mt-2 col-xl-4 col-lg-4 col-md-4 col-sm-12">
                                    <button class="w-100 btn btn-primary" type="button" data-bs-toggle="modal"
                                            data-bs-target="#editar-info" aria-controls="editar-info">Edit product information</button>
                                    
                                    <div class="modal fade" id="editar-info" tabindex="-1" aria-labelledby="editar-info-label" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="editar-info-label">Confirm</h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>

                                                <div class="modal-body">
                                                    Do you want to edit product information?
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
                                
                                <div id="info-vendedor-wrapper" class="mt-2 col-xl-4 col-lg-4 col-md-4 col-sm-12">
                                    <button class="w-100 btn btn-primary" type="button" data-bs-toggle="modal"
                                            data-bs-target="#info-contacto" aria-controls="info-contacto">Seller's contact information</button>

                                    <div class="modal fade" id="info-contacto" tabindex="-1" aria-labelledby="info-contacto-label" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="info-contacto-label">Seller's contact information</h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>

                                                <div class="modal-body">
                                                    <p>Name: <span class="fw-bold"><%=a.getUsuario().getNombre()%></span></p>
                                                    <p>Email: <a class="fw-bold text-decoration-none link-primary" 
                                                                 href="mailto:<%=a.getUsuario().getCorreo()%>?Subject=Ventamal%20-%20<%=a.getNombre()%>"><%=a.getUsuario().getCorreo()%></a></p>
                                                    <p>Phone number: <a class="fw-bold phone-number text-decoration-none link-primary" 
                                                                        href="tel:<%=a.getUsuario().getTelefono()%>"><%=a.getUsuario().getTelefono()%></a></p>
                                                </div>

                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                                
                                <div id="boton-interes" class="mt-2 col-xl-4 col-lg-4 col-md-4 col-sm-12"></div>
                            </div>
                            
                            <%}%>
                        </div>
                        
                        <div class="col-xl-12 col-md-12 col-12 mb-3">
                            <h3 class="fs-4 fw-bold mb-4">Comments</h3>
                            
                            <div id="lista-comentarios">
                                <jsp:include page="/WEB-INF/jspf/comentarios.jsp"/>
                            </div>
                            
                            <% if (session.getAttribute("usuario") != null) {%>
                            <form action="#" method="POST" class="mt-5" onsubmit="return comentar();">
                                <input type="hidden" id="id-articulo" name="id-articulo" value="<%=a.getId()%>"/>
                                
                                <label class="form-label"><strong>New comment</strong></label>
                                
                                <div class="row g-2 align-items-center">
                                    <div class="col-auto">
                                        <label for="visibilidad" class="form-label">Visibility</label>
                                    </div>
                                    <div class="col-auto">
                                        <select class="form-select mb-2" id="visibilidad" name="visibilidad"></select>
                                    </div>
                                </div>
                                
                                <textarea class="form-control mb-3" id="texto" name="texto" rows="3"></textarea>
                                
                                <input type="submit" class="btn btn-primary" value="Post comment" onclick="return validar();" />
                            </form>
                            <%}%>
                        </div>
                    </div>
                    <%}%>
                </div>
                
                <%-- Barra lateral --%>
                <div class="col-sm-12 col-md-6 offset-md-3 col-xl-3 offset-xl-0 px-5 pt-5">
                    <jsp:include page="/WEB-INF/plantillas/lateral.jsp"/>
                </div>
                <%-- Barra lateral --%>
            </div>
        </div>
        
        <jsp:include page="/WEB-INF/plantillas/footer.jsp"/>
        
        <script src="js/clase-interes.js" type="text/javascript"></script>
        <script src="js/detalle.js" type="text/javascript"></script>
        <script src="js/bootstrap.bundle.min.js" type="text/javascript"></script>
    </body>
</html>
