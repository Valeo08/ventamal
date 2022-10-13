<%@page import="valeo.ventamal.entidades.Articulo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
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
                <jsp:include page="/WEB-INF/plantillas/error-msg.jsp"/>
                
                <% if (a != null) { %>
                <div class="col-xl-4 offset-xl-4 col-md-6 offset-md-3 col-10 offset-1 border border-2 rounded-2 p-3">
                    <div class="row">
                        <div class="col-xl-7 col-lg-8 col-12 mb-2">
                            <h3 class="fs-3 fw-bold">Edit product</h3>
                        </div>
                        
                        <div class="col-xl-5 col-lg-4 col-12 mb-2">
                            <button type="button" data-bs-toggle="modal" data-bs-target="#confirmar-eliminacion" 
                                    aria-controls="confirmar-eliminacion" class="btn btn-danger w-100">Remove product</button>
                                
                            <div class="modal fade" id="confirmar-eliminacion" tabindex="-1" aria-labelledby="confirmar-eliminacion-label" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="confirmar-eliminacion-label">Confirm</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>

                                        <div class="modal-body">
                                            Do you want to remove this product? 
                                            <br><br>
                                            To continue, type <span class="link-danger">DELETE</span> in the text field below and click the corresponding button...
                                            <br>
                                            <input type="text" id="texto-confirmar" class="form-control text-danger">
                                            <br>
                                        </div>

                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Cancel</button>
                                            <a id="boton-confirmar" role="button" tabindex="-1" aria-disabled="true" 
                                               href="eliminar-articulo?id=<%=a.getId()%>" class="btn btn-danger disabled">DELETE</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <form id="form-publicar" method="POST" action="editar-articulo" validate onsubmit="return validar();" enctype="multipart/form-data">
                        <div class="row">
                            <input type="hidden" class="form-control" value="<%=a.getId()%>" name="id">
                            
                            <div class="col-md-12 col-12 mb-3">
                                <label for="nombre-art" class="form-label">Name<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="nombre-art" name="nombre-art" 
                                       value="<%=a.getNombre()%>" placeholder="Product name" required/>
                            </div>
                            
                            <input id="temp-categoria" class="form-control" type="hidden" value="<%=a.getCategoria()%>">
                            <div class="col-md-12 col-12 mb-3">
                                <label for="categoria" class="form-label">Category<span class="text-danger">*</span></label>
                                <select id="categoria" name="categoria" class="form-select" placeholder="Select a category" required>
                                    <option selected value="">Select a category</option>
                                </select>
                            </div>
                            
                            <div class="col-md-12 col-12 mb-3">
                                <label for="descripcion" class="form-label">Description</label>
                                <textarea class="form-control" id="descripcion" name="descripcion" rows="3"><%=a.getDescripcion()%></textarea>
                            </div>
                            
                            <input id="temp-estado" class="form-control" type="hidden" value="<%=a.getEstado()%>">
                            <div class="col-md-12 col-12 mb-3">
                                <label for="estado" class="form-label">Condition</label>
                                <select id="estado" name="estado" class="form-select" placeholder="Unspecified">
                                    <option selected value="">Unspecified</option>
                                </select>
                            </div>
                            
                            <div class="col-md-12 col-12 mb-3">
                                <label for="ano-adquisicion" class="form-label">Approximate acquisition year</label>
                                <input type="number" class="form-control" id="ano-adquisicion" name="ano-adquisicion" 
                                       placeholder="Year" value="<%=a.getAnoAdquisicion()%>"/>
                                <div id="info-ano-adquisicion"></div>
                            </div>
                            
                            <div class="col-md-12 col-12 mb-3">
                                <label for="precio" class="form-label">Price<span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input type="number" class="form-control" id="precio" name="precio" 
                                           placeholder="Price" required step="0.01" value="<%=a.getPrecio()%>"/>
                                    <span class="input-group-text">&euro;</span>
                                </div>
                                <div id="info-precio"></div>
                            </div>
                                    
                            <% if (a.tieneImagen()) {%>
                            <div class="card mx-auto card-custom">
                                <img class="card-img-top img-fluid rounded" src="datos/<%=a.getUsuario().getId()%>/<%=a.getId()%>.jpg"/>
                            </div>
                            <% } %>
                            
                            <div class="col-md-12 col-12 mb-3">
                                <label for="imagen" class="form-label">Image</label>
                                <input class="form-control" type="file" id="imagen" name="imagen" accept=".png,.gif,.jpeg,.jpg">
                                <div id="info-imagen"></div>
                            </div>
                            
                            <div class="col-md-2 col-12 mb-2">
                                <input class="btn btn-primary w-100" type="submit" value="Edit">
                            </div>
                            
                            <div class="col-md-2 col-12 mb-2">
                                <a class="btn btn-primary w-100" href="articulo?id=<%=a.getId()%>">Cancel</a>
                            </div>
                        </div>
                    </form>
                </div>
                <% } %>
            </div>
        </div>
        
        <jsp:include page="/WEB-INF/plantillas/footer.jsp"/>
        
        <script src="js/editar-articulo.js" type="text/javascript"></script>
        <script src="js/bootstrap.bundle.min.js" type="text/javascript"></script>
    </body>
</html>
