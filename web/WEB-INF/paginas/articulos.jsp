<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" type="image/ico" href="img/favicon.ico">
        
        <title>Products</title>
        
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
        <link href="css/estilos.css" rel="stylesheet" type="text/css"/>
    </head>
    
    <body>
        <jsp:include page="/WEB-INF/plantillas/navbar.jsp"/>
        
        <div class="container-fluid" id="main-wrapper">
            <div class="row">
                <div class="col-sm-12 col-md-10 offset-md-1 col-xl-6 offset-xl-3">
                    <h3 class="fs-3 fw-bold">Products</h3>
                    
                    <form id="buscar" action="#" method="POST" onsubmit="return filtrar();">
                        <div class="row mb-4">
                            <div class="col-xl-8 col-md-8 col-sm-12 mt-2">
                                <div class="input-group">
                                    <div class="input-group-text">
                                        <i class="bi bi-search"></i>
                                    </div>
                                    <input type="text" class="form-control" id="filtro-nombre" 
                                       placeholder="What are you looking for?" aria-label="What are you looking for?">
                                </div>
                            </div>

                            <div class="col-xl-1 col-md-1 offset-md-0 col-sm-3 col-3 offset-3 mt-2">
                                <button class="btn btn-primary" type="submit" onclick="return validarFiltro();">Search</button>
                            </div>

                            <div class="col-xl-1 ms-xl-4 ms-lg-3 col-md-1 offset-md-0 ms-md-5 col-sm-3 col-3 mt-2 ms-2">
                                <button class="btn btn-primary" type="button" data-bs-toggle="offcanvas"
                                        data-bs-target="#contenido-filtros" aria-controls="contenido-filtros">Filters</button>
                            </div>

                            <div id="contenido-filtros" class="offcanvas offcanvas-start" tabindex="-1"
                                 aria-labelledby="filtros-titulo">
                                <div class="offcanvas-header">
                                    <h5 class="offcanvas-title fw-bold" id="filtros-titulo">Filters</h5>
                                    <button type="button" id="filtros-cerrar" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                                </div>
                                <div class="offcanvas-body">
                                    <div class="row">
                                        <h4 class="fs-5">Category</h4>
                                        <div class="col-md-12">
                                            <select id="filtro-categoria" name="filtro-categoria" class="form-select" placeholder="All">
                                                <option selected value="">All categories</option>
                                            </select>
                                        </div>

                                        <h4 class="fs-5 mt-4">Postal code</h4>
                                        <div class="col-md-6">
                                            <input type="number" id="filtro-cp" name="filtro-cp" class="form-control" placeholder="All">
                                        </div>

                                        <h4 class="fs-5 mt-4">Price</h4>
                                        <div class="col-md-6">
                                            <label for="filtro-precio-desde" class="form-label">From</label>
                                            <input type="number" id="filtro-precio-desde" name="filtro-precio-desde" class="form-control" placeholder="0">
                                        </div>
                                        <div class="col-md-6">
                                            <label for="filtro-precio-hasta" class="form-label">To</label>
                                            <input type="number" id="filtro-precio-hasta" name="filtro-precio-hasta" class="form-control" placeholder="Sin límite">
                                        </div>

                                        <div class="col-md-6 mt-4">
                                            <button class="btn btn-primary" type="submit" 
                                                    id="filtro-submit" name="filtro-submit" onclick="return validarFiltro();">Filter</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                    
                    <div class="row row-cols-xl-3 row-cols-md-2 row-cols-1 mb-3" id="lista-articulos">
                        <jsp:include page="/WEB-INF/jspf/articulos-filtrados.jsp"/>
                    </div>
                </div>
                
                <%-- Barra lateral --%>
                <div class="col-sm-12 col-md-6 offset-md-3 col-xl-3 offset-xl-0 px-5 pt-5">
                    <jsp:include page="/WEB-INF/plantillas/lateral.jsp"/>
                </div>
                <%-- Barra lateral --%>
            </div>
        </div>
        
        <jsp:include page="/WEB-INF/plantillas/footer.jsp"/>
        
        <script src="js/articulos.js" type="text/javascript"></script>
        <script src="js/bootstrap.bundle.min.js" type="text/javascript"></script>
    </body>
</html>
