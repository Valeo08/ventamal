<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

Boolean error = (Boolean)request.getAttribute("error");

%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/ico" href="img/favicon.ico">
        
        <title>Publish product</title>
        
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
        <link href="css/estilos.css" rel="stylesheet" type="text/css"/>
    </head>
    
    <body>
        <jsp:include page="/WEB-INF/plantillas/navbar.jsp"/>
        
        <div class="container-fluid" id="main-wrapper">
            <div class="row">
                <div class="col-xl-4 offset-xl-4 col-md-6 offset-md-3 col-10 offset-1 border border-2 rounded-2 p-3">
                    <h3 class="fs-3 fw-bold">Publish a product</h3>
                    
                    <% if (error != null && error) { %>
                    <div id="publicar-error" class="mt-2 alert alert-danger" role="alert">
                        Error publishing the product. Please try again.
                    </div>
                    <% } %>
                    
                    <form id="form-publicar" method="POST" action="agregar-articulo" validate onsubmit="return validar();" enctype="multipart/form-data">
                        <div class="row">
                            <div class="col-md-12 col-12 mb-3">
                                <label for="nombre-art" class="form-label">Name<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="nombre-art" name="nombre-art" placeholder="Product name" required/>
                            </div>
                            
                            <div class="col-md-12 col-12 mb-3">
                                <label for="categoria" class="form-label">Category<span class="text-danger">*</span></label>
                                <select id="categoria" name="categoria" class="form-select" placeholder="Select a category" required>
                                    <option selected value="">Select a category</option>
                                </select>
                            </div>
                            
                            <div class="col-md-12 col-12 mb-3">
                                <label for="descripcion" class="form-label">Description</label>
                                <textarea class="form-control" id="descripcion" name="descripcion" rows="3"></textarea>
                            </div>
                            
                            <div class="col-md-12 col-12 mb-3">
                                <label for="estado" class="form-label">Condition</label>
                                <select id="estado" name="estado" class="form-select" placeholder="Unspecified">
                                    <option selected value="">Unspecified</option>
                                </select>
                            </div>
                            
                            <div class="col-md-12 col-12 mb-3">
                                <label for="ano-adquisicion" class="form-label">Approximate acquisition year</label>
                                <input type="number" class="form-control" id="ano-adquisicion" name="ano-adquisicion" 
                                       placeholder="Year"/>
                                <div id="info-ano-adquisicion"></div>
                            </div>
                            
                            <div class="col-md-12 col-12 mb-3">
                                <label for="precio" class="form-label">Price<span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <input type="number" class="form-control" id="precio" name="precio" placeholder="Price" required step="0.01"/>
                                    <span class="input-group-text">&euro;</span>
                                </div>
                                <div id="info-precio"></div>
                            </div>
                            
                            <div class="col-md-12 col-12 mb-3">
                                <label for="imagen" class="form-label">Image</label>
                                <input class="form-control" type="file" id="imagen" name="imagen" accept=".png,.gif,.jpeg,.jpg">
                                <div id="info-imagen"></div>
                            </div>
                            
                            <div class="col-md-12 col-12 mb-2">
                                <input class="btn btn-primary" type="submit" value="Publish">
                            </div>
                        </div>
                    </form>
                </div>
                
                <%-- Barra lateral --%>
                <div class="col-sm-12 col-md-6 offset-md-3 col-xl-3 offset-xl-0 px-5 pt-5">
                    <jsp:include page="/WEB-INF/plantillas/lateral.jsp"/>
                </div>
                <%-- Barra lateral --%>
            </div>
        </div>
        
        <jsp:include page="/WEB-INF/plantillas/footer.jsp"/>
        
        <script src="js/publicar.js" type="text/javascript"></script>
        <script src="js/bootstrap.bundle.min.js" type="text/javascript"></script>
    </body>
</html>
